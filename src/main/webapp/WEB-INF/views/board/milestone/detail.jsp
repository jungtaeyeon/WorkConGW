<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/fonts/font.css">

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
							<i class="fa-solid fa-angles-right"></i>마일스톤상세
						</h2>
					</div>
                </div>
		 	</div>

            <div class="row clearfix">
                <div class="col-lg-12 col-md-12" style="padding: 0;">
                    <div>
                        <div class="body project_report">
                        	<button type="button" class="btn btn-light" onclick="window.location.href='${pageContext.request.contextPath}/board/issue/list';" style="font-family: S-CoreDream-6Bold">이슈</button>
                        	<button type="button" class="btn btn-light active" onclick="window.location.href='${pageContext.request.contextPath}/board/milestone/list';" style="font-family: S-CoreDream-6Bold">마일스톤</button>
                        	<button type="button" class="btn btn-light" onclick="window.location.href='${pageContext.request.contextPath}/board/project/list';">프로젝트</button>
                        	<hr>
                        	
                        	<!-- 마일스톤 제목 -->
                           	<div style="margin-top:20px;">
                                <h4 style="width:90%;">
                                	<span style="margin-bottom:5px;font-weight: bold;vertical-align: middle;margin-left:5px;font-size:1.1em;">${milestone.milestone_Name }</span>
                                </h4>
                           	</div>

							<%-- 진행률 progress bar 영역 --%>
							<div class="progress-container m-t-15" style="">
								<div class="progress progress-xs" style="height:20px;margin:15px 5px 10px;background-color:rgb(0,0,0,0.2);">
									<div class="progress-bar" role="progressbar" aria-valuenow="86" aria-valuemin="0" aria-valuemax="100" style="width: 0%; height:20px;">
									</div>
									<span id="percentage" style="position: absolute;color: white;left: 50%;font-size: 1.1em;line-height: 1.5em;">0%</span>
								</div>
							</div>

                           	<div style="font-size: 1.1em;">
								<span style="margin-left:10px;"><strong style="font-size:1.1em;">${milestone.todoIssueCount }</strong> Todo</span>
								<span style="margin-left:10px;"><strong style="font-size:1.1em;">${milestone.inprogressIssueCount }</strong> Inprogress</span>
								<span style="margin-left:10px;"><strong style="font-size:1.1em;">${milestone.doneIssueCount }</strong> Done</span>
                           	</div>
							<div style="font-size: 1.1em;">
								<span style="margin-left:10px;"><i class="far fa-clock"></i> 마감일
								 <c:if test="${!empty milestone.milestone_End_Dt }">
									 : <span style="font-size:1.1em;" class="deadline"><fmt:formatDate value="${milestone.milestone_End_Dt }" pattern="yyyy-MM-dd"/></span>
								 </c:if>
	                                <c:if test="${empty milestone.milestone_End_Dt }">
										없음
									</c:if>
								</span>
							</div>
                        	
                        	<!-- 이슈 리스트 -->
							<form:form modelAttribute="milestoneVO" name="listForm">
								<form:hidden path="isOpen" id="isOpenForTab" />
	                            <div class="table-responsive" style="margin-top:20px;">
		                        	<ul class="nav nav-tabs">
											<%-- 클릭 시 changeCategory 함수 호출 --%>
										<c:choose>
											<c:when test="${milestone.isOpen eq 'open' }">
												<li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="open" onclick="changeCategory(this);"><i class="fas fa-info-circle"></i> <span style="margin-left:5px;">${milestone.openIssueCount }</span> Open</a></li>
												<li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="closed" onclick="changeCategory(this);"><i class="fa fa-check"></i> <span style="margin-left:5px;">${milestone.closedIssueCount}</span> Closed</a></li>
											</c:when>
											<c:otherwise>
												<li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="open" onclick="changeCategory(this);"><i class="fas fa-info-circle"></i> <span style="margin-left:5px;">${milestone.openIssueCount }</span> Open</a></li>
												<li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="closed" onclick="changeCategory(this);"><i class="fa fa-check"></i> <span style="margin-left:5px;">${milestone.closedIssueCount}</span> Closed</a></li>
											</c:otherwise>
										</c:choose>
						            </ul>
						            
						            <div class="tab-content p-l-0 p-r-0 p-t-0">
						            	<!-- 마일스톤 뷰-->
						                <div class="tab-pane animated fadeIn active">
			                                <table class="table table-hover js-basic-example table-custom m-b-0 no-footer" role="grid">
			                                    <tbody style="border:hidden;">
													<c:if test="${!empty milestone.issueList}">
														<c:forEach items="${milestone.issueList }" var="issue">
				                                        	<tr role="row">
					                                            <td class="project-title" style="padding:15px 30px;">
					                                            	<div style="margin-bottom:5px;">
						                                                <h6 style="display:inline-block;font-weight: bold;max-width: 400px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;">
																			<%-- 이슈 상태 open일 때 --%>
																			<c:if test="${milestoneVO.isOpen eq 'open' }">
							                                                	<i class="fas fa-info-circle" style="color:green;"></i>
																			</c:if>
																			<%-- 이슈 상태 close일 때 --%>
																			<c:if test="${milestoneVO.isOpen eq 'closed' }">
							                                                	<i class="fa fa-check" style="color:red;"></i>
																			</c:if>
																				<%-- 클릭 시 해당 이슈 상세 이동?? --%>
																				<span class="issueTitle" style="cursor:pointer;margin-left:5px;font-size:1.1em;" onclick="window.location.href='${pageContext.request.contextPath }/board/issue/detail?issue_Board_Id=${issue.issue_Board_Id }';">${issue.issue_Board_Title }</span>
						                                                </h6>
																		<%-- 이슈에 업무 엮여있을 때: 클릭 시, 업무 상세 --%>
																		<c:if test="${!empty issue.duty_Board_Title }">
																			<a href="${pageContext.request.contextPath }/board/duty/detail?duty_Board_Id=${issue.duty_Board_Id }">
																			<span class="btn btn-secondary" style="padding: 0px 3px;margin-left:5px;">#${issue.duty_Board_Id }</span>
																		</a>
																		</c:if>
					                                            	</div>
																	<span style="margin-left:25px;">이슈 번호: #${issue.issue_Board_Id }</span><br>
																	<span style="margin-left:25px;"><i class="far fa-clock"></i> 생성일: <fmt:formatDate value="${issue.issue_Board_Create_Dt}" pattern="yyyy-MM-dd"/></span>
					                                            </td>
					                                            <td class="project-actions" style="font-size:1.3em;">
																	<%-- 이슈 댓글 있는 경우 --%>
																<td class="project-actions" style="font-size:1.3em;">
																	<c:if test="${issue.reply_Count ne 0}">
																		<i class="far fa-comment-alt" style="margin-left:5px;"></i> ${issue.reply_Count }
																	</c:if>
					                                            </td>
					                                        </tr>
														</c:forEach>
													</c:if>
			                                    	<!-- 이슈가 없을때 -->
			                                    	<c:if test="${empty milestone.issueList }">
			                                    		<tr role="row">
				                                            <td class="project-title noList" style="text-align:center;font-size:1.2em;font-weight: bold;height:80px;">이슈가 존재하지 않습니다.</td>
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

<script>
	window.onload=function(){
		$('#${milestone.isOpen}').addClass('active');
		changePercentage();
	}

	function changeCategory(obj){
		$('#isOpenForTab').val($(obj).attr('id'));
		$('form[name="listForm"]').submit();
	}

	function changePercentage() {
		var todoCount = ${milestone.todoIssueCount };
		var inprogressCount = ${milestone.inprogressIssueCount };
		var doneCount = ${milestone.doneIssueCount };
		console.log(inprogressCount)

		var totalIssueCount = todoCount + inprogressCount + doneCount;
		var percentage = 0;

		if (totalIssueCount !== 0) {
			var totalWeight = todoCount * 0 + inprogressCount * 0.5 + doneCount * 1;
			percentage = Math.floor((totalWeight / totalIssueCount) * 100);
		}

		$('.progress-bar').css('width', percentage + "%");
		$('#percentage').text(percentage + '%');
	}


	// 마일스톤 삭제
function removeMilestone(milestone_Id){

}

</script>

</section>
<!-- 푸터 인클루드 -->
<%@ include file="../../include/footer.jsp"%>
</body>
