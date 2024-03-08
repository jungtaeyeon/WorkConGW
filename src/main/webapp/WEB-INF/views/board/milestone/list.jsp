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
tr:hover{
	background-color: white;
}
.subTitleText {
			margin-bottom: 25px;
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

	<div class="contentConteiner">
<!-- 메인 content -->
		<div id="main-content">
			<div class="container-fluid">
					<div class="row clearfix">
						<div class="col-12" style="padding: 0;">
							<div class="subTitleText">
								<h2>
									<i class="fa-solid fa-angles-right"></i>마일스톤
								</h2>
							</div>
						</div>
					</div>

					<div class="row clearfix">
						<div class="col-lg-12 col-md-12" style="padding: 0;">
							<div>
								<div class="body project_report">
									<button type="button" class="btn btn-light" onclick="window.location.href='${pageContext.request.contextPath}/board/issue/list';">이슈</button>
									<button type="button" class="btn btn-light active" onclick="window.location.href='${pageContext.request.contextPath}/board/milestone/list';">마일스톤</button>
									<button type="button" class="btn btn-light" onclick="window.location.href='${pageContext.request.contextPath}/board/project/list';">프로젝트</button>
									<button type="button" class="btn btn-primary float-right" onclick="window.location.href='${pageContext.request.contextPath}/board/milestone/registForm';">마일스톤 생성하기</button>

									<form:form modelAttribute="milestoneVO" name="listForm" action="${pageContext.request.contextPath }/board/milestone/list">
										<form:hidden path="isOpen" id="isOpenForTab" />
										<div class="table-responsive" style="margin-top:20px;">
											<ul class="nav nav-tabs">
												<c:choose>
													<c:when test="${milestoneVO.isOpen eq 'open' }">
														<li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="open" onclick="changeCategory(this);"><i class="fas fa-info-circle"></i> <span style="margin-left:5px;">${milestoneList.size() }</span> Open</a></li>
														<li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="closed" onclick="changeCategory(this);"><i class="fa fa-check"></i> <span style="margin-left:5px;">${oppListCount}</span> Closed</a></li>
													</c:when>
													<c:otherwise>
														<li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="open" onclick="changeCategory(this);"><i class="fas fa-info-circle"></i> <span style="margin-left:5px;">${oppListCount}</span> Open</a></li>
														<li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="closed" onclick="changeCategory(this);"><i class="fa fa-check"></i> <span style="margin-left:5px;">${milestoneList.size() }</span> Closed</a></li>
													</c:otherwise>
												</c:choose>
											</ul>
											<div class="tab-content p-l-0 p-r-0 p-t-0">
												<!-- 마일스톤 뷰-->
												<div class="tab-pane animated fadeIn active">
													<table class="table table-hover js-basic-example table-custom m-b-0 no-footer" role="grid">
														<tbody style="border:hidden;">
															<c:if test="${!empty milestoneList}">
																<c:forEach items="${milestoneList }" var="milestone">
																	<tr role="row">
																		<td class="project-title" style="padding:30px;width:50%;">
																			<div>
																				<h6>
																					<span data-openIssueCount="${milestone.openIssueCount }" data-closedIssueCount="${milestone.closedIssueCount }" data-milestone_Id="${milestone.milestone_Id }"
																						  style="margin-bottom:5px;display:inline-block;font-weight: bold;max-width: 500px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;cursor:pointer;margin-left:5px;font-size:1.1em;" onclick="detailPage('${milestone.milestone_Id}')">${milestone.milestone_Name }</span>
																				</h6>
																			</div>
																			<div style="font-size: 1.1em;">
																				<i class="far fa-clock"></i><span style="margin-left:5px;">마감일
																				<%-- 마감일 if문 작성 영역 --%>
																				<c:if test="${!empty milestone.milestone_End_Dt }">
																					: <fmt:formatDate value="${milestone.milestone_End_Dt }" pattern="yyyy-MM-dd"/>
																				</c:if>
						                                                		<c:if test="${empty milestone.milestone_End_Dt }">
																					없음
																				</c:if>
																				</span>
																			</div>
																			<div style="font-size: 1.1em;">
																				<i class="far fa-clock"></i><span style="margin-left:5px;">최근 수정일
																				: <fmt:formatDate value="${milestone.milestone_Update_Dt }" pattern="yyyy-MM-dd"/>
																			</span>
																			</div>
																		</td>
																		<td class="project-title" style="padding:5px 30px;width:50%;">

																			<!-- 진행률 -->
																			<c:if test="${milestone.todoIssueCount + milestone.inprogressIssueCount + milestone.doneIssueCount eq 0 }">
																				<c:set var="percentage" value="0"></c:set>
																			</c:if>
																			<c:if test="${milestone.todoIssueCount + milestone.inprogressIssueCount + milestone.doneIssueCount ne 0 }">
																				<c:set var="totalWeight" value="${milestone.todoIssueCount * 0 + milestone.inprogressIssueCount * 0.5 + milestone.doneIssueCount * 1 }" />
																				<c:set var="totalIssueCount" value="${milestone.todoIssueCount + milestone.inprogressIssueCount + milestone.doneIssueCount }" />
																				<c:set var="percentage" value="${(totalWeight / totalIssueCount) * 100 }" />
																				<fmt:parseNumber var="percentage" value="${percentage}" integerOnly="true" />
																			</c:if>
																			<%-- 진행률 progress bar 영역 --%>
																			<div class="progress progress-xs" style="height:10px;margin-top:5px;background-color:rgb(0,0,0,0.2);">
																				<div class="progress-bar" role="progressbar" aria-valuenow="${percentage }" aria-valuemin="0" aria-valuemax="100" style="width: ${percentage }%; height:10px;"></div>
																			</div>

																			<div style="margin-top: 5px;font-size:1.1em;">
																				<span><strong style="font-size:1.1em;">${percentage }%</strong> 진행됨</span>
																				<span style="margin-left:10px;"><strong style="font-size:1.1em;">${milestone.todoIssueCount }</strong> Todo</span>
																				<span style="margin-left:10px;"><strong style="font-size:1.1em;">${milestone.inprogressIssueCount }</strong> Inprogress</span>
																				<span style="margin-left:10px;"><strong style="font-size:1.1em;">${milestone.doneIssueCount }</strong> Done</span>
																			</div>
																			<div style="margin-top: 10px;">
																					<span class="btn btn-info" style="height: 25px;padding: 0px 10px;font-size:1.1em;" onclick="window.location.href='${pageContext.request.contextPath }/board/milestone/modifyForm?milestone_Id=${milestone.milestone_Id }';">수정</span>
																					<c:if test="${milestone.milestone_St eq 1 }">
																						<span class="btn btn-secondary" style="height: 25px;margin-left:10px;padding: 0px 10px;font-size:1.1em;" onclick="modifyMilestone('${milestone.milestone_Id}',2);">종료</span>
																					</c:if>
																					<c:if test="${milestone.milestone_St eq 2 }">
																						<span class="btn btn-success" style="height: 25px;margin-left:10px;padding: 0px 10px;font-size:1.1em;" onclick="modifyMilestone('${milestone.milestone_Id}',1);">재시작</span>
																					</c:if>
																					<c:if test="${milestone.milestoneCount eq 0 }">
																						<span class="btn btn-danger" style="height: 25px;margin-left:10px;padding: 0px 10px;font-size:1.1em;" onclick="removeMilestone('${milestone.milestone_Id}');">삭제</span>
																					</c:if>
																			</div>
																		</td>
																	</tr>
																</c:forEach>
															</c:if>

															<!-- 마일스톤이 없을때 -->
															<c:if test="${empty milestoneList }">
																<tr role="row">
																	<td class="project-title noList" style="text-align:center;font-size:1.2em;font-weight: bold;height:80px;">마일스톤이 존재하지 않습니다.</td>
																</tr>
															</c:if>
														</tbody>
													</table>
												</div>

											</div>
										</div>
									</form:form>
								</div>
							</div>
						</div>
					</div>
			</div>
		</div>
	</div>

	<form name="modifyForm" action='<c:url value="/board/milestone/modify"/>' method='post'>
		<input type="hidden" name="milestone_Id" />
		<input type="hidden" name="milestone_Name" />
		<input type="hidden" name="milestone_End_Dt" />
		<input type="hidden" name="milestone_St" />
		<input type="hidden" name="isOpen" id ="isOpenForModify" />
		<!-- detail 페이지 용 -->
<%--		<input type="hidden" name="openIssueCount" />--%>
<%--		<input type="hidden" name="closedIssueCount" />--%>
	</form>


<script>
	window.onload=function(){
		$('#${milestoneVO.isOpen}').addClass('active');
	}

	// open/closed 탭 변경시
	function changeCategory(obj){
		$('#isOpenForTab').val($(obj).attr('id'));
		$('form[name="listForm"]').submit();
	}

	// 마일스톤 정보 수정
	function modifyMilestone(milestoneId, milestoneSt){
		$('input[name="milestone_Id"]').val(milestoneId);
		$('input[name="milestone_St"]').val(milestoneSt);

		$('#isOpenForModify').val(milestoneSt == 1 ? 'open' : 'closed');

		document.modifyForm.submit();
	}

	// 마일스톤 삭제
	function removeMilestone(milestoneId){
		if(!confirm('마일스톤을 삭제하시겠습니까?')){
			return;
		}

		$('input[name="milestone_Id"]').val(milestone_Id);

		document.modifyForm.action = '<c:url value="/board/milestone/remove"/>';
		document.modifyForm.submit();
	}

	// 마일스톤 상세 페이지
	function detailPage(milestone_Id){
		location.href="${pageContext.request.contextPath }/board/milestone/detail?milestone_Id="+milestone_Id;
	}
</script>

</section>
<!-- 푸터 인클루드 -->
<%@ include file="../../include/footer.jsp"%>
</body>
