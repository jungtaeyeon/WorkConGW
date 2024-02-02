<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
	<!-- Font Awesome CDN -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" integrity="sha512-" crossorigin="anonymous" />
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- Bootstrap JS -->
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</head>

<%--<!-- MAIN CSS -->--%>

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

</style>

<body>

<%--	<!-- 메인 content -->--%>
	<div id="main-content">
		<div class="container-fluid" style="font-family: S-CoreDream-4Regular" >
			<div class="row clearfix" >
				<div class="col-12" style="margin-top: 2%; font-family: S-CoreDream-4Regular" >
					<h2 style="font-family: S-CoreDream-4Regular">
						<i class="fas fa-bullhorn"></i>&nbsp;사내공지
						<button type="button" class="btn btn-secondary float-right" onclick="window.close('<%=request.getContextPath()%>/board/notice/list');"
							style="margin-right: 22px; font-family: S-CoreDream-4Regular" >
							<i class="fas fa-times"></i> <span>닫기</span>
						</button>
						<c:if test="${loginUser.emp_Id == notice.emp_writer_id }">
							<button class="btn btn-danger float-right m-r-5"
								data-type="confirm" onclick="remove_go();">
								<i class="fas fa-trash"></i> <span>삭제</span>
							</button>
							<button type="button" class="btn btn-info float-right m-r-5" onclick="modify_go();">
								<i class="fa fa-eraser"></i> <span>수정</span>
							</button>
						</c:if>

					</h2>
					<hr>
				</div>
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
							<div style="margin-top: 20px; padding-left: 15px; padding-right: 15px;">${notice.notice_content }</div>
					</div>
				</div>
			</div>

<!-- 			<div class="button1"> -->
<!-- 								<button type="button" class="btn btn-outline-info" > -->
<!-- 									<i class="fa fa-paperclip" >링크복사</i> -->
<!-- 								</button> -->

<!-- 						</div> -->
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<%-- <form:form commandName="boardFormVO" name="detailForm" action="${pageContext.request.contextPath }/board/notice/detail"> --%>
<%-- 	<form:hidden path="noticeVO.noticeId" /> --%>
<%-- 	<form:hidden path="noticeVO.noticeTitle"/> --%>
<%-- 	<form:hidden path="noticeVO.noticeContent"/> --%>
<%-- 	<form:hidden path="noticeVO.empName"/> --%>
<%-- 	<form:hidden path="noticeVO.noticeReadcnt"/> --%>
<%-- 	<form:hidden path="noticeVO.noticeCreateDt"/> --%>
<%-- </form:form> --%>

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
   <form:hidden path="noticeVO.noticeAttachList[${status.index }].attach_size" value="${noticeAttach.attach_size }" />
</c:forEach>
</form:form>


<script>
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
			window.opener.location.reload(true);
			window.close();
		},
// 		function showConfirmMessage() {
//     		swal({
// 		        title: "정말 삭제하시겠습니까?",
// 		//         text: "You will not be able to recover this imaginary file!",
// 		        type: "warning",
// 		        showCancelButton: true,
// 		        confirmButtonColor: "#dc3545",
// 		        confirmButtonText: "삭제",
// 		        closeOnConfirm: false
// 		    }, function () {
// 		        swal("삭제가 완료되었습니다.", "  ", "success");
// 		    });
// 		},

		error:function(){
			alert('삭제 실패');
		}
	});
}

</script>



</body>