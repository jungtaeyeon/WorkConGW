<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<body>
<!-- 헤더인클루드 -->
<%@ include file="../../include/header.jsp"%>
<section class="subPageContain">
	<!-- 사이드바 -->
	<%@ include file="../issueSidebar.jsp"%>

	<style>
		.pagination{
			text-align: center;
			justify-content: center;
		}
		.columnList {
			position:absolute;
		}
		.columnList:hover{
			background-color: white !important;
			border-color: white white #dee2e6 !important;
		}
		.issueTitle:hover{
			color:#2980b9;
		}
	</style>

	<!--컨텐츠 영역-->
	<div class="contentConteiner">

		<!-- 메인 content -->
		<div id="main-content">
			<div class="container-fluid">
				<div class="row clearfix">
					<div class="col-12" style="margin-top: 2%; font-family: S-CoreDream-6Bold">
						<h2><i class="fa fa-tasks"></i>&nbsp;이슈 목록</h2>
						<hr>
					</div>
				</div>

				<div class="row clearfix" style="font-family: S-CoreDream-7ExtraBold">
					<div class="col-lg-12 col-md-12">
						<div class="card">
							<div class="body project_report">
								<button type="button" class="btn btn-light active" onclick="window.location.href='${pageContext.request.contextPath}/board/issue/list';">이슈</button>
								<button type="button" class="btn btn-light" onclick="window.location.href='${pageContext.request.contextPath}/board/milestone/list';">마일스톤</button>
								<button type="button" class="btn btn-light" onclick="window.location.href='${pageContext.request.contextPath}/board/project/list';">프로젝트</button>

								<label class="fancy-checkbox m-l-30">
									<input type="checkbox" data-parsley-multiple="checkbox" <c:if test="${boardFormVO.searchIssueVO.searchCondition eq 'w' && boardFormVO.searchIssueVO.searchKeyword eq loginUser.emp_Name }">checked</c:if>  onchange="setSearchCondition(this);"/>
									<span>내 이슈만 보기</span>
								</label>

								<div style="display:inline-block;margin:5px 15px;font-size: 1.2em;color:gray;">
									[총 <fmt:formatNumber value="${paginationInfo.totalRecordCount }" type="number"/>개]
								</div>

								<form:form modelAttribute="boardFormVO" name="listForm">
									<form:hidden path="searchIssueVO.isOpen" />
									<form:hidden path="searchIssueVO.issue_Open_St" />
									<div style="margin-top:20px;">
										<form:select path="searchIssueVO.searchCondition" class="form-control selectSearch" style="width:130px;font-size: 1.2em;float:left;">
											<form:option value="tcw">전체</form:option>
											<form:option value="t">제목</form:option>
											<form:option value="c">내용</form:option>
											<form:option value="w">작성자</form:option>
										</form:select>
										<div id="navbar-search" class="navbar-form search-form selectSearch" style="float:left;">
											<form:input path="searchIssueVO.searchKeyword" class="form-control" placeholder="검색어 입력" type="text" style="display: inline-block; width: 400px;height:36px;padding-right: 40px;" onkeypress="checkEnter(searchIssueList);"/>
											<button type="button" class="btn btn-default" onclick="searchIssueList();"><i class="fas fa-search"></i></button>
										</div>
										<div class="form-group" style="float:right;">
											<div style="display: inline-block;float:left;font-size: 1.2em;margin:6px 20px 0 0">
												<span>${paginationInfo.currentPageNo} </span>/<span> ${paginationInfo.totalPageCount} 페이지 중</span>
											</div>
										</div>
									</div>

									<div class="table-responsive">
										<ul class="nav nav-tabs" style="position:absolute;width:97.5%;z-index: 10;">
											<c:choose>
												<c:when test="${boardFormVO.searchIssueVO.isOpen eq 'open' }">
													<li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="open" onclick="changeCategory(this);"><i class="fas fa-info-circle"></i> <span style="margin-left:5px;">${paginationInfo.totalRecordCount }</span> Open</a></li>
													<li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="closed" onclick="changeCategory(this);"><i class="fa fa-check"></i> <span style="margin-left:5px;">${oppListCount}</span> Closed</a></li>
												</c:when>
												<c:otherwise>
													<li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="open" onclick="changeCategory(this);"><i class="fas fa-info-circle"></i> <span style="margin-left:5px;">${oppListCount}</span> Open</a></li>
													<li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="closed" onclick="changeCategory(this);"><i class="fa fa-check"></i> <span style="margin-left:5px;">${paginationInfo.totalRecordCount }</span> Closed</a></li>
												</c:otherwise>
											</c:choose>
										</ul>
										<div class="tab-content p-l-0 p-r-0 p-t-0">
											<!-- Open 이슈 -->
											<div class="tab-pane animated fadeIn active">
												<table class="table table-hover js-basic-example table-custom m-b-0 no-footer" role="grid">
													<thead>
													<tr>
														<th style="width:40%;"></th>
														<th style="width:20%;">마일스톤</th>
														<th style="width:20%;">작성자</th>
														<th style="width:10%;">댓글</th>
														<th style="width:10%;">조회수</th>
													</tr>
													</thead>
													<tbody style="border:hidden;">
													<c:if test="${!empty issueList}">
														<c:forEach items="${issueList }" var="issue">
															<tr role="row">
																<td class="project-title" style="padding:15px 30px;">
																	<div>
																		<h6 style="display:inline-block;font-weight: bold;max-width: 400px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;">
																			<c:if test="${boardFormVO.searchIssueVO.isOpen eq 'open' }">
																				<i class="fas fa-info-circle" style="color:green;"></i>
																			</c:if>
																			<c:if test="${boardFormVO.searchIssueVO.isOpen eq 'closed' }">
																				<i class="fa fa-check" style="color:red;"></i>
																			</c:if>
																			<span class="issueTitle" style="cursor:pointer;margin-left:5px;font-size:1.1em;" onclick="checkIssue(${issue.issue_Board_St}, '${pageContext.request.contextPath }/board/issue/detail?issue_Board_Id=${issue.issue_Board_Id }', '${loginUser.emp_Id}', '${issue.emp_Id}')">${issue.issue_Board_Title }</span>
