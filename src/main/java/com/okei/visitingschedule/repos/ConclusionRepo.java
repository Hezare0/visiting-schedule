package com.okei.visitingschedule.repos;

import com.okei.visitingschedule.entity.schedule.Conclusion;
import com.okei.visitingschedule.entity.schedule.Event;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ConclusionRepo extends JpaRepository<Conclusion, Long> {
}