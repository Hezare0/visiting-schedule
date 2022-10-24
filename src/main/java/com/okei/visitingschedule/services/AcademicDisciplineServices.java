package com.okei.visitingschedule.services;

import com.okei.visitingschedule.entity.schedule.AcademicDiscipline;
import com.okei.visitingschedule.entity.schedule.Position;
import com.okei.visitingschedule.repos.AcademicDisciplineRepo;
import com.okei.visitingschedule.repos.PositionRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AcademicDisciplineServices {

    private final AcademicDisciplineRepo academicDisciplineRepo;
    @Autowired
    public AcademicDisciplineServices(AcademicDisciplineRepo academicDisciplineRepo) {
        this.academicDisciplineRepo = academicDisciplineRepo;
    }

    public void save(AcademicDiscipline academicDiscipline){
        academicDisciplineRepo.save(academicDiscipline);
    }

    public List<AcademicDiscipline> findAll(){
        return (List<AcademicDiscipline>) academicDisciplineRepo.findAll();
    }
}
