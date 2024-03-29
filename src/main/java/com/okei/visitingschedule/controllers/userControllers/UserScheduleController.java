package com.okei.visitingschedule.controllers.userControllers;

import com.okei.visitingschedule.dto.ConclusionRequestDTO;
import com.okei.visitingschedule.dto.VisitingCriteriaResponseDTO;
import com.okei.visitingschedule.dto.VisitingRequestDTO;
import com.okei.visitingschedule.dto.event.EventRequestDTO;
import com.okei.visitingschedule.dto.event.ListEventRequestDTO;
import com.okei.visitingschedule.entity.User;
import com.okei.visitingschedule.entity.schedule.*;
import com.okei.visitingschedule.services.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.*;

@Controller
@RequestMapping("/schedule/")
public class UserScheduleController {

    private final AcademicDisciplineServices academicDisciplineServices;
    private final PositionServices positionServices;
    private final VisitingServices visitingServices;
    private final UserServices userServices;
    private final CriteriaScoreServices criteriaScoreServices;
    private final StudyGroupServices studyGroupServices;
    private final VisitingCriteriaService visitingCriteriaService;
    private final ScheduleServices scheduleServices;
    private final EventServices eventServices;
    private final ConclusionServices conclusionServices;

    @Autowired
    public UserScheduleController(AcademicDisciplineServices academicDisciplineServices, PositionServices positionServices,
                                  VisitingServices visitingServices, StudyGroupServices studyGroupServices,
                                  VisitingCriteriaService visitingCriteriaService, CriteriaScoreServices criteriaScoreServices,
                                  ScheduleServices scheduleServices, EventServices eventServices,
                                  ConclusionServices conclusionServices,UserServices userServices) {
        this.academicDisciplineServices = academicDisciplineServices;
        this.positionServices = positionServices;
        this.visitingServices = visitingServices;
        this.studyGroupServices = studyGroupServices;
        this.visitingCriteriaService = visitingCriteriaService;
        this.criteriaScoreServices = criteriaScoreServices;
        this.scheduleServices = scheduleServices;
        this.eventServices = eventServices;
        this.conclusionServices = conclusionServices;
        this.userServices = userServices;
    }

    @GetMapping("add/{schedule}")
    public String addVisiting(@PathVariable Schedule schedule, Principal principal, Map<String, Object> model) {
        User user = (User) ((UsernamePasswordAuthenticationToken) principal).getPrincipal();
        user = userServices.findByUsername(user.getUsername());
        Position position = user.getPosition();
        Iterable<StudyGroup> studyGroups = studyGroupServices.findAll();
        Iterable<AcademicDiscipline> academicDisciplines = academicDisciplineServices.findAll();
        List<CriteriaType> criteriaTypes = new ArrayList<>(EnumSet.allOf(CriteriaType.class));

        model.put("schedule", schedule);
        model.put("statuses", Status.values());
        model.put("studyGroups", studyGroups);
        model.put("academicDisciplins", academicDisciplines);
        model.put("position", position);
        model.put("criteriaTypes", criteriaTypes);
        return "createVisiting";
    }

    @PostMapping("add/select-criteria-type")
    public ResponseEntity<List<VisitingCriteriaResponseDTO>> selectCriteriaType(@RequestParam String criteriaType, Map<String,Object> model){
        List<VisitingCriteria> visitingCriteria = visitingCriteriaService.findAllByCriteriaType(CriteriaType.valueOf(criteriaType));
        List<VisitingCriteriaResponseDTO> responseDTOList = new ArrayList<>();
        for (VisitingCriteria criteria:visitingCriteria) {
            responseDTOList.add(new VisitingCriteriaResponseDTO(criteria.getId(), criteria.getCriteriaName(),criteria.getValueOfOnePoint(),criteria.getValueOfTwoPoint(),criteria.getValueOfThreePoint()));
        }
        return new ResponseEntity<>(responseDTOList,HttpStatus.OK);
    }

