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
<body>

<form id = "find" action="<%=request.getContextPath()%>/emp/findPw" method="post">
    <div class="form-floating mb-3">
        <input type="text" class="form-control rounded-4"  name = "emp_Id" placeholder="사번"/>
        <label for="emp_Id">사번</label>
    </div>
    <div class="form-floating mb-3">
        <input type="text" class="form-control rounded-4" id="emp_Name" name = "emp_Name" placeholder="성명"/>
        <label for="emp_Name">성명</label>
    </div>
    <div class="form-floating mb-3">
        <input type="email" class="form-control rounded-4" id="emp_Email" name = "emp_Email"placeholder="회원가입시 입력한 이메일"/>
        <label for="emp_Email">이메일주소</label>
        <p style="margin-left: 5px">
            <small class="text-muted me-1"> * 회원가입시 입력한 이메일주소</small>
        </p>
    </div>
    <button class="w-100 mb-2 btn btn-lg rounded-4 btn-secondary" type="button" onclick="tempPwd();">임시 비밀번호 발급</button>
</form>

<script>

    let msg = "${msg}";
    if(msg !== "")
    {
        alert(msg);
    }


    function tempPwd()
    {
        let total = $("#find").serialize();
        console.log('total : '+total)

        $.ajax({
            url: "<%=request.getContextPath()%>/emp/findPw",
            type: "POST",
            data: total,
            success:function (data)
            {

                alert('임시비밀번호 전송에 성공했습니다.')
                window.close()

            },
            error:function(){
                alert('에러가 발생했습니다.')
            }
        })

    }
</script>

</body>
</html>
