<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
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
<!-- 메인 content -->
<div id="main-content" style="width: 100%;">
    <div class="container-fluid">
        <div class="block-header">
            <div class="row" style="margin-bottom: 20px; align-items: center;">
                <div class="col-sm-5">
                    <div class="subTitleText">
                        <h2>
                            <i class="fa-solid fa-angles-right"></i>공지 작성
                        </h2>
                    </div>
                </div>
                <div class="col-sm-7" >
                    <div style="float:right; font-family: S-CoreDream-4Regular">
                        <button type="button" class="btn btn-primary" style="width:80px;" onclick="regist_go();">등록</button>
                        <button type="button" onclick="location.href='<%=request.getContextPath()%>/reservation/adminMain'" class="btn btn-secondary" style="width:80px;">취소</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="row clearfix" style="font-family: S-CoreDream-4Regular">
            <div class="col-lg-12 col-md-12 col-sm-12">
                <%--@elvariable id="meetRoomFormVO" type="com.WorkConGW.reservation.dto.MeetRoomFormVO"--%>
                <form:form modelAttribute="meetRoomFormVO" name="noticeModifyForm" action="${pageContext.request.contextPath }/reservation/registNotice" enctype="multipart/form-data">
                    <form:hidden path="reservationNoticeVO.reservation_Notice_Id"/>
                    <form:hidden path="reservationNoticeVO.reservation_Notice_Content" id="noticeContent"/>
                    <form:hidden path="reservationNoticeVO.emp_Id" value="${loginUser.emp_Id }"/>
                    <form:hidden path="reservationNoticeVO.reservation_Notice_Create_Date" id="noticeDate"/>
                    <div class="body">
                        <div class="row clearfix">
                            <div class="table-responsive" style="padding:5px 15px;">
                                <table class="table table-hover m-b-0">
                                    <thead class="shadow-none p-3 mb-5 bg-light rounded">
                                    <!-- 게시판 선택 -->
                                    <tr>
                                    </tr>
                                    <tr>
                                        <td style="width:130px;">
                                            <strong>제목</strong>
                                        </td>
                                        <td colspan="5">
                                            <div style="padding-left:15px;border-left: 1px dotted gray;">
                                                <form:textarea class="form-control" path="reservationNoticeVO.reservation_Notice_Title" style="width:100%;"></form:textarea>
<%--                                                <!-- 											 class="form-control" type="text" name="title" id="edit-title" required="required"  -->--%>
                                            </div>
                                        </td>
                                    </tr>

                                    <tr>

                                        <td style="width:130px;">
                                            <strong>작성자</strong>
                                        </td>
                                        <td>
                                            <div style="padding-left:15px;border-left: 1px dotted gray;">관리자</div>
                                        </td>
                                        <td>
                                            <strong>작성일자</strong>
                                        </td>
                                        <td>
                                            <div style="padding-left:15px;border-left: 1px dotted gray;" >
                                                <p id="date">
                                            </div>
                                        </td>
                                    </tr>
                                    <!-- 내용 -->
                                    <tr>
                                        <th colspan="6" style="padding:15px;">

                                        </th>
                                    </tr>
                                    </thead>
                                </table>
                            </div>
                            <div class="col-sm-12 formGroup noticeForm anonyForm">
                                <div class="summernote"style="height: 200px;"></div>
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</div>



</section>
<%@ include file="../include/footer.jsp"%>
<script>
    var today = new Date();
    var year = today.getFullYear();
    var month = today.getMonth()+1;
    var day = today.getDate();
    var format = year+"-"+(("00"+month.toString()).slice(-2))+"-"+(("00"+day.toString()).slice(-2));
    $('#date').text(format);

</script>


<script>

    function regist_go(){
        var modifyForm = $('form[name="noticeModifyForm"]')[0];
        if($.trim($('.note-editable').html())==""){
            alert('공지 내용을 입력하세요.');
            $('.note-editable').focus();
            return;
        }
        $('#noticeContent').val($('.note-editable').html());
        $('#noticeDate').val($('#date').text());


        var formData = new FormData(modifyForm);

        $.ajax({
            url:modifyForm.action,
            type:'post',
            data:formData,
            processData:false,
            contentType:false,
            success:function(){
                alert("글이 생성되었습니다.");
                location.href='${pageContext.request.contextPath}/reservation/adminMain'
            },
            error:function(){
                alert("글 생성에실패했습니다.");
            }
        });

    }

</script>
</body>
</html>