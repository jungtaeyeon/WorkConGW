<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>

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

    </style>
</head>

<body>
<!-- 헤더인클루드 -->
<%@ include file="../include/header.jsp"%>
<section class="subPageContain">

<button type="button" class="btn btn-outline-light" id="hiddenFillBtn" onclick="presentationFill();" style="position:absolute;right:25px;top:160px;color:#ffffff; z-index: 100; border: 0px;width:100px;height:50px;"></button>
<div id="main-content" class="profilepage_1">
    <div class="container-fluid">
        <div class="block-header">
            <div class="row">
                <div class="col-lg-6 col-md-8 col-sm-12">
                    <h2 style="font-family: S-CoreDream-6Bold; font-size: 30px;" ><a onclick="location.href='<%=request.getContextPath()%>/reservation/main';" class=""><i class="fa fa-home" style="font-size: 30px;" ></i></a> 관리자 회의실 관리</h2>
                </div>
            </div>
        </div>

        <div class="row clearfix">
            <div class="col-lg-4 col-md-12">
                <div class="card">
                    <div class="body">
                        <div class="row">
                            <h5 style="font-family: S-CoreDream-4Regular" class="col-md-10">공지사항 </h5>
                        </div>
                        <div class="body" style="font-family: S-CoreDream-6Bold">
                            <div class="table-responsive" style="overflow-x: hidden;">
                                <table class="table table-hover m-b-0 c_list">
                                    <thead>
                                    <tr>
                                        <th>날짜</th>
                                        <th>제목</th>
                                    </tr>
                                    </thead>
                                    <tbody style="cursor: pointer;">
<%--                                    여기도 수정 예정--%>
                                    <c:forEach items="${reservationNoticeList}" var="notice" varStatus="status">
                                        <c:if test="${status.count <5}">
                                            <tr role="row" class="odd" onclick="location.href='<%=request.getContextPath()%>/reservation/reservationNoticeDetail?reservation_Notice_Id=${notice.reservation_Notice_Id}', 'WorkConGW', 1000, 700;">
                                                <td>${notice.reservation_Notice_Create_Date }</td>
                                                <td style="text-overflow: ellipsis;">${notice.reservation_Notice_Title }</td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                        <%--여기도 수정--%>
                                    <c:if test="${empty reservationNoticeList}">
                                        <tr>
                                            <td colspan="6" style="text-align: center;"><strong>공지가  존재하지 않습니다.</strong></td>
                                        </tr>
                                    </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <button class="btn btn-primary" style="font-family: S-CoreDream-4Regular" onclick="location.href='<%=request.getContextPath() %>/reservation/noticeRegistForm';">공지사항 작성</button></div>
                </div>


                <div class="card">
                    <div class="body" style="font-family: S-CoreDream-6Bold">
                        <h5 style="font-family: S-CoreDream-4Regular">들어온 민원</h5>
                        <div class="table-responsive" style="overflow-x: hidden;">
                            <table class="table table-hover m-b-0 c_list">
                                <thead>
                                <tr>
                                    <th>날짜</th>
                                    <th>민원내용</th>
                                </tr>
                                </thead>
                                <tbody style="cursor: pointer;">
<%--                                여긴 수정 예정--%>
                                <c:forEach items="${complainList}" var="complain" varStatus="status">
                                    <c:if test="${status.count <5}">
                                        <tr role="row" class="odd" onclick="location.href='${pageContext.request.contextPath}/reservation/complain/detail?complain_Id=${complain.complain_Id}','민원상세창',500,400;">
                                            <td>${complain.complain_Create_Date }</td>
                                            <td>
			                                            <span style="display: inline-block;font-weight: bold;max-width: 280px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">
                                                                ${complain.complain_Content }
                                                        </span>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                                <%--여기도 수정예정--%>
                                <c:if test="${empty complainList}">
                                    <tr>
                                        <td colspan="6" style="text-align: center;"><strong>민원이  존재하지 않습니다.</strong></td>
                                    </tr>
                                </c:if>
                                </tbody>
                            </table>
                            </table>
                        </div>
                    </div>
                </div>
                <!--                     회의실 활성화 비활성화 하는 곳 -->
                <div class="card">
            <%--@elvariable id="meetRoomFormVO" type="MeetRoomFormVO"--%>
            <form:form modelAttribute="meetRoomFormVO" id="listForm" name="listForm">
                        <div class="row">
                            <div class="header col-12" style="padding-bottom: 0px; font-family: S-CoreDream-4Regular; padding-left: 40px;">
                                <h4>회의실 현황 </h4>
                                <button type="button" class="btn btn-outline-secondary" onclick="resetAndSubmitForm();">
                                    <i class="fas fa-sync-alt"></i> <!-- 초기화 아이콘 -->
                                </button>
                            </div>
                            <div class="col-12" style="font-family: S-CoreDream-6Bold">
                                <form:select path="searchMeetRoomVO.searchCondition" class="form-control selectSearch" style="width:80px;font-size: 1.2em;float:left;margin-left: 10px;">
                                    <form:option value="tcw">전체</form:option>
                                    <form:option value="t">회의실 명</form:option>
                                    <form:option value="c">내용</form:option>
                                </form:select>
                                <div id="navbar-search" class="navbar-form search-form selectSearch" style="float:left;">
                                    <form:input path="searchMeetRoomVO.searchKeyword" class="form-control" placeholder="Search here..." type="text" style="width: 218px;height:36px;padding-right: 40px;" onkeypress="checkEnter(searchMeetRoomList());"/>


                                </div>
                                <div class="form-group" style="float:right;">
                                    <form:select path="searchMeetRoomVO.pageUnit" class="form-control" style="width:110px;font-size: 1.2em;margin-right: 10px;" onchange="searchMeetRoomList(1);">
                                        <form:options items="${meetRoomFormVO.searchMeetRoomVO.pageUnitSelector}" itemValue="pageUnitValue" itemLabel="pageUnitLabel"/>
                                    </form:select>
                                </div>
                            </div>
                            <div class="col-12" style="font-family: S-CoreDream-6Bold">
                                <div class="header" style="text-align: right;padding-bottom: 0px;padding-top: 0px;margin-top: 0px;">
                                    <form:button path="searchMeetRoomVO.meet_Room_St" type="submit"  value="1" class="btn btn-primary" style="border-right-width: 0px; margin-right: 10px;" name="meetRoomSt">사용중인 회의실</form:button>
                                    <form:button path="searchMeetRoomVO.meet_Room_St" type="submit"   value="2" class="btn btn-danger" style="border-right-width: 0px; margin-right: 10px;" name="meetRoomSt">비활성 회의실</form:button>
