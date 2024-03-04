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
    top: 47%;
    left: 80%;
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

.save-id {
    color: #0f0f0f;
    padding-top: 2px;
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

.panel-container {
    position: absolute;
    width: 65%;
    height: 100%;
    top: 0;
    left: 0;
}

.panel {
    height: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: space-around;
    padding: 6rem 4% 2rem;
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

.btn.login-btn.transparent {
    margin: 0;
    width: 150px;
    height: 40px;
    font-size: 1.1rem;
    color: #0f0f0f;
    background: #F4F3FF;
    border: 1px solid #0f0f0f;
}

.btn.login-btn.transparent:hover {
    text-decoration: none;
    font-weight: 600;
    color: #fff;
    background: #0f0f0f;
    border: 1px solid #0f0f0f;
}

.image {
    width: 100%;
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
    </style>
  </head>
  <body>

<%--  <img src="<%=request.getContextPath() %>/images/user1.jpg" id="profileImage">--%>
<%--  <img src="<%=request.getContextPath() %>/pdsee/00001_05593.png" id="profileImage">--%>


    <div class="container">
      <div class="form-container">
        <div class="signin">
          <form id = "loginForm" action="/WorkConGW/common/login" class="signin-form" method="post">
            <h1 class="title">WorkConGW</h1>
            <h5 class="sub-title">업무도 내 회사 생활도 완벽하게</h5>
            <div class="input-field">
              <i class="fas fa-user"></i>
              <input id = "emp_Id" name="emp_Id" value="${cookie.id.value}" type="text" placeholder="사번" required />
            </div>
            <div class="input-field">
              <i class="fa-solid fa-shield-halved"></i>
              <input id = "emp_Pwd"name="emp_Pwd" type="password" placeholder="비밀번호" required />
            </div>
            <div class="login-info">
              <div class="find-idpwd">
                <button type="button" class="btn btn-sm" onclick="OpenWindow('<%=request.getContextPath()%>/emp/findIdView', 'WorkConGW', 700,700)">사번 찾기 </button>
                <button type="button" class="btn btn-sm" onclick="OpenWindow('<%=request.getContextPath()%>/emp/findPwView', 'WorkConGW', 700,700)">비밀번호 찾기</button>

              </div>
            </div>
            <input type="submit" value="로그인" class="login-btn solid" />
          </form>
          <div class="media-panel">
          </div>
        </div>
      </div>
      <div class="panel-container">
        <div class="panel">
          <div class="content">
            <h3 style="color: #0f0f0f">그룹에 참여해보세요!</h3>
            <p>올인원 업무플랫폼 WorkConGW와 함께 새로운 회사 생활을 경험해 보세요.</p>
          </div>
        </div>
      </div>
    </div>





</body>
</html>


<script>


  function list_go()
  {
    location.href = "<%=request.getContextPath()%>/admin/emp/empList"
  }


  function OpenWindow(UrlStr, WinTitle, WinWidth, WinHeight){
    winleft = (screen.width - WinWidth) / 2;
    wintop = (screen.height - WinHeight) / 2;
    var winX      = window.screenX || window.screenLeft || 0;// 현재창의 x좌표
    var winY      = window.screenY || window.screenTop || 0; // 현재창의 y좌표

    winleft = winX + winleft;
    wintop = winY + wintop;

    var win = window.open(UrlStr, WinTitle, "scrollbars=yes,width="+ WinWidth +", "
            +"height="+WinHeight + ", top=" + wintop +", left="
            + winleft +", resizable=yes, status=yes");
    win.focus();
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
        alert('전송에 성공했습니다.')
      },
      error:function(){
        alert('에러가 발생했습니다.')
      }
    })

  }
</script>