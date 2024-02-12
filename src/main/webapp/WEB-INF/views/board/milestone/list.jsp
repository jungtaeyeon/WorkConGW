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
</style>

	<div class="contentConteiner">
<!-- 메인 content -->
		<div id="main-content">
			<div class="container-fluid">
					<div class="row clearfix">
						<div class="col-12" style="margin-top: 2%; font-family: 'S-CoreDream-6Bold">
							<h2><i class="fas fa-directions"></i> 마일스톤</h2>
							<hr>
						</div>
					</div>

					<div class="row clearfix" style="font-family: S-CoreDream-7ExtraBold">
						<div class="col-lg-12 col-md-12">
							<div class="card">
								<div class="body project_report">
									<button type="button" class="btn btn-light" onclick="window.location.href='${pageContext.request.contextPath}/board/issue/list';">이슈</button>
									<button type="button" class="btn btn-light active" onclick="window.location.href='${pageContext.request.contextPath}/board/milestone/list';">마일스톤</button>
									<button type="button" class="btn btn-light" onclick="window.location.href='${pageContext.request.contextPath}/board/project';">프로젝트</button>
									<button type="button" class="btn btn-primary float-right" onclick="window.location.href='${pageContext.request.contextPath}/board/milestone/registForm';">마일스톤 생성하기</button>

										<div class="table-responsive" style="margin-top:20px;">
											<ul class="nav nav-tabs">
													<%-- 클릭 시 changeCategory 함수 호출 --%>
														<li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="open" onclick="changeCategory(this);"><i class="fas fa-info-circle"></i> <span style="margin-left:5px;"></span> Open</a></li>
														<li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="closed" onclick="changeCategory(this);"><i class="fa fa-check"></i> <span style="margin-left:5px;"></span> Closed</a></li>
											</ul>
											<div class="tab-content p-l-0 p-r-0 p-t-0">
												<!-- 마일스톤 뷰-->
												<div class="tab-pane animated fadeIn active">
													<table class="table table-hover js-basic-example table-custom m-b-0 no-footer" role="grid">
														<tbody style="border:hidden;">
																	<tr role="row">
																		<td class="project-title" style="padding:30px;width:50%;">
																			<div>
																				<h6>
																					<span style="margin-bottom:5px;display:inline-block;font-weight: bold;max-width: 500px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;cursor:pointer;margin-left:5px;font-size:1.1em;" onclick="detailPage()">{마일스톤 이름}</span>
																				</h6>
																			</div>
																			<div style="font-size: 1.1em;">
																				<i class="far fa-clock"></i><span style="margin-left:5px;">마감일
																				<%-- 마감일 if문 작성 영역 --%>
																				없음
																				</span>
																			</div>
																		</td>
																		<td class="project-title" style="padding:5px 30px;width:50%;">
																			<!-- 진행률 -->
																			<%-- 오픈이슈 카운트 + 클로즈이슈 카운트 = 0이면: percentage 벨류값0 부터 시작 --%>
																					<c:set var="percentage" value="0"></c:set>

																			<%-- 오픈이슈 카운트 + 클로즈이슈 카운트 = 0이 아니면: percentage 벨류값0 부터 시작 --%>
																			<%-- 클로즈이슈 / 전체이슈(오픈이슈+클로즈이슈) * 100 --%>


																			<%-- 진행률 progress bar 영역 --%>
																			<div class="progress progress-xs" style="height:10px;margin-top:5px;background-color:rgb(0,0,0,0.2);">
																				<div class="progress-bar" role="progressbar" aria-valuenow="${percentage }" aria-valuemin="0" aria-valuemax="100" style="width: ${percentage }%; height:10px;"></div>
																			</div>

																			<div style="margin-top: 5px;font-size:1.1em;">
																				<span><strong style="font-size:1.1em;">${percentage }%</strong> 진행됨</span>
																				<span style="margin-left:10px;"><strong style="font-size:1.1em;">${milestone.openIssueCount }</strong> Open</span>
																				<span style="margin-left:10px;"><strong style="font-size:1.1em;">${milestone.closedIssueCount }</strong> Closed</span>
																			</div>
																			<div style="margin-top: 10px;">
																				<%-- milestone_St open 상태일 때 노출 --%>
																					<span class="btn btn-secondary" style="height: 25px;margin-left:10px;padding: 0px 10px;font-size:1.1em;" onclick="modifyMilestone('${milestone.milestone_Id}','N');">종료</span>

																					<%-- milestone_St close 상태일 때 노출 --%>
																					<span class="btn btn-success" style="height: 25px;margin-left:10px;padding: 0px 10px;font-size:1.1em;" onclick="modifyMilestone('${milestone.milestone_Id}','Y');">재시작</span>
																			</div>
																		</td>
																	</tr>

															<!-- 마일스톤이 없을때 -->
<%--															<c:if test="${empty milestoneList }">--%>
																<tr role="row">
																	<td class="project-title noList" style="text-align:center;font-size:1.2em;font-weight: bold;height:80px;">마일스톤이 존재하지 않습니다.</td>
																</tr>
<%--															</c:if>--%>
														</tbody>
													</table>
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


<script>

// 마일스톤 상세 페이지
function detailPage(milestone_Id){
	location.href="${pageContext.request.contextPath }/board/milestone/detail";
}
</script>

</section>
<!-- 푸터 인클루드 -->
<%@ include file="../../include/footer.jsp"%>
</body>
