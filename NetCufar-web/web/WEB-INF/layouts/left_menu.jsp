<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>

<head>
    <link rel="stylesheet" media="screen" href="../../resources/css/left_menu.css">
    <script src="../../resources/js/jquery-2.1.3.min.js"></script>
    <script src="../../resources/js/jquery-ui-1.11.2.min.js"></script>
    <link href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet"/>

</head>

<body>

<div class="navbar navbar-left">
    <nav id="navigation">
        <ul>
            <c:forEach items="${categoryAndSubCategories}" var="categories">
                <li class="dropdown" rel="${categories.key.title}"><a href="#" class="my-item" id="${categories.key.title}">
                    <span><spring:message code="${categories.key.title}"/></span>
                    <ul class="dropdown-${categories.key.title}">
                        <c:forEach items="${categories.value}" var="subCategory">
                            <li><a href="#"><span><spring:message code="${subCategory.title}"></spring:message> </span></a></li>
                        </c:forEach>
                    </ul>
                </a></li>
            </c:forEach>
        </ul>
    </nav>
</div>



<script>
    /*
*	Remove jQuery if you want pure css dropdown menus
*/
    jQuery(document).ready(function($) {
        $("li.dropdown").hover(function() {
            var id = $(this).attr("rel");
            $(this).toggleClass("active");
            $("ul.dropdown-" + id).toggle("fade", 250);
        });
    });
</script>

<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.min.js">
</script>

<script type="text/javascript">

    var messages = [];
    <c:forEach var="key" items="${keys}">
    messages["<spring:message text="${key}" javaScriptEscape="true"/>"] = "<spring:message code='${key}' javaScriptEscape='true' />";
    </c:forEach>


    $(document).on('click','.my-item',function(event){
        event.preventDefault();
        var supercategory = event.currentTarget.id;

        $.ajax({
            url : '/get-products-by-supercategory',
            type: 'GET',
            dataType: 'json',
            contentType: 'application/json',
            data : ({
                supercategory: supercategory
            }),
            success: function (data) {
                $('.products').empty();
                $.each(data, function(id, key){
                    var product = ///// icon-green (c:choose) missing
                        "<div class=\"col-sm-4\">\n" +
                        "   <div class=\"product\">\n" +
                        "       <div class=\"product-img\">\n" +
                        "           <a><img src=\"https://drive.google.com/uc?export=download&confirm=no_antivirus&id=" + key.photo + "\" onerror=\"this.src='${contextPath}/resources/img/placeholder-image.png'\"/></a>\n" +
                        "           <div class=\"product-icons\">\n" +
                        "                   <a href=\"#\" class=\"icon\">\n" +
                        "                       <img src=\"${contextPath}/resources/img/heart.png\">\n" +
                        "                   </a>\n" +
                        "           </div>\n" +
                        "       </div>\n" +
                        "       <p class=\"product-title\">\n" +
                        "           <a href=\"${contextPath}/product/" + key.id + "\"><strong>" + key.title + "</strong></a>\n" +
                        "       </p>\n" +
                        "       <p class=\"product-desc\">" + key.description + "</p>\n" +
                        "       <p class=\"product-category\">" + messages[key.category] + "</p>\n" +
                        "       <p class=\"product-price\">" + key.cost + "</p>\n" +
                        "   </div>\n" +
                        "</div>";
                    $('.products').append(product);
                })
            }
        });
        return false;
    });
</script>
</body>