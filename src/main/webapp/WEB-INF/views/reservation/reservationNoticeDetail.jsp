<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/fonts/font.css">


<style>
    .attachList {
        cursor: pointer;
        font-weight: normal;
    }
    .attachList:hover {
        color: blue;
        text-decoration: underline;
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
<body>

<jsp:include page="../include/header.jsp"/>
<!-- 메인 content -->
<section class="subPageContain">
<%@ include file="./sideBar.jsp"%>
<div id="main-content" style="width: 100%;">
    <div class="container-fluid" >
        <form:form modelAttribute="reservationNoticeVO" name="detailForm" >
            <form:hidden path="reservation_Notice_Id" value="${noticeVO.reservation_Notice_Id}" />
            <div class="block-header">
                <div class="row">
                    <div class="col-sm-5">
                        <div class="subTitleText">
                            <h2>
                              <i class="fa-solid fa-angles-right"></i>시설예약 공지
                            </h2>
                        </div>
                    </div>
                    <div class="col-sm-7" style="display: flex; justify-content: flex-end; align-items: center;">
                        <div>
                            <c:if test="${loginUser.auth_Id eq 's'}">
                                <button type="button" class="btn btn-danger" style="width:80px;" onclick="remove_go();">삭제</button>
                            </c:if>
                            <button type="button" onclick="goBack();" class="btn btn-secondary" style="width:80px;">닫기</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row clearfix">
                <div class="col-lg-12 col-md-12 col-sm-12" style="font-family: S-CoreDream-6Bold">
                    <div class="body">
                        <div class="row clearfix">
                            <div class="table-responsive" style="padding:5px 15px;">

                                <table class="table table-hover m-b-0">
                                    <thead class="shadow-none p-3 mb-5 bg-light rounded">
                                    <tr>
                                        <td style="width:130px;">
                                            <strong>제목</strong>
                                        </td>

                                        <td colspan="7">
                                            <div style="padding-left:15px;border-left: 1px dotted gray;">${noticeVO.reservation_Notice_Title }</div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <strong>작성자</strong>
                                        </td>
                                        <td style="width:200px;">
                                            <div style="padding-left:15px;border-left: 1px dotted gray;">관리자</div>
                                        </td>
                                        <td style="width:130px;">
                                            <strong>작성일자</strong>
                                        </td>
                                        <td colspan="3">
                                            <div style="padding-left:15px;border-left: 1px dotted gray;">
                                                    ${noticeVO.reservation_Notice_Create_Date }
                                            </div>
                                        </td>
                                    </tr>
                                    <!-- 내용 -->
                                    <tr>
                                        <th colspan="8" style="padding:15px; font-family: S-CoreDream-4Regular">
                                            내용 : <br>
                                                ${noticeVO.reservation_Notice_Content }
                                        </th>
                                    </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form:form>


    </div>
</div>
</section>



<script type="text/javascript">

    function goBack() {
        window.history.back();
    }


    // 게시글 삭제
    function remove_go(){
        var check = confirm('문서를 삭제하시겠습니까?');
        if(!check) return;

        var detailForm = document.detailForm;
        detailForm.action = '${pageContext.request.contextPath }/reservation/reservationNoticeRemove';
        var form = new FormData(detailForm);


        $.ajax({
            url:detailForm.action,
            type:'post',
            data:form,
            processData:false,
            contentType:false,
            success:function(){
                alert('글이 삭제되었습니다.');
                location.href='${pageContext.request.contextPath}/reservation/adminMain'
            },
            error:function(){
                alert('삭제 실패');
            }
        });
    }
</script>
</body>