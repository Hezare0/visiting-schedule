<#import "parts/common.ftlh" as c>
<#import "parts/createObject.ftlh" as cr>
<#include "parts/security.ftlh">

<@c.page>
    <div>
        <form id="submitForm">
            <div class="input-group mb-3">
                <div class="form-floating">
                    <textarea class="form-control" required name="purposeOfTheVisit" id="purposeOfTheVisit"
                              style="height: 15vh"></textarea>
                    <label for="purposeOfTheVisit">Цель посещения занятия</label>
                </div>
            </div>
            <div class="input-group mb-3">
                <span class="input-group-text">Дата</span>
                <input type="date" required class="form-control" name="visitingDate" id="visitingDate">
            </div>
            <div class="input-group mb-3">
                <select class="form-select" required id="studyGroupsSelect" aria-label="Default select example"
                        onchange="selectedGroup(this);">
                    <option value="" selected disabled hidden>Группа</option>
                    <#list studyGroups as studyGroup>
                        <option value="${studyGroup.id!"No value"}">${studyGroup.groupName!"No value"}</option>
                    </#list>
                </select>
            </div>
            <div class="input-group mb-3">
                <span class="input-group-text">Количество обучающихся</span>
                <input type="number" class="form-control" required name="numberOfStudents" id="numberOfStudents">
            </div>

            <div class="input-group mb-3">
                <div class="form-floating">
                    <input type="text" class="form-control" name="position" id="position"
                           value="${position.positionName}" readonly>
                    <label for="position">Должность</label>
                </div>
            </div>

            <div class="input-group mb-3">
                <select class="form-select" required id="academicDisciplinsSelect" aria-label="Default select example"
                        onchange="selectedDiscipline(this);">
                    <option value="" selected disabled hidden>Учебная дисциплина</option>
                    <#list academicDisciplins as academicDiscipline>
                        <option value="${academicDiscipline.id!"No value"}">${academicDiscipline.disciplineName!"No value"}</option>
                    </#list>
                </select>
            </div>
            <div class="input-group mb-3">
                <div class="form-floating">
                    <textarea class="form-control" required name="lessonTopic" id="lessonTopic"
                              style="height: 15vh"></textarea>
                    <label for="lessonTopic">Тема занятия</label>
                </div>
            </div>
            <div class="input-group mb-3">
                <div class="form-floating">
                    <textarea class="form-control" required name="purposeOfTheLesson" id="purposeOfTheLesson"
                              style="height: 15vh"></textarea>
                    <label for="purposeOfTheLesson">Цель занятия</label>
                </div>
            </div>
            <div class="input-group mb-3">
                <select class="form-select" required id="criteriaType" onchange="changeCriteriaType(this)">
                    <option value="" selected disabled hidden>Тип критериев</option>
                    <#list criteriaTypes as type>
                        <option value="${type.name()!"No value"}">${type.typeName!"No value"}</option>
                    </#list>
                </select>
            </div>
            <div class="mb-3">
                <div class="container text-left">
                    <table class="table table-sm table-borderless">
                        <caption>
                            <label for="recipient-name" class="col-form-label" id="scoreInfo"></label>
                        </caption>
                        <thead>
                        <tr>
                            <th scope="col">Критерии <br>оценивания <br>(баллы)</th>
                            <th scope="col"></th>
                            <th scope="col">Показатели</th>
                            <th scope="col">Баллы</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td colspan="4">
                                <table class="table table-bordered table-sm">
                                    <tbody id="criteria">

                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="mb-3">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <button class="btn btn-outline-primary btn-lg mb-6" type="submit">Сохранить</button>
                <#if isAdmin>
                    <button type="button" class="btn btn-sm btn-outline-secondary me-3"
                            data-bs-toggle="modal"
                            href="#addCriteria"
                            data-bs-whatever="@getbootstrap">Добавить критерий оценивания
                    </button>
                </#if>
            </div>
        </form>
        <#if isAdmin>
            <div class="modal fade" id="addCriteria" tabindex="-1"
                 aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5">Создание критерия оценивания</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="createVisitingCriteriaForm">
                                <div class="mb-3">
                                    <div class="form-group row mt-2">
                                        <label class="col-sm-3 col-form-label">Название критерия: </label>
                                        <div class="col-sm-8 d-flex">
                                            <textarea class="form-control flex-fill" required
                                                      name="critariaName"></textarea>
                                        </div>
                                    </div>
                                    <div class="form-group row mt-2">
                                        <label class="col-sm-3 col-form-label">Значение для 1 балла: </label>
                                        <div class="col-sm-8 d-flex">
                                            <textarea class="form-control flex-fill" required type="text"
                                                      name="valueOfOnePoint"></textarea>
                                        </div>
                                    </div>
                                    <div class="form-group row mt-2">
                                        <label class="col-sm-3 col-form-label">Значение для 2 балла:</label>
                                        <div class="col-sm-8 d-flex">
                                            <textarea class="form-control flex-fill" required type="text"
                                                      name="valueOfTwoPoint"></textarea>
                                        </div>
                                    </div>
                                    <div class="form-group row mt-2">
                                        <label class="col-sm-3 col-form-label">Значение для 3 балла: </label>
                                        <div class="col-sm-8 d-flex">
                                            <textarea class="form-control flex-fill" required type="text"
                                                      name="valueOfThreePoint"></textarea>
                                        </div>
                                    </div>
                                    <div class="form-group row mt-2">
                                        <label class="col-sm-3 col-form-label">Тип критерия: </label>
                                        <div class="col-sm-8 d-flex">
                                            <select name="criteriaType" class="form-select" required>
                                                <option value="" disabled hidden selected>Откройте это меню выбора
                                                </option>
                                                <#list criteriaTypes as type>
                                                    <option value="${type.name()}">${type.typeName}</option>
                                                </#list>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                                    <input type="hidden" name="scheduleId" value="${schedule.id}">
                                    <button class="btn btn-outline-primary" type="submit">Сохранить</button>
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                        Отмена
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </#if>
    </div>
    <script>
        let maxScore
        let criteria =[];
        let currentScore;
        let groupId;
        let positionId = ${position.id};
        let disciplineId;
        let status;
        let curr;
        let str = "${schedule.visitingWeek}";
        let splitDate = str.split('-W');
        let week = splitDate[1].split("0")
        if (week.length === 2) {
            curr = new Date(getDateOfWeek(splitDate[0], week[1]));
        } else {
            curr = new Date(getDateOfWeek(splitDate[0], week[0]));
        }
        document.addEventListener("DOMContentLoaded", () => {

            let inputData = document.getElementById("visitingDate");
            inputData.valueAsDate = new Date(curr);
            let month = inputData.valueAsDate.getMonth() + 1
            let lastDayOfWeek = new Date(inputData.valueAsDate);
            lastDayOfWeek.setDate(inputData.valueAsDate.getDate() + 6);
            inputData.min = inputData.valueAsDate.getFullYear() + ((month < 10) ? "-0" : "-") + month + ((inputData.valueAsDate.getDate() < 10) ? "-0" : "-") + inputData.valueAsDate.getDate();
            inputData.max = lastDayOfWeek.getFullYear() + ((lastDayOfWeek.getMonth() < 10) ? "-0" : "-") + (lastDayOfWeek.getMonth() + 1) + ((lastDayOfWeek.getDate() < 10) ? "-0" : "-") + lastDayOfWeek.getDate();
        })

        function selectValueOfCriteria() {
            currentScore = 0

            document.querySelectorAll('#criteriaScoreRadio').forEach((elem) => {
                if (elem.checked) {
                    currentScore = (+currentScore) + (+elem.value)
                }
            })
            document.getElementById("scoreInfo").innerHTML = "Общий балл: " + currentScore + "   (Максимальный балл "+maxScore+")";
        }



        let studentNumberInput = document.getElementById('numberOfStudents')
        studentNumberInput.addEventListener('keydown', (ev) => studentNumberInputKeyDown(ev))

        function studentNumberInputKeyDown(event) {
            if (event.key === 'e'
                || event.key === '.'
                || event.key === ','
                || event.key === '+'
                || event.key === '-') {
                event.preventDefault()
            }
            if (studentNumberInput.value.length >= 2 && !(event.key == "Backspace" || event.key == "Delete")) {
                event.preventDefault()
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


        function selectedGroup(sel) {
            groupId = sel.value;
        }

        function selectedPosition(sel) {
            positionId = sel.value;
        }

        function selectedDiscipline(sel) {
            disciplineId = sel.value;
        }

        async function changeCriteriaType(sel) {
            let requestDTO = new FormData();
            let criteriaTbody = document.getElementById("criteria");
            requestDTO.append("criteriaType", sel.value);
            requestDTO.append("_csrf", "${_csrf.token}");
            let res = await fetch('select-criteria-type', {
                method: "POST",
                body: requestDTO
            })
            if (res.ok){
                criteriaTbody.innerHTML = '';
                let resJson = await res.json();
                let count = 0;
                resJson.forEach((elem)=>{
                    criteria.push(elem.criteriaId);
                    let wrapperHead = document.createElement('tr');
                    let wrapperValueOfOnePoint = document.createElement('tr');
                    let wrapperValueOfTwoPoint = document.createElement('tr');
                    let wrapperValueOfThreePoint = document.createElement('tr');
                    wrapperHead.innerHTML = [
                        '<td colspan="3"><b>'+elem.criteriaName+'</b></td>'
                    ]
                    wrapperValueOfOnePoint.innerHTML = [
                        '<th scope="row">1</th>'+
                            '<td>'+elem.valueOfOnePoint+'</td>'+
                               '<td><input class="form-check-input" checked type="radio" name="'+elem.criteriaName+'" id="criteriaScoreRadio" value="1" onchange="selectValueOfCriteria();">'+
                            '</td>'
                    ]
                    wrapperValueOfTwoPoint.innerHTML = [
                        '<th scope="row">2</th>'+
                        '    <td>'+elem.valueOfTwoPoint+'</td>'+
                        '        <td><input class="form-check-input"  type="radio" name="'+elem.criteriaName+'" id="criteriaScoreRadio" value="1" onchange="selectValueOfCriteria();">'+
                        '    </td>'
                    ]
                    wrapperValueOfThreePoint.innerHTML = [
                        '<th scope="row">3</th>'+
                        '    <td>'+elem.valueOfThreePoint+'</td>'+
                        '        <td><input class="form-check-input"  type="radio" name="'+elem.criteriaName+'" id="criteriaScoreRadio" value="1" onchange="selectValueOfCriteria();">'+
                        '    </td>'
                    ]
                    criteriaTbody.appendChild(wrapperHead);
                    criteriaTbody.appendChild(wrapperValueOfOnePoint);
                    criteriaTbody.appendChild(wrapperValueOfTwoPoint);
                    criteriaTbody.appendChild(wrapperValueOfThreePoint);
                    count++;
                })
                maxScore =count*3;
                selectValueOfCriteria();
            }else{
                criteriaTbody.innerHTML = '';
            }
        }

        createVisitingCriteriaForm.onsubmit = async (e) =>{
            e.preventDefault();
            let criteriaRequestDTO = new FormData(createVisitingCriteriaForm);
            await fetch('/admin/add/create-visiting-criteria', {
                method: 'POST',
                body: criteriaRequestDTO,
                redirect: "manual"
            }).then((res) => {
                if (res.ok) {
                    window.location.href = '/schedule/add/${schedule.id}';
                }
            });
        }

        submitForm.onsubmit = async (e) => {
            e.preventDefault();
            let criteriaScore = [];
            let visitingRequestDTO = new FormData();
            document.querySelectorAll('#criteriaScoreRadio:checked').forEach((elem) => {
                criteriaScore.push(elem.value)
            })
            visitingRequestDTO.append("studyGroupId", groupId)
            visitingRequestDTO.append("purposeOfTheVisit", document.getElementById('purposeOfTheVisit').value)
            visitingRequestDTO.append("numberOfStudents", document.getElementById('numberOfStudents').value)
            visitingRequestDTO.append("lessonTopic", document.getElementById('lessonTopic').value)
            visitingRequestDTO.append("purposeOfTheLesson", document.getElementById('purposeOfTheLesson').value)
            visitingRequestDTO.append("positionId", positionId)
            visitingRequestDTO.append("academicDisciplineId", disciplineId)
            visitingRequestDTO.append("criteriaScoreIds", criteriaScore)
            visitingRequestDTO.append("date", document.getElementById('visitingDate').value)
            visitingRequestDTO.append("criterionIds", criteria)
            visitingRequestDTO.append("scheduleId", ${schedule.id})
            visitingRequestDTO.append("_csrf", "${_csrf.token}");

            await fetch('/schedule/add/visiting', {
                method: 'POST',
                body: visitingRequestDTO,
                redirect: "manual"
            }).then((res) => {
                if (res.ok) {
                    window.location.href = '/home';
                }
            });
        }

    </script>
</@c.page>
