<#import "parts/common.ftlh" as c>
<#import "parts/createObject.ftlh" as cr>

<@c.page>
    <div>
        <div class="input-group mb-3">
            <span class="input-group-text" id="basic-addon1">Цель посещения занятия</span>
            <input type="text" class="form-control" value="${visiting.purposeOfTheLesson}" disabled
                   name="purposeOfTheVisit" id="purposeOfTheVisit">
        </div>

        <div class="input-group mb-3">
            <span class="input-group-text" id="basic-addon1">Дата</span>
            <input type="date" class="form-control" disabled value="${visiting.date}" name="visitingDate"
                   id="visitingDate">
        </div>

        <div class="input-group mb-3">
            <span class="input-group-text" id="basic-addon1">Группа</span>
            <input type="text" class="form-control" value="${visiting.studyGroup.groupName}" disabled>
        </div>


        <div class="input-group mb-3">
            <span class="input-group-text" id="basic-addon1">Количество обучающихся</span>
            <input type="text" class="form-control" value="${visiting.numberOfStudents}" disabled
                   name="numberOfStudents" id="numberOfStudents">
        </div>

        <div class="input-group mb-3">
            <span class="input-group-text" id="basic-addon1">Должность посетившего занятия</span>
            <input type="text" class="form-control" value="${visiting.position.positionName}" disabled
                   name="numberOfStudents" id="numberOfStudents">
        </div>

        <div class="input-group mb-3">
            <span class="input-group-text" id="basic-addon1">Учебная дисциплина</span>
            <input type="text" class="form-control" value="${visiting.academicDiscipline.disciplineName}" disabled
                   name="numberOfStudents" id="numberOfStudents">
        </div>

        <div class="input-group mb-3">
            <span class="input-group-text" id="basic-addon1">Тема занятия</span>
            <input type="text" class="form-control" value="${visiting.purposeOfTheLesson}" disabled name="lessonTopic"
                   id="lessonTopic">
        </div>
        <div class="input-group mb-3">
            <span class="input-group-text" id="basic-addon1">Цель занятия</span>
            <input type="text" class="form-control" value="${visiting.lessonTopic}" disabled name="purposeOfTheLesson"
                   id="purposeOfTheLesson">
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
                                                   value="1" disabled onchange="selectValueOfCriteria();">
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row">2</th>
                                        <td>${criteria.valueOfTwoPoint}</td>
                                        <td>
                                            <input class="form-check-input" type="radio"
                                                   name="${criteria.criteriaName}"
                                                   id="${criteria.criteriaName}"
                                                   value="2" disabled onchange="selectValueOfCriteria();">
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row">3</th>
                                        <td>${criteria.valueOfThreePoint}</td>
                                        <td>
                                            <input class="form-check-input" type="radio"
                                                   name="${criteria.criteriaName}"
                                                   id="${criteria.criteriaName}"
                                                   value="3" disabled onchange="selectValueOfCriteria();">
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


        <div class="input-group mb-3">
        <form action="/home" method="get">
            <div class="mb-3 me-3">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <button class="btn btn-outline-secondary btn-lg mb-6" type="submit">Назад</button>
            </div>
        </form>
                <#if access>
                    <form action="/home" method="get">
                        <div class="mb-3 me-3">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <button class="btn btn-primary btn-lg mb-6" type="submit">Подтвердить</button>
                        </div>
                    </form>
                </#if>
        </div>
    </div>


    <script>

        let currentScore;
        let criteriaScore = [];
        <#list criteriaScore as score>
        criteriaScore.push(${score.score});
        </#list>

        document.addEventListener("DOMContentLoaded", () => {
            let i = 0;
            <#list criteries as criteria>
            document.querySelectorAll('input[name="${criteria.criteriaName}"]').forEach((elem)=>{
                if (elem.value == criteriaScore[i]){
                    elem.checked = true;
                }
            })
            i++;
            </#list>
        })
    </script>
</@c.page>
