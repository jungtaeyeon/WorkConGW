<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>WorkConGW</title>
    <script src="https://kit.fontawesome.com/3a92c85ff9.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
            crossorigin="anonymous"
    />
    <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
            crossorigin="anonymous"
    ></script>
</head>

<style>
    ul li {list-style : none;
        font-weight: bold;
        font-size: 40px;
    }

</style>
<body>

<div class="card o-hidden border-0 shadow-lg my-5">
    <div class = "jumbotron">
        <h2>사번은 : </h2> <br/>
        <ul>
            <c:forEach items = "${empVO}" var = "emp">
                <li>${emp.emp_Id}</li><br/>
            </c:forEach>
        </ul>
        <h2>입니다.</h2>
    <br/>
        <button type="button" class="btn btn-dark" onclick="location.href='<%=request.getContextPath()%>/common/loginForm'">로그인페이지</button>
    </div>
</div>





</body>
</html>
