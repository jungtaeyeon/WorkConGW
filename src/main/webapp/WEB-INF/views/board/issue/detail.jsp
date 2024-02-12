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
			<div class="block-header">
	            <div class="row">
	            	<div class="col-sm-9" style="width:80%;">
	                	<h2 class="detailMode" style="padding-left:10px; font-size:2.5em; font-family:S-CoreDream-6Bold ">

							<%--이슈 타이틀과 이슈 번호 issueVO에서 받아올 예정--%>
	                	<span id="spanissue_Board_Title" style="word-wrap:break-word;"> #n </span> {이슈 타이틀} </h2>
						<input type="text" name="issue_Board_Title" id="issue_Board_Title" class="modifyMode" style="width:100%;padding-left:10px;font-size:2em;display:none;" />
	                	<div>
								<%--이슈 상태 close일 때 숨기기--%>
                			<span class="openIssueBadge" <c:if test="${issue.issue_Open_St eq 'close' }">style="display:none;"</c:if>>
	 	 	              		<span class="badge badge-success" style="font-size:1.2em;margin: 10px 10px 0px;">
		                			<i class="fas fa-info-circle" style="vertical-align: middle;"></i>
		                			<span style="line-height: 1.2em;vertical-align: middle;">Open</span>
	                			</span>
                			</span>

									<%--이슈 상태 open일 때 숨기기--%>
                			<span class="closedIssueBadge" <c:if test="${issue.issue_Open_St eq 'oepn' }">style="display:none;"</c:if>>
	 	 	              		<span class="badge badge-danger" style="font-size:1.2em;margin: 10px 10px 0px;">
		                			<i class="fas fa-check-circle" style="vertical-align: middle;"></i>
		                			<span style="line-height: 1.2em;vertical-align: middle;">Closed</span>
	                			</span>
                			</span>

                			<div style="display:inline;font-size:1.2em;vertical-align: middle;">
	                			<span style="margin-left:5px;">댓글 <span id="issuereply_Count">${issue.reply_Count }</span></span>
	                			<span class="detailMode">
									<%-- 이슈 공개 상태(Y) 인 경우 비공개 미노출 --%>
	                				<span id="spanissue_Board_St" <c:if test="${issue.issue_Board_St eq 'Y' }">style="display:none;"</c:if> >
			                			<span style="margin-left:5px;">•</span>
			                			<span style="margin-left:5px;">비공개</span>
	                				</span>
	                			</span>
	                			<span class="modifyMode m-l-15" style="display:none;">
	                				<select name="issueVO.issue_Board_St">
	                					<option <c:if test="${issue.issue_Board_St eq 'Y' }">selected</c:if> value="Y">공개</option>
	                					<option <c:if test="${issue.issue_Board_St eq 'N' }">selected</c:if> value="N">비공개</option>
	                				</select>
	                			</span>
                			</div>
	                	</div>
	                </div>

	                <div class="col-sm-3">
	               		<div style="float:right;">
							<%-- 이슈 작성자만 아래 버튼 노출 --%>
	               			<c:if test="${loginUser.emp_Id == issue.emp_Id }">
		                    	<button type="button" class="btn btn-info detailMode" style="width:80px;font-family: S-CoreDream-6Bold;" onclick="changeMode('제목');">수정</button>
		                    	<button type="button" class="btn btn-danger detailMode" style="width:80px;font-family: S-CoreDream-6Bold;" onclick="removeIssue();">삭제</button>
								<%-- 저장 함수 필요 --%>
		                    	<button type="button" class="btn btn-primary modifyMode" style="width:80px;display:none;" onclick="saveIssue();">저장</button>
								<button type="button" onclick="changeMode('제목');" class="btn btn-secondary modifyMode" style="width:80px;display:none;">취소</button>
	               			</c:if>
	                    	<button type="button" onclick="goBackToList();" class="btn btn-secondary detailMode" style="width:80px; font-family: S-CoreDream-6Bold">목록</button>

	                	</div>
	             	</div>
	            </div>
	        </div>
	        
	        <div class="row clearfix" style="font-family: S-CoreDream-4Regular">
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
	                                        <strong class="name" style="font-size:1.2em;display:inline;vertical-align: middle;">{이름}</strong>
	                                    </div>
	                                </div>
	                                <div style="padding:20px;">
	                                	<div class="row">
	                                		<div class="col-lg-10">
												<%-- 내용: issue_Board_Content 받아올 예정 --%>
		                                        <span id="spanissue_Board_Content" class="detailModeContent" style="font-size:1.1em;">{내용 내용 내용}</span>
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
		                                        <div class="summernote" id="summernote" >{내용 내용 내용}</div>
		                                        <div class="m-t-10" style="float:right;">
													<%-- 저장 함수 필요 --%>
				                                    <button type="button" class="btn btn-primary" style="width: 60px;" onclick="saveIssue();">저장</button>
				                                    <button type="button" class="btn btn-secondary" style="width: 60px;" onclick="changeMode('내용');" >취소</button>
		                                        </div>
	                                		</div>
	                                	</div>
	                                </div>
		                        </li>

