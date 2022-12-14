package com.okei.visitingschedule.entity.schedule;

public enum Status {
    PLANNED("Запланированно"),
    WAITING_TO_CONFIRM("В ожидании подтверждения"),
    OVERDUE("Просрочено");

    private String name;
    Status(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    @Override
    public String toString() {
        return name;
    }
}
