<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>

<html>
<head>
    <title>Title</title>
    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${contextPath}/resources/css/account.css"/>
    <link rel="stylesheet" href="../../resources/css/bootstrap.min.css">
</head>
<body>

<div class="row">
    <div class="col-md-offset-2 col-md-8 col-lg-offset-3 col-lg-6">
        <div class="well profile">
            <div class="col-sm-12">
                <div class="col-xs-12 col-sm-8">
                    <h2>${user.username}</h2>
                    <p><strong><spring:message code="full_name"/>: </strong>${user.fio!=null && !user.fio.equals("") ? user.fio : "--"}</p>
                    <p><strong><spring:message code="from"/>: </strong>${user.city!=null && !user.city.equals("") ? user.city : "--"}</p>
                    <p><strong><spring:message code="email"/>: </strong>${user.email!=null && !user.email.equals("") ? user.email : "--"}</p>
                    <p><strong><spring:message code="telephone_number"/>: </strong>${user.telephone!=null && !user.telephone.equals("") ? user.telephone : "--"}</p>
                    <p><strong><spring:message code="sex"/>: </strong>${user.sex!=null && !user.sex.equals("") ? user.sex : "--"}</p>
                    <p><strong><spring:message code="date_of_birth"/>: </strong>${user.dateOfBirth!=null && !user.dateOfBirth.equals("") ? user.dateOfBirth : "--"}</p>
                    <%--<p><strong>Темы объявлений: </strong>--%>
                        <%--<span class="tags">Техника</span>--%>
                        <%--<span class="tags">Стиль</span>--%>
                        <%--<span class="tags">Животные</span>--%>
                        <%--<span class="tags">IvanTkachev</span>--%>
                    <%--</p>--%>
                </div>
                <div class="col-xs-12 col-sm-4 text-center">
                    <figure>
                        <img src="../../resources/img/dsa.jpg" alt="user" class="img-circle img-responsive">
                        <figcaption class="ratings">
                            <p><spring:message code="rating"/>
                                <a href="#">
                                    <span class="fa fa-star"></span>
                                </a>
                                <a href="#">
                                    <span class="fa fa-star"></span>
                                </a>
                                <a href="#">
                                    <span class="fa fa-star"></span>
                                </a>
                                <a href="#">
                                    <span class="fa fa-star"></span>
                                </a>
                                <a href="#">
                                    <span class="fa fa-star-o"></span>
                                </a>
                            </p>
                        </figcaption>
                    </figure>
                    <security:authorize access="(hasAnyRole('ROLE_ADMIN','ROLE_USER')) and principal.username=='${user.username}'">
                      <form method="post">
                          <sec:csrfInput/>
                          <div class="col-xs-12 text-center product-icons">
                            <a href="${contextPath}/feedback" class="icon">
                                <img src="${contextPath}/resources/img/feedback_button.png">
                            </a>
                          </div>
                          <div class="col-xs-12 text-center product-icons" id="pencil">
                            <a href="${contextPath}/profiles" class="icon">
                                <img src="${contextPath}/resources/img/pencil.png">
                            </a>
                          </div>
                      </form>
                    </security:authorize>
                </div>
            </div>
            <div class="col-xs-12 divider text-center">
                <div class="col-xs-12 col-sm-4 emphasis">
                    <h2><strong>${user.userProductList.size()}</strong></h2>
                    <p>
                        <small><spring:message code="ad"/></small>
                    </p>
                    <button class="btn btn-success btn-block">
                        <spring:message code="look"/>
                        <span class="fa fa-plus-circle">

                        </span>
                    </button>
                </div>
                <%--<div class="col-xs-12 col-sm-4 emphasis">--%>
                    <%--<h2><strong>${user.favoriteProductList.size()}</strong></h2>--%>
                    <%--<p>--%>
                        <%--<small>В избранном</small>--%>
                    <%--</p>--%>
                    <%--<button class="btn btn-info btn-block"><span class="fa fa-user"></span> Просмотреть</button>--%>
                <%--</div>--%>
                <%--<div class="col-xs-12 col-sm-4 emphasis">--%>
                    <%--<h2><strong>-1</strong></h2>--%>
                    <%--<p>--%>
                        <%--<small>Комментариев</small>--%>
                    <%--</p>--%>
                    <%--<div class="btn-group dropup btn-block">--%>
                        <%--<button type="button" class="btn btn-primary"><span class="fa fa-gear"></span> Опции</button>--%>
                        <%--<button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">--%>
                            <%--<span class="caret"></span>--%>
                            <%--<span class="sr-only">Toggle Dropdown</span>--%>
                        <%--</button>--%>
                        <%--<ul class="dropdown-menu text-left" role="menu">--%>
                            <%--<li><a href="#"><span class="fa fa-envelope pull-right"></span> Отправить email </a></li>--%>
                            <%--<li><a href="#"><span class="fa fa-list pull-right"></span> Редактировать список</a></li>--%>
                            <%--<li class="divider"></li>--%>
                            <%--<li><a href="#"><span class="fa fa-warning pull-right"></span>Сообщить о спаме</a></li>--%>
                            <%--<li class="divider"></li>--%>
                            <%--<li><a href="#" class="btn disabled" role="button"> Отписатся </a></li>--%>
                        <%--</ul>--%>
                    <%--</div>--%>
                <%--</div>--%>
        </div>
    </div>
</div>
</div>
</body>
</html>