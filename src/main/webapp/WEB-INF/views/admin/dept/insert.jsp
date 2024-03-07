<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>WorkConGW</title>
    <script src="https://kit.fontawesome.com/3a92c85ff9.js" crossorigin="anonymous"></script>
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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

</head>

<style>
    .contentConteiner {
        flex: 1; /* 콘텐츠 컨테이너가 남은 공간을 채우도록 설정 */
        padding: 50px;
    }
    .subPageContain {
        display: flex;
    }
    #headDiv{
        float: left;
    }
    .whole{
        margin-top: 20px;
    }
    input.btn.float-right {
        margin-left: 10px;
        width: 20%;
    }
    .form-group.row{
        margin: 10px 0px 10px;

    }
    #registBody{
        padding: 0px 20px 30px 20px;
    }

    .form-group.row label.col-sm-2.float-left{
        padding: 5px 0px 0px 0px;
        margin-top: 10px;
    }
    #dept_NameLabel{
        margin-top: 0px;
    }
    .input-group{
        margin-top: 10px;

    }
    input#deptTeamYn1, input#deptTeamYn2 {
        width: 15px;
        font-size: smaller;
        margin: 10px 0px 0px 0px;
    }
    #deptTeamYnDiv label{
        margin: 10px 40px 0px 40px;
    }
    .form-group input{padding: 20px 10px !important;}


</style>
<body>
<!-- 헤더인클루드 -->

<section class="subPageContain">
    <!-- 사이드바 -->
    <%@ include file="../sidebar.jsp"%>
    <!--컨텐츠 영역-->
    <div class="contentConteiner">
        <!-- 메인 content -->
        <div class="container-fluid">
            <!-- 메인 content 넣는 곳 -->
            <div class="row clearfix">
                <div class="col-lg-12 whole">
                    <div class="card" style="padding: 5px 15px;">
                        <div class="header">
                            <div id="headDiv">
                                <h3>부서/팀 추가</h3>
                            </div>
                        </div>
                        <br>
                        <hr/>

                        <div class="body"  id="registBody">
                            <form:form modelAttribute="deptVO" id="basicForm" name="basicForm" class="horizontal" method="post" autocomplete="off">
                                <div class="form-group row">
                                    <label class="col-sm-2 float-left" id="deptNameLabel" style="margin-top: 10px;" for="dept_Name" >명칭</label>
                                    <div class="col-sm-10 input-group input-group-sm ">
                                        <form:input type="text" path="dept_Name" id="dept_Name" class="form-control float-left" required="true" placeholder="명칭을 입력하세요"/>
                                        <button type="button" class="btn" style="background-color: #0c1e35; color: #ffffff;" onclick="checkName()">중복확인</button>
                                        <input type="hidden" value="0" id="dupleYN">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-2 float-left" for="dept_Sup_Id" >상위부서</label>
                                    <div class="col-sm-10 input-group input-group-sm "><!-- 부서목록 select -->
                                        <form:input type="text" path="dept_Sup_Id" id="dept_Sup_Id" class="form-control float-left" required="true" placeholder="부서추가일 경우 d000를 입력해주세요"/>
                                        <button type="button" class="btn input-btn" style="background-color: #0c1e35; color: #ffffff;" onclick="OpenWindow('<%=request.getContextPath()%>/organization', 'WorkConGW', 700,700)">조직도</button>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-2 float-left" for="dept_Hp" >연락처</label>
                                    <div class="col-sm-10 input-group input-group-sm ">
                                        <form:input type="text" path="dept_Hp" id="dept_Hp" class="form-control float-left" required="true" placeholder="연락처를 입력해주세요"/>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-2 float-left"  >팀/부서 여부</label>
                                    <div class="col-sm-10 input-group input-group-sm " id="deptTeamYnDiv" required="true"><!-- 팀일경우 체크 -->
                                        <form:select path="dept_Team_Yn" id="dept_Team_Yn" cssClass="form-control float-left" style="width:75px;" multiple="false">
                                            <form:option value="1">팀</form:option>
                                            <form:option value="0">부서</form:option>
                                        </form:select>
                                    </div>
                                </div>
                            </form:form>
                        </div>
                        <input type="button" onclick="regist();" class="btn" style="background-color: #0c1e35; color: #ffffff;" id="realRegistBtn" value="저장"> <!-- float-right 클래스 추가 -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- 푸터 인클루드 -->
<!-- 푸터 인클루드 -->
    <!-- 푸터 인클루드 -->


<script defer>


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

    function regist() {
        let dupleYN = $("#dupleYN").val();
        let dept_Name = $("#dept_Name").val().trim();

        if (!dept_Name) {
            alert('명칭은 필수입니다.');
            return false;
        } else if (dupleYN == 0) {
            alert('직책명 중복확인은 필수입니다.')
            return false;
        }
        let dept_Hp = $("#dept_Hp").val();
        console.log(dept_Hp);
        let dept_Sup_Id = $("#dept_Sup_Id").val();
        let dept_Team_Yn = $("#dept_Team_Yn").val();

        if (!dept_Team_Yn) {
            alert('팀/부서 여부를 선택해주세요.');
            return false;
        }

        let registData = {
            dept_Name: dept_Name,
            dept_Sup_Id: dept_Sup_Id,
            dept_Team_Yn: dept_Team_Yn,
            dept_Hp:dept_Hp
        }
        console.log(registData);

        $.ajax({
            url: "<%=request.getContextPath()%>/admin/dept/regist",
            type: "post",
            data: registData,
            success: function(data) {
                console.log(data)
                if (data > 0) {
                    alert('부서가 등록되었습니다.')
                    location.href = "<%=request.getContextPath()%>/admin/dept/deptInsert"
                }
                else {
                    alert('부서가 등록되지 않았습니다.')
                }
            },
            error: function() {
                alert('오류입니다.')
            }
        });
    }


    function checkName()
    {
        let deptName = $('#dept_Name').val().trim();
        if(!deptName){
            alert('명칭은 필수입니다.');
            return false; // 수정된 부분
        }
        let sendData = {deptName:deptName};
        console.log(sendData);

        $.ajax({
            url:"<%=request.getContextPath()%>/admin/dept/checkName",
            type:"post",
            data: sendData,
            success:function (response)
            {
                //response > 0 중복된 데이터가 있다는 얘기
                if(response >0)
                {
                    alert('중복된 데이터가 있습니다. 다시 입력해주세요')
                    $("#dupleYN").val(0); // 값을 다시 초기화해야함
                    result = false
                }
                else{
                    alert('사용 가능한 부서명입니다.')
                    $("#dupleYN").val(1)
                    result = true;
                }
            }  ,error: function(request, status, error){
                console.log("error 발생 >> " +error);
            }
        })
    }
</script>
</body>

</html>
