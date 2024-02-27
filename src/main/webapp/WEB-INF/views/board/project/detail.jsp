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
	.dd-list {
		padding-left: 0;
	}

	ol {
		list-style-type: none;
	}
.issueManage{
	overflow-y: auto;
	padding:0 20px;
}
.issueCount {
	display: inline-block;
    border-radius: 50%;
    background-color: gray;
    width: 28px;
    height: 28px;
    text-align: center;
    line-height: 1.8em;
    vertical-align: middle;
    color: white;
    font-size: 1.2em;
}
h5.number {
    display: inline-block;
    margin-bottom: 0px;
    vertical-align: middle;
    margin-left:5px;
}

</style>

	<div class="contentConteiner">
<!-- 메인 content -->
<div id="main-content">
	<div class="container-fluid">
			<div class="row clearfix">
                <div class="col-12" style="margin-top: 2%; font-family: 'S-CoreDream-6Bold">
                    <h2><i class="fa fa-clipboard"></i>&nbsp;프로젝트 관리</h2>
                    <hr>
                </div>
		 	</div>

            <div class="row clearfix" id="projectAll" style="font-family: S-CoreDream-7ExtraBold">
                <div class="col-lg-12 col-md-12" style="padding-right:0px;">
                    <div class="card">
                        <div class="body project_report">
                        	<button type="button" class="btn btn-light" onclick="window.location.href='${pageContext.request.contextPath}/board/issue/list';">이슈</button>
                        	<button type="button" class="btn btn-light" onclick="window.location.href='${pageContext.request.contextPath}/board/milestone/list';">마일스톤</button>
                        	<button type="button" class="btn btn-light active" onclick="window.location.href='${pageContext.request.contextPath}/board/project/list';">프로젝트</button>
	                    </div>

	                   	<div style="padding:10px 30px;">
							<span style="font-size:1.1em;">프로젝트 진행률</span>
							<div class="progress-container m-t-15" style="">
								<div class="progress progress-xs" style="height:20px;background-color:rgb(0,0,0,0.2);">
									<div class="progress-bar" role="progressbar" aria-valuenow="86" aria-valuemin="0" aria-valuemax="100" style="width: 0%; height:20px;">
									</div>
									<span id="percentage" style="position: absolute;color: white;left: 50%;font-size: 1.1em;line-height: 1.5em;">0%</span>
								</div>
							</div>
						</div>

	                    <div class="row clearfix" style="margin:10px;">

							<%-- 해야할 일 시작 --%>
	                    	<div class="top_counter col-lg-4 col-md-6">
	                    		<div class="card" style="height:80vh;background-color:#eee;">
			                        <div class="body">
										<%-- todoList 카운트 (비어있으면0 아니면 사이즈 출력) --%>
											<span class="issueCount">${empty todoList ? 0 : todoList.size() }</span>
		                                <h5 class="number">해야할 일</h5>
			                        </div>

			                        <div class="issueManage" id="div_todo" style="height:70vh;">
			                            <div class="dd dd4" id="todo">
											<%-- todoList가 비어있지 않으면 --%>
											<c:if test="${!empty todoList }">
				                                <ol class="dd-list">
													<%-- todoList forEach var="issue --%>
														<c:forEach items="${todoList }" var="issue">
													<%-- 비동기 처리를 위해 id값 주기 --%>
					                                    <li class="dd-item" id="${issue.issue_Board_Id}" style=";margin-top: 20px; position: relative;">
															<div class="dd-handle card" style="height:70vh;margin-left:0px;padding:10px 10px;height:auto;color:black;border:1px solid rgb(0,0,0,0.2);">
																<div style="margin-bottom:-15px;display:flex;align-items:center;">
																	<h6 style="font-weight:bold;max-width:85%;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;margin-right:5px;">
																		<c:if test="${issue.issue_Open_St eq 1 }">
																			<i class="fas fa-info-circle" style="color:green;"></i>
																		</c:if>
																		<c:if test="${issue.issue_Open_St eq 2 }">
																			<i class="fa fa-check" style="color:red;"></i>
																		</c:if>
																		<span class="issueTitle" style="font-size:1.1em;cursor:pointer;"
																			  onclick="handleIssueClick(${issue.issue_Board_Id}, ${issue.issue_Board_St}, ${issue.emp_Id}, ${loginUser.emp_Id})">
																				${issue.issue_Board_Title}
																		</span>
																	</h6>
																	<span class="badge badge-secondary py-1 px-1" style="font-size:0.8em; margin-top: -10px;">#${issue.duty_Board_Id}</span>
																</div>
																<span style="margin-top:5%">이슈번호: #${issue.issue_Board_Id}</span>
																최근 수정일: <fmt:formatDate value="${project.project_Update_Dt }" pattern="yyyy-MM-dd"/>
															</div>

															<%-- 프로젝트 상태 변경 --%>
															<i class="fa fa-ellipsis-h" data-toggle="dropdown" aria-expanded="false" style="cursor: pointer;position: absolute;z-index: 10;bottom: 10px;font-size: 1.5em;right: 20px;"></i>
															<div class="user-account" style="position: absolute;top:0px;">
						                                        <div class="dropdown">
												                    <ul class="dropdown-menu dropdown-menu-right account animated flipInY menuProfile" x-placement="bottom-end" style="position: absolute; will-change: transform; top: 0px; left: -100px; padding:10px;transform: translate3d(89px, 42px, 0px);">
													                        <li data-id="${issue.issue_Board_Id }" data-st="inprogress" data-issue_St=1 data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-spinner"></i><span>이슈 진행</span></a></li>
																			<li id="issue_todo" data-id="${issue.issue_Board_Id }" data-st="done" data-issue_St=2 data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this); registIssueReply(2, ${issue.issue_Board_Id });"><a href="javascript:void(0);"><i class="fas fa-check-circle"></i><span>이슈 완료</span></a></li>
												                    </ul>
												                </div>
					                                        </div>
															<%-- 프로젝트 상태 변경 끝 --%>
					                                    </li>
													<%-- fofEach 끝 --%>
														</c:forEach>
				                                </ol>
											</c:if>
												<%-- todoList 비어있으면 공백 노출 --%>
			                            </div>
			                        </div>
	                    		</div>
		                    </div>
							<%-- 해야할 일 끝 --%>

							<%-- 진행 중 시작 --%>
								<div class="top_counter col-lg-4 col-md-6">
									<div class="card" style="height:80vh;background-color:#eee;">
										<div class="body">
											<%-- todoList 카운트 (비어있으면0 아니면 사이즈 출력) --%>
											<span class="issueCount">${empty inprogressList ? 0 : inprogressList.size() }</span>
												<h5 class="number" style="display:inline-block;">진행중</h5>
										</div>

										<div class="issueManage" id="div_inprogress" style="height:70vh;">
											<div class="dd dd4" id="inprogress">
												<%-- inprogressList 비어있지 않으면 --%>
												<c:if test="${!empty inprogressList }">
													<ol class="dd-list">
															<%-- inprogressList forEach var="issue --%>
														<c:forEach items="${inprogressList }" var="issue">
															<%-- 비동기 처리를 위해 id값 주기 --%>
															<li class="dd-item" id="${issue.issue_Board_Id}" style="margin-top: 20px; position: relative;">
																<div class="dd-handle card" style="height:70vh;margin-left:0px;padding:10px 10px;height:auto;color:black;border:1px solid rgb(0,0,0,0.2);">
																	<div style="margin-bottom:-15px;display:flex;align-items:center;">
																		<h6 style="font-weight:bold;max-width:85%;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;margin-right:5px;">
																			<c:if test="${issue.issue_Open_St eq 1 }">
																				<i class="fas fa-info-circle" style="color:green;"></i>
																			</c:if>
																			<c:if test="${issue.issue_Open_St eq 2 }">
																				<i class="fa fa-check" style="color:red;"></i>
																			</c:if>
																			<span class="issueTitle" style="font-size:1.1em;cursor:pointer;"
																				  onclick="handleIssueClick(${issue.issue_Board_Id}, ${issue.issue_Board_St}, ${issue.emp_Id}, ${loginUser.emp_Id})">
																					${issue.issue_Board_Title}
																			</span>
																		</h6>
																		<span class="badge badge-secondary py-1 px-1" style="font-size:0.8em; margin-top: -10px;">#${issue.duty_Board_Id}</span>
																	</div>
																	<span style="margin-top:5%">이슈번호: #${issue.issue_Board_Id}</span>
																	최근 수정일: <fmt:formatDate value="${project.project_Update_Dt }" pattern="yyyy-MM-dd"/>
																</div>

																	<%-- 프로젝트 상태 변경 --%>
																<i class="fa fa-ellipsis-h" data-toggle="dropdown" aria-expanded="false" style="cursor: pointer;position: absolute;z-index: 10;bottom: 10px;font-size: 1.5em;right: 20px;"></i>
																<div class="user-account" style="position: absolute;top:0px;">
																	<div class="dropdown">
																		<ul class="dropdown-menu dropdown-menu-right account animated flipInY menuProfile" x-placement="bottom-end" style="position: absolute; will-change: transform; top: 0px; left: -100px; padding:10px;transform: translate3d(89px, 42px, 0px);">
																			<li data-id="${issue.issue_Board_Id }" data-st="todo" data-issue_St=1 data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-pencil-alt"></i><span>해야할 일</span></a></li>
																			<li id="issue-inprogress" data-id="${issue.issue_Board_Id }" data-st="done" data-issue_St=2 data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this); registIssueReply(2, ${issue.issue_Board_Id });"><a href="javascript:void(0);"><i class="fas fa-check-circle"></i><span>이슈 완료</span></a></li>
																		</ul>
																	</div>
																</div>
																	<%-- 프로젝트 상태 변경 끝 --%>
															</li>
															<%-- fofEach 끝 --%>
														</c:forEach>
													</ol>
												</c:if>
												<%-- inprogressList 비어있으면 공백 노출 --%>
											</div>
										</div>
									</div>
								</div>
							<%-- 진행 중 끝 --%>

							<%-- 완료 시작 --%>
								<div class="top_counter col-lg-4 col-md-6">
									<div class="card" style="height:80vh;background-color:#eee;">
										<div class="body">
											<%-- todoList 카운트 (비어있으면0 아니면 사이즈 출력) --%>
											<span class="issueCount">${empty doneList ? 0 : doneList.size() }</span>
											<h5 class="number" style="display:inline-block;">완료</h5>
										</div>

										<div class="issueManage" id="div_done" style="height:70vh;">
											<div class="dd dd4" id="done">
												<%-- doneList 비어있지 않으면 --%>
												<c:if test="${!empty doneList }">
													<ol class="dd-list">
															<%-- doneList forEach var="issue --%>
														<c:forEach items="${doneList }" var="issue">
															<%-- 비동기 처리를 위해 id값 주기 --%>
															<li class="dd-item" id="${issue.issue_Board_Id}" style="margin-top: 20px; position: relative;">
																<div class="dd-handle card" style="height:70vh;margin-left:0px;padding:10px 10px;height:auto;color:black;border:1px solid rgb(0,0,0,0.2);">
																	<div style="margin-bottom:-15px;display:flex;align-items:center;">
																		<h6 style="font-weight:bold;max-width:85%;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;margin-right:5px;">
																			<c:if test="${issue.issue_Open_St eq 1 }">
																				<i class="fas fa-info-circle" style="color:green;"></i>
																			</c:if>
																			<c:if test="${issue.issue_Open_St eq 2 }">
																				<i class="fa fa-check" style="color:red;"></i>
																			</c:if>
																			<span class="issueTitle" style="font-size:1.1em;cursor:pointer;"
																				  onclick="handleIssueClick(${issue.issue_Board_Id}, ${issue.issue_Board_St}, ${issue.emp_Id}, ${loginUser.emp_Id})">
																					${issue.issue_Board_Title}
																			</span>
																		</h6>
																		<span class="badge badge-secondary py-1 px-1" style="font-size:0.8em; margin-top: -10px;">#${issue.duty_Board_Id}</span>
																	</div>
																	<span style="margin-top:5%">이슈번호: #${issue.issue_Board_Id}</span>
																	최근 수정일: <fmt:formatDate value="${project.project_Update_Dt }" pattern="yyyy-MM-dd"/>
																</div>


															<%-- 프로젝트 상태 변경 --%>
																<i class="fa fa-ellipsis-h" data-toggle="dropdown" aria-expanded="false" style="cursor: pointer;position: absolute;z-index: 10;bottom: 10px;font-size: 1.5em;right: 20px;"></i>
																<div class="user-account" style="position: absolute;top:0px;">
																	<div class="dropdown">
																		<ul class="dropdown-menu dropdown-menu-right account animated flipInY menuProfile" x-placement="bottom-end" style="position: absolute; will-change: transform; top: 0px; left: -100px; padding:10px;transform: translate3d(89px, 42px, 0px);">