<%--								댓글 영역 시작 --%>
								<%-- 댓글(아래 브릿지는 댓글 작성일때 만 노출) --%>
								<li class="replyBridge" style="clear:both;border-left:1px solid black;height:30px;margin-left:30px;">
								</li>
								<li id="li_${issueReply.replyId }" class="online" style="clear:both;border:1.5px solid rgb(0,0,0,0.2);border-radius:15px;">
									<div class="media" style="margin:0px;border-bottom:1px solid rgb(0,0,0,0.2);padding:10px 20px;">
										<div  class="rounded-circle avatar pictureView" style="background-image:url('${pageContext.request.contextPath }/pds/empPicture/${issueReply.emp_Picture}');width: 60px; height: 60px;"></div>
										<div class="media-body" style="margin-top: 7px;">
											<strong class="name" style="font-size:1.2em;display:inline;vertical-align: middle;">{댓글 작성한 사원 이름}</strong>
											<%-- 이슈 작성자인 경우 노출 --%>
											<span class="badge badge-default" style="color:black;border-color: black;">작성자</span>
											<br>
											<%-- 시간 차이 계산 함수 적용 예정 --%>
											<span>n분 or n시간 전 or n일 전</span>
										</div>
									</div>
									<div style="padding:20px;">
										<%-- 댓글내용: replyContent 가져올 예정 --%>
										<div style="width:90%;display:inline-block;">
											<span style="font-size:1.1em;">{댓글 내용}</span>
										</div>
											<%-- 작성자에게만 노출(수정, 삭제 버튼) --%>
                                            <div class="detailModeReply_${issueReply.replyId }" style="display:inline;float:right;">
												<a href="javascript:void(0);" class="btn btn-sm btn-outline-info" title="수정" onclick="changeMode('댓글','${issueReply.replyId }');"><i class="fas fa-edit"></i></a>
												<a href="javascript:void(0);" class="btn btn-sm btn-outline-danger" title="삭제" onclick="removeReply(${issueReply.replyId});"><i class="fas fa-trash-alt"></i></a>
											</div>

								<!-- 이슈 종료 시 댓글 -->
								<li class="left float-left closedHistory" style="border-top:2px solid #ee2558; width:100%; margin-top:10px; margin-bottom:30px;">
									<div class="timeline-item danger" style="margin-top:10px; margin-left:30px;">
										<%-- 시간 차이 계산 함수 적용 예정 --%>
										<span>n분 or n시간 전 or n일 전</span>
										<h5 style="font-weight:bold;">이슈 종료</h5>
										<%-- 로그인한 사원 이름 가져올 예정 --%>
										<p style="margin:5px 0px 0px;">{로그인 사원 이름}님이 이슈를 종료시켰습니다.</p>
									</div>
								</li>
								<li class="closedHistory" style="clear:both;"></li>


		                        <!-- 이슈 재진행 시 댓글 -->
								<li class="left float-left" style="border-top:2px solid #86c541; margin-bottom:0px;width:100%;">
									<div class="timeline-item green" style="margin-top:10px; margin-left:30px;">
										<%-- 시간 차이 계산 함수 적용 예정 --%>
										<span>n분 or n시간 전 or n일 전</span>
										<h5 style="font-weight:bold;">이슈 재시작</h5>
										<%-- 로그인한 사원 이름 가져올 예정 --%>
										<p style="margin:5px 0px 0px;">{로그인 사원 이름}님이 이슈를 다시 진행시켰습니다.</p>
									</div>
								</li>
								<li style="clear: both"></li>

