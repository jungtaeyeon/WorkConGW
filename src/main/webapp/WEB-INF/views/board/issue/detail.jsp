<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<body>
<!-- 헤더인클루드 -->
<%@ include file="../../include/header.jsp"%>
<section class="subPageContain">
	<!-- 사이드바 -->
	<%@ include file="../issueSidebar.jsp"%>
	<!--컨텐츠 영역-->


<style>
.milestone:hover {
	cursor: pointer;
	color: #2980b9;
}
.pictureView{
	border-radius: 50%;
	border: 1px solid gray; 
	margin: 0px 20px 0px 0px;
	background-position: center;
	background-size: cover;
	background-repeat: no-repeat;
}
</style>
	<div class="contentConteiner">
<!-- 메인 content -->
<div id="main-content" >
	<div class="container-fluid" >
		<form:form modelAttribute="boardFormVO" name="detailForm" method="post">
		<form:hidden path="issueVO.issue_Board_Id"/>
		<form:hidden path="issueVO.issue_Board_Content"/>
		<form:hidden path="issueVO.issue_Open_St"/>
		<form:hidden id="hiddenIssue_Board_St" path="issueVO.issue_Board_St"/>
		<form:hidden path="issueVO.issue_Project_St"/>
			<div class="block-header">
	            <div class="row">
	            	<div class="col-sm-9" style="width:80%;">
						<%--이슈 타이틀과 이슈 번호 issueVO에서 받아올 예정--%>
	                	<h2 style="padding-left:10px; font-size:2em; ">
							#${issue.issue_Board_Id}
						</h2>
							<h2 class="detailMode" style="padding-left:10px; font-size:2.5em; font-family:S-CoreDream-6Bold ">
								<span id="spanIssue_Board_Title" style="word-wrap:break-word;">${issue.issue_Board_Title }</span> </h2>
							<form:input path="issueVO.issue_Board_Title" class="modifyMode" style="width:100%;padding-left:10px;font-size:2em;display:none;" />
	                	<div>
								<%--이슈 상태 close일 때 숨기기--%>
                			<span class="openIssueBadge" <c:if test="${issue.issue_Open_St eq 2 }">style="display:none;"</c:if>>
	 	 	              		<span class="badge badge-success" style="font-size:1.2em;margin: 10px 10px 0px;">
		                			<i class="fas fa-info-circle" style="vertical-align: middle;"></i>
		                			<span style="line-height: 1.2em;vertical-align: middle;">Open</span>
	                			</span>
                			</span>

									<%--이슈 상태 open일 때 숨기기--%>
                			<span class="closedIssueBadge" <c:if test="${issue.issue_Open_St eq 1 }">style="display:none;"</c:if>>
	 	 	              		<span class="badge badge-danger" style="font-size:1.2em;margin: 10px 10px 0px;">
		                			<i class="fas fa-check-circle" style="vertical-align: middle;"></i>
		                			<span style="line-height: 1.2em;vertical-align: middle;">Closed</span>
	                			</span>
                			</span>

                			<div style="display:inline;font-size:1.2em;vertical-align: middle;">
	                			<span style="margin-left:5px;">댓글 <span id="issueReplyCount">${issue.reply_Count }</span></span>
	                			<span class="detailMode">
									<%-- 이슈 공개 상태(Y) 인 경우 비공개 미노출 --%>
	                				<span id="spanIssue_Board_St" <c:if test="${issue.issue_Board_St eq 1 }">style="display:none;"</c:if> >
			                			<span style="margin-left:5px;">•</span>
			                			<span style="margin-left:5px;">비공개</span>
	                				</span>
	                			</span>
	                			<span class="modifyMode m-l-15" style="display:none;">
	                				<select name="issueVO.issue_Board_St" id="issue_Board_St">
	                					<option <c:if test="${issue.issue_Board_St eq 1 }">selected</c:if> value=1>공개</option>
	                					<option <c:if test="${issue.issue_Board_St eq 2 }">selected</c:if> value=2>비공개</option>
	                				</select>
	                			</span>
                			</div>
	                	</div>
	                </div>

	                <div class="col-sm-3">
	               		<div style="float:right;">
							<%-- 이슈 작성자만 아래 버튼 노출 --%>
	               			<c:if test="${loginUser.emp_Id == issue.emp_Id }">
		                    	<button type="button" class="btn btn-info detailMode" style="width:80px;" onclick="changeMode('제목');">수정</button>
		                    	<button type="button" class="btn btn-danger detailMode" style="width:80px;" onclick="removeIssue();">삭제</button>
								<%-- 저장 함수 필요 --%>
		                    	<button type="button" class="btn btn-primary modifyMode" style="width:80px;display:none;" onclick="saveIssue('제목');">저장</button>
								<button type="button" onclick="changeMode('제목');" class="btn btn-secondary modifyMode" style="width:80px;display:none;">취소</button>
	               			</c:if>
	                    	<button type="button" onclick="goBackToList();" class="btn btn-secondary detailMode" style="width:80px;">목록</button>

	                	</div>
	             	</div>
	            </div>
	        </div>
	        
	        <div class="row clearfix">
                <div class="col-lg-9">
                    <div class="card" style="border: none; margin-top: 10px;">
                        <div class="body" >
                        	
                        	<ul id="replyHistory" class="right_chat list-unstyled mb-0" style="border-bottom:2px solid rgb(0,0,0,0.2);">
                       			<!-- 이슈 내용 -->
                        		<li class="online" style="clear:both;border:1.5px solid rgb(0,0,0,0.2);border-radius:15px;">
	                                <div class="media" style="margin:0px;border-bottom:1px solid rgb(0,0,0,0.2);padding:10px 20px;">
										<%-- 작성자 프로필 이미지 (헤더에서 그대로 따옴) --%>
	                                	<div  class="rounded-circle avatar pictureView" style="background-image:url('${pageContext.request.contextPath }/pds/empPicture/${loginUser.emp_Picture}');width: 60px; height: 60px;"></div>
	                                    <div class="media-body" style="margin-top: 7px;">
											<%-- 이름: emp_Name 받아올 예정 --%>
	                                        <strong class="name" style="font-size:1.2em;display:inline;vertical-align: middle;">${issue.emp_Name}</strong>
												<span class="badge badge-default" style="color:black;border-color: black;">작성자</span>
												<br>
												<span style="font-size:1.1em;">
													<fmt:formatDate value="${issue.issue_Board_Create_Dt}" pattern="yyyy-MM-dd"/>
												</span>
	                                    </div>
	                                </div>
	                                <div style="padding:20px;">
	                                	<div class="row">
	                                		<div class="col-lg-10">
												<%-- 내용: issue_Board_Content 받아올 예정 --%>
		                                        <span id="spanIssueBoardContent" class="detailModeContent" style="font-size:1.1em;">${issue.issue_Board_Content}</span>
	                                		</div>
	                                		<div class="col-lg-2">
												<%-- 작성자만 버튼 노출 --%>
	                                			<c:if test="${loginUser.emp_Id == issue.emp_Id }">
			                                    	<a href="javascript:void(0);" class="btn btn-sm btn-outline-info detailModeContent float-right" title="수정" onclick="changeMode('내용');"><i class="fas fa-edit"></i></a>
			                                    </c:if>
	                                		</div>
	                                	</div>
	                                	<div class="row modifyModeContent" style="display:none;">
	                                		<div class="col-lg-12">
												<%-- 내용: issue_Board_Content 받아올 예정 --%>
		                                        <div class="summernote" id="summernote" >${issue.issue_Board_Content}</div>
		                                        <div class="m-t-10" style="float:right;">
													<%-- 저장 함수 필요 --%>
				                                    <button type="button" class="btn btn-primary" style="width: 60px;" onclick="saveIssue('내용');">저장</button>
				                                    <button type="button" class="btn btn-secondary" style="width: 60px;" onclick="changeMode('내용');" >취소</button>
		                                        </div>
	                                		</div>
	                                	</div>
	                                </div>
		                        </li>
								<%-- 댓글 영역 시작 --%>
								<ul id="commentList" style="max-height: 400px; overflow-y: auto; overflow-x: hidden; list-style-type: none;">
								<c:forEach items="${issueReplyList }" var="issueReply" varStatus="status">
									<%-- 댓글 --%>
									<c:if test="${issueReply.reply_Group_Code eq 1 }">
										<%-- 댓글(아래 브릿지는 댓글 작성일때 만 노출) --%>
									<c:if test="${status.index eq 0 }">
										<li class="replyBridge" style="clear:both;border-left:1px solid black;height:30px;margin-left:30px;">
										</li>
									</c:if>
									<li id="li_${issueReply.reply_Id }" class="online" style="clear:both;border:1.5px solid rgb(0,0,0,0.2);border-radius:15px;">
										<div class="media" style="margin:0px;border-bottom:1px solid rgb(0,0,0,0.2);padding:10px 20px;">
											<div  class="rounded-circle avatar pictureView" style="background-image:url('${pageContext.request.contextPath }/pds/empPicture/${issueReply.emp_Picture}');width: 60px; height: 60px;"></div>
											<div class="media-body" style="margin-top: 7px;">
												<strong class="name" style="font-size:1.2em;display:inline;vertical-align: middle;">${issueReply.emp_Name}</strong>
												<%-- 이슈 작성자인 경우 노출 --%>
												<c:if test="${issueReply.emp_Id == issue.emp_Id }">
													<span class="badge badge-default" style="color:black;border-color: black;">작성자</span>
												</c:if>
												<br>
												<%-- 시간 차이 계산 함수 적용 예정 --%>
												<span class="message replyDate" data-createDt="${issueReply.reply_Create_Dt }" style="font-size:1.1em;"></span>
											</div>
										</div>
										<div style="padding:20px;">
											<%-- 댓글내용: replyContent 가져올 예정 --%>
												<div id="replyForm_${issueReply.reply_Id }" style="width:90%;display:inline-block;">
													<span id="spanIssueReplyContent_${issueReply.reply_Id }" class="detailModeReply_${issueReply.reply_Id }" style="font-size:1.1em;">${issueReply.reply_Content }</span>
													<!-- 댓글 수정창 -->
													<div class="modifyModeReply_${issueReply.reply_Id }" style="display:none;">
														<div class="summernote">${issueReply.reply_Content }</div>
														<div class="m-t-10" style="float:right;">
															<button type="button" class="btn btn-primary" style="width: 60px;" onclick="modifyReply(${issueReply.reply_Id});">저장</button>
															<button type="button" class="btn btn-secondary" style="width: 60px;" onclick="changeMode('댓글','${issueReply.reply_Id }');" >취소</button>
														</div>
													</div>
												</div>
												<%-- 작성자에게만 노출(수정, 삭제 버튼) --%>
												<div class="detailModeReply_${issueReply.reply_Id }" style="display:inline;float:right;">
													<c:if test="${issueReply.emp_Id == loginUser.emp_Id }">
													<a href="javascript:void(0);" class="btn btn-sm btn-outline-info" title="수정" onclick="changeMode('댓글','${issueReply.reply_Id }');"><i class="fas fa-edit"></i></a>
													<a href="javascript:void(0);" class="btn btn-sm btn-outline-danger" title="삭제" onclick="removeReply(${issueReply.reply_Id});"><i class="fas fa-trash-alt"></i></a>
													</c:if>
												</div>
										</div>
									</li>
										<!-- 마지막이 댓글이거나 다음 요소가 댓글일 경우 -->
										<c:if test="${status.index eq issueReplyList.size()-1 || issueReplyList.get(status.index+1).reply_Group_Code eq 1}">
											<li class="replyBridge" style="clear:both;border-left:1px solid black;height:30px;margin-left:30px;">
											</li>
										</c:if>
									</c:if>

									<!-- 이슈 종료 시 댓글 -->
									<c:if test="${issueReply.reply_Group_Code eq 2 }">
									<li class="left float-left closedHistory" style="border-top:2px solid #ee2558; width:100%; margin-top:10px; margin-bottom:10px;">
										<div class="timeline-item danger" style="margin-top:10px; margin-left:30px;">
											<%-- 시간 차이 계산 함수 적용 예정 --%>
												<span class="date replyDate" data-createDt="${issueReply.reply_Create_Dt }"></span>
											<h5 style="font-weight:bold;">이슈 종료</h5>
											<%-- 로그인한 사원 이름 가져올 예정 --%>
												<p style="margin:5px 0px 0px;">${loginUser.emp_Name }님이 이슈를 종료시켰습니다.</p>
										</div>
									</li>
									<li class="closedHistory" style="clear:both;"></li>
									</c:if>


									<!-- 이슈 재진행 시 댓글 -->
									<c:if test="${issueReply.reply_Group_Code eq 3 }">
									<li class="left float-left" style="border-top:2px solid #86c541; margin-bottom:10px;width:100%;">
										<div class="timeline-item green" style="margin-top:10px; margin-left:30px;">
											<%-- 시간 차이 계산 함수 적용 예정 --%>
												<span class="date replyDate" data-createDt="${issueReply.reply_Create_Dt }"></span>
												${issueReply.koreanTime}
											<h5 style="font-weight:bold;">이슈 재시작</h5>
											<%-- 로그인한 사원 이름 가져올 예정 --%>
											<p style="margin:5px 0px 0px;">${loginUser.emp_Name}님이 이슈를 다시 진행시켰습니다.</p>
										</div>
									</li>
									<li style="clear: both"></li>
									</c:if>
								</c:forEach>
								</ul>
								<%-- 댓글 영역 끝 --%>
                        	</ul>
                        
			           		<!-- 댓글 등록 에디터: close 상태일 때 미노출 -->
			           		<div class="body openIssueBadge" style="<c:if test="${issue.issue_Open_St eq 2 }">display:none;</c:if>background-color: #eee;margin-top:15px;">
			                    <div class="form-group">
			                    	<div class="summernote" id="replySummernote"></div>
			                    </div>
			                    <div class="align-right">
									<%-- 댓글 등록 함수 필요 --%>
			                        <button type="button" class="btn btn-primary" onclick="registIssueReply(1);" >댓글 등록</button>
			                	</div>
			                </div>

			                <!-- 이슈 재진행 버튼: 이슈 상태 open일 때 미노출-->
			                <div class="closedIssueBadge" <c:if test="${issue.issue_Open_St eq 1 }">style="display:none;"</c:if>>
								<%-- 이슈 저장 함수 필요 --%>
				                <button type="button" class="btn btn-success float-right" style="margin-top:10px;" onclick="saveIssue('이슈상태', 1, 'inprogress');">이슈 재진행</button>
				                <div style="clear:both;"></div>
			                </div>
							<!-- 이슈 종료 버튼: 이슈 상태 close일 때 미노출-->
							<div class="closedIssueBadge" <c:if test="${issue.issue_Open_St eq 2 }">style="display:none;"</c:if>>
									<%-- 이슈 저장 함수 필요 --%>
								<button type="button" class="btn btn-danger float-right" style="margin-top:10px;" onclick="saveIssue('이슈상태', 2, 'done');">이슈 종료</button>
								<div style="clear:both;"></div>
							</div>
                        </div>
                    </div>
                </div>
                
                <!-- 우측 사이드바(업무, 마일스톤) -->
                <div class="col-lg-3" style="padding-left:0px;">
                    <div class="m-b-10 card">
                        <div class="body">
							<%-- 이슈 작성자만 클릭 시, changeMode 함수 호출 --%>
                        	<div <c:if test="${loginUser.emp_Id == issue.emp_Id }">class="duty" onclick="changeMode('업무번호');"</c:if> >
	                        	<strong>관련 업무</strong>
	                        	<i class="fas fa-cogs float-right" style="font-size: 1.25em;"></i>
                        	</div>
                        	<div class="m-t-10 detailModeTask">
                        		<span id="spanduty_Board_Title" style="max-width:75%;vertical-align:middle;display:inline-block;overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">
                        			<c:if test="${!empty issue.duty_Board_Title }">
                        				${issue.duty_Board_Title }
                        			</c:if>
                        			<c:if test="${empty issue.duty_Board_Title }">
		                        		관련 업무가 없습니다.
                        			</c:if>
                        		</span>
                        	</div>
                        	<!-- 업무 수정창 -->
                        	<div class="m-t-5 modifyModeTask" style="display:none;">
								<form:input path="issueVO.duty_Board_Id" id="dutyBoardIdForIssue" style="width:100%;margin-top:5px;margin-bottom:5px;" readonly="true"/>
								<a href="#largeModal" id="addDuty" data-toggle="modal" data-target="#dutyModal"> + 업무 선택하기</a><br>
							<%-- 이슈 저장 함수 필요 --%>
								<button type="button" class="btn btn-primary" style="width: 49%;font-size: 0.9em;padding: 5px;" onclick="saveIssue('업무번호');">저장</button>
                        		<button type="button" class="btn btn-secondary" style="width: 49%;font-size: 0.9em;padding: 5px;" onclick="changeMode('업무번호');">취소</button>
                        	</div>
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="body">
							<%-- 이슈 작성자만 클릭 시, changeMode 함수 호출 --%>
                        	<div <c:if test="${loginUser.emp_Id == issue.emp_Id }">class="milestone" onclick="changeMode('마일스톤');"</c:if> >
	                        	<strong>마일스톤</strong>
	                        	<i class="fas fa-cogs float-right" style="font-size: 1.25em;"></i>
                        	</div>
                        	<div class="detailModeMilestone">
	                            <!-- 마일스톤 이름 -->
	                            <div style="margin-top:10px;">
	                            	<c:if test="${!empty issue.milestone_Name }">
		                            	<span>${issue.milestone_Name }</span>
	                            	</c:if>
	                            	<c:if test="${empty issue.milestone_Name }">
		                            	<span>등록된 마일스톤이 없습니다.</span>
	                            	</c:if>
	                            </div>
                        	</div>
                        	<!-- 마일스톤 수정폼 -->
                        	<div class="modifyModeMilestone" style="display:none;margin-top:10px;">
								<%-- select조건 및 이슈 저장 함수 필요 --%>
                        		<select name="issueVO.milestone_Id" style="padding:5px;" onchange="saveIssue('마일스톤');">
                        			<option style="padding:5px;" value="-1">-- 마일스톤 선택 --</option>
									<%-- 드롭다운에 마일스톤 리스트 전부 노출 --%>
                        			<c:forEach items="${milestoneList }" var="milestone">
                        				<option style="padding:5px;" value="${milestone.milestone_Id }">${milestone.milestone_Name }</option>
                        			</c:forEach>
                        			<option style="padding:5px;" disabled="disabled">------------------------------</option>
									<%-- 벨류값을 0으로 줘서 "마일스톤 삭제" 선택 후 저장 시 milestone_Id 값 0으로 --%>
                        			<option style="padding:5px;" value="0">마일스톤 삭제</option>
                        		</select>
                        	</div>
                        </div>
                    </div>
                </div>
            </div>
		</form:form>
	</div>