<%--                                    									<button type="button" onclick="getRomList(1);" class="btn btn-primary"style="border-right-width: 0px; margin-right: 10px;">사용중인회의실</button>--%>
<%--                                     									<button type="button" onclick="getRomList(0);" class="btn btn-danger">비활성 회의실</button>--%>
                                </div>
                            </div>
                        </div>
                        <div class="body" style="padding-top: 0px; font-family: S-CoreDream-6Bold">
                            <hr>
                            <div class="w_user"></div>

                            <ul class="right_chat list-unstyled mb-0">
                                <c:forEach items="${meetRoomList}" var="room">
                                    <li class="online">
                                        <a href="javascript:void(0);">
                                            <div class="media">
                                                <div class="media-body">
													<span class="name">${room.meet_Room_Name}
														<c:choose>
                                                            <c:when test="${room.meet_Room_St == 1}"><span class="badge badge-primary">활성화</span></c:when>
                                                            <c:when test="${room.meet_Room_St == 0}"><span class="badge badge-danger">비활성화</span></c:when>
                                                        </c:choose>
													</span>
                                                    <span class="message">${room.meet_Room_Capacity}인용/${room.meet_Room_Content}</span>
                                                    <img alt="" src="getPicture?picture=${room.meet_Room_Attach_Origin}" style="width: 50px;border-top-width: 10px;margin-top: 50px;">
                                                </div>
                                                <div>
                                                    <button type="button" class="btn btn-outline-secondary" onclick="location.href='<%=request.getContextPath()%>/reservation/detail?meet_Room_Id=${room.meet_Room_Id}', 'WorkConGW', 1000, 700;">조회</button>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                        <!-- Pagination -->
                        <nav aria-label="Page navigation example" style="height:45px;text-align: center;margin-top:5px;">
<%--                            <ul class="pagination" style="display: inline-block;">--%>
<%--                                <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="searchMeetRoomList" />--%>
<%--                            </ul>--%>
                        </nav>
                        <form:hidden path="searchMeetRoomVO.pageIndex" />
            </form:form>
                </div>
            </div>

            <!--                 회의실 생성 -->
            <div class="col-lg-8 col-md-12">
                <div class="card" style="padding-top: 0px;">
                    <div class="header" style="padding-bottom: 5px;">
                        <h4 style="font-family: S-CoreDream-4Regular">회의실 생성</h4>
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
                                <form:input type="file" name="fileUploadCommand.uploadFile" class="dropify image"  style="height: 200px;"  path="fileUploadCommand.uploadFile"/>
<%--                                <!-- 									<input type="file" name="fileUploadCommand.uploadFile" class="dropify"  style="height: 200px;"> -->--%>
                            </div>
                        </form:form>
                        <div >
                            <button  type="button" class="btn btn-primary" onclick="regist_go();" style="margin-top: 5px; width: 100%;">회의실 생성</button>
                        </div>
                    </div>



                </div>
                <div class="card">
                    <div class="body" style="font-family: S-CoreDream-6Bold">

                        <c:forEach items="${reservationList  }" var="reservation" varStatus="status">
                            <c:if test="${status.count <8}">
                                <div class="timeline-item green" onclick="location.href='<%=request.getContextPath()%>/reservation/reservationDetail?meetRoomVO.meet_Room_Reservation_Id=${reservation.meet_Room_Reservation_Id}', 'WorkConGW', 1000, 700;">
                                    <span class="date">${reservation.meet_Room_Name }(${reservation.meet_Room_No })</span>
                                    <h6>${reservation.meet_Room_Detail }</h6>
                                    <span>직원 : <a href="javascript:void(0);" title="Fidel Tonn">${reservation.emp_Name }</a><span class="badge badge-primary">${reservation.emp_Id }</span></span>
                                    <span>사용 시간 : ${reservation.reservation_Date }/ ${reservation.reservation_Start_Time }시 ~ ${reservation.reservation_End_Time }시</span>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
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