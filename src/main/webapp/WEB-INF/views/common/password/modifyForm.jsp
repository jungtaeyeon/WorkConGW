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



    <style>
        body {
            background-color: #fff;
        }


        * {
            padding: 0;
            margin: 0;
            box-sizing: border-box;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        body, input {
            font-family: 'Noto Sans KR', sans-serif;
        }


        .container {
            position: relative;
            width: 100%;
            min-height: 100vh;
            background-color: #fff;
            overflow: hidden;
        }

        /* .container:before {
            content: '';
            position: absolute;
            width: 2000px;
            height: 2000px;
            border-radius: 50%;
            background: linear-gradient(-45deg, #7D6CFF, #7d6cfe);
            top: -10%;
            right: 45%;
            transform: translateY(-40%);
        } */

        .form-container {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
        }

        .signin {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 50%;
            z-index: 1;
        }

        .signin-form{
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            padding: 0 5rem;
            overflow: hidden;
        }

        .title {
            font-size: 4rem;
            color: #0f0f0f;
            margin-bottom: 0px;
            font-weight: 700;
            font-family: 'Passion One', sans-serif;
        }

        .sub-title {
            margin-bottom: 22px;
            font-size: 1rem;
            color: #0f0f0f;
            font-weight: 600;
        }

        .input-field {
            max-width: 380px;
            width: 100%;
            height: 60px;
            background-color: rgb(241, 239, 239);
            margin: 10px 0;
            border-radius: 20px;
            display: grid;
            grid-template-columns: 15% 85%;
            padding: 0 .4rem;
        }

        .input-field i {
            text-align: center;
            line-height: 55px;
            color: #0f0f0f;
            font-size: 1.1rem;
        }

        .input-field input {
            background: none;
            outline: none;
            border: none;
            line-height: 1;
            font-weight: 600;
            font-size: 1.1rem;
            color: #0f0f0f;
        }

        .input-field input::placeholder {
            color: #0f0f0f;
            font-weight: 500;
        }

        .login-btn {
            width: 200px;
            height: 50px;
            border: none;
            outline: none;
            border-radius: 20px;
            cursor: pointer;
            background-color: #0f0f0f;
            color: #fff;
            font-weight: 600;
            font-size: 1.2rem;
            margin: 10px 0;
            transition: .5s;
            display: flex;
            justify-content: center;
            align-items: center; /* Center vertically */
        }

        .login-btn:hover {
            background-color: #0f0f0f;
            color: #fff;
        }

        .login-info {
            display: flex;
            max-width: 340px;
            width: 100%;
            justify-content: space-between;
            padding: .4rem 0 .8rem;
            font-size: .9rem;
            font-weight: 500;
        }



        .find-idpwd,
        .find-idpwd button {
            color: #8a8a8a;
            padding: 0;
        }

        .find-idpwd button:hover,
        .save-id:hover  {
            color: #0f0f0f;
            font-weight: 600;
        }



        .panel .content {
            position: absolute;
            top: 20%;
            left: 10%;
            margin-bottom: 15px;
            color: #0f0f0f;
        }

        .panel h3 {
            margin-top: 1rem;
            font-weight: 600;
            line-height: 1;
            font-size: 1.4rem;
        }

        .panel p {
            font-size: 0.9rem;
            padding: 0.7rem 0;
        }



        .media-panel {
            display: none;
            text-align: center;
            margin-top: 5px;
            font-size: .9rem;
            color: #F4F3FF;
            font-weight: 500;
        }




        @media (max-width: 1000px){
            .container{
                min-height: 800px;
                height: 100vh;
            }

            .panel-container {
                display: none;
            }

            .signin {
                width: 100%;
                left: 50%;
                top: 40%;
            }

            .media-panel {
                display: block;
            }

            .media-panel a:hover {
                font-weight: 600;
                color: #0f0f0f;
            }

        }

        .input-field {
            /* 이전 CSS */
            position: relative; /* 추가 */
        }

        #validatePwd {
            /* 추가 */
            position: absolute;
            top: 50%;
            right: 10px;
            transform: translateY(-50%);
            display: flex;
            justify-content: flex-end;
            align-items: center;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="form-container">
        <div class="signin">
            <form id = "loginForm" class="signin-form" >
                <div class="input-field">
                    <i class="fas fa-user"></i>
                    <input id = "emp_Id" name="emp_Id"  type="text" placeholder="사번" required />
                    <div id="validateId" class="float-left">
                        <span></span>
                    </div>
                </div>
                <div class="input-field">
                    <i class="fa-solid fa-shield-halved"></i>
                    <input type="password" id="oldPwd" class="form-control" placeholder="기존 비밀번호를 입력하세요">
                </div>
                <div class="input-field">
                    <i class="fa-solid fa-shield-halved"></i>
                    <input type="password" id="pwd1" class="form-control"  onclick="" placeholder="영문자,숫자,특수문자 최소 1개 포함 8 ~ 20 자리">
                    <div id="validatePwd" class="float-left">
                        <span></span>
                    </div>
                </div>
                <div class="input-field">
                    <i class="fa-solid fa-shield-halved"></i>
                    <input type="password" id="pwd2" class="form-control" placeholder="새 비밀번호를 다시 한 번 입력해 주세요">
                </div>
                <div class="login-info">
                    <div class="find-idpwd">
                    </div>
                </div>
                <div id="checkPwd1VsPwd2" class="float-left">
                    <span></span>
                </div>
                <input value="최초비밀번호변경" onclick="updatePwdgo()" class="login-btn solid" style="padding: 20px;"/>

            </form>
            <div class="media-panel">
            </div>
        </div>
    </div>
</div>

<script>

    $(document).on("input","#emp_Id", function (){
        let emp_Id  = $('#emp_Id').val();
        console.log(emp_Id)
        let str = "";
        if(emp_Id.length === "")
        {
            alert('ID를 입력해주세요')
            emp_Id.focus();
            return false
        }


        $("#validateId").html(str)
    })

    $(document).on("input","#pwd1", function (){
        let pwPattetn =  /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+])(?!.*[^a-zA-z0-9$`~!@$!%*#^?&\\(\\)\-_=+]).{8,20}$/;
        let vaildateStr = "";
        let pwd1 = $('#pwd1').val();
        let pwd2 = $('#pwd2').val();
        let str = "";

        if(pwd2)
        {
            if(pwd2 === pwd1 && pwd2 != null)
            {
                str = "<span></span>"
                flag_compare = true; // 비교가 끝난거니깐 true로 바꾸기
            }
            if(pwd2 !== pwd1)
            {
                str = '<span style="color: red">입력한 비밀번호가 서로 일치하지 않습니다.</span>'
                flag_compare = true;
            }

            $('#checkPwd1VsPwd2').html(str);
        }


        if(!pwPattetn.test(pwd1)&&pwd1!="") // 정규식 패턴에 맞지 않으면
        {
            vaildateStr = "<span style='color:red'>사용불가</span>"
            flag_vaildate = false;
        }
        else{
            vaildateStr = "<span style='color:blue'>안전</span>"
            flag_vaildate =  true
            if(pwd1.length>=12)
            {
                vaildateStr = "<span style='color: green'>매우안전</span>"
                flag_vaildate = true;
            }

        }


        if(pwd1 == ""){
            vaildateStr = "<span></span>"
            flag_vaildate = false
        }

        $("#validatePwd").html(vaildateStr)

    })


    $(document).on("input","#pwd2",function (){
        let pwd1 = $("#pwd1").val();
        let pwd2 = $("#pwd2").val();
        str = ""

        if(pwd2 === pwd1 && pwd2 != null)
        {
            str = "<span style='color: blue'>입력한 비밀번호가 일치합니다.</span>"
            flag_compare = true
        }

        if(pwd2 !== pwd1)
        {
            str = "<span style='color: red'>입력한 비밀번호가 서로 일치하지 않습니다.</span>"
            flag_compare = false
        }

        $("#checkPwd1VsPwd2").html(str);
    })

    function updatePwdgo(){
        let msg = ""
        let emp_Pwd = $("#oldPwd").val(); //기존 비밀번호
        let emp_Id = $("#emp_Id").val();
        let empVO = {"emp_Pwd":emp_Pwd, "emp_Id":emp_Id}

        if(flag_vaildate && flag_compare) // 두개가 true일 때 실행
        {
            $.ajax({
                type:"post",
                url:'<%=request.getContextPath()%>/emp/firstCompareEmpPwd',
                contentType:"application/json",
                async:false,
                data:JSON.stringify(empVO),
                success : function (data)
                {
                    console.log(data)
                    msg = data;
                },
                error : function (e)
                {
                    console.log(e)
                }
            });


            if(msg === 'false')
            {
                alert('기존 비밀번호와 다릅니다. 다시 확인해주세요');
                return false;
            }
        }

        else{//flag_vaildate && flag_compare => false인 경우
            alert('새로운 비밀번호의 유효성을 검사해주세요')
            return false;
        }

        empVO.emp_Pwd = $("#pwd2").val()
        $.ajax({
            type:"post",
            url: '<%=request.getContextPath()%>/emp/firstChangeAction',
            contentType : "application/json",
            async : false,
            data : JSON.stringify(empVO),
            success : function (data)
            {
                console.log(data)
                alert('비밀번호가 변경되었습니다.')
                opener.window.location.href = '<%=request.getContextPath()%>/common/loginForm'; // 부모 창 리다이렉션
                window.close();


            },
            error:function (e)
            {
                console.log(e)
                alert('이전 비밀번호를 확인해주세요')
            }
        });
    }

</script>




</body>
</html>