</div>

		<!-----------------------------------------------업무 추가 모달--------------------------------------------->
		<!-- Modal -->
		<div class="modal fade" id="dutyModal" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="modal-dialog" role="document" style="max-width: 400px;">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="title" id="largeProjectModalLabel">업무 수정</h4>
					</div>
					<div class="modal-body">
						<!-- 모달 수신자 등록 폼 -->
						<div class="body" style="padding: 6px;">
							<ul class="nav nav-tabs">
								<li class="nav-item"><a class="nav-link show active" data-toggle="tab" href="#projectOrg">프로젝트</a></li>
							</ul>
							<div class="tab-content" style="padding: 0;">
								<!-- 조직도 -->
								<div class="tab-pane show active" id="projectOrg">
									<div class="header" style="height: 5px; margin-top: 15px;">
									</div>
									<div class="body" style="overflow-y: scroll; height: 300px;">
										<div>
											<ul id="projectList" class="treeview">
												<li>
													프로젝트 리스트&nbsp
													<ul id="project"></ul>
												</li>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal" id="closeProjectModal">닫기</button>
					</div>
				</div>
			</div>
		</div>



		<form name="replyRegistForm">
			<input type="hidden" name="issue_Board_Id" value="${issue.issue_Board_Id }"/>
			<input type="hidden" name="emp_Id" value="${loginUser.emp_Id }"/>
			<input type="hidden" name="reply_Content" />
			<input type="hidden" name="reply_Group_Code" />
		</form>

