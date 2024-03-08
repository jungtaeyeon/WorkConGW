<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<style>
.pagination {
	text-align: center;
}

#tr1 {
/* 	text-align: center; */
	padding-left: -10px;
}

tbody {
	text-align: center;
	"
}

.td2 {
	text-align: left;
}

.card{
/* 	text-align: center; */
	padding-bottom: 30px;
}

.button1{
	text-align: right;
    padding-right: 38px;
}

.body{
    padding-top: 15px;
    padding-left: 17px;
    padding-right: 17px;
}

.attachList:hover{
	color: blue;
	text-decoration: underline;
	cursor: pointer;
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
<!-- 헤더인클루드 -->
<%@ include file="../../include/header.jsp"%>
<section class="subPageContain">
	<!-- 사이드바 -->
	<%@ include file="../boardSidebar.jsp"%>
	<!--컨텐츠 영역-->
	<div class="contentConteiner">

<%--	<!-- 메인 content -->--%>
	<div id="main-content">
		<div class="container-fluid">
			<div class="row clearfix" >
				<div class="col-12" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;" >
					<div class="subTitleText">
						<h2><i class="fa-solid fa-angles-right"></i>사내공지</h2>
					</div>
					<div>
						<button type="button" class="btn btn-secondary float-right" onclick="goBackToList();">목록</button>
						<c:if test="${loginUser.auth_Id == 's' }">
							<button class="btn btn-danger float-right m-r-5"
								data-type="confirm" onclick="remove_go();">
								<i class="fas fa-trash"></i> <span>삭제</span>
							</button>
							<button type="button" class="btn btn-info float-right m-r-5" onclick="modify_go();">
								<i class="fa fa-eraser"></i> <span>수정</span>
							</button>
						</c:if>
					</div>
				</div>
				<hr>
			</div>
			<div class="div2">
				<div class="row clearfix">
					<div class="col-lg-12 col-md-12">
						<div class="card">
							<div class="body project_report" style="width: 100%">

								<div class="body" style="display: block;  width: 100%; overflow-x: auto; padding-left: 0px; padding-right: 0px;">
									<div class="table-responsive">
										<table class="table table-hover m-b-0">
											<thead class="shadow-none p-3 mb-5 bg-light rounded">
								<tr>
									<td style="width:130px;">
										<h6 id="h6" style="font-weight: bold;">제목</h6>
									</td>
									<td colspan="5">
										<div style="padding-left:15px;border-left: 1px dotted gray;">${notice.notice_title }</div>
									</td>
								</tr>
								<tr>
									<td>
										<strong>작성일자</strong>
									</td>
									<td>
										<div style="padding-left:15px;border-left: 1px dotted gray;">
											<fmt:formatDate value="${notice.notice_create_dt }" pattern="yyyy-MM-dd"/>

										</div>
									</td>
									<td>
										<strong>작성자</strong>
									</td>
									<td>
										<div style="padding-left:15px;border-left: 1px dotted gray;">${notice.emp_Name }</div>
									</td>
									<td>
										<strong>조회수</strong>
									</td>
									<td>
										<div style="padding-left:15px; border-left: 1px dotted gray;">${notice.notice_readcnt }</div>
									</td>
								</tr>
								<tr>
									<th>
										<i class="fas fa-download"></i>
										<strong>첨부파일</strong>
									</th>
									<th colspan="5">
										<div style="padding-left:15px;border-left: 1px dotted gray;">
											<c:if test="${notice.noticeAttachList.size() > 0 }">
												<c:forEach items="${notice.noticeAttachList }" var="noticeAttach">
													<span class="attachList" data-attachId="${noticeAttach.attach_id }" data-filePath="${noticeAttach.attach_path }" onclick="fileDownload(this);">
														<c:choose>
                                                        <c:when test="${noticeAttach.attach_type eq 'JPG' || noticeAttach.attach_type eq 'PNG' || noticeAttach.attach_type eq 'GIF'}">
                                                           <i class="far fa-file-image"></i>
                                                        </c:when>
                                                        <c:otherwise>
                                                           <i class="far fa-file-alt"></i>
                                                        </c:otherwise>
                                                     </c:choose>
                                             &nbsp;${noticeAttach.attach_name }
													</span>
												</c:forEach>
											</c:if>
											<c:if test="${notice.noticeAttachList.size() == 0 }">
												<span style="font-weight: normal;">없음</span>
											</c:if>
										</div>
									</th>
								</tr>

							</thead>
						</table>
							<!-- 내용 -->
							<div style="margin-top: 20px; padding-left: 15px; padding-right: 15px; font-size: 16px;">${notice.notice_content }</div>
					</div>
				</div>
			</div>

					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<form name="fileForm" action="${pageContext.request.contextPath }/common/getFile" method="post">
	<input type="hidden" name="fileUploadPath"/>
	<input type="hidden" name="attach_id"/>
</form>

<form:form modelAttribute="boardFormVO" name="noticeModifyForm" action="${pageContext.request.contextPath }/board/notice/modifyForm">
	<form:hidden path="noticeVO.notice_id"/>
	<form:hidden path="noticeVO.notice_title"/>
	<form:hidden path="noticeVO.notice_content"/>
	<form:hidden path="noticeVO.emp_Name"/>
	<form:hidden path="noticeVO.notice_readcnt"/>
	<form:hidden path="noticeVO.notice_create_dt"/>

<c:forEach items="${notice.noticeAttachList }" var="noticeAttach" varStatus="status">
   <form:hidden path="noticeVO.noticeAttachList[${status.index }].attach_id" value="${noticeAttach.attach_id }" />
   <form:hidden path="noticeVO.noticeAttachList[${status.index }].attach_path" value="${noticeAttach.attach_path }" />
   <form:hidden path="noticeVO.noticeAttachList[${status.index }].attach_name" value="${noticeAttach.attach_name }" />
   <form:hidden path="noticeVO.noticeAttachList[${status.index }].attach_type" value="${noticeAttach.attach_type }" />
</c:forEach>
</form:form>


<script>
	function goBackToList() {
		location.href = "${pageContext.request.contextPath}/board/notice/noticeList";
	}

//파일 다운로드
function fileDownload(obj){
	var fileForm = $('form[name="fileForm"]');
	$('input[name="attach_id"]').val($(obj).attr('data-attachId'));
	$('input[name="fileUploadPath"]').val($(obj).attr('data-filePath'));
	fileForm.submit();
}

// 수정 페이지
function modify_go(){
	var noticeModifyForm = document.noticeModifyForm;
	noticeModifyForm.action = '${pageContext.request.contextPath }/board/notice/modifyForm';

	noticeModifyForm.submit();
}

//게시글 삭제
function remove_go(){
	var check = confirm('글을 삭제하시겠습니까?');
	if(!check) return;

	var noticeModifyForm = document.noticeModifyForm;
	noticeModifyForm.action = '${pageContext.request.contextPath }/board/notice/remove';

	var form = new FormData(noticeModifyForm);

	$.ajax({
		url:noticeModifyForm.action,
		type:'post',
		data:form,
		processData:false,
		contentType:false,
		success:function(){
			alert('글이 삭제되었습니다.');
			window.location.href="${pageContext.request.contextPath }/board/notice/noticeList"
		},
		error:function(){
			alert('삭제 실패');
		}
	});
}

</script>

</div>
</section>
<%-- 푸터 인클루드 --%>
<%@ include file="../../include/footer.jsp"%>
</body>