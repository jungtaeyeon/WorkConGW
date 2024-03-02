<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/fonts/font.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Popper.js CDN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha512-ldc1sPu1FZ8smgkgp+HwnYyVb1eRn2wEmKrDg1JqPEb02+Ei4kNzDIQ0Uwh0AJVLQFjJoWwG+764x70zy5Tv4A==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- Bootstrap CSS, js CDN -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- FontAwesome -->
<script src="https://kit.fontawesome.com/3a92c85ff9.js" crossorigin="anonymous"></script>
<!-- TreeView -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/js/treeview/jquery.treeview.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/js/treeview/screen.css" />
<script src="<%=request.getContextPath() %>/js/treeview/jquery.treeview.js"></script>
<!-- Summernote -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
<!-- Bootstrap Datepicker CSS, JS CDN -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/css/bootstrap-datepicker.min.css" integrity="sha512-34s5cpvaNG3BknEWSuOncX28vz97bRI59UnVtEEpFX536A7BtZSJHsDyFoCl8S7Dt2TPzcrCEoHBGeM4SUBDBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/js/bootstrap-datepicker.min.js" integrity="sha512-LsnSViqQyaXpD4mBBdRYeP6sRwJiJveh2ZIbW41EBrNmKxgr/LFZIiWT6yr+nycvhvauz8c2nYMhrP80YhG7Cw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- common.js -->
<script src="<%=request.getContextPath() %>/js/common.js"></script>

<style>
	.subPageContain {
		display: flex;
	}
	#header-group {
		width: 1000px;
	}

	:root {
		--side-bar-width: 250px;
		--side-bar-height: 100vh;
	}

	.side-bar {
		/*position: fixed;*/
		/*background-color: rgba(255, 255, 255, 0.95);*/
		background-color: #0c1e35;
		color: white;
		box-shadow: 0px 0px 7px -2px rgba(0, 0, 0, 0.025);
		width: var(--side-bar-width);
		min-height: var(--side-bar-height);
		-webkit-user-select: none;
		-moz-user-select: none;
		-ms-user-select: none;
		user-select: none;
	}

	.contentContainer {
		flex: 1; /* 콘텐츠 컨테이너가 남은 공간을 채우도록 설정 */
		padding: 50px;
	}

	#listForm{
		width: 1423px;
		height: 500px;
	}
	.body{
		max-width: 1500px; /* 예시로 1200px로 설정 */
	}


	th {
		width: auto; /* 기본 너비 설정을 해제하여 내용에 맞게 조절될 수 있도록 함 */
	}

	/* 각 th에 대한 너비 설정 */
	th:nth-child(1) { width: 60px; } /* 첫 번째 th의 너비 */
	th:nth-child(2) { width: 200px; } /* 두 번째 th의 너비 */
	th:nth-child(3) { width: 200px; } /* 세 번째 th의 너비 */
	th:nth-child(4) { width: 200px; }
	th:nth-child(5) { width: 200px; }
	th:nth-child(6) { width: 200px; }
	th:nth-child(7) { width: 230px; }
	/* 나머지 th에 대한 너비 설정 계속... */


</style>
<!-- 메인 content -->
<!-- 헤더인클루드 -->

