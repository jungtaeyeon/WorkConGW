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

<body>
<!-- 헤더인클루드 -->
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<section class="subPageContain">
	<!--컨텐츠 영역-->
	<div class="contentConteiner">

		<div id="main-content" >
			<div class="container-fluid">
				<form:form modelAttribute="boardFormVO"  name="detailForm" action="${pageContext.request.contextPath }/board/anony/detail" method="get">
					<form:hidden path="anonyVO.anony_Board_Id" />
					<form:hidden path="anonyVO.anony_Board_Title"/>
					<form:hidden path="anonyVO.anony_Board_Content"/>
					<form:hidden path="anonyVO.anony_Board_ReadCnt"/>
					<form:hidden path="anonyVO.anony_Board_Create_Dt"/>
					<form:hidden path="searchanonyReplyVO.pageIndex" />
					<div class="row clearfix">
						<div class="col-12" style="margin-top: 2%;">
							<h2 style="font-family: S-CoreDream-6Bold">
								<i class="icon-bubbles"></i>&nbsp;익명 게시판
								<button type="button" class="btn btn-secondary float-right" onclick="location.href='<%=request.getContextPath()%>/board/anony/list';"
										style="margin-right: 22px; font-family: S-CoreDream-4Regular" >
									<i class="icon-close"></i> <span>목록</span>
								</button>
								<c:if test="${loginUser.auth_Id == 'a06' }">
									<button class="btn btn-danger float-right m-r-5"
											data-type="confirm" onclick="remove_go();">
										<i class="fa fa-trash-o"></i> <span>삭제</span>
									</button>
									<c:if test = "${loginUser.auth_Id ne 'a06'} ">
										<c:if test="${anony.anony_Hangle_Dt<= (1000*60*5) }">
											<button type="button" class="btn btn-info float-right m-r-5" onclick="modify_go();">
											<i class="fa fa-eraser"></i> <span>수정</span>
										</c:if>
										</button>
									</c:if>
								</c:if>
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
															<div style="padding-left:15px;border-left: 1px dotted gray; ">
																	${anony.anony_Board_Title }&nbsp;&nbsp;&nbsp;

															</div>
														</td>
													</tr>
													<tr style= "vertical-align: bottom; border-bottom: 2px solid #dee2e6;">
														<td>
															<strong>작성일자</strong>
														</td>
														<td>
															<div style="padding-left:15px;border-left: 1px dotted gray;">
																<fmt:formatDate value="${anony.anony_Board_Create_Dt }" pattern="yyyy-MM-dd"/>
															</div>
														</td>
														<td style="width:130px;">
															<strong>조회수</strong>
														</td>
														<td>
															<div style="padding-left:15px;border-left: 1px dotted gray;">${anony.anony_Board_ReadCnt }</div>
														</td>
													</tr>
													</thead>
													<tr style="vertical-align: bottom; border-bottom: 2px solid #dee2e6;">
													</tr>
												</table>
												<!-- 내용 -->
												<div style="margin-top: 20spx; margin-top: 20px;padding-left: 13px;padding-right: 13px;">${anony.anony_Board_Content}</div>
											</div>
										</div>
									</div>

									<div class="header" style="padding-bottom: 0px;">
										<h4><b>💬 댓글 ${paginationInfo.totalRecordCount}</b></h4>
									</div>
									<!-- 댓글 등록 -->
									<div class="body">
										<form>
											<div class="form-group">
												<textarea id="reply_Content" rows="4" class="form-control no-resize" placeholder="댓글을 입력해주세요"></textarea>
											</div>
											<div class="btn1">
												<button class="btn btn-primary" onclick="registAnonyReply();"><i class="fa fa-check-square"></i> 등록</button>
												<!--     <a href="javascript:void(0);" class="float-right">13K users active</a> -->
											</div>
										</form>
										<c:if test="${anonyReplyVOList.size() == 0 }">
											<hr>
											<div style="height:70px;text-align: center;padding:10px;">
												<span>등록된 댓글이 없습니다.</span>
											</div>
										</c:if>
										<br>
										<c:if test="${anonyReplyVOList.size() > 0 }">
											<c:forEach items="${anonyReplyVOList}" var="anonyReply">
												<ul class="right_chat list-unstyled mb-0" id="replyList_${anonyReply.reply_Id}">
													<li class="offline">
														<a href="javascript:void(0);">
															<div class="media">
																<i class="icon-user" style="font-size: large;"></i>
																<div class="media-body">
	                                                <span class="name" style="padding-left: 5px;">익명
	                                               	<small class="float-right"><i class="fa fa-clock-o"></i>
	                                                </small>
	                                                </span>
																	<c:if test="${loginUser.auth_Id == 'a06' }">
																		<div class="float-right">
																			<a href="javascript:void(0);" style="margin-left:10px;" onclick="removeReply(${anonyReply.reply_Id});"><i class="fa fa-trash-o"></i> 삭제</a>
																		</div>
																	</c:if>





																	<span class="message">
	                                                	<h6 style="margin-bottom:5px; color: grey;">${anonyReply.reply_Content }</h6>
	                                                </span>
																	<span class="badge badge-outline status"></span>
																</div>
															</div>
														</a>
													</li>
												</ul>
											</c:forEach>
											<%--//////////////////////////페이징 처리구간/////////////////////////////////////////////////--%>
											<nav aria-label="Page navigation example" style="height:45px;text-align: center;margin-top:15px;">
												<div class="col-sm-12 col-md-7" style="text-align:right">
													<div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
														<ul class="pagination">

															<c:if test="${searchanonyReplyVO.prev}">
																<li class="paginate_button page-item previous" id="dataTable_previous">
																	<a href="javascript:void(0);" onclick="searchList(${searchanonyReplyVO.startDate - 1}); return false;" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a>
																</li>
															</c:if>

															<c:forEach var="num" begin="${searchanonyReplyVO.startDate}" end="${searchanonyReplyVO.endDate}">
																<li class="paginate_button page-item">
																	<a href="javascript:void(0);" onclick="searchList(${num}); return false;" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">${num}</a>
																</li>
															</c:forEach>

															<c:if test="${searchanonyReplyVO.next}">
																<li class="paginate_button page-item next" id="dataTable_next">
																	<a href="javascript:void(0);" onclick="searchList(${searchanonyReplyVO.endDate + 1}); return false;" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Next</a>
																</li>
															</c:if>
														</ul>
													</div>
												</div>
											</nav>

											<%--//////////////////////////페이징 처리구간/////////////////////////////////////////////////--%>
										</c:if>
										<div class="button1" >
											<!-- 								<button type="button" class="btn btn-outline-info"> -->
											<!-- 									<i class="fa fa-paperclip">링크복사</i> -->
											<!-- 								</button> -->
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form:form>

			</div>
		</div>

	</div>
