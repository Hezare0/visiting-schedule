package com.okei.visitingschedule.services;

import com.okei.visitingschedule.entity.schedule.StudyGroup;
import com.okei.visitingschedule.repos.StudyGroupRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StudyGroupServices {

    private final StudyGroupRepo studyGroupRepo;
    @Autowired
    public StudyGroupServices(StudyGroupRepo studyGroupRepo) {
        this.studyGroupRepo = studyGroupRepo;
    }

    public void save(StudyGroup studyGroup){
        studyGroupRepo.save(studyGroup);
    }
    public StudyGroup findByGroupName(String groupName){
        return studyGroupRepo.findByGroupName(groupName);
    }

    public void addStudyGroup (String groupName){
        studyGroupRepo.save(new StudyGroup(groupName));
    }

    public List<StudyGroup> findAll(){
        return (List<StudyGroup>) studyGroupRepo.findAll(Sort.by(Sort.Direction.ASC,"groupName"));
    }

    public void delete(StudyGroup studyGroup){
        studyGroupRepo.delete(studyGroup);
    }

}