<%--																			<li data-id="${issue.issue_Board_Id }" data-st="todo" data-issue_St=1 data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-pencil-alt"></i><span>해야할 일</span></a></li>--%>
																			<li id="issue_done" data-id="${issue.issue_Board_Id }" data-st="inprogress" data-issue_St=1 data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this); registIssueReply(3, ${issue.issue_Board_Id });"><a href="javascript:void(0);"><i class="fas fa-spinner"></i><span>이슈 재진행</span></a></li>
																		</ul>
																	</div>
																</div>
																	<%-- 프로젝트 상태 변경 끝 --%>
															</li>
															<%-- fofEach 끝 --%>
														</c:forEach>
													</ol>
												</c:if>
												<%-- doneList 비어있으면 공백 노출 --%>
											</div>
										</div>
									</div>
								</div>
								<%-- 완료 끝 --%>
						</div>
	                </div>
	            </div>
            </div>
        </div>
</div>

	</div>
</section>

<form name="modifyIssueForm">
	<input type="hidden" name="issueVO.issue_Board_Id">
	<input type="hidden" name="issueVO.issue_Open_St">
	<input type="hidden" name="issueVO.issue_Project_St">
	<input type="hidden" name="issueVO.issue_Board_Title">
</form>

<form name="replyRegistForm">
	<input type="hidden" name="issue_Board_Id"/>
	<input type="hidden" name="emp_Id" value="${loginUser.emp_Id }"/>
	<input type="hidden" name="reply_Content" />
	<input type="hidden" name="reply_Group_Code" />