<%--											댓글 영역 끝  --%>
                        	</ul>
                        
			           		<!-- 댓글 등록 에디터: close 상태일 때 미노출 -->
			           		<div class="body openIssueBadge" style="<c:if test="${issue.issue_Open_St eq 'close' }">display:none;</c:if>background-color: #eee;margin-top:15px;">
			                    <div class="form-group">
			                    	<div class="summernote" id="replySummernote"></div>
			                    </div>
			                    <div class="align-right">
									<%-- 댓글 등록 함수 필요 --%>
			                        <button type="button" class="btn btn-primary" onclick="registIssueReply();" >댓글 등록</button>
			                	</div>
			                </div>

							<%-- 이슈 작성자만 재진행, 종료 버튼 노출 --%>
							<c:if test="${issue.emp_Id == loginUser.emp_Id }">
			                <!-- 이슈 재진행 버튼: 이슈 상태 close일 때 노출-->
			                <div class="closedIssueBadge" <c:if test="${issue.issue_Open_St eq 'close' }">style="display:none;"</c:if>>
								<%-- 이슈 저장 함수 필요 --%>
				                <button type="button" class="btn btn-success float-right" style="margin-top:10px;" onclick="saveIssue();">이슈 재진행</button>
				                <div style="clear:both;"></div>
			                </div>
							<!-- 이슈 종료 버튼: 이슈 상태 open일 때 노출-->
							<div class="closedIssueBadge" <c:if test="${issue.issue_Open_St eq 'open' }">style="display:none;"</c:if>>
									<%-- 이슈 저장 함수 필요 --%>
								<button type="button" class="btn btn-danger float-right" style="margin-top:10px;" onclick="saveIssue();">이슈 종료</button>
								<div style="clear:both;"></div>
							</div>
							</c:if>
                        </div>
                    </div>
                </div>
                
                <!-- 우측 사이드바 -->
                <div class="col-lg-3" style="padding-left:0px;">
                    <div class="m-b-10 card">
                        <div class="body">
							<%-- 이슈 작성자만 클릭 시, changeMode 함수 호출 --%>
                        	<div <c:if test="${loginUser.emp_Id == issue.emp_Id }">class="duty" onclick="changeMode('업무번호');"</c:if> >
	                        	<strong>관련 업무</strong>
	                        	<i class="fas fa-cogs float-right" style="font-size: 1.25em;"></i>
                        	</div>
                        	<div class="m-t-10 detailModeTask">
								<%-- duty_Board_Title이 없을 때(업무 미등록) 미노출 duty_Board_Id 가져올 예정 --%>
	                        	<span id="spanNoduty_Board_Id" class="m-r-5" style="vertical-align:middle;<c:if test="${!empty issue.duty_Board_Title}">display:none;</c:if>">#${issue.duty_Board_Id}</span>
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

								<input type="text" name="duty_Board_Id" id="duty_Board_Id" style="width:100%;margin-top:5px;margin-bottom:5px;" />
								<%-- 이슈 저장 함수 필요 --%>
								<button type="button" class="btn btn-primary" style="width: 49%;font-size: 0.9em;padding: 5px;" onclick="saveIssue();">저장</button>
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
                        		<select name="issueVO.milestone_Id" style="padding:5px;" onchange="saveIssue();">
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
	</div>
</div>

<script type="text/javascript">
		function goBackToList() {
		location.href = "${pageContext.request.contextPath}/board/issue/list";
	}


// 수정버튼 클릭 (이슈 제목, 이슈 내용, 업무, 댓글, 마일스톤)
function changeMode(category, replyId){
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
		if($('.detailModeReply_'+replyId).css('display')=='inline'){
			$('.detailModeReply_'+replyId).css('display','none');
			$('.modifyModeReply_'+replyId).css('display','');
			$('#replyForm_'+replyId).css('width','100%');
		}else{
			$('.detailModeReply_'+replyId).css('display','');
			$('.modifyModeReply_'+replyId).css('display','none');
			$('#replyForm_'+replyId).css('width','90%');
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

// 댓글 수정
function modifyReply(replyId){

}

// 댓글 삭제
function removeReply(replyId){
	var chk = confirm('댓글을 삭제하시겠습니까?');
	if(!chk) return;
}

// 이슈 삭제
function removeIssue(){
	var check = confirm('이슈를 삭제하시겠습니까?');
	if(!check) return;
}

</script>
</div>
</section>
<!-- 푸터 인클루드 -->
<%@ include file="../../include/footer.jsp"%>
</body>