    @GetMapping("view/{schedule}")
    public String viewVisiting(@PathVariable Schedule schedule, Principal principal, Map<String, Object> model) {
        Visiting thisVisiting = visitingServices.findVisitingBySchedule(schedule);
        User user = (User) ((UsernamePasswordAuthenticationToken) principal).getPrincipal();
        Set<CriteriaScore> criteriaScore = thisVisiting.getCriteriaScore();
        Conclusion thisConclusion = conclusionServices.findConclusionByVisiting(thisVisiting);
        List<Event> events = eventServices.findAll(thisConclusion);

        List<CriteriaScore> sortedCriteriaScore = criteriaScoreServices.sortCriteria(criteriaScore);
        boolean access = false;
        if (((schedule.getVisitedUser().equals(user) || user.isAdmin()) && schedule.getStatus().contains(Status.WAITING_TO_CONFIRM))
                || ((schedule.getVisitorUser().equals(user) || user.isAdmin()) && schedule.getStatus().contains(Status.WAITING_TO_CONFIRM_EVENT))) {
            access = true;
        }

        boolean subjectToEditing = false;
        if ((schedule.getVisitorUser().equals(user) || user.isAdmin())
                && schedule.getStatus().contains(Status.WAITING_TO_CONFIRM)) {
            subjectToEditing = true;
        }

        boolean summingUpSubjectToEditing = false;
        if ((schedule.getVisitorUser().equals(user) || user.isAdmin())
                && thisVisiting.getConclusion() != null){
            summingUpSubjectToEditing = true;
        }

        boolean subjectToCompletionEvent = false;
        int notConfirmedEventSize = 0;
        for (Event event:thisVisiting.getConclusion().getEvents()) {
            if (!event.isCompletionMark()){
                ++notConfirmedEventSize;
            }
        }
        if ((schedule.getVisitedUser().equals(user) || user.isAdmin())
                && notConfirmedEventSize>0
                && schedule.getStatus().contains(Status.CONFIRMED)){
            subjectToCompletionEvent=true;
        }

        List<VisitingCriteria> visitingCriteria = new ArrayList<>();
        for (CriteriaScore score : sortedCriteriaScore) {
            visitingCriteria.add(visitingCriteriaService.findById(score.getVisitingCriteria().getId()));
        }

        model.put("access", access);
        model.put("subjectToCompletionEvent",subjectToCompletionEvent);
        model.put("subjectToEditing", subjectToEditing);
        model.put("summingUpSubjectToEditing", summingUpSubjectToEditing);
        model.put("criteriaScore", sortedCriteriaScore);
        model.put("criteries", visitingCriteria);
        model.put("visiting", thisVisiting);
        model.put("conclusion",thisConclusion);
        model.put("events",events);
        return "visiting";
    }

    @GetMapping("edit/{schedule}")
    public String editVisiting(@PathVariable Schedule schedule, Map<String, Object> model) {
        Iterable<StudyGroup> studyGroups = studyGroupServices.findAll();
        Iterable<Position> positions = positionServices.findAll();
        Iterable<AcademicDiscipline> academicDisciplines = academicDisciplineServices.findAll();
        Visiting thisVisiting = visitingServices.findVisitingBySchedule(schedule);

        Set<CriteriaScore> criteriaScore = thisVisiting.getCriteriaScore();
        List<CriteriaScore> sortedCriteriaName = new ArrayList<>(criteriaScoreServices.sortCriteria(criteriaScore));

        List<VisitingCriteria> visitingCriteria = new ArrayList<>();
        for (CriteriaScore score : sortedCriteriaName) {
            visitingCriteria.add(visitingCriteriaService.findById(score.getVisitingCriteria().getId()));
        }

        model.put("criteriaScore", sortedCriteriaName);
        model.put("criteries", visitingCriteria);
        model.put("visiting", thisVisiting);
        model.put("studyGroups", studyGroups);
        model.put("positions", positions);
        model.put("academicDisciplins", academicDisciplines);
        return "editVisiting";
    }

    @GetMapping("summing-up/{schedule}")
    public String summingUp(@PathVariable Schedule schedule, Map<String, Object> model) {

        model.put("schedule", schedule);
        return "summingUp";
    }

