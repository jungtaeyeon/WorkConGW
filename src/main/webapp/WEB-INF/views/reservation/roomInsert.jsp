<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<style>
  .subTitleText {
        margin-bottom: 13px;
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
</style>
<!-- 헤더인클루드 -->
<%@ include file="../include/header.jsp"%>
<section class="subPageContain">
  <%@ include file="./sideBar.jsp"%>
  <div id="main-content" class="profilepage_1" style="width: 100%; margin-bottom: 30px;">
    <div class="" style="padding-top: 0px;">
      <div class="subTitleText">
        <h2>
          <i class="fa-solid fa-angles-right"></i>
          회의실생성
        </h2>
      </div>
      <div class="body" style="padding-top: 10px; font-family: S-CoreDream-4Regular">
          <form:form modelAttribute="meetRoomFormVO" name="meetRoomModifyForm"  enctype="multipart/form-data" id="registRoom">
              <form:hidden path="meetRoomVO.meet_Room_Id"/>
              <div class="form-group">

                  <form:input path="meetRoomVO.meet_Room_Name" class="form-control roomName" style="width: 100%;margin-bottom: 5px" placeholder="회의실 명 "></form:input>
                  <form:input class="form-control roomNo" path="meetRoomVO.meet_Room_No" style="width: 100%;margin-bottom: 5px" placeholder="회의실 호"></form:input>
                  <p style="color: red;margin-bottom: 0px;">*숫자만 입력해주세요</p>
                  <form:input class="form-control roomCapacity" path="meetRoomVO.meet_Room_Capacity" style="width: 100%;" placeholder="수용 가능 인원" value="" id="Capacity"></form:input>
                  <p style="color: red;margin-bottom: 0px;">*100자 내로 적어주세요</p>
                  <form:textarea id="text" name="text" class="form-control roomContent" path="meetRoomVO.meet_Room_Content" style="height: 150px;" placeholder="회의실 정보 작성"></form:textarea>
              </div>
              <p style="color: red;margin-bottom: 0px;">*이미지는 필수입니다</p>
              <div>
                  <form:input type="file" name="fileUploadCommand.uploadFile" class="dropify image"  path="fileUploadCommand.uploadFile"/>
                  <%--  <!-- 									<input type="file" name="fileUploadCommand.uploadFile" class="dropify"  style="height: 200px;"> -->--%>
              </div>
          </form:form>
          <div >
              <button  type="button" class="btn btn-primary" onclick="regist_go();" style="margin-top: 5px; width: 100%;">회의실 생성</button>
          </div>
      </div>
    </div>
  </div>
</section>
<%@ include file="../include/footer.jsp"%>

<script>
  //회의실 등록(내일 조건 값이 비면 안됨 이미지 없으면 안됨 호수에 이상한거  넣으면 안됨 인원에 글자 들어가면 안됨 이미지 말고 이상한 파일이면 안됨)
  function regist_go(){
      var regex= /^[0-9]/g; // 숫자 정규식

      var roomName =$(".roomName").val();
      var roomNo =$(".roomNo").val();
      var roomCapacity= $(".roomCapacity").val();
      var roomContent= $(".roomContent").val();
      var image= $(".image").val();


      if (roomName == ""||roomName.length >20) {
          alert("회의실 이름을 적어주세요");
          return;
      }else if (roomNo == "" || roomNo.length >20) {
          alert("몇호인지 입력해주세요");
          return;
      }else if (!regex.test(roomCapacity) || roomCapacity <= 0 || roomCapacity >= 99) {
          alert("수용인원은 숫자만 입력해주세요");
          return;
      }else if (roomContent == "" || roomContent.length >100) {
          alert('내용을 입력해주세요');
      }else if (image == null || image == "") {
          alert("이미지는 필수입니다");
          return;
      }

      var modifyForm = $('form[name="meetRoomModifyForm"]')[0];
      modifyForm.action = "<c:url value='/reservation/regist'/>";
      var formData = new FormData(modifyForm);
          console.log(JSON.stringify(modifyForm))

      console.log(formData);
      $.ajax({
          url:modifyForm.action,
          type:'post',
          data: formData,
          processData:false,
          contentType:false,
          success:function(){
              alert("생성에 성공하였습니다");

              location.href="/WorkConGW/reservation/adminMain";
          },
          error:function(){
              alert("오류가  발생했습니다. 연결이 유실됩니다");

          }
      });

  }
</script>
