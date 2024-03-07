<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<title>${meetRoomVO.meet_Room_Name } 회의실 </title>
<style>
    #main-content{
        margin: 0px;
    }
    *, ::after, ::before{
        box-sizing: border-box;
    }
    .container-fluid-header, .container-fluid-footer{
        display: flex;
        justify-content: space-between;
    }
    body {
        padding: 0px 30px 30px 30px;
    }
    .col-xs-12 {
        padding: 5px;
    }
    div#main-content{
        border: solid 1px rgba(0,0,0,.03);
        border-radius: 1%;
        background-color: #ffffff;
        padding: 0px 10px 10px;
    }
    body{
        padding: 0px 30px 30px 30px;
        background-color: rgba(0,0,0,.03);
    }
    .form-control[disabled], .form-control[readonly], fieldset[disabled] .form-control{
        background-color: #ffffff;
    }
    #edit-participater{
        cursor: pointer;
    }
    #modifyBtn{
        display: none;
    }
      .subTitleText h2 {
        display: flex;
        justify-content: flex-start;
        align-items: center;
        font-size: 27px;
        padding: 10px 0;
        font-family: "Noto Sans KR", sans-serif;
      }
      .subTitleText i {
        font-size: 24px;
        margin-right: 5px;
      }
      .row.reservationDeteailText {
            font-size: 17px;
        }
</style>

<body>
<!-- 헤더인클루드 -->
<%@ include file="../include/header.jsp"%>
<section class="subPageContain">
<%@ include file="./sideBar.jsp"%>
<div id="main-content" style="width: 100%;">
    
    <div class="container-fluid">
        <div class="form-header container-fluid-header">
            <div class="subTitleText">
                <h2>
                  <i class="fa-solid fa-angles-right"></i>${meetRoomVO.meet_Room_Name } 회의실
                </h2>
            </div>
            <div>
                <c:if test="${loginUser.emp_Id == meetRoomVO.emp_Id}">
                    <button type="button" class="btn btn-danger" onclick="removeRoom();">취소</button>
                </c:if>

                <button type="button" class="btn btn-secondary" onclick="goBack()">닫기</button>
            </div>
        </div>
        <hr>
        <div class="row">
            <div class="col-md-4">
                <form:form modelAttribute="meetRoomVO" id="detailForm" name="detailForm" style="margin: 0;" class="form-horizontal" autocomplete="off">
                    <form:hidden path="meet_Room_Id" />
                    <form:hidden path="meet_Room_Reservation_Id"  />
                    <form:hidden path="emp_Id"/>
                </form:form>
                <div class="row reservationDeteailText">
                    <div class="col-xs-12">
                        <label class="col-xs-12" for="edit-title">예약자 </label>
                        <div class="col-sm-12 input-group-sm">
                            ${meetRoomVO.emp_Name }(${meetRoomVO.official_Name})
                        </div>
                    </div>
                </div>
                <div class="row reservationDeteailText">
                    <div class="col-xs-12">
                        <label class="col-xs-12" for="edit-title">부서명</label>
                        <div class="col-sm-12 input-group-sm">
                            ${meetRoomVO.dept_Name}
                        </div>
                    </div>
                </div>
                <div class="row reservationDeteailText">
                    <div class="col-xs-12">
                        <label class="col-xs-12" for="edit-title">예약정보</label>
                        <div class="col-sm-12 input-group-sm">
                            <span 예약 회의실 : ${meetRoomVO.meet_Room_Name }/>
                            ${meetRoomVO.meet_Room_Name } (${meetRoomVO.meet_Room_Capacity } 인)/${meetRoomVO.meet_Room_No }호
                        </div>
                    </div>
                </div>
                <div class="row reservationDeteailText">
                    <div class="col-xs-12">
                        <label class="col-xs-12" for="edit-title">예약 날짜</label>
                        <div class="col-sm-12 input-group-sm" style="color: red;">
                            ${meetRoomVO.reservation_Date } / ${meetRoomVO.reservation_Start_Time }시 ~ ${meetRoomVO.reservation_End_Time }시
                        </div>
                    </div>
                </div>
                <div class="row reservationDeteailText" >
                    <div class="col-xs-12">
                        <label class="col-xs-4" for="edit-end">내용</label>
                        <div class="col-sm-10 input-group-sm">
                            <form:textarea path="meetRoomVO.meet_Room_Detail" id="meetRoomContent" class="form-control" rows="4" cols="40" readonly="true"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-8">
                <%-- 				<div class="mailbox-attachment-icon has-img" id="pictureView" style="background-image: url('getPicture?picture=${meetRoomVO.meetRoomAttachPath}');"></div> --%>
                <img alt="" src="getPicture?picture=${meetRoomVO.meet_Room_Attach_Origin}" style="width: 550px;border-top-width: 10px;margin-top: 50px;">
            </div>
        </div>
    </div>
</div>
</section>
<script>
    function goBack() {
        window.history.back();
    }


    function removeRoom(){

        var meetRoomId = '${meetRoomVO.meet_Room_Id}';

        if(confirm('해당 예약을 취소하시겠습니까?')){
            var detailForm = $('form[name="detailForm"]')[0];
            var formData = new FormData(detailForm);

            $.ajax({
                url:"<c:url value='/reservation/reservationRemove'/>",
                type:'post',
                data:formData,
                processData:false,
                contentType:false,
                success:function(response){
                    if(response && response > 0){
                        alert("예약이 취소되었습니다.");
                    }else{
                        alert("예약 취소에 실패했습니다..");
                    }
                    location.href='<%=request.getContextPath()%>/reservation/main';
                },
                error:function(request, status, error){
                    alert("취소에 실패했습니다..");
                    console.log(error);
                    CloseWindow();
                }
            });
        }
    }


</script>
