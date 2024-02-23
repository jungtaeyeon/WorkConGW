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
						<h2><i class="fa fa-clipboard"></i>&nbsp;프로젝트</h2>
						<hr>
					</div>
				</div>

				<div class="row clearfix" style="font-family: S-CoreDream-7ExtraBold">
					<div class="col-lg-12 col-md-12">
						<div class="card">
							<div class="body project_report">
								<button type="button" class="btn btn-light" onclick="window.location.href='${pageContext.request.contextPath}/board/issue/list';">이슈</button>
								<button type="button" class="btn btn-light " onclick="window.location.href='${pageContext.request.contextPath}/board/milestone/list';">마일스톤</button>
								<button type="button" class="btn btn-light active" onclick="window.location.href='${pageContext.request.contextPath}/board/project/list';">프로젝트</button>
								<button type="button" class="btn btn-primary float-right" onclick="window.location.href='${pageContext.request.contextPath}/board/project/registForm';">프로젝트 생성하기</button>

								<form:form modelAttribute="projectVO" name="listForm" action="${pageContext.request.contextPath }/board/project/list">
									<form:hidden path="isOpen" id="isOpenForTab" />
									<div class="table-responsive" style="margin-top:20px;">
										<ul class="nav nav-tabs">
											<c:choose>
												<c:when test="${projectVO.isOpen eq 'open' }">
													<li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="open" onclick="changeCategory(this);"><i class="fas fa-info-circle"></i> <span style="margin-left:5px;">${projectList.size() }</span> Open</a></li>
													<li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="closed" onclick="changeCategory(this);"><i class="fa fa-check"></i> <span style="margin-left:5px;">${oppListCount}</span> Closed</a></li>
												</c:when>
												<c:otherwise>
													<li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="open" onclick="changeCategory(this);"><i class="fas fa-info-circle"></i> <span style="margin-left:5px;">${oppListCount}</span> Open</a></li>
													<li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="closed" onclick="changeCategory(this);"><i class="fa fa-check"></i> <span style="margin-left:5px;">${projectList.size() }</span> Closed</a></li>
												</c:otherwise>
											</c:choose>
										</ul>
										<div class="tab-content p-l-0 p-r-0 p-t-0">
											<!-- 프로젝트 뷰-->
											<div class="tab-pane animated fadeIn active">
												<table class="table table-hover js-basic-example table-custom m-b-0 no-footer" role="grid">
													<tbody style="border:hidden;">
													<c:if test="${!empty projectList}">
														<c:forEach items="${projectList }" var="project">
															<tr role="row">
																<td class="project-title" style="padding:30px;width:50%;">
																	<div>
																		<h6>
						                                                	<span data-openIssueCount="${project.openIssueCount }" data-closedIssueCount="${project.closedIssueCount }" data-project_Id="${project.project_Id }"
																				  style="margin-bottom:5px;display:inline-block;font-weight: bold;max-width: 500px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;cursor:pointer;margin-left:5px;font-size:1.1em;" onclick="detailPage('${project.project_Id}')">${project.project_Title }</span>
																		</h6>
																	</div>
																	<div style="font-size: 1.1em;">
																		<i class="far fa-clock"></i><span style="margin-left:5px;">마감일
																		 : <fmt:formatDate value="${project.project_End_Dt }" pattern="yyyy-MM-dd"/>
						                                                </span>
																	</div>
																	<div style="font-size: 1.1em;">
																		<i class="far fa-clock"></i><span style="margin-left:5px;">최근 수정일
																		 : <fmt:formatDate value="${project.project_Update_Dt }" pattern="yyyy-MM-dd"/>
						                                                </span>
																	</div>
																</td>
																<td class="project-title" style="padding:5px 30px;width:50%;">
																	<!-- 진행률 -->
																	<c:if test="${project.openIssueCount + project.closedIssueCount eq 0 }">
																		<c:set var="percentage" value="0"></c:set>
																	</c:if>
																	<c:if test="${project.openIssueCount + project.closedIssueCount ne 0 }">
																		<fmt:parseNumber var="percentage" value="${project.closedIssueCount/(project.openIssueCount + project.closedIssueCount)*100 }" integerOnly="true" />
																	</c:if>
																	<div class="progress progress-xs" style="height:10px;margin-top:5px;background-color:rgb(0,0,0,0.2);">
																		<div class="progress-bar" role="progressbar" aria-valuenow="${percentage }" aria-valuemin="0" aria-valuemax="100" style="width: ${percentage }%; height:10px;">
																		</div>
																	</div>
																	<div style="margin-top: 5px;font-size:1.1em;">
																		<span><strong style="font-size:1.1em;">${percentage }%</strong> 진행됨</span>
																		<span style="margin-left:10px;"><strong style="font-size:1.1em;">${project.openIssueCount }</strong> Open</span>
																		<span style="margin-left:10px;"><strong style="font-size:1.1em;">${project.closedIssueCount }</strong> Closed</span>
																	</div>
																	<div style="margin-top: 10px;">
																		<span class="btn btn-info" style="height: 25px;padding: 0px 10px;font-size:1.1em;" onclick="window.location.href='${pageContext.request.contextPath }/board/project/modifyForm?project_Id=${project.project_Id }';">수정</span>
																		<c:if test="${project.project_St eq 1 }">
																			<span class="btn btn-secondary" style="height: 25px;margin-left:10px;padding: 0px 10px;font-size:1.1em;" onclick="modifyProject('${project.project_Id}',2);">종료</span>
																		</c:if>
																		<c:if test="${project.project_St eq 2 }">
																			<span class="btn btn-success" style="height: 25px;margin-left:10px;padding: 0px 10px;font-size:1.1em;" onclick="modifyProject('${project.project_Id}',1);">재시작</span>
																		</c:if>
																		<c:if test="${project.duty_Count eq 0 }">
																			<span class="btn btn-danger" style="height: 25px;margin-left:10px;padding: 0px 10px;font-size:1.1em;" onclick="removeProject('${project.project_Id}');">삭제</span>
																		</c:if>
																	</div>
																</td>
															</tr>

														</c:forEach>
													</c:if>
													<!-- 프로젝트가 없을때 -->
													<c:if test="${empty projectList }">
														<tr role="row">
															<td class="project-title noList" style="text-align:center;font-size:1.2em;font-weight: bold;height:80px;">프로젝트가 존재하지 않습니다.</td>
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

		<form name="modifyForm" action='<c:url value="/board/project/modify"/>' method='post'>
			<input type="hidden" name="project_Id" />
			<input type="hidden" name="project_Title" />
			<input type="hidden" name="project_End_Dt" />
			<input type="hidden" name="project_St" />
			<input type="hidden" name="isOpen" id ="isOpenForModify" />
			<!-- detail 페이지 용 -->
			<input type="hidden" name="openIssueCount" />
			<input type="hidden" name="closedIssueCount" />
		</form>

		<script>
			window.onload=function(){
				$('#${projectVO.isOpen}').addClass('active');
			}

			// open/closed 탭 변경시
			function changeCategory(obj){
				$('#isOpenForTab').val($(obj).attr('id'));
				$('form[name="listForm"]').submit();
			}

			// 프로젝트 정보 수정
			function modifyProject(project_Id, project_St) {

				console.log(project_Id+","+project_St)

				// 폼 데이터에 넣기
				$('input[name="project_Id"]').val(project_Id);
				$('input[name="project_St"]').val(project_St);

				$('input[name="openIssueCount"]').remove();
				$('input[name="closedIssueCount"]').remove();

				$('#isOpenForModify').val(project_St == 1 ? 'open' : 'closed');

				document.modifyForm.submit();
			}

			// 프로젝트 삭제
			function removeProject(project_Id){
				if(!confirm('프로젝트를 삭제하시겠습니까?')){
					return;
				}

				$('input[name="project_Id"]').val(project_Id);
				$('input[name="project_St"]').remove(); // 이 부분 추가
				$('input[name="openIssueCount"]').remove();
				$('input[name="closedIssueCount"]').remove();

				document.modifyForm.action = '<c:url value="/board/project/remove"/>';
				document.modifyForm.submit();
			}

			// 프로젝트 상세 페이지
			function detailPage(project_Id){
				document.listForm.action ='<c:url value="/board/project/detail?project_Id='+project_Id+'"/>';
				document.listForm.submit();
			}
		</script>
	</div>
</section>
<!-- 푸터 인클루드 -->
<%@ include file="../../include/footer.jsp"%>
</body>