<script type="text/javascript">
	window.onload=function(){
		$('.note-editable').css('height','150');

		// 시간 포맷 변경
		$('.issueDate').text(getTimeDefferFromCurrent(new Date('${issue.issue_Board_Create_Dt}')));
		$('.replyDate').each(function(){
			$(this).text(getTimeDefferFromCurrent(new Date($(this).attr('data-createDt'))));
		});

		// 서버에서 받은 날짜 문자열
		var serverDateStr = "${issueReply.reply_Create_Dt}";

// JavaScript Date 객체 생성
		var serverDate = new Date(serverDateStr);

// 클라이언트의 로컬 시간대에 맞게 시간 변환
		var clientDateStr = serverDate.toLocaleString();

// 변환된 시간을 HTML 요소에 삽입
		document.getElementById("clientTime").innerText = clientDateStr;

	}

		function goBackToList() {
		location.href = "${pageContext.request.contextPath}/board/issue/list";
	}

	var jsIssueReplyVO = {
		reply_Group_Code:0,
		milestoneId:'${issue.milestone_Id}'
	}

	// 이전 마일스톤
	var milestoneManager;


	// 업무 번호 추가 !
	function displayProjectTree(projectTree) {
		var projectList = $("#project");

		projectTree.forEach(function(projectWithDuties) {
			var project = projectWithDuties.project;
			var duties = projectWithDuties.duties;

			var projectLink = $("<a>").addClass("project-link").attr("href", "#").attr("data-project-id", project.project_Id).text(project.project_Title);
			var imgSrc = $("<img>").attr("src", "<%=request.getContextPath() %>/js/treeview/images/file.gif");
			var projectItem = $("<li>").addClass("project-item").attr("id", project.project_Id).append(imgSrc).append(projectLink);

			var dutyList = $("<ul>").addClass("duty-list");

			duties.forEach(function(duty) {
				var dutyLink = $("<a>").addClass("duty-link").attr("href", "#").attr("data-duty-id", duty.duty_Board_Id).text(duty.duty_Board_Title);
				var dutyItem = $("<li>").addClass("duty-item").attr("id", duty.duty_Board_Id).append(dutyLink);

				// 이미지 요소를 생성하고 업무 아이템에 추가합니다.
				var imgSrc = $("<img>").attr("src", "<%=request.getContextPath() %>/js/treeview/images/file.gif");
				dutyLink.prepend(imgSrc);

				dutyList.append(dutyItem);

				// 클릭된 업무 아이템에서 duty-Board-Id를 가져옵니다.
				dutyLink.click(function() {
					var dutyBoardId = $(this).attr('data-duty-id');

					// 가져온 duty-Board-Id를 입력란에 넣습니다.
					$('#dutyBoardIdForIssue').val(dutyBoardId);

					// 모달을 닫습니다.
					$('#dutyModal').modal('hide');
				});
			});

			// 클릭된 프로젝트 아이템에서 project-Id를 가져옵니다.
			projectLink.click(function() {
				toggleExpandCollapse(this);
			});

			var expandIcon = $("<div>").addClass("hitarea expandable-hitarea").attr("onclick", "toggleExpandCollapse(this);");
			projectItem.prepend(expandIcon);

			if (duties.length > 0) {
				projectItem.addClass("expandable").append(dutyList).find(".hitarea").addClass("collapsable-hitarea");
				dutyList.hide();
			} else {
				projectItem.addClass("collapsable").find(".hitarea").addClass("expandable-hitarea");
			}

			projectList.append(projectItem);
		});
	}



	function toggleExpandCollapse(element) {
		var $element = $(element);
		var $dutyList = $element.siblings(".duty-list");

		$element.toggleClass("expandable-hitarea collapsable-hitarea");
		$dutyList.toggle();

		if ($dutyList.is(":hidden")) {
			$element.removeClass("collapsable-hitarea").addClass("expandable-hitarea");
		} else {
			$element.removeClass("expandable-hitarea").addClass("collapsable-hitarea");
		}
	}

	$(document).ready(function() {
		$.ajax({
			type: "GET",
			url: "<c:url value='/getProjectTreeView' />",
			contentType: "application/json",
			processData: true,
			success: function(data) {
				displayProjectTree(data);
			},
			error: function(xhr, status, error) {
				console.error("Failed to retrieve project tree:", error);
			}
		});

		// 모든 프로젝트를 닫힌 상태로 표시
		$(".duty-list").hide();
	});


