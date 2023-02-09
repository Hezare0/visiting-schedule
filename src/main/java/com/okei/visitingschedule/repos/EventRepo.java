package com.okei.visitingschedule.repos;

import com.okei.visitingschedule.entity.schedule.Event;
import com.okei.visitingschedule.entity.schedule.Position;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EventRepo extends JpaRepository<Event, Long> {
}