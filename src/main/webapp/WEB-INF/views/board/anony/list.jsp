<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="root" value="<%=request.getContextPath() %>" scope="application"/>



<head>
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

.pagination{
	text-align: center;
	margin-left: 350px;
}

#tr1{
	text-align: center;
	padding-left: -10px;

}

tbody{
	text-align: center;
}

.td2{
/* 	text-align: left;  */
/* 	padding-left: 80px; */
}

.num{
	width:80px;
}


</style>

<body>


<%@ include file="/WEB-INF/views/include/header.jsp"%>
<section class="subPageContain">
	<!-- 사이드바 -->
	<%@ include file="../boardSidebar.jsp"%>
	<!--컨텐츠 영역-->
	<div class="contentConteiner">
		<div class="container-fluid">
			<div class="row clearfix" style="font-family: S-CoreDream-7ExtraBold;">


				<div class="col-md-8">
					<div class="row">
						<div class="col">
							<h2 style="font-family: S-CoreDream-6Bold"><i class="fa fa-comments-o"></i>&nbsp;익명 게시판</h2>
							<hr>
						</div>
					</div>

					<!-- 나머지 익명 게시판 내용은 여기에 들어갑니다 -->
					<div id="main-content">

						<div class="container-fluid">


							<div class="row clearfix" style="font-family: S-CoreDream-7ExtraBold;">
								<div class="col-lg-12 col-md-12">
									<div class="card">
										<div class="body project_report">
											<form:form modelAttribute="boardFormVO" id="listForm"  action = "${root}/board/anony/list" method ="get">
												<!-- 리셋버튼 -->
												<button id="resetBtn" type="reset" class="btn btn-default" title="Refresh" style="display: none;"></button>
												<label onclick="conditionReset();"  style="cursor: pointer;">
													<i class="fa fa-refresh"></i>&nbsp&nbsp검색 조건 초기화
												</label>
												<div style="display:inline-block;margin:5px 15px;font-size: 1.2em;color:gray;">
													<div class="tab-content p-l-0 p-r-0 text-align" style="font-size: 20px;text-align: center;">


													</div>
													<span>총 게시물 ${totCnt} / 페이지(${searchAnonyVO.pageIndex} / ${totalPageCnt})</span>
												</div>
												<div>
													<form:select path="searchAnonyVO.searchCondition" class="form-control selectSearch" style="width:130px;font-size: 1.2em;float:left;">
														<form:option value="tc">전체</form:option>
														<form:option value="t">제목</form:option>
														<form:option value="c">내용</form:option>
													</form:select>
													<button type="button" class="btn btn-default" onclick="searchList();"><i class='fas fa-search'></i></button>

													<div id="navbar-search" class="navbar-form search-form selectSearch" style="float:left;">
														<form:input path="searchAnonyVO.searchKeyword" class="form-control" placeholder="검색어를 입력하세요" type="text" style="width: 218px;height:36px;padding-right: 40px;" onkeypress="checkEnter(searchList);"/>

													</div>

													<div class="form-group" style="float:right;">
														<div style="display: inline-block;float:left;font-size: 1.2em;margin:6px 20px 0 0">

															<span>${paginationInfo.currentPageNo} </span>/<span> ${paginationInfo.totalRecordCount} 페이지 중</span>-
														</div>

													</div>
												</div>
												<!-- 게시판 목록 -->
												<div class="body">
													<div class="table-responsive">
														<table class="table table-bordered" width="100%" cellspacing="0" style="text-align:center;">
															<thead class="shadow-none p-3 mb-5 bg-light rounded">
															<tr id="tr1">
																<th class="num" style="width: 105px; text-align: center;">번호</th>
																<th class="title" style="width: 300px;">제목</th>
																<th>작성일자</th>
																<th>조회수</th>
															</tr>
															</thead>
															<tbody style="cursor: pointer;">
															<c:if test="${!empty anonyList }">
																<c:forEach items="${anonyList}" var="anony">
																	<tr role="row" onclick="window.location='<%=request.getContextPath()%>/board/anony/detail?anonyVO.anony_Board_Id=${anony.anony_Board_Id }'">
																	<td id="anony_Board_Id" style="text-align:center;">${anony.anony_Board_Id}</td>
																		<td id="anony_Board_Title" style="width: 60%;text-align: left; padding-left: 100px;">
																			<span style="width: 300px;"><c:out value = "${anony.anony_Board_Title}"/></span>

																			<c:if test="${anony.anony_Hangle_Dt<= (1000*60*5) }">
																				&nbsp<span class="badge badge-danger" >방금전</span>
																			</c:if>
																			<c:if test="${anony.anonyReplyList.size() > 0 }">
																				<i class="icon-bubble text-info" style="margin-left:5px; font-size: 1.2em; font-weight: bold">
																		<span class="m-l-5" style="vertical-align: text-top; margin-left: 3px;">
																			<fmt:formatNumber value="${anony.anonyReplyList.size() }" type="number"/>
																		</span>
																				</i>
																			</c:if>
																		</td>
																		<td>
																			<fmt:formatDate value="${anony.anony_Board_Create_Dt }" pattern="yyyy.MM.dd"/>
																		</td>
																		<td style="text-align:center;">${anony.anony_Board_ReadCnt }</td>
																	</tr>
																</c:forEach>
															</c:if>

															<c:if test="${empty anonyList}">
																<td style="text-align: center;"><strong>해당 내용이 없습니다.</strong></td>
															</c:if>
															</tbody>
														</table>
													</div>
												</div>


												<!-- Pagination -->
												<div class="col-sm-12 col-md-7" style="text-align:right">
													<div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
														<ul class="pagination">

															<c:if test="${searchAnonyVO.prev}">
																<li class="paginate_button page-item previous" id="dataTable_previous">
																	<a href="javascript:void(0);" onclick="searchList(${searchAnonyVO.startDate - 1}); return false;" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a>
																</li>
															</c:if>

															<c:forEach var="num" begin="${searchAnonyVO.startDate}" end="${searchAnonyVO.endDate}">
																<li class="paginate_button page-item">
																	<a href="javascript:void(0);" onclick="searchList(${num}); return false;" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">${num}</a>
																</li>
															</c:forEach>

															<c:if test="${searchAnonyVO.next}">
																<li class="paginate_button page-item next" id="dataTable_next">
																	<a href="javascript:void(0);" onclick="searchList(${searchAnonyVO.endDate + 1}); return false;" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Next</a>
																</li>
															</c:if>
														</ul>
													</div>
												</div>

												<!-- Pagination -->
												<form:hidden path="searchAnonyVO.pageIndex" />
											</form:form>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- 푸터 인클루드 -->
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>

	<script defer>

	// 검색 조건 설정 변화
	function changeForm(obj){
		var searchCri = $(obj).attr('data');

		if($(obj).is(':checked')==true){
			$('.'+searchCri).css('display','');
		}else{
			$('.'+searchCri).css('display','none');
			$('.'+searchCri).val("");
		}
	}


	$("#regist").on("click", function (e) {
		e.preventDefault();
		// 이후의 로직을 여기에 추가
	});



	// 검색 및 페이지네이션
	function searchList(pageNo){
		if(!pageNo){
			pageNo = 1;
		}
		let listForm = $('form[name="listForm"]');
		$('input[name="searchAnonyVO.pageIndex"]').val(pageNo);

		$("#pageIndex").val(pageNo);
		$("#listForm").submit();
		return false;




	}


	window.onload=function(){
		// 정렬 아이콘 삭제
		var thList = $('tr[role="row"] > th');
		for(var i=0; i<thList.length; i++){
			thList.eq(i).removeClass();
		}

		// 검색 조건 체크박스 설정
		if($('#inputSearchDeadline').val()!=""){
			$('#checkboxDeadline').attr("checked",true);
			changeForm(document.getElementById('checkboxDeadline'));
		}
		if($('#selectSearchState').val()!=""){
			$('#checkboxState').attr("checked",true);
			changeForm(document.getElementById('checkboxState'));


		}}





	// 검색조건 초기화
	function conditionReset() {
		$("#resetBtn").click();
		$('.myConditions').css("display","none");
		$('input#searchAnonyVO.searchKeyword').val("");
		$("input:checkbox:checked").click();
		$("#inputSearchDt").val("");
	}



	$(document).ready(function() {

		let thisIndex = "${searchAnonyVO.pageIndex}"
		$(".pagination li a").each(function(){
			let idx = $(this).parent().index();
			let thistitle = $(this).attr("title");
			if(thistitle == thisIndex){
				$(".pagination").find("li").eq(idx).addClass("active");
			}
		});

		});



	</script>
