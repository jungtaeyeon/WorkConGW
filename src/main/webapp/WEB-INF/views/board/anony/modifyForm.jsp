<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
<!-- VENDOR CSS -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/js/treeview/jquery.treeview.css" />
	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- Font Awesome CDN -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" integrity="sha512-" crossorigin="anonymous" />
	<!-- Bootstrap CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<!-- Bootstrap JS -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
	<!-- Summernote -->
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>






</head>

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
    padding-right: 18px;
}

.body{	
    padding-top: 15px;
    padding-left: 17px;
    padding-right: 17px;	
}

.btn1{
	text-align: right;
}

th{
	vertical-align: bottom;
    border-bottom: 2px solid #dee2e6;
}

</style>

<body>

<script src="<%=request.getContextPath()%>/js/summernote.js"></script>
<!-- 메인 content -->
	<div id="main-content" >
		<div class="container-fluid">
			<form:form modelAttribute="boardFormVO" name="anonyModifyForm" action="${pageContext.request.contextPath }/board/anony/modify" enctype="multipart/form-data">
				<form:hidden path="anonyVO.pageIndex"/>
		        <form:hidden path="anonyVO.anony_Board_Id" />
<%-- 		        <form:hidden path="anonyVO.anonyBoardTitle"/> --%>
		        <form:hidden path="anonyVO.anony_Board_Content" id="anony_Board_Content"/>
		        <form:hidden path="anonyVO.anony_Board_ReadCnt"/>
		        <form:hidden path="anonyVO.anony_Board_Create_Dt"/>
				<%--현재 로그인한 사용자의 ID를 hidden input에 설정 --> 서버단에서 사용--%>
		        <form:hidden path="anonyVO.replyCount"/>
		<div class="row clearfix">
			<div class="col-12" style="margin-top: 2%;">
				<h2 style="font-family: S-CoreDream-6Bold">
					<i class="icon-bubbles"></i>&nbsp;익명 게시판
				</h2>
				<hr>
			</div>
		</div>
	<div class="div2">
		<div class="row clearfix" >
			<div class="col-lg-12 col-md-12" >
				<div class="card" style="font-family: S-CoreDream-4Regular">
					<div class="body project_report" >
						<div class="body" style="padding-left: 0px; padding-right: 0px;">
							<div class="table-responsive">
								<table class="table table-hover m-b-0">
									<thead class="shadow-none p-3 mb-5 bg-light rounded">
										<tr id="tr1">
											<td style="width:130px;">
												<h6 id="h6" style="font-weight: bold;">제목</h6>
											</td>
											<td colspan="5">
												<div style="padding-left:15px;border-left: 1px dotted gray;">
												<form:textarea path="anonyVO.anony_Board_Title" style="width: 85%; height: 35px;"/>
												</div>
											</td>
										</tr>
										<tr style= "vertical-align: bottom; border-bottom: 2px solid #dee2e6;">
											<td>
												<strong>작성일자</strong>
											</td>
											<td>
												<div style="padding-left:15px;border-left: 1px dotted gray;">
													<fmt:formatDate value="${boardFormVO.anonyVO.anony_Board_Create_Dt }" pattern="yyyy-MM-dd"/>
												</div>
											</td>
											<td style="width:130px;">
												<strong>조회수</strong>
											</td>
											<td>
												<div style="padding-left:15px;border-left: 1px dotted gray;">${boardFormVO.anonyVO.anony_Board_ReadCnt }</div>
											</td>
										</tr>
									</thead>
										<tr style="vertical-align: bottom; border-bottom: 2px solid #dee2e6;">
										</tr>
										</table>
<!-- 내용 -->
	<div style="margin-top: 20px; margin-top: 20px;padding-left: 13px;padding-right: 13px;"><div class="summernote" contenteditable="true">${boardFormVO.anonyVO.anony_Board_Content }</div>
						</div>
						</form:form>
					</div>
				</div>
				<div class="modifySuccessbutton" style="text-align: center; margin-top: 5px;">
                  <button class="btn btn-primary " data-type="success" onclick="modify_go();" >수정완료</button>
				</div>
				
<script>
//열고 닫는 함수입니다.
function plusFromMinus(obj){
	if($(obj).hasClass("expandable-hitarea")){
		$(obj).parent("li").removeClass("expandable lastExpandable");
		$(obj).parent("li").addClass("collapsable lastCollapsable");
		$(obj).removeClass("hitarea expandable-hitarea lastExpandable-hitarea");
		$(obj).addClass("hitarea collapsable-hitarea lastCollapsable-hitarea");
		$(obj).parent("li").children("ul").css("display","block");
	}else{
		$(obj).parent("li").removeClass("collapsable lastCollapsable");
		$(obj).parent("li").addClass("expandable lastExpandable");
		$(obj).removeClass("hitarea collapsable-hitarea lastCollapsable-hitarea");
		$(obj).addClass("hitarea expandable-hitarea lastExpandable-hitarea");
		$(obj).parent("li").children("ul").css("display","none");
	}
}
//수정
function modify_go(){
	let modifyForm = $('form[name="anonyModifyForm"]')[0];
	
	if($.trim($('textarea[name="anonyVO.anony_Board_Title"]').val())==""){
		alert('제목을 입력하세요.');
		$('textarea[name="anonyVO.anony_Board_Title"]').focus();
		return;
	}



	$('input[name="anonyVO.anony_Board_Content"]').val($('.note-editable').html());


	
	let formData = new FormData(modifyForm);
	$.ajax({
		url:modifyForm.action,
		type:'post',
		data:formData,
		processData:false,
		contentType:false,
		success:function(){
			alert("글이 수정되었습니다.");
			
			window.location.href='<c:url value="/board/anony/detail?anonyVO.anony_Board_Id=${boardFormVO.anonyVO.anony_Board_Id}"/>';
		},
		error:function(){
			alert("글 수정에 실패했습니다.");
			window.location.href='<c:url value="/board/anony/detail?anonyVO.anony_Board_Id=${boardFormVO.anonyVO.anony_Board_Id}" />';
		}
	});
}


</script>