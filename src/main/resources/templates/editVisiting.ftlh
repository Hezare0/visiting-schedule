<#import "parts/common.ftlh" as c>
<#import "parts/createObject.ftlh" as cr>
<#include "parts/security.ftlh">

<@c.page>
    <div>
        <div class="input-group mb-3">
            <span class="input-group-text" id="basic-addon1">Цель посещения занятия</span>
            <input type="text" class="form-control" value="${visiting.purposeOfTheLesson}"
                   name="purposeOfTheVisit" id="purposeOfTheVisit">
        </div>

        <div class="input-group mb-3">
            <span class="input-group-text" id="basic-addon1">Дата</span>
            <input type="date" class="form-control" value="${visiting.date}" name="visitingDate"
                   id="visitingDate">
        </div>
        <div class="input-group mb-3">
            <select class="form-select" id="studyGroupsSelect" aria-label="Default select example">
                <option value="${visiting.studyGroup.id}" selected disabled hidden>${visiting.studyGroup.groupName}</option>
                <#list studyGroups as studyGroup>
                    <option value="${studyGroup.id!"No value"}">${studyGroup.groupName!"No value"}</option>
                </#list>
            </select>
        </div>
        <div class="input-group mb-3">
            <span class="input-group-text" id="basic-addon1">Количество обучающихся</span>
            <input type="text" class="form-control" value="${visiting.numberOfStudents}"
                   name="numberOfStudents" id="numberOfStudents">
        </div>

        <div class="input-group mb-3">
            <select class="form-select" id="positionsSelect" aria-label="Default select example">
                <option value="${visiting.position.id}" selected disabled hidden>${visiting.position.positionName}</option>
                <#list positions as position>
                    <option value="${position.id!"No value"}">${position.positionName!"No value"}</option>
                </#list>
            </select>
        </div>

        <div class="input-group mb-3">
            <select class="form-select" id="academicDisciplinsSelect" aria-label="Default select example">
                <option value="${visiting.academicDiscipline.id}" selected disabled hidden>${visiting.academicDiscipline.disciplineName}</option>
                <#list academicDisciplins as academicDiscipline>
                    <option value="${academicDiscipline.id!"No value"}">${academicDiscipline.disciplineName!"No value"}</option>
                </#list>
            </select>
        </div>
        <div class="input-group mb-3">
            <span class="input-group-text" id="basic-addon1">Тема занятия</span>
            <input type="text" class="form-control" value="${visiting.purposeOfTheLesson}" name="lessonTopic"
                   id="lessonTopic">
        </div>
        <div class="input-group mb-3">
            <span class="input-group-text" id="basic-addon1">Цель занятия</span>
            <input type="text" class="form-control" value="${visiting.lessonTopic}" name="purposeOfTheLesson"
                   id="purposeOfTheLesson">
        </div>

        <div class="mb-3">
            <#assign
            currentScore = 0
            maxScore = 0
            >
            <#list criteries as criteria>
                <#assign
                maxScore = (maxScore!0) + 3
                >
            </#list>
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
                                <tbody>
                                <#list criteries as criteria>
                                    <tr>
                                        <td colspan="3"><b>${criteria.criteriaName}</b></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">1</th>
                                        <td>${criteria.valueOfOnePoint}</td>
                                        <td>
                                            <input class="form-check-input" type="radio"
                                                   name="${criteria.criteriaName}"
                                                   id="${criteria.criteriaName}"
                                                   value="1" onchange="selectValueOfCriteria();">
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row">2</th>
                                        <td>${criteria.valueOfTwoPoint}</td>
                                        <td>
                                            <input class="form-check-input" type="radio"
                                                   name="${criteria.criteriaName}"
                                                   id="${criteria.criteriaName}"
                                                   value="2" onchange="selectValueOfCriteria();">
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row">3</th>
                                        <td>${criteria.valueOfThreePoint}</td>
                                        <td>
                                            <input class="form-check-input" type="radio"
                                                   name="${criteria.criteriaName}"
                                                   id="${criteria.criteriaName}"
                                                   value="3" onchange="selectValueOfCriteria();">
                                        </td>
                                    </tr>
                                </#list>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <form id="submitForm">
            <div class="mb-3">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <button class="btn btn-outline-primary btn-lg mb-6" type="submit">Сохранить</button>
            </div>
        </form>
    </div>
    <script>

        let currentScore;
        let groupId;
        let positionId;
        let disciplineId;
        let status;
        let curr;
        let criteriaScore = [];
        <#list criteriaScore as score>
        criteriaScore.push(${score.score});
        </#list>
        let str = "${schedule.visitingWeek}";
        let splitDate = str.split('-W');
        let week = splitDate[1].split("0")
        if (week.length === 2) {
            curr = new Date(getDateOfWeek(splitDate[0], week[1]));
        } else {
            curr = new Date(getDateOfWeek(splitDate[0], week[0]));
        }
        document.addEventListener("DOMContentLoaded", () => {

            document.getElementById("scoreInfo").innerHTML = 'Общий балл: 0 (Максимальный балл ${maxScore})';
            let dataDoc = document.getElementById("visitingDate");
            let inputData = new Date(curr);
            let month = inputData.getMonth() + 1
            let lastDayOfWeek = new Date(inputData);
            lastDayOfWeek.setDate(inputData.getDate() + 6);
            dataDoc.min = inputData.getFullYear() + ((month < 10) ? "-0" : "-") + month + ((inputData.getDate() < 10) ? "-0" : "-") + inputData.getDate();
            dataDoc.max = lastDayOfWeek.getFullYear() + ((lastDayOfWeek.getMonth() < 10) ? "-0" : "-") + (lastDayOfWeek.getMonth() + 1) + ((lastDayOfWeek.getDate() < 10) ? "-0" : "-") + lastDayOfWeek.getDate();
            let i = 0;
            <#list criteries as criteria>
            document.querySelectorAll('input[name="${criteria.criteriaName}"]').forEach((elem) => {
                if (elem.value == criteriaScore[i]) {
                    elem.checked = true;
                }
            })
            i++;
            </#list>
        })
        function selectValueOfCriteria() {
            currentScore = 0
            <#list criteries as criteria>
            if (document.querySelector('input[name="${criteria.criteriaName}"]:checked') != null) {
                currentScore = (+currentScore) + (+document.querySelector('input[name="${criteria.criteriaName}"]:checked').value);
            }
            </#list>
            document.getElementById("scoreInfo").innerHTML = "Общий балл: " + currentScore + "   (Максимальный балл ${maxScore})";
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

        submitForm.onsubmit = async (e) => {
            groupId = document.querySelector("#studyGroupsSelect option:checked").value;
            positionId = document.querySelector("#positionsSelect option:checked").value;
            disciplineId = document.querySelector("#academicDisciplinsSelect option:checked").value;
            let criteriaScore = [];
            let criteria = [];
            e.preventDefault();
            let visitingRequestDTO = new FormData(submitForm);
            <#list criteries as criteria>
            criteriaScore.push(document.querySelector('input[name="${criteria.criteriaName}"]:checked').value);
            criteria.push(${criteria.id});
            </#list>
            visitingRequestDTO.append("studyGroupId", groupId)
            visitingRequestDTO.append("purposeOfTheVisit", document.getElementById('purposeOfTheVisit').value)
            visitingRequestDTO.append("numberOfStudents", document.getElementById('numberOfStudents').value)
            visitingRequestDTO.append("lessonTopic", document.getElementById('lessonTopic').value)
            visitingRequestDTO.append("purposeOfTheLesson", document.getElementById('purposeOfTheLesson').value)
            visitingRequestDTO.append("positionId", positionId)
            visitingRequestDTO.append("visitingId",${visiting.id})
            visitingRequestDTO.append("academicDisciplineId", disciplineId)
            visitingRequestDTO.append("criteriaScoreIds", criteriaScore)
            visitingRequestDTO.append("date", document.getElementById('visitingDate').value)
            visitingRequestDTO.append("criterionIds", criteria)
            visitingRequestDTO.append("scheduleId", ${schedule.id})
            let response = await fetch('/schedule/edit/${visiting.schedule.id}', {
                method: 'POST',
                body: visitingRequestDTO
            });
        }

    </script>
</@c.page>