<#import "parts/common.ftlh" as c>

<@c.page>
    <div>
        <#if isEmpty[0]>
        <#else>
            <div class="card mb-3">
                <div class="card-header">
                    <div class="d-flex justify-content-between">
                        <div class="col-sm-10 align-self-center">
                            <label class="me-2">Посещения ожидающие подведения итогов</label>
                        </div>
                        <div class="col-auto align-self-center">
                            <button class="btn d-flex btn-sm" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#scheduleSummingUp" aria-expanded="true"
                                    aria-controls="scheduleSummingUp" onclick="collapseButtonClick(this)">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                     class="bi flex-fill bi-chevron-up" viewBox="0 0 16 16">
                                    <path fill-rule="evenodd"
                                          d="M7.646 4.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1-.708.708L8 5.707l-5.646 5.647a.5.5 0 0 1-.708-.708l6-6z"/>
                                </svg>
                            </button>
                        </div>
                    </div>
                </div>
                <div class="collapse show multi-collapse" id="scheduleSummingUp">
                    <div class="card-body">
                        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 row-cols-xl-5 g-4 mb-3">
                            <#assign
                            i = 0
                            >
                            <#list schedulesSummingUp as schedule>
                                <div class="col">
                                    <div class="card text-center my-3 h-100">
                                        <div class="card-header bg-transparent">${schedule.visiting.date}</div>
                                        <div class="card-body">
                                            <h5 class="card-title">Посещающий
                                                занятие: ${schedule.visitorUser.lastname} ${schedule.visitorUser.firstname} ${schedule.visitorUser.middlename!""}</h5>
                                            <h5 class="card-title">
                                                Преподаватель: ${schedule.visitedUser.lastname}  ${schedule.visitedUser.firstname}  ${schedule.visitedUser.middlename!""}</h5>
                                        </div>
                                        <div class="card-footer text-muted">
                                            <#if accessToSummingUpVisiting[i] == true>
                                                <form action="/schedule/summing-up/${schedule.id}" method="get">
                                                    <button type="submit"
                                                            class="btn btn-outline-danger btn-xs"
                                                            style="width: 100%; height: 100%">
                                                        Подвести итоги
                                                    </button>
                                                    <input type="hidden" name="_csrf"
                                                           value="${_csrf.token}">
                                                </form>
                                            <#else>
                                                <label class="col-form-label">В ожидании подтверждения итогов</label>
                                            </#if>
                                        </div>
                                    </div>
                                </div>
                                <#assign
                                i = i+1
                                >
                            </#list>
                        </div>
                    </div>
                </div>
            </div>
        </#if>
        <#if isEmpty[1]>
        <#else>
            <div class="card mb-3">
                <div class="card-header">
                    <div class="d-flex justify-content-between">
                        <div class="col-sm-10 align-self-center">
                            <label class="me-2">Посещения ожидающие подтверждения</label>
                        </div>
                        <div class="col-auto align-self-center">
                            <button class="btn d-flex btn-sm" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#scheduleWaitingToConfirmCards" aria-expanded="true"
                                    aria-controls="scheduleWaitingToConfirmCards" onclick="collapseButtonClick(this)">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                     class="bi flex-fill bi-chevron-up" viewBox="0 0 16 16">
                                    <path fill-rule="evenodd"
                                          d="M7.646 4.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1-.708.708L8 5.707l-5.646 5.647a.5.5 0 0 1-.708-.708l6-6z"/>
                                </svg>
                            </button>
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"
                                  id="scheduleBadge">
                                </span>
                        </div>
                    </div>
                </div>
                <div class="collapse show multi-collapse" id="scheduleWaitingToConfirmCards">
                    <div class="card-body">
                        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 row-cols-xl-5 g-4 mb-3">
                            <#assign
                            i = 0
                            >
                            <#list schedulesWaitingToConfirmEvent as schedule>
                                <div class="col">
                                    <div class="card text-center my-3 h-100">
                                        <div class="card-header bg-transparent">${schedule.visiting.date}</div>
                                        <div class="card-body">
                                            <h5 class="card-title">Посещающий
                                                занятие: ${schedule.visitorUser.lastname} ${schedule.visitorUser.firstname} ${schedule.visitorUser.middlename!""}</h5>
                                            <h5 class="card-title">
                                                Преподаватель: ${schedule.visitedUser.lastname}  ${schedule.visitedUser.firstname}  ${schedule.visitedUser.middlename!""}</h5>
                                        </div>
                                        <div class="card-footer text-muted">
                                            <#if accessToConfirmEvent[i] == true>
                                                <form action="/schedule/view/${schedule.id}" method="get">
                                                    <button type="submit"
                                                            class="btn btn-outline-danger btn-xs"
                                                            style="width: 100%; height: 100%">
                                                        Подтвердить
                                                        мероприятие
                                                    </button>
                                                    <input type="hidden" name="_csrf"
                                                           value="${_csrf.token}">
                                                </form>
                                            <#else>
                                                <label class="col-form-label">В ожидании подтверждения
                                                    мероприятия</label>
                                            </#if>
                                        </div>
                                    </div>
                                </div>
                                <#assign
                                i = i+1
                                >
                            </#list>
                            <#assign
                            i = 0
                            >
                            <#list schedulesWaitingToConfirm as schedule>
                                <div class="col">
                                    <div class="card text-center my-3 h-100">
                                        <div class="card-header bg-transparent">${schedule.visiting.date}</div>
                                        <div class="card-body">
                                            <h5 class="card-title">Посещающий
                                                занятие: ${schedule.visitorUser.lastname} ${schedule.visitorUser.firstname} ${schedule.visitorUser.middlename!""}</h5>
                                            <h5 class="card-title">
                                                Преподаватель: ${schedule.visitedUser.lastname}  ${schedule.visitedUser.firstname}  ${schedule.visitedUser.middlename!""}</h5>
                                        </div>
                                        <div class="card-footer text-muted">
                                            <#if accessToConfirmVisiting[i] == true>
                                                <form action="/schedule/view/${schedule.id}" method="get">
                                                    <button type="submit"
                                                            class="btn btn-outline-danger btn-xs"
                                                            style="width: 100%; height: 100%">
                                                        Подтвердить
                                                        посещение
                                                    </button>
                                                    <input type="hidden" name="_csrf"
                                                           value="${_csrf.token}">
                                                </form>
                                            <#else>
                                                <form action="/schedule/view/${schedule.id}" method="get">
                                                    <button type="submit"
                                                            class="btn btn-outline-warning btn-xs"
                                                            style="width: 100%; height: 100%">
                                                        Редактировать посещение
                                                    </button>
                                                    <input type="hidden" name="_csrf"
                                                           value="${_csrf.token}">
                                                </form>
                                            </#if>
                                        </div>
                                    </div>
                                </div>
                                <#assign
                                i = i+1
                                >
                            </#list>
                        </div>
                    </div>
                </div>
            </div>
        </#if>
        <#if isEmpty[2]>
        <#else>
            <div class="card mb-3">
                <div class="card-header">
                    <div class="d-flex justify-content-between">
                        <div class="col-sm-10 align-self-center">
                            <label class="me-2">Запланированные посещения</label>
                        </div>
                        <div class="col-auto align-self-center">
                            <button class="btn d-flex btn-sm" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#schedulePlannedCards" aria-expanded="true"
                                    aria-controls="schedulePlannedCards" onclick="collapseButtonClick(this)">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                     class="bi flex-fill bi-chevron-up" viewBox="0 0 16 16">
                                    <path fill-rule="evenodd"
                                          d="M7.646 4.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1-.708.708L8 5.707l-5.646 5.647a.5.5 0 0 1-.708-.708l6-6z"/>
                                </svg>
                            </button>
                        </div>
                    </div>
                </div>
                <div class="collapse show multi-collapse" id="schedulePlannedCards">
                    <div class="card-body">
                        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 row-cols-xl-5 g-4 mb-3">
                            <#assign
                            i = 0
                            >
                            <#list schedulesPlanned as schedule>
                                <div class="col">
                                    <div class="card text-center my-3 h-100">
                                        <div class="card-header bg-transparent">${schedule.visitingWeek}</div>
                                        <div class="card-body">
                                            <h5 class="card-title">Посещающий
                                                занятие: ${schedule.visitorUser.lastname} ${schedule.visitorUser.firstname} ${schedule.visitorUser.middlename!""}</h5>
                                            <h5 class="card-title">
                                                Преподаватель: ${schedule.visitedUser.lastname}  ${schedule.visitedUser.firstname}  ${schedule.visitedUser.middlename!""}</h5>
                                        </div>
                                        <div class="card-footer text-muted">
                                            <#if accessToCreateVisiting[i] == true>
                                                <form class="me-3" action="/schedule/add/${schedule.id}"
                                                      method="get">
                                                    <button type="submit"
                                                            class="btn btn-outline-warning btn-xs"
                                                            style="width: 100%; height: 100%">
                                                        Начать
                                                        посещение
                                                    </button>
                                                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                                                </form>
                                            <#else>
                                                <label class="col-form-label">Посещение запланировано</label>
                                            </#if>
                                        </div>
                                    </div>
                                </div>
                                <#assign
                                i = i+1
                                >
                            </#list>
                        </div>
                    </div>
                </div>
            </div>
        </#if>
        <#if isEmpty[3]>
        <#else>
            <div class="card mb-3">
                <div class="card-header">
                    <div class="d-flex justify-content-between">
                        <div class="col-sm-10 align-self-center">
                            <label class="me-2">Прошедшие посещения</label>
                        </div>
                        <div class="col-auto align-self-center">
                            <button class="btn d-flex btn-sm" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#scheduleConfirmedCards" aria-expanded="true"
                                    aria-controls="scheduleConfirmedCards" onclick="collapseButtonClick(this)">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                     class="bi flex-fill bi-chevron-up" viewBox="0 0 16 16">
                                    <path fill-rule="evenodd"
                                          d="M7.646 4.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1-.708.708L8 5.707l-5.646 5.647a.5.5 0 0 1-.708-.708l6-6z"/>
                                </svg>
                            </button>
                        </div>
                    </div>
                </div>
                <div class="collapse show multi-collapse" id="scheduleConfirmedCards">
                    <div class="card-body">
                        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 row-cols-xl-5 g-4 mb-3">
                            <#assign
                            i = 0
                            >
                            <#list schedulesConfirmed as schedule>
                                <div class="col">
                                    <div class="card text-center my-3 h-100">
                                        <div class="card-header bg-transparent">${schedule.visiting.date}</div>
                                        <div class="card-body">
                                            <h5 class="card-title">Посещающий
                                                занятие: ${schedule.visitorUser.lastname} ${schedule.visitorUser.firstname} ${schedule.visitorUser.middlename!""}</h5>
                                            <h5 class="card-title">
                                                Преподаватель: ${schedule.visitedUser.lastname}  ${schedule.visitedUser.firstname}  ${schedule.visitedUser.middlename!""}</h5>
                                            <#if notConfirmedEventSize[i] gt 0>
                                                <h5 class="card-title">
                                                    Колличество неподтвержденных
                                                    мероприятий: ${notConfirmedEventSize[i]}</h5>
                                            </#if>
                                        </div>
                                        <div class="card-footer text-muted">
                                            <form action="/schedule/view/${schedule.id}" method="get">
                                                <button type="submit"
                                                        class="btn btn-outline-info btn-xs"
                                                        style="width: 100%; height: 100%">
                                                    <#if (accessToEditEventStatus[i] == true)&&(notConfirmedEventSize[i] gt 0)>
                                                        Подтвердить выполнение мероприятия
                                                    <#else>
                                                        Просмотреть посещение
                                                    </#if>
                                                </button>
                                                <input type="hidden" name="_csrf"
                                                       value="${_csrf.token}">
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <#assign i++>
                            </#list>
                        </div>
                    </div>
                </div>
            </div>
        </#if>
        <#if isEmpty[4]>
        <#else>
            <div class="card mb-3">
                <div class="card-header">
                    <div class="d-flex justify-content-between">
                        <div class="col-sm-10 align-self-center">
                            <label class="me-2">Просроченные посещения</label>
                        </div>
                        <div class="col-auto align-self-center">
                            <button class="btn d-flex btn-sm" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#scheduleOverdueCards" aria-expanded="true"
                                    aria-controls="scheduleOverdueCards" onclick="collapseButtonClick(this)">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                     class="bi flex-fill bi-chevron-up" viewBox="0 0 16 16">
                                    <path fill-rule="evenodd"
                                          d="M7.646 4.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1-.708.708L8 5.707l-5.646 5.647a.5.5 0 0 1-.708-.708l6-6z"/>
                                </svg>
                            </button>
                        </div>
                    </div>
                </div>
                <div class="collapse show multi-collapse" id="scheduleOverdueCards">
                    <div class="card-body">
                        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 row-cols-xl-5 g-4 mb-3">
                            <#list schedulesOverdue as schedule>
                                <div class="col">
                                    <div class="card text-center my-3 h-100">
                                        <div class="card-header bg-transparent schedule-overdue">${schedule.visitingWeek}</div>
                                        <div class="card-body">
                                            <h5 class="card-title">Посещающий
                                                занятие: ${schedule.visitorUser.lastname} ${schedule.visitorUser.firstname} ${schedule.visitorUser.middlename!""}</h5>
                                            <h5 class="card-title">
                                                Преподаватель: ${schedule.visitedUser.lastname}  ${schedule.visitedUser.firstname}  ${schedule.visitedUser.middlename!""}</h5>
                                        </div>
                                    </div>
                                </div>
                            </#list>
                        </div>
                    </div>
                </div>
            </div>
        </#if>
    </div>
    <script>
        document.addEventListener("DOMContentLoaded", () => {
            let dataDoc = document.querySelectorAll(".card-header");
            dataDoc.forEach((elem) => {
                let curr;
                let str = elem.innerHTML;
                if (str.split('-W').length === 2) {
                    let splitDate = str.split('-W');
                    let week = splitDate[1]
                    if (week[0] == '0') {
                        week = week.split("0")
                        curr = new Date(getDateOfWeek(splitDate[0], week[1]));
                    } else {
                        curr = new Date(getDateOfWeek(splitDate[0], week));
                    }

                    let inputData = new Date(curr);
                    let month = inputData.getMonth() + 1
                    let lastDayOfWeek = new Date(inputData);
                    lastDayOfWeek.setDate(inputData.getDate() + 6);
                    let minDate = ((inputData.getDate() < 10) ? "0" : "") + inputData.getDate() + ((month < 10) ? ".0" : ".") + month + "." + inputData.getFullYear();
                    let maxDate = ((lastDayOfWeek.getDate() < 10) ? "0" : "") + lastDayOfWeek.getDate() + ((lastDayOfWeek.getMonth() < 10) ? ".0" : ".") + (lastDayOfWeek.getMonth() + 1) + "." + lastDayOfWeek.getFullYear();
                    if (elem.classList.contains('schedule-overdue')) {
                        elem.innerHTML = "Посещение было запланированно на неделю с " + minDate + " по " + maxDate;
                    } else {
                        elem.innerHTML = "Посещение запланировано на неделю с " + minDate + " по " + maxDate;
                    }
                } else if (str.split('-').length === 3) {
                    let splitDate = str.split('-');
                    elem.innerHTML = "Посещение прошло: " + splitDate[2] + "." + splitDate[1] + "." + splitDate[0];
                }
            })
            <#if isEmpty[1]>
            <#else>
            if (${badgeCount} == 0) {
                document.getElementById("scheduleBadge").hidden = true;
            } else {
                document.getElementById("scheduleBadge").innerHTML = ${badgeCount};
            }
            </#if>
        })

        function collapseButtonClick(elem) {
            if (elem.ariaExpanded == 'true') {
                elem.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-up" viewBox="0 0 16 16"> <path fill-rule="evenodd" d="M7.646 4.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1-.708.708L8 5.707l-5.646 5.647a.5.5 0 0 1-.708-.708l6-6z"/> </svg>'
            } else {
                elem.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-down" viewBox="0 0 16 16"> <path fill-rule="evenodd" d="M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z"/> </svg>';
            }
        }

        function getDateOfWeek(year, week) {
            let simple = new Date(year, 0, 1 + (week - 1) * 7, 5);
            let dow = simple.getDay();
            let ISOweekStart = simple;
            if (dow <= 4)
                ISOweekStart.setDate(simple.getDate() - simple.getDay() + 1);
            else
                ISOweekStart.setDate(simple.getDate() + 8 - (simple.getDay()));
            return ISOweekStart;
        }
    </script>
</@c.page>