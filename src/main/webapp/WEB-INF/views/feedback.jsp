<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form" %>
<html xmlns:th="http://www.thymeleaf.org">
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content=" width=device-width, initial-scale=1.0">

    <title>Netcufar | FeedBack</title>

</head>

<body>
<%@include file="../layouts/preloader.jsp"%>
<%@include file="../layouts/high_menu_bar.jsp"%>
<f:form class="content" method="post" acceptCharset="utf-8">
    <div class="col-md-12 col-md-offset-1">
        <div class="form-group row has-feedback">
            <label class="col-2 col-form-label">От кого</label>
            <div class="col-10">
                <input class="form-control" type="text" name="emailFrom" pattern="([a-z0-9_\.-])+@[a-z0-9-]+\.([a-z]{2,4}\.)?[a-z]{2,4}$"/>
            </div>
        </div>
        <div class="form-group row has-feedback">
            <label class="col-2 col-form-label">Тема письма</label>
            <div class="col-10">
                <input class="form-control" type="text" name="about" pattern="[0-9а-яА-ЯёЁa-zA-Z\s-]{1,70}$"/>
            </div>
        </div>
        <div class="form-group row has-feedback">
            <label class="col-2 col-form-label">Текст</label>
            <textarea class="form-control" rows="5" name="message" pattern="[0-9а-яА-ЯёЁa-zA-Z]{1,500}$"></textarea>
        </div>
        <button type="submit" class="btn">Отправить</button>
    </div>
</f:form>

<script type="text/javascript">$(document).ready(function() {

    $('#emailFrom').blur(function() {
        if($(this).val() != '') {
            var pattern = /^([a-z0-9_\.-])+@[a-z0-9-]+\.([a-z]{2,4}\.)?[a-z]{2,4}$/i;
            if(pattern.test($(this).val())){
                $(this).css({'border' : '1px solid #04f92d'});
            } else {
                $(this).css({'border' : '1px solid #ff0000'});
            }
        }
    });

    $('#theme').blur(function() {
        if($(this).val() != '') {
            var pattern = /^[0-9а-яА-ЯёЁa-zA-Z]{1,70}$/i;
            if(pattern.test($(this).val())){
                $(this).css({'border' : '1px solid #04f92d'});
            } else {
                $(this).css({'border' : '1px solid #ff0000'});
            }
        }
    });

    $('#comment').blur(function() {
        if($(this).val() != '') {
            var pattern = /^[0-9а-яА-ЯёЁa-zA-Z]{1,500}$/i;
            if(pattern.test($(this).val())){
                $(this).css({'border' : '1px solid #04f92d'});
            } else {
                $(this).css({'border' : '1px solid #ff0000'});
            }
        }
    });
})
</script>
</body>