</section>
<!-- 푸터 인클루드 -->
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>



<form name="replyRegistForm">
   <input type="hidden" name="anonyReplyVO.anony_Board_Id" value="${anony.anony_Board_Id }" />
   <input type="hidden" name="anonyReplyVO.reply_Content" />
</form>

<script type="text/javascript">





//댓글 등록
function registAnonyReply(){
	
   if($.trim($('textarea#reply_Content').val())==""){
      alert('내용을 입력하세요.');
      $('textarea#reply_Content').focus();
      return;
   }
   $('input[name="anonyReplyVO.reply_Content"]').val($('textarea#reply_Content').val()); // hidden의 name에 form id+text값을 넣어줌.


   $.ajax({
      url:'<c:url value="/board/anony/reply/regist"/>',
      type:'post',
      data:$('form[name="replyRegistForm"]').serialize(),
      success:function(){
         alert('댓글 등록 완료');
         window.location.reload(true);
      },
      error:function(){
         alert('댓글 등록이 실패했습니다.');
      }
   });
}

// 댓글 수정창 표시
function modifyReplyForm(reply_Id, reply_Content){
   if($('#replyListModify_'+reply_Id).children().length>0){
      return;
   }
   //reply_Id를 줘야 (시퀀스 처럼) 앞 값이 바뀌어야함.
   let modifyForm = '<div id="replyListModify_'+reply_Id+'" class="body" style="background-color: #eee;margin-top:15px;">'
                   +'<div class="form-group">'
                         +'<textarea id="reply_Content" rows="3" class="form-control no-resize">'+reply_Content+'</textarea>'
                   +'</div>'
                   +'<div class="post-toolbar-b align-right">'
                       +'<button class="btn btn-info" onclick="modifyReply('+reply_Id+');">수정</button>'
                       +'<button style="margin-left:5px;" class="btn btn-secondary" onclick="modifyCancel('+reply_Id+');">취소</button>'
                  +'</div>'
               +'</div>'
   $('#replyList_'+reply_Id).append(modifyForm);
}