<section class="subPageContain">
	<!-- 사이드바 -->
	<div class="side-bar">
		<div><%@ include file="../sidebar.jsp"%></div>
	</div>
	<!--컨텐츠 영역-->
	<div class="contentConteiner">

		<div class="container-fluid">
			<!-- 메인 content 넣는 곳 -->
			<div class="row clearfix" >
				<div class="col-lg-12" >
					<div class="card">
						<div class="header-group" id="header-group">
							<div class="header col-lg-6">
								<span style="color: #a9a9a9; font-family: S-CoreDream-4Regular">조직 관리</span>
								<h3 style="font-family: S-CoreDream-6Bold">직원 목록</h3>

							</br>
							</br>
							</div>
						</div>

						<form:form modelAttribute="empFormVO" id = "listForm" name = "listForm" method="get">

						<div class="box" id="searchFormDiv" style="font-family: S-CoreDream-7ExtraBold">

							<form:select path="searchEmpVO.search_code" class="form-control selectSearch" style="width:150px;font-size: 1.2em;float:left;">
								<form:option value="">직책 전체</form:option>
								<form:option value="c01">부장</form:option>
								<form:option value="c02">차장</form:option>
								<form:option value="c03">과장</form:option>
								<form:option value="c04">대리</form:option>
								<form:option value="c05">사원</form:option>
							</form:select>



							<form:select path = "searchEmpVO.searchCondition"  class="form-control selectSearch" style="width:150px;font-size: 1.2em;float:left;">
								<form:option value="np">키워드 전체</form:option>
								<form:option value="n">이름</form:option>
								<form:option value="p">휴대폰</form:option>
							</form:select>
							<div id="navbar-search" class="navbar-form search-form selectSearch" style="float:left;">
								<form:input path = "searchEmpVO.searchKeyword" class="form-control" placeholder="검색" type="text" style="width: 218px;height:36px;padding-right: 40px;" onkeypress="checkEnter(searchList);"  autocomplete="off"/>
								<button type="button" class="btn btn-default" onclick="searchList();"><i class="icon-magnifier"></i></button>
							</div>
							<button type="button" class="btn btn-default" onclick="searchList();" style="margin-left: 5px;"><i class="fas fa-search" aria-hidden="true"></i></button>


						</div>

						<div class="body" style="font-family: S-CoreDream-7ExtraBold">
							<div class="table-responsive">
								<table class="table table-hover js-basic-example dataTable table-custom table-striped m-b-0 c_list">
									<thead class="thead-dark">
									<tr >
										<th style="text-align: left;">
											<label class="fancy-checkbox">
												<input class="select-all" type="checkbox" name="checkbox" id="empId_0">
												<span></span>
											</label>
										</th>
										<th>이름</th>
										<th>사원번호</th>
										<th>부서명</th>
										<th>직급</th>
										<th>권한</th>
										<th>휴대폰</th>
										<th>출근</th>
									</tr>
									</thead>
									<tbody>
									<c:forEach items="${empVOList}" var ="emp">
										<tr onclick = "getDetail('${emp.emp_Id}');">
											<td class="width45" onclick="event.cancelBubble=true">
												<%--계층 구조상 다음 이벤트 핸들러가 이벤트를 받는 것을 막는다.--%>
												<label class="fancy-checkbox">
													<input class="checkbox-tick" type="checkbox" name="checkbox">
													<span></span>
												</label>
											</td>
											<td>
												<h6 class="mb-0">${emp.emp_Name}</h6>
											</td>
											<td><span>${emp.emp_Id }</span></td>
											<td>${emp.dept_Name }</td>
											<td>${emp.code_Name }</td>
											<c:if test = "${emp.auth_Name eq '관리자'}">
												<td><span  class="badge badge-danger">${emp.auth_Name }</span></td>
											</c:if>
											<c:if test = "${emp.auth_Name eq '일반'}">
												<td><span  class="badge badge-primary">${emp.auth_Name }</span></td>
											</c:if>
											<td><span >${emp.emp_Hp }</span></td>
											<c:choose>
												<c:when test="${emp.attend_St_Name eq '정상출근'}">
													<td><span class="badge badge-primary">${emp.attend_St_Name}</span></td>
												</c:when>
												<c:when test="${emp.attend_St_Name eq '지각'}">
													<td><span class="badge badge-danger">${emp.attend_St_Name}</span></td>
												</c:when>
												<c:when test="${emp.attend_St_Name eq '퇴근'}">
													<td><span class="badge badge-warning">${emp.attend_St_Name}</span></td>
												</c:when>
												<c:when test="${emp.attend_St_Name eq '조퇴'}">
													<td><span class="badge badge-info">${emp.attend_St_Name}</span></td>
												</c:when>
												<c:when test="${emp.attend_St_Name eq '야근'}">
													<td><span class="badge badge-warning">${emp.attend_St_Name}</span></td>
												</c:when>
												<c:otherwise>
													<td><span>${emp.attend_St_Name}</span></td>
												</c:otherwise>
											</c:choose>


										</tr>
									</c:forEach>
									</tbody>
								</table>
							</div>
							<!-- Pagination -->
							<div class="col-sm-12 col-md-7" style="text-align:right">
								<div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
									<ul class="pagination">

										<c:if test="${searchEmpVO.prev}">
											<li class="paginate_button page-item previous" id="dataTable_previous">
												<a href="javascript:void(0);" onclick="searchList(${searchEmpVO.startDate - 1}); return false;" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a>
											</li>
										</c:if>

										<c:forEach var="num" begin="${searchEmpVO.startDate}" end="${searchEmpVO.endDate}">
											<li class="paginate_button page-item">
												<a href="javascript:void(0);" onclick="searchList(${num}); return false;" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">${num}</a>
											</li>
										</c:forEach>

										<c:if test="${searchEmpVO.next}">
											<li class="paginate_button page-item next" id="dataTable_next">
												<a href="javascript:void(0);" onclick="searchList(${searchEmpVO.endDate + 1}); return false;" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Next</a>
											</li>
										</c:if>
									</ul>
								</div>
							</div>

							<!-- Pagination -->
							<form:hidden path="searchEmpVO.pageIndex" />
							</form:form>
						</div>
					</div>
				</div>
			</div>


		</div>
</section>
<!-- 푸터 인클루드 -->


<script>



	function getDetail(emp_Id)
	{
		location.href = '<%=request.getContextPath()%>/admin/emp/empDetail?emp_Id='+emp_Id
	}

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


	function searchList(pageNo)
	{
		if(!pageNo)
		{
			pageNo = 1;
		}
		let listForm = $('form[name="listForm"]')
		$('input[name="searchEmpVO.pageIndex"]').val(pageNo);
		$("#pageIndex").val(pageNo);
		$("#listForm").submit();
		return false;
	}


	function OpenWindow(UrlStr, WinTitle, WinWidth, WinHeight){
		winleft = (screen.width - WinWidth) / 2;
		wintop = (screen.height - WinHeight) / 2;
		var winX      = window.screenX || window.screenLeft || 0;// 현재창의 x좌표
		var winY      = window.screenY || window.screenTop || 0; // 현재창의 y좌표

		winleft = winX + winleft;
		wintop = winY + wintop;

		var win = window.open(UrlStr, WinTitle, "scrollbars=yes,width="+ WinWidth +", "
				+"height="+WinHeight + ", top=" + wintop +", left="
				+ winleft +", resizable=yes, status=yes");
		win.focus();
	}


	$(document).ready(function (){
		let thisIndex = "${searchEmpVO.pageIndex}"

		$(".pagination li a").each(function (){
			let idx = $(this).parent().index();
			let thistitle = $(this).attr("title");
			if(thistitle == thisIndex)
			{
				$(".pagination").find("li").eq(idx).addClass("active");
			}
		})
	})

</script>

</body>