// 수정버튼 클릭 (이슈 제목, 이슈 내용, 업무, 댓글, 마일스톤)
function changeMode(category, reply_Id){
	if(category=='제목'){
		if($('.detailMode').css('display')=='block'){
			$('.detailMode').css('display','none');
			$('.modifyMode').css('display','');
		}else{
			$('.detailMode').css('display','');
			$('.modifyMode').css('display','none');
		}
	}else if(category=='내용'){
		if($('.detailModeContent').css('display')=='inline'){
			$('.detailModeContent').css('display','none');
			$('.modifyModeContent').css('display','');
		}else{
			$('.detailModeContent').css('display','');
			$('.modifyModeContent').css('display','none');
		}
	}else if(category=='업무번호'){
		if($('.detailModeTask').css('display')=='block'){
			$('.detailModeTask').css('display','none');
			$('.modifyModeTask').css('display','');
		}else{
			$('.detailModeTask').css('display','');
			$('.modifyModeTask').css('display','none');
		}
	}else if(category=='댓글'){
		if($('.detailModeReply_'+reply_Id).css('display')=='inline'){
			$('.detailModeReply_'+reply_Id).css('display','none');
			$('.modifyModeReply_'+reply_Id).css('display','');
			$('#replyForm_'+reply_Id).css('width','100%');
		}else{
			$('.detailModeReply_'+reply_Id).css('display','');
			$('.modifyModeReply_'+reply_Id).css('display','none');
			$('#replyForm_'+reply_Id).css('width','90%');
		}
	}else if(category=='마일스톤'){
		if($('.detailModeMilestone').css('display')=='block'){
			$('.detailModeMilestone').css('display','none');
			$('.modifyModeMilestone').css('display','');
		}else{
			$('.detailModeMilestone').css('display','');
			$('.modifyModeMilestone').css('display','none');
		}
	}

}
// 댓글 및 히스토리 등록
	function registIssueReply(reply_Group_Code){
		var replyRegistView;

		if(reply_Group_Code==1){	// 댓글
			replyRegistView = $('.note-editable').last();
			if($.trim(replyRegistView.text())==""){
				alert('내용을 입력하세요.');
				replyRegistView.focus();
				return;
			}

			$('input[name="reply_Content"]').val(replyRegistView.html());
		}else if(reply_Group_Code==2){	// 이슈 종료
			$('input[name="reply_Content"]').val('이슈 종료');
		}else if(reply_Group_Code==3){	// 이슈 재진행
			$('input[name="reply_Content"]').val('이슈 재진행');
		}
		$('input[name="reply_Group_Code"]').val(reply_Group_Code);

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

	// 댓글 수정
	function modifyReply(replyId){
		var textarea = $('.modifyModeReply_'+replyId+' .note-editable');
		if($.trim(textarea.text()) == ""){
			alert('내용을 입력하세요.');
			textarea.focus();
			return;
		}

		$.ajax({
			url:'<c:url value="/board/issue/reply/modify"/>',
			type:'post',
			data:{'reply_Id':replyId,'reply_Content':textarea.html()},
			success:function(){
				alert('댓글이 수정되었습니다.');
				$('#spanIssueReplyContent_'+replyId).html(textarea.html());

				changeMode('댓글',replyId);
			},
			error:function(){
				alert('댓글 수정 실패');
			}
		});
	}

// 댓글 삭제
function removeReply(replyId){
	var chk = confirm('댓글을 삭제하시겠습니까?');
	if(!chk) return;

	$.ajax({
		url:'<c:url value="/board/issue/reply/remove"/>',
		type:'post',
		data:{'reply_Id':replyId},
		success:function(){
			alert('댓글이 삭제되었습니다.');
			window.location.reload(true);
		},
		error:function(){
			alert('댓글 삭제 실패');
		}
	});
}

	// 이슈 제목/내용/상태 변경
	function saveIssue(category, issueSt, projectSt){
		if(category=='이슈상태'){
			$('input[name="issueVO.issue_Open_St"]').val(issueSt);
			$('input[name="issueVO.issue_Project_St"]').val(projectSt);
		}
		if(category=='제목'){
			var selectedValue = document.getElementById('issue_Board_St').value;
			// 숨은 입력 필드에 선택된 값 설정
			document.querySelector('input[name="issueVO.issue_Board_St"]').value = selectedValue;
		}
		if(category=='마일스톤'){
			var value = $('select[name="issueVO.milestone_Id"]').val();

			if(value == '-1' || jsIssueReplyVO.milestoneId == value){
				$('select[name="issueVO.milestone_Id"]').val("-1");
				return;
			}

			if(value == '0'){
				if(!confirm('마일스톤을 삭제하시겠습니까?')){
					$('select[name="issueVO.milestone_Id"]').val("-1");
					return;
				}
			}

			// 현재 선택한 마일스톤으로 변경
			milestoneManager = $('select[name="issueVO.milestone_Id"] option:checked');
		}

		$('input[name="issueVO.issue_Board_Content"]').val($('.note-editable').html());
		$.ajax({
			url:"<c:url value='/board/issue/modify'/>",
			type:'post',
			data:$('form[name="detailForm"]').serialize(),
			success:function(duty_Board_Title){

				var msg = category;
				if(category=='업무번호' || category=='이슈상태'){
						msg += '가';
					}else{
						msg += '이';
					}
					alert(msg+' 수정되었습니다.');


				if(category=='제목'){
					$('#spanIssue_Board_Title').text($('input[name="issueVO.issue_Board_Title"]').val());
					if ($('#hiddenIssue_Board_St').val() == 1) {
						$('#spanIssue_Board_St').css('display','none');
					}else{
						$('#spanIssue_Board_St').css('display','inline');
					}

				}else if(category=='내용'){
					$('#spanIssueBoardContent').html($('input[name="issueVO.issue_Board_Content"]').val());
				}else if(category=='업무번호'){
					window.location.reload(true);

				}else if(category=='이슈상태'){
						if(issueSt == 2){	// 이슈 종료
							jsIssueReplyVO.reply_Group_Code = 2;

					}else{	// 이슈 재진행
						jsIssueReplyVO.reply_Group_Code = 3;

					}

					// 히스토리 등록
					registIssueReply(jsIssueReplyVO.reply_Group_Code);

					window.location.reload(true);
				}else if(category=='마일스톤'){
					window.location.reload(true);
					// jsIssueReplyVO.milestone_Id = $('select[name="issueVO.milestone_Id"]').val();
					//
					// // 마일스톤 뷰 수정
					// $('.detailModeMilestone').children().remove();
					// var milestoneView = '';
					// if(jsIssueReplyVO.milestone_Id == 0){	// 마일스톤 삭제
					// 	milestoneView += '<div style="margin-top:10px;">'
					// 			+'<span>등록된 마일스톤이 없습니다.</span>'
					// 			+'</div>';
					// }
					// $('.detailModeMilestone').append(milestoneView);
					//
					// if($('select[name="issueVO.milestone_Id"]').val() == 0){
					// 	$('select[name="issueVO.milestone_Id"]').val("-1");
					// }
				}
				changeMode(category);
				// window.location.reload(true);
			},
			error:function(){
				alert('제목 수정 실패');
			}
		});
	}

// 이슈 삭제
function removeIssue(){
	var check = confirm('이슈를 삭제하시겠습니까?');
	if(!check) return;

	$.ajax({
		url:"<c:url value='/board/issue/remove'/>",
		type:'post',
		data:$('form[name="detailForm"]').serialize(),
		success:function(){
			alert('이슈가 삭제되었습니다.');
			window.location.href="<c:url value='/board/issue/list'/>"
		},
		error:function(){
			alert('삭제 실패');
		}
	});
}

</script>
</div>
</section>
<!-- 푸터 인클루드 -->
<%@ include file="../../include/footer.jsp"%>
</body>