    @GetMapping("edit/summing-up/{schedule}")
    public String editSummingUp(@PathVariable Schedule schedule, Map<String, Object> model) {
        Visiting thisVisiting = visitingServices.findVisitingBySchedule(schedule);
        Conclusion thisConclusion = conclusionServices.findConclusionByVisiting(thisVisiting);
        List<Event> events = eventServices.findAll(thisConclusion);

        model.put("visiting", thisVisiting);
        model.put("conclusion", thisConclusion);
        model.put("events", events);
        return "editSummingUp";
    }

    @PostMapping("summing-up/add/conclusion/{visiting}")
    public ResponseEntity<Long> addConclusion(@PathVariable Visiting visiting,ConclusionRequestDTO conclusionRequestDTO,Map<String,Object> model){
        Conclusion conclusion = new Conclusion(conclusionRequestDTO.getVirtuesOfOccupation(),conclusionRequestDTO.getProblems(),visiting);
        visiting.setConclusion(conclusion);

        conclusionServices.save(conclusion);
        visitingServices.save(visiting);

        return new ResponseEntity<>(conclusion.getId(),HttpStatus.OK);
    }

    @PostMapping(value="summing-up/add/event/{schedule}",consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity addEvents(@PathVariable Schedule schedule,@RequestBody ListEventRequestDTO events, Map<String,Object> model){
        Conclusion conclusion = conclusionServices.findById(events.getConclusionId());
        Set<Status> statusSet = new HashSet<>();
        statusSet.add(Status.WAITING_TO_CONFIRM);

        Set<Event> eventsSet = new HashSet<>();
        for (EventRequestDTO event: events.getEvents()) {
                eventsSet.add(eventServices.addEvent(event.getEventName(),conclusion));
        }

        conclusion.setEvents(eventsSet);
        conclusionServices.save(conclusion);

        schedule.setStatus(statusSet);
        scheduleServices.save(schedule);

        return new ResponseEntity(HttpStatus.OK);
    }

    @PostMapping("summing-up/edit/{conclusion}")
    public ResponseEntity editSummingUp(@PathVariable Conclusion conclusion, ConclusionRequestDTO conclusionRequestDTO, Map<String, Object> model) {
        conclusion.setProblems(conclusionRequestDTO.getProblems());
        conclusion.setVirtuesOfOccupation(conclusionRequestDTO.getVirtuesOfOccupation());

        conclusionServices.save(conclusion);
        return new ResponseEntity(HttpStatus.OK);
    }

    @PostMapping(value = "summing-up/edit/event/{conclusion}",consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity editEvents(@RequestBody ListEventRequestDTO events,@PathVariable Conclusion conclusion,Map<String ,Object> model){
        Set<Event> eventsSet = new HashSet<>();
        for (EventRequestDTO event: events.getEvents()) {
            if (event.getEventId() != null){
                eventsSet.add(eventServices.editEvent(event.getEventId(),event.getEventName()));
            }else {
                eventsSet.add(eventServices.addEvent(event.getEventName(),conclusion));
            }
        }
        conclusion.setEvents(eventsSet);
        conclusionServices.save(conclusion);
        return new ResponseEntity(HttpStatus.OK);
    }

    @DeleteMapping("summing-up/delete/{event}")
    public ResponseEntity deleteEvent(@PathVariable Event event){
        try {
            eventServices.delete(event);
            return new ResponseEntity(HttpStatus.OK);
        }catch (Exception e){
            return new ResponseEntity(HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping("edit/{schedule}")
    public ResponseEntity saveEditedVisiting(@RequestParam("studyGroupId") StudyGroup studyGroup,
                                     @RequestParam("academicDisciplineId") AcademicDiscipline academicDiscipline,
                                     @RequestParam("positionId") Position position,
                                     @RequestParam("visitingId") Visiting visiting,
                                     VisitingRequestDTO visitingRequestDTO,
                                     Map<String, Object> model) {
        Set<CriteriaScore> criteriaScoreSet = visiting.getCriteriaScore();
        List<CriteriaScore> sortedCriteriaScore = criteriaScoreServices.sortCriteria(criteriaScoreSet);

        int i = 0;
        for (Integer criteriaScore : visitingRequestDTO.getCriteriaScoreIds()) {
            sortedCriteriaScore.get(i).setScore(criteriaScore);
            criteriaScoreServices.save(sortedCriteriaScore.get(i));
            i++;
        }

        new Visiting();
        visiting.setPurposeOfTheVisit(visitingRequestDTO.getPurposeOfTheVisit());
        visiting.setNumberOfStudents(visitingRequestDTO.getNumberOfStudents());
        visiting.setLessonTopic(visitingRequestDTO.getLessonTopic());
        visiting.setDate(visitingRequestDTO.getDate());
        visiting.setStudyGroup(studyGroup);
        visiting.setPosition(position);
        visiting.setAcademicDiscipline(academicDiscipline);
        visitingServices.save(visiting);
        return new ResponseEntity(HttpStatus.OK);
    }

    @PostMapping(value = "edit/event/completion-mark/{schedule}",consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity editCompletionMark(@PathVariable Schedule schedule,@RequestBody boolean[] completionMarks,Map<String,Object> model){
        List<Event> events= eventServices.findAll(schedule.getVisiting().getConclusion());
        Set<Status> statusSet = new HashSet<>();
        statusSet.add(Status.WAITING_TO_CONFIRM_EVENT);

        int i = 0;
        for (Event event:events) {
            event.setCompletionMark(completionMarks[i]);
            i++;
        }

        schedule.setStatus(statusSet);
        scheduleServices.save(schedule);
        return new ResponseEntity(HttpStatus.OK);
    }

    @PostMapping("view/{schedule}")
    public String confirmationVisiting(@PathVariable Schedule schedule, Map<String, Object> model) {
        Set<Status> statusSet = new HashSet<>();
        statusSet.add(Status.CONFIRMED);
        schedule.setStatus(statusSet);
        scheduleServices.save(schedule);
        return "redirect:/home";
    }


    @PostMapping("add/visiting")
    public ResponseEntity createSchedule(@RequestParam("studyGroupId") StudyGroup studyGroup,
                                         @RequestParam("scheduleId") Schedule schedule,
                                         @RequestParam("academicDisciplineId") AcademicDiscipline academicDiscipline,
                                         @RequestParam("positionId") Position position,
                                         VisitingRequestDTO visitingRequestDTO, Map<String, Object> model) {
        Visiting visitingFromDb = visitingServices.findFromDb(schedule, visitingRequestDTO.getDate());
        List<VisitingCriteria> criteriaLists = new ArrayList<>();
        Set<Status> statusSet = new HashSet<>();
        statusSet.add(Status.SUMMING_UP);
        for (Long criteriaId : visitingRequestDTO.getCriterionIds()) {
            criteriaLists.add(visitingCriteriaService.findById(criteriaId));
        }


        if (visitingFromDb == null) {
            visitingServices.addVisiting(visitingRequestDTO.getPurposeOfTheVisit(),
                    visitingRequestDTO.getNumberOfStudents(),
                    visitingRequestDTO.getLessonTopic(),
                    visitingRequestDTO.getPurposeOfTheLesson(),
                    visitingRequestDTO.getDate(), studyGroup,
                    position, academicDiscipline,
                    criteriaLists,
                    schedule);
            visitingFromDb = visitingServices.findFromDb(schedule, visitingRequestDTO.getDate());
            schedule.setStatus(statusSet);
            schedule.setVisiting(visitingFromDb);
            scheduleServices.save(schedule);
            int i = 0;
            for (Integer criteriaScore : visitingRequestDTO.getCriteriaScoreIds()) {
                CriteriaScoreKey scoreKey = new CriteriaScoreKey(visitingFromDb.getId(), criteriaLists.get(i).getId());

                CriteriaScore newCriteriaScore = new CriteriaScore(scoreKey, visitingFromDb, criteriaLists.get(i), criteriaScore.intValue());
                criteriaScoreServices.save(newCriteriaScore);
                i++;
            }
            return new ResponseEntity(HttpStatus.OK);
        }
        return new ResponseEntity(HttpStatus.NOT_ACCEPTABLE);
    }
}