<%--																			<span class="issueTitle" style="cursor:pointer;margin-left:5px;font-size:1.1em;" onclick="window.location.href='${pageContext.request.contextPath }/board/issue/detail?issue_Board_Id=${issue.issue_Board_Id }';">${issue.issue_Board_Title }</span>--%>
																		</h6>
																		<c:if test="${!empty issue.duty_Board_Title }">
																			<a href="${pageContext.request.contextPath }/board/duty/detail?duty_Board_Id=${issue.duty_Board_Id }">
																				<span class="btn btn-secondary" style="padding: 0px 3px;margin-left:5px;">#${issue.duty_Board_Id }</span>
																			</a>
																		</c:if>
																		<c:if test="${issue.issue_Board_St eq 2 }">
																			<span class="btn btn-secondary" style="padding: 0px 3px;margin-left:5px;">비공개</span>
																		</c:if>
																	</div>
																	<span style="margin-left:25px;">이슈 번호: #${issue.issue_Board_Id }</span><br>
																	<span style="margin-left:25px;"><i class="far fa-clock"></i> 생성일: <fmt:formatDate value="${issue.issue_Board_Create_Dt}" pattern="yyyy-MM-dd"/></span>
																</td>
																<td class="project-actions" style="max-width: 0px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;padding-right:50px;">
																		<c:if test="${issue.milestone_Id ne 0}">
																			${issue.milestone_Name }
																		</c:if>
																		<c:if test="${issue.milestone_Id eq 0}">
																			없음
																		</c:if>
																</td>
																<td class="project-actions">
																	<c:choose>
																		<c:when test="${empty issue.emp_Picture }">
																			<img src="<%=request.getContextPath() %>/resources/image/NO_IMAGE.png" data-toggle="tooltip" data-placement="top" title="" alt="Avatar" class="width45 rounded" data-original-title="${issue.emp_Name }">
																		</c:when>
																		<c:otherwise>
																			<div id="pictureView" style="display:inline-block;vertical-align:middle;margin-right:10px;background-image:url('${pageContext.request.contextPath }/pds/empPicture/${issue.emp_Picture}'); width: 45px; height: 45px;" class="rounded-circle avatar" data-toggle="tooltip" data-placement="top" data-original-title="${issue.emp_Name }"></div>
																			<div style="display:inline-block;vertical-align:middle;">
																				<strong>${issue.emp_Name }&nbsp;${issue.officialName }</strong>
																				<div>
																					<c:if test="${not empty issue.dept_Name}">
																						${issue.dept_Name } /
																					</c:if>
																					<span>${issue.teamName }</span>
																				</div>
																			</div>
																		</c:otherwise>
																	</c:choose>
																</td>
																<td class="project-actions" style="font-size:1.3em;">
																		<i class="fas fa-comment" style="margin-left:5px;"></i> ${issue.reply_Count }
																</td>
																<td class="project-actions" style="font-size:1.3em;">
																	${issue.issue_Board_Readcnt }
																</td>
															</tr>
														</c:forEach>
													</c:if>
													<!-- 검색결과가 없을때 -->
													<c:if test="${empty issueList }">
														<tr role="row">
															<td class="project-title noList" style="text-align:center;font-size:1.2em;font-weight: bold;height:80px;" colspan="8">검색 결과가 없습니다.</td>
														</tr>
													</c:if>
													</tbody>
												</table>
											</div>

											<!-- Pagination -->
											<div aria-label="Page navigation example" style="height:45px;text-align: center;margin-top:5px;">
												<div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate" >
													<ul class="pagination">
														<c:if test="${boardFormVO.searchIssueVO.prev}">
															<li class="paginate_button page-item previous" id="dataTable_previous">
																<a href="javascript:void(0);" onclick="searchIssueList(${boardFormVO.searchIssueVO.startDate - 1}); return false;" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a>
															</li>
														</c:if>

														<c:forEach var="num" begin="${boardFormVO.searchIssueVO.startDate}" end="${boardFormVO.searchIssueVO.endDate}">
															<li class="paginate_button page-item">
																<a href="javascript:void(0);" onclick="searchIssueList(${num}); return false;" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">${num}</a>
															</li>
														</c:forEach>

														<c:if test="${boardFormVO.searchIssueVO.next}">
															<li class="paginate_button page-item next" id="dataTable_next">
																<a href="javascript:void(0);" onclick="searchIssueList(${boardFormVO.searchIssueVO.endDate + 1}); return false;" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Next</a>
															</li>
														</c:if>
													</ul>
												</div>
											</div>
											<form:hidden path="searchIssueVO.pageIndex" />

										</div>
									</div>
								</form:form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<script>
			window.onload=function(){
				$('#${boardFormVO.searchIssueVO.isOpen}').addClass('active');
			}

			function checkIssue(issueBoardSt, url, loginUserEmpId, issueEmpId) {
				if (issueBoardSt === 1) {
					window.location.href = url;
				} else if (issueBoardSt === 2) {
					if (loginUserEmpId === issueEmpId) {
						window.location.href = url;
					} else {
						alert("비공개 이슈입니다.");
					}
				}
			}

			// open/closed 탭 변경시
			function changeCategory(obj){
				$('input[name="searchIssueVO.isOpen"]').val($(obj).attr('id'));
				$('form[name="listForm"]').submit();
			}

			//검색 및 페이지네이션
			function searchIssueList(pageNo){
				if(!pageNo){
					pageNo = 1;
				}
				var listForm = $('form[name="listForm"]');
				$('input[name="searchIssueVO.pageIndex"]').val(pageNo);
				listForm.submit();
			}

			// 내 이슈만 보기
			function setSearchCondition(obj){
				if($(obj).is(':checked')){
					$('select[name="searchIssueVO.searchCondition"]').val('w');
					$('input[name="searchIssueVO.searchKeyword"]').val('${loginUser.emp_Name}');
					$('input[name="searchIssueVO.issue_Open_St"]').val(2);
				}else{
					$('select[name="searchIssueVO.searchCondition"]').val('tcw');
					$('input[name="searchIssueVO.searchKeyword"]').val('');
					$('input[name="searchIssueVO.issue_Open_St"]').val(1);
				}
				searchIssueList();
			}
		</script>

		<!--컨텐츠 영역 끝-->
	</div>
</section>
<!-- 푸터 인클루드 -->
<%@ include file="../../include/footer.jsp"%>
</body>