// 댓글 수정
function modifyReply(reply_Id){
   let textarea = $('#replyListModify_'+reply_Id+' textarea'); // 위에 Contents에 접근했음.

   if($.trim(textarea.val()) == ""){
      alert('내용을 입력하세요.');
      textarea.focus();
      return;
   }
   
   $.ajax({
      url:'<c:url value="/board/anony/reply/modify"/>',
      type:'post',
      data:{'reply_Id':reply_Id,'reply_Content':textarea.val()},
      success:function(){
         alert('댓글이 수정되었습니다.');
         window.location.reload(true);
      },
      error:function(){
         alert('댓글 수정 실패');
         window.location.reload(true);
      }
   });
}

// 댓글 수정 취소
function modifyCancel(reply_Id){
   $('#replyListModify_'+reply_Id).remove();
   //jQuery를 사용하여 해당 댓글의 수정 폼을 DOM에서 제거
}

// 댓글 삭제
function removeReply(reply_Id){
   let chk = confirm('댓글을 삭제하시겠습니까?');
   if(!chk) return;
   
   $.ajax({
      url:'<c:url value="/board/anony/reply/remove"/>',
      type:'post',
      data:{'reply_Id':reply_Id},
      success:function(){
         alert('댓글이 삭제되었습니다.');
         window.location.reload(true);
      },
      error:function(){
         alert('댓글 삭제 실패');
      }
   });
}

// 댓글 페이지네이션
function searchList(pageNo){
	if(!pageNo){
		pageNo = 1;
	}

	let detailForm = $('form[name="detailForm"]');
	$('input[name="searchanonyReplyVO.pageIndex"]').val(pageNo);
	detailForm.submit();

	$("#pageIndex").val(pageNo);
	$("#detailForm").submit();
	return false;

}

//수정 페이지
function modify_go(){
	let anonyModifyForm = document.detailForm;
	anonyModifyForm.action = '${pageContext.request.contextPath }/board/anony/modifyForm';
	
	anonyModifyForm.submit();
}

//게시글 삭제
function remove_go(){
	let check = confirm('글을 삭제하시겠습니까?');
	if(!check) return;

	let detailForm = document.detailForm;
	detailForm.action = '${pageContext.request.contextPath }/board/anony/remove';
	let form = new FormData(detailForm);
	
	$.ajax({
		url:detailForm.action,
		type:'get',
		data:form,
		processData:false,
		contentType:false,
		success:function(){
			alert('글이 삭제되었습니다.');

		},
		error:function(){

		}
	});
}
// $(function () {
//     $('.js-sweetalert').on('click', function () {
//         var type = $(this).data('type');
//         if (type === 'basic') {
//             showBasicMessage();
//         }
        
//         else if (type === 'confirm') {
//             showConfirmMessage();
//         }
//     });
// });

// function showConfirmMessage() {
//     swal({
//         title: "정말 삭제하시겠습니까?",
// //         text: "You will not be able to recover this imaginary file!",
//         type: "warning",
//         showCancelButton: true,
//         confirmButtonColor: "#dc3545",
//         confirmButtonText: "삭제",
//         closeOnConfirm: false
//     }, function () {
//         swal("삭제가 완료되었습니다.", "  ", "success");
//     });
// }



</script>



</body>