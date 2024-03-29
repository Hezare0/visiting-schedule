package com.okei.visitingschedule.dto.event;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.io.Serializable;
import java.util.Arrays;

@JsonIgnoreProperties(ignoreUnknown = true)
public class ListEventRequestDTO implements Serializable {

    private EventRequestDTO[] events;
    private Long conclusionId;

    public ListEventRequestDTO(EventRequestDTO[] events, Long conclusionId) {
        this.events = events;
        this.conclusionId = conclusionId;
    }

    public ListEventRequestDTO(EventRequestDTO[] events) {
        this.events = events;
    }

    public ListEventRequestDTO() {
    }

    public EventRequestDTO[] getEvents() {
        return events;
    }

    public void setEvents(EventRequestDTO[] events) {
        this.events = events;
    }

    public Long getConclusionId() {
        return conclusionId;
    }

    public void setConclusionId(Long conclusionId) {
        this.conclusionId = conclusionId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ListEventRequestDTO that = (ListEventRequestDTO) o;
        return Arrays.equals(events, that.events);
    }

    @Override
    public int hashCode() {
        return Arrays.hashCode(events);
    }

    @Override
    public String toString() {
        return "ListEventRequestDTO{" +
                "events=" + Arrays.toString(events) +
                '}';
    }
}