</form>


<script>
	window.onload=function(){
		changePercentage();
	}

	function registIssueReply(reply_Group_Code, issueBoardId){
		var replyRegistView;

		if(reply_Group_Code==2){	// 이슈 종료
			$('input[name="reply_Content"]').val('이슈 종료');
		}else if(reply_Group_Code==3){	// 이슈 재진행
			$('input[name="reply_Content"]').val('이슈 재진행');
		}
		$('input[name="reply_Group_Code"]').val(reply_Group_Code);

		console.log(issueBoardId)
		$('input[name="issue_Board_Id"]').val(issueBoardId);

		$.ajax({
			url:"<c:url value='/board/issue/reply/regist'/>",
			type:'post',
			data:$('form[name="replyRegistForm"]').serialize(),
			success:function(issueReplyVO) {
				alert('댓글 등록이 성공했습니다.');
				window.location.reload(true);
			},
			error:function(){
				alert('댓글 등록이 실패했습니다.');
			}
		});
	}

	function handleIssueClick(issueId, issueStatus, issueCreatorId, loginUserEmpId) {
		if (issueStatus === 2 && loginUserEmpId !== issueCreatorId) {
			alert("비공개 이슈입니다.");
		} else {
			// 이동할 URL로 리다이렉트
			window.location.href = '${pageContext.request.contextPath}/board/issue/detail?issue_Board_Id=' + issueId;
		}
	}

	function changePercentage() {
		var sum = 0;
		$('.issueCount').each(function(index) {
			if (index < 3) {
				sum += $(this).text() * 1;
			}
		});

		var totalWeight = sum == 0 ? 0 : ($('.issueCount').eq(0).text() * 0 + $('.issueCount').eq(1).text() * 0.5 + $('.issueCount').eq(2).text() * 1);
		var totalIssueCount = $('.issueCount').eq(0).text() * 1 + $('.issueCount').eq(1).text() * 1 + $('.issueCount').eq(2).text() * 1;
		var percentage = totalIssueCount == 0 ? 0 : Math.floor((totalWeight / totalIssueCount) * 100);

		$('.progress-bar').css('width', percentage + "%");
		$('#percentage').text(percentage + '%');
	}

	// 이슈 상태 수정
	function modifyIssue(obj){
		var issue_Board_Id = $(obj).attr('data-id');
		var issue_Project_St = $(obj).attr('data-st');
		var issue_Board_Title = $(obj).attr('data-title');
		var issue_Open_St = $(obj).attr('data-issue_St');

		$('input[name="issueVO.issue_Board_Id"]').val(issue_Board_Id);
		$('input[name="issueVO.issue_Open_St"]').val(issue_Open_St);
		$('input[name="issueVO.issue_Project_St"]').val(issue_Project_St);
		$('input[name="issueVO.issue_Board_Title"]').val(issue_Board_Title);

		// 추후 비동기 처리 예정
		$.ajax({
			url: '<c:url value="/board/issue/modify"/>',
			type: 'post',
			data: $('form[name="modifyIssueForm"]').serialize(),
			success: function(data){
				location.reload();
			},
			error: function(xhr, status, error) {
			}
		});
	}

</script>

<!-- 푸터 인클루드 -->
<%@ include file="../../include/footer.jsp"%>
</body>
