<#macro login path, buttonName>
    <form action="${path}" method="post">
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Имя пользователя : </label>
            <div class="col-sm-5">
                <input type="text" name="username" class="form-control" placeholder="Имя пользователя">
            </div>
        </div>
        <div class="form-group row mt-2">
            <label class="col-sm-2 col-form-label">Пароль : </label>
            <div class="col-sm-5">
                <input type="password" name="password" class="form-control" placeholder="Пароль">
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <button class="btn btn-primary mt-2" type="submit">${buttonName}</button>
    </form>
</#macro>

<#macro logout>
    <form action="/logout" method="post">
        <button class="btn btn-primary" type="submit">Выйти</button>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
    </form>
</#macro>