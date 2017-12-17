<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>

<script type="text/javascript">
    function findProducts() {
        $.ajax({
            scriptCharset:"utf-8",
            type: 'GET',
            url: "/productSearch",
            dataType: 'json',
            data: {
                subString: encodeURIComponent($('#search').val())
            },
            success: function (products) {
                $('#myUL').empty();
                $.each(products, function (idx, value) {
                    var newInput = ("<li>"+"<a href="+"${contextPath}/product/"+value.id+">"
                        +value.title+ " | " +value.superCategory+ " - " +value.category+"</a>"+"</li>");
                    $('#myUL').append(newInput);
                })
            },
            error: function () {
                alert('Error');
            }
        })
    }
</script>

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Log in with your account</title>

    <link href="${contextPath}/resources/css/wrapper/font-awesome.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/wrapper/noJS.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/wrapper/style.css" rel="stylesheet">

    <link rel="stylesheet"  href="../../resources/css/main.css">
    <link rel="stylesheet"  href="../../resources/css/bootstrap.min.css">

    <script src="../../resources/js/jquery-3.2.1.min.js"></script>
    <script src="../../resources/js/drop-down.js"></script>
    <script>
        function changeLocaleFunction(locale) {

            $.ajax({
                type : "POST",
                contentType : "application/json",
                url : "/changeLocale?${_csrf.parameterName}=${_csrf.token}",
                data : JSON.stringify(locale),
                dataType : 'json',
                complete:function () {
                   location.reload();
                }
            });

        }
    </script>

</head>

<style>
    body {
        background: #ececec;
    }
</style>

<body>

    <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="${contextPath}/welcome"><spring:message code="headerShop"/></a>
                <button type="submit" onclick="changeLocaleFunction('en')">EN</button>
                <button type="submit" onclick="changeLocaleFunction('ru')">RU</button>
                <c:if test="${pageContext.request.userPrincipal.name != null}">
                    <a class="navbar-text">
                        <spring:message code="headerWelcome"/>, ${pageContext.request.userPrincipal.name}
                    </a>
                </c:if>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav navbar-right">
                <div class="col-sm-4 col-md-5">
                            <form class="navbar-form" role="search" action="/catalog">
                                <div class="input-group">
                                    <input id="search" type="text" class="form-control"  autocomplete="off"
                                           placeholder="<spring:message code="headerSearch"/>" name="q"
                                       onkeyup="findProducts()">
                                    <div class="input-group-btn">
                                        <button class="btn btn-default" type="submit">
                                            <i class="glyphicon glyphicon-search"></i>
                                        </button>
                                    </div>
                                </div>
                            </form>
                            <div class="dropdown" id="desired_element" style="max-height: 500px;  overflow: auto; position: fixed">
                                <ul id="myUL">

                                </ul>
                            </div>
                        </div>
                    <li><a class="wrapper-dropdown-5" href="${contextPath}/welcome"><spring:message code="headerStartPage"/></a></li>
                    <li><a href="${contextPath}/about"><spring:message code="headerAbout"/></a></li>
                    <li>
                        <div id="dd" class="wrapper-dropdown-5" tabindex="1"><spring:message code="headerAccount"/>
                            <ul class="dropdown">
                                <li><a href="${contextPath}/account"><i class="icon-user"></i><spring:message code="headerAccount"/></a></li>
                                <li><a href="${contextPath}/my_products"><i class="icon-list"></i><spring:message code="headerMenuMyProducts"/></a></li>
                                <c:if test="${pageContext.request.userPrincipal.name != null}">
                                    <li><a href="${contextPath}/favorites"><i class="icon-list"></i><spring:message code="headerMenuFavorites"/></a></li>
                                </c:if>
                                <c:if test="${pageContext.request.isUserInRole(\"ROLE_ADMIN\")}">
                                    <li><a href="${contextPath}/not_moderated"><i class="icon-list"></i><spring:message code="headerMenuProductModeration"/></a></li>
                                </c:if>
                                <c:if test="${pageContext.request.isUserInRole(\"ROLE_ADMIN\")}">
                                    <li><a href="${contextPath}/all_profiles"><i class="icon-list"></i><spring:message code="headerMenuAllProfiles"/></a></li>
                                </c:if>
                                <%--<li><a href="#"><i class="icon-cog"></i><spring:message code="headerMenuSettings"/></a></li>--%>
                                <li>
                                    <c:if test="${pageContext.request.userPrincipal.name != null}">
                                        <form id="logoutForm" method="POST" action="${contextPath}/logout">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                        </form>
                                        <a class="btn btn-default" onclick="document.forms['logoutForm'].submit()"><spring:message code="headerMenuLogOut"/></a>
                                    </c:if>

                                    <c:if test="${pageContext.request.userPrincipal.name == null}">
                                        <a class="btn btn-default" href="${contextPath}/login"><spring:message code="headerMenuLogIn"/></a>
                                    </c:if>
                                </li>

                            </ul>
                        </div>
                        <%--a onmouseover="down()"href="${contextPath}/profile">Profile</a--%>

                    </li>

                </ul>
            </div>
        </div>
    </div>

</body>