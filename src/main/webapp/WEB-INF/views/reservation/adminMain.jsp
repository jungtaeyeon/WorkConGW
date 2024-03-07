<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <style>
        .highlight{
            background-color: #f8f9fa;
            padding: 20px;
        }
        .highlight pre code {
            font-size: inherit;
            color: #212529;
        }
        .nt {
            color: #2f6f9f;
        }
        .na {
            color: #4f9fcf;
        }
        .s {
            color: #d44950;
        }
        pre.prettyprint {
            background-color: #eee;
            border: 0px;
            margin: 0;
            padding: 20px;
            text-align: left;
        }

        .atv,
        .str {
            color: #05AE0E;
        }

        .tag,
        .pln,
        .kwd {
            color: #3472F7;
        }

        .atn {
            color: #2C93FF;
        }

        .pln {
            color: #333;
        }

        .com {
            color: #999;
        }
        #hiddenFillBtn:hover{
            background-color: #ffffff;
        }
        .subTitleText {
        margin-bottom: 25px;
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
      .badge{
        font-size: 14px !important;
        padding: 8px 10px !important;
      }
      
    </style>

<body>
<!-- 헤더인클루드 -->
<%@ include file="../include/header.jsp"%>
<section class="subPageContain">
    <%@ include file="./sideBar.jsp"%>
<div id="main-content" class="profilepage_1" style="width: 100%;">
    <div class="container-fluid">
        <div class="block-header">
            <div class="row">
                <div class="col-lg-6 col-md-8 col-sm-12">
                    <div class="subTitleText">
                        <h2>
                          <i class="fa-solid fa-angles-right"></i>관리자 회의실 관리
                        </h2>
                      </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12 card" style="padding: 10px 15px;">
            <%--@elvariable id="meetRoomFormVO" type="MeetRoomFormVO"--%>
            <form:form modelAttribute="meetRoomFormVO" id="listForm" name="listForm">
                <div class="row">
                    <div class="header col-12" style="padding-bottom: 0px; margin-bottom: 10px; display: flex; justify-content: space-between; align-items: center;">
                        <h3 style="font-size: 22px; margin: 0;">회의실 현황</h3>
                        <div>
                            <a href="roomInsert" class="btn btn-success"style="border-right-width: 0px; margin-right: 10px;">회의실생성</a>
                            <form:button path="searchMeetRoomVO.meet_Room_St" type="submit"  value="1" class="btn btn-primary" style="border-right-width: 0px; margin-right: 10px;" name="meetRoomSt">사용중인 회의실</form:button>
                            <form:button path="searchMeetRoomVO.meet_Room_St" type="submit"   value="2" class="btn btn-danger" style="border-right-width: 0px; margin-right: 10px;" name="meetRoomSt">미사용 회의실</form:button>
                            <%--                                    									<button type="button" onclick="getRomList(1);" class="btn btn-primary"style="border-right-width: 0px; margin-right: 10px;">사용중인회의실</button>--%>
                            <%--                                     									<button type="button" onclick="getRomList(0);" class="btn btn-danger">미사용 회의실</button>--%>
                        </div>
                    </div>
                    <div class="col-12" style="font-family: S-CoreDream-6Bold">
                        <form:select path="searchMeetRoomVO.searchCondition" class="form-control selectSearch" style="width:125px;float:left;">
                            <form:option value="tcw">전체</form:option>
                            <form:option value="t">회의실 명</form:option>
                            <form:option value="c">내용</form:option>
                        </form:select>
                        <div id="navbar-search" class="navbar-form search-form selectSearch" style="float:left;">
                            <form:input path="searchMeetRoomVO.searchKeyword" class="form-control" placeholder="검색해주세요." type="text" style="width: 218px;padding-right: 40px;" onkeypress="checkEnter(searchMeetRoomList());"/>
                        </div>
                        <div class="form-group" style="float:right;">
                            <form:select path="searchMeetRoomVO.pageUnit" class="form-control" style="width:110px;margin-right: 10px;" onchange="searchMeetRoomList(1);">
                                <form:options items="${meetRoomFormVO.searchMeetRoomVO.pageUnitSelector}" itemValue="pageUnitValue" itemLabel="pageUnitLabel"/>
                            </form:select>
                        </div>
                        <button type="button" class="btn btn-secondary" onclick="resetAndSubmitForm();">
                            <i class="fas fa-sync-alt"></i> <!-- 초기화 아이콘 -->
                            초기화
                        </button>
                    </div>
                </div>
                <div class="row clearfix" style="font-family: S-CoreDream-7ExtraBold">
                    <div class="col-lg-12">
                        <div class="body project_report">
                            <div class="table-responsive" >
                              
                              <div class="p-l-0 p-r-0 p-t-0">
                                <!-- Open 이슈 -->
                                <div>
                                  <table class="table table-hover">
                                    <thead class="thead-light">
                                    <tr>
                                      <th>이름</th>
                                      <th>인원수</th>
                                      <th>회의실내용</th>
                                      <th>회의실이미지</th>
                                      <th>사용여부</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:if test="${!empty meetRoomList}">
                                      
                                      <c:forEach items="${meetRoomList }" var="room">
                                            <tr style="cursor:pointer;" onclick="location.href='<%=request.getContextPath()%>/reservation/detail?meet_Room_Id=${room.meet_Room_Id}', 'WorkConGW', 1000, 700;">
                                              <td class="project-title">
                                                <div>
                                                  <span class="roomTitle" >${room.meet_Room_Name}</span>
                                                </div>
                                              </td>
                                              <td class="project-actions">
                                                ${room.meet_Room_Capacity}인용
                                              </td>
                                              <td class="project-actions">
                                                <div style="display:inline-block;vertical-align:middle;">
                                                    ${room.meet_Room_Content}
                                                </div>
                                              </td>
                                              <td>
                                                <img alt="" src="getPicture?picture=${room.meet_Room_Attach_Origin}" style="width: 50px;border-top-width: 10px;">
                                              </td>
                                              <td>
                                                <c:choose>
                                                    <c:when test="${room.meet_Room_St == 1}"><span class="badge badge-primary">사용중</span></c:when>
                                                    <c:when test="${room.meet_Room_St == 0}"><span class="badge badge-danger">미사용</span></c:when>
                                                </c:choose>
                                              </td>
                                            </tr>
                                        </c:forEach>
                                    </c:if>
                                    </tbody>
                                  </table>
                                </div>
                              </div>
                              </div>
                          </div>
                      </div>
                  </div>
            </form:form>
        </div>
        <!-- 예약리스트 -->
        <div class="col-lg-12 card" style="padding: 10px 15px;">
            <div>
                <h3 style="font-size: 22px; margin-bottom: 20px;">예약리스트</h3>
            </div>
            <div class="row clearfix" style="font-family: S-CoreDream-7ExtraBold">
              <div class="col-lg-12">
                  <div class="body project_report">
                      <div class="table-responsive" >
                        
                        <div class="p-l-0 p-r-0 p-t-0">
                          <!-- Open 이슈 -->
                          <div>
                            <table class="table table-hover">
                              <thead class="thead-light">
                              <tr>
                                <th>제목</th>
                                <th>예약위치</th>
                                <th>예약자</th>
                                <th>날짜</th>
                                <th>시간</th>
                              </tr>
                              </thead>
                              <tbody>
                              <c:if test="${!empty reservationList}">
                                
                                <c:forEach items="${reservationList }" var="room">
                                      <tr style="cursor:pointer;" onclick="location.href='<%=request.getContextPath()%>/reservation/reservationDetail?meet_Room_Reservation_Id=${room.meet_Room_Reservation_Id }', 'WorkConGW', 1200, 700;">
                                        <td class="project-title">
                                          <div>
                                            <span class="roomTitle" >${room.meet_Room_Detail }</span>
                                          </div>
                                        </td>
                                        <td class="project-actions">
                                            ${room.meet_Room_Name } / ${room.meet_Room_No}
                                        </td>
                                        <td class="project-actions">
                                          <div style="display:inline-block;vertical-align:middle;">
                                            ${room.emp_Name } ${room.official_Name }
                                            <div>${room.dept_Name }</div>
                                          </div>
                                        </td>
                                        <td>
                                          <span>${room.reservation_Date }  </span>
                                        </td>
                                        <td>
                                          <span>${room.reservation_Start_Time }시 ~ ${room.reservation_End_Time }시</span>
                                        </td>
                                      </tr>
                                  </c:forEach>
                              </c:if>
                              <!-- 검색결과가 없을때 -->
                              <c:if test="${empty reservationList }">
                                <tr role="row">
                                  <td class="project-title noList" style="text-align:center;font-size:1.2em;font-weight: bold;height:80px;" colspan="8">검색 결과가 없습니다.</td>
                                </tr>
                              </c:if>
                              </tbody>
                            </table>
                          </div>
                        </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--회의실의 공자사항 -->
      <div class="col-lg-12 card" style="padding: 10px 15px;">
        <div class="">
          <div class="body project_report" >
            <div style=" margin-bottom: 10px;display: flex; justify-content: space-between; align-items: center;">
              <h3 id="reservationType" style="font-size: 22px;">공지사항</h3>
              <button class="btn btn-primary" style="font-family: S-CoreDream-4Regular" onclick="location.href='<%=request.getContextPath() %>/reservation/noticeRegistForm';">공지사항 작성</button>
            </div>
            <form:form modelAttribute="meetRoomFormVO" name="listForm2">
              <form:hidden path="searchReservationNoticeVO.isType" id="isReservationNoticeType"/>
              <!--                         	예약탭 -->
              <div class="table-responsive">
                <div class="p-l-0 p-r-0 p-t-0">
                  <!-- Open 이슈 -->
                  <div>
                    <table class="table table-hover">
                      <thead class="thead-light">
                        <tr>
                          <th>제목</th>
                          <th>날짜</th>
                          <th>작성자</th>
                        </tr>
                      </thead>
                      <tbody>
                      <c:if test="${!empty reservationNoticeList}">
                        <c:forEach items="${reservationNoticeList }" var="notice">
                          <tr style="cursor:pointer;" onclick="location.href='${pageContext.request.contextPath }/reservation/reservationNoticeDetail?reservation_Notice_Id=${notice.reservation_Notice_Id}', 'WorkConGW', 1200, 700;">
                            <td class="project-title">
                              <div>
                                  <span class="roomTitle">${notice.reservation_Notice_Title }</span>
                              </div>
                            </td>
                            <td class="project-actions">
                                ${notice.reservation_Notice_Create_Date }
                            </td>
                            <td class="project-actions">
                              <div style="display:inline-block;vertical-align:middle;">관리자
                              </div>
                            </td>
                          </tr>
                        </c:forEach>
                      </c:if>
                      <!-- 검색결과가 없을때 -->
                      <c:if test="${empty reservationNoticeList }">
                        <tr role="row">
                          <td class="project-title noList" style="text-align:center;font-size:1.2em;font-weight: bold;height:80px;" colspan="8">검색 결과가 없습니다.</td>
                        </tr>
                      </c:if>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </form:form>
          </div>
        </div>
      </div>
      <!--회의실 민원을 접수하는 곳 -->
      <div class="col-lg-12 card" style="padding: 10px 15px;">
        <div class="">
          <div class="body project_report">
            <div>
              <h3 id="reservationType" style="font-size: 22px; margin-bottom: 20px;">회의실민원</h3>
            </div>
            <form:form modelAttribute="meetRoomFormVO" name="listForm3">
              <!--                         	예약탭 -->
              <div class="table-responsive">
                <div class="p-l-0 p-r-0 p-t-0">
                  <!-- Open 이슈 -->
                  <div>
                    <table class="table table-hover">
                      <thead class="thead-light">
                      <tr>
                        <th style="width:40%;">제목</th>
                        <th style="width:20%;">작성 날짜</th>
                      </tr>
                      </thead>
                      <tbody>
                      <c:if test="${!empty complainList}">
                        <c:forEach items="${complainList }" var="complain">
                          <tr style="cursor:pointer;" onclick="location.href='${pageContext.request.contextPath}/reservation/complain/detail?complain_Id=${complain.complain_Id}','민원상세창',500,400;">
                            <td class="project-title">
                              <div>
                                  <span class="complainTitle">${complain.complain_Content}</span>
                              </div>
                            </td>
                            <td class="project-actions">
                                ${complain.complain_Create_Date }
                            </td>
                          </tr>
                        </c:forEach>
                      </c:if>
                      <!-- 검색결과가 없을때 -->
                      <c:if test="${empty complainList }">
                        <tr role="row">
                          <td class="project-title noList" style="text-align:center;font-size:1.2em;font-weight: bold;height:80px;" colspan="8">검색 결과가 없습니다.</td>
                        </tr>
                      </c:if>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </form:form>
            <!-- 	                         -->
          </div>
        </div>
      </div>
    </div>
</div>
</section>
<%@ include file="../include/footer.jsp"%>
</body>


<script>

    // 버튼 클릭 이벤트 핸들러
    $('form[name="listForm"] button[type="submit"]').click(function() {
        // 클릭된 버튼의 value 값(문자열)을 가져옵니다.
        var value = $(this).val();

        // 정수로 변환합니다.
        var intValue = parseInt(value);

        // 정수값을 갖는 숨겨진 input 태그를 생성하여 폼에 추가합니다.
        var input = $('<input>').attr('type', 'hidden').attr('name', 'searchMeetRoomVO.meet_Room_St').val(intValue);
        $('form[name="listForm"]').append(input);


        // 폼을 제출합니다.
        $('form[name="listForm"]').submit();
    });



    //검색조건 초기화
    function resetAndSubmitForm(pageNo) {
            if(!pageNo){
                pageNo = 1;
            }
            var listForm = $('form[name="listForm"]');
            $('input[name="searchMeetRoomVO.pageIndex"]').val(pageNo);
        $('select[name="searchMeetRoomVO.searchCondition"]').val('');
        $('input[name="searchMeetRoomVO.searchKeyword"]').val('');
            listForm.submit();
        }






    window.addEventListener('load', function() {
        var navBar = $('.reservationAdmin');
        navBar.addClass('active');
        /*회의실 내용 제거*/
        $("#registRoom")[0].reset();
        $("#dropify").val()
        $(".dropify-filename-inner").text("");
        $(".dropify-render").text("");
    });
</script>

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

                location.reload();
            },
            error:function(){
                alert("오류가  발생했습니다. 연결이 유실됩니다");

            }
        });

    }


    //검색 및 페이지네이션
    function searchMeetRoomList(pageNo){
        if(!pageNo){
            pageNo = 1;
        }
        var listForm = $('form[name="listForm"]');
        $('input[name="searchMeetRoomVO.pageIndex"]').val(pageNo);
        listForm.submit();
    }
    //회의실 리스트
        function getRomList(){
            console.log("룸리스트호출")
            $.ajax({
            url: "<c:url value='/reservation/roomList'/>",
            type:'get',
            processData:false,
            contentType:false,
            success:function(){},
            error:function(){}
        });
    }
    function notUseRoomList(){
        $.ajax({
            url: "<c:url value='/reservation/notUseRoomList'/>",
            type:'get',
            processData:false,
            contentType:false,
            success:function(){

            },
            error:function(){}
        });
    }



    window.onload=function(){
        $('#Capacity').val('');
        // 정렬 아이콘 삭제
        var thList = $('tr[role="row"] > th');
        for(var i=0; i<thList.length; i++){
            thList.eq(i).removeClass();
        }

        paginationCSS(${paginationInfo.currentPageNo},
            ${paginationInfo.firstPageNoOnPageList},
            ${paginationInfo.lastPageNoOnPageList},
            ${paginationInfo.totalPageCount});
    }




</script>
<%--<script> // 시연용--%>
<%--function presentationFill(){--%>
<%--// 	alert('클릭');--%>

<%--    $(".roomName").val("분임토의 5실");--%>
<%--    $(".roomNo").val("406호");--%>
<%--    $(".roomCapacity").val("25");--%>
<%--    $(".roomContent").val("노트북/모니터/키보드/마우스/빔프로젝터/에어컨");--%>

<%--}--%>
<%--</script>--%>
</html>