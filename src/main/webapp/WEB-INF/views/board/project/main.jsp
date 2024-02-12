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

            <div class="row clearfix" style="font-family: S-CoreDream-7ExtraBold">
                <div class="col-lg-9 col-md-12" style="padding-right:0px;">
                    <div class="card">
                        <div class="body project_report">
                        	<button type="button" class="btn btn-light" onclick="window.location.href='${pageContext.request.contextPath}/board/issue/list';">이슈</button>
                        	<button type="button" class="btn btn-light" onclick="window.location.href='${pageContext.request.contextPath}/board/milestone/list';">마일스톤</button>
                        	<button type="button" class="btn btn-light active" onclick="window.location.href='${pageContext.request.contextPath}/board/project';">프로젝트</button>
	                    </div>

	                   	<div style="padding:10px 30px;">

							<span style="font-size:1.1em;">프로젝트 진행률</span>
							<%-- todoList + inprogress + done = 0이면: percentage 벨류값0 부터 시작 --%>
							<c:set var="percentage" value="20"></c:set>

								<%-- todoList + inprogress + done = 0이 아니면 --%>
								<%-- done / 전체(todoList + inprogress + done) * 100 --%>

	                   		<div class="progress-container m-t-15" style="">
	                           <div class="progress progress-xs" style="height:20px;background-color:rgb(0,0,0,0.2);">
	                               <div class="progress-bar" role="progressbar" aria-valuenow="${percentage }" aria-valuemin="0" aria-valuemax="100" style="width: ${percentage }%; height:20px;">
	                               </div>

	                               <span id="percentage" style="position: absolute;color: white;left: 50%;font-size: 1.1em;line-height: 1.5em;">${percentage }%</span>

	                           </div>
	                       	</div>
	                   	</div>

	                    <div class="row clearfix" style="margin:10px;">

							<%-- 해야할 일 시작 --%>
	                    	<div class="top_counter col-lg-4 col-md-6">
	                    		<div class="card" style="height:80vh;background-color:#eee;">
			                        <div class="body">
										<%-- todoList 카운트 (비어있으면0 아니면 사이즈 출력) --%>
			                        	<span class="issueCount">0</span>
		                                <h5 class="number">해야할 일</h5>
			                        </div>

			                        <div class="issueManage" id="div_todo" style="height:70vh;">
			                            <div class="dd dd4" id="todo">

											<%-- todoList가 비어있지 않으면 --%>
				                                <ol class="dd-list">
													<%-- todoList forEach var="issue --%>

													<%-- 클릭 시 해당 이슈 상세로 이동하게 하기위해 id에 이슈id를 줌  --%>
					                                    <li class="dd-item" id="${issue.issue_Board_Id}" style="cursor:pointer; margin-top: 20px">
					                                        <div class="dd-handle card" style="height:70vh;margin-left: 0px; padding:10px 20px;height:auto;color:black;border:1px solid rgb(0,0,0,0.2);">
				                                            	<div style="margin-bottom: -15px;">

					                                                <div style="display:inline-block;font-weight: bold;max-width: 85%; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;">
																		<%-- issue_Open_St eq 'open' 라면 --%>
						                                                	<i class="fas fa-info-circle" style="color:green;"></i>

																			<%-- issue_Open_St eq 'close' 라면 --%>
						                                                	<i class="fa fa-check" style="color:red;"></i>

					                                                	<span class="issueTitle" style="font-size:1.1em;">{이슈 타이틀}</span>
					                                                </div>

																	<%-- 이슈에 업무 연결되어 있으면 노출 --%>
																	<div class="row clearfix" style="margin-top:10px;">
						                                                <span class="btn btn-secondary" style="height:auto; padding: 0px 3px;font-size:0.8em;margin-top: -10px;"># {업무 번호}</span>
																	</div>
				                                            	</div>
																<div class="row clearfix" style="margin-top:20px;">
				                                                <span># {이슈번호}</span>
																</div>
					                                        </div>

															<%-- 프로젝트 상태 변경 --%>
					                                        <i class="fa fa-ellipsis-h" data-toggle="dropdown" aria-expanded="false" style="cursor: pointer;position: absolute;z-index: 10;top: 25px;font-size: 1.5em;right: 20px;"></i>
					                                        <div class="user-account" style="position: absolute;top:0px;right:150px;">
						                                        <div class="dropdown">
												                    <ul class="dropdown-menu dropdown-menu-right account animated flipInY menuProfile" x-placement="bottom-end" style="position: absolute; will-change: transform; top: 0px; left: -100px; padding:10px;transform: translate3d(89px, 42px, 0px);">

																		<li data-id="${issue.issue_Board_Id }" data-st="todo" data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-pencil-alt"></i><span>해야할 일</span></a></li>
																		<li data-id="${issue.issue_Board_Id }" data-st="inprogress" data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-spinner"></i><span>이슈 진행</span></a></li>
																		<li data-id="${issue.issue_Board_Id }" data-st="done" data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-check-circle"></i><span>이슈 완료</span></a></li>

																		<%-- issue_Project_St eq todo 이면 --%>
												                    	<c:if test="${issue.issue_Project_St eq 'todo' }">
													                        <li data-id="${issue.issue_Board_Id }" data-st="inprogress" data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-spinner"></i><span>이슈 진행</span></a></li>
																			<li data-id="${issue.issue_Board_Id }" data-st="done" data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-check-circle"></i><span>이슈 완료</span></a></li>
												                    	</c:if>

																			<%-- issue_Project_St eq inprogress 이면 --%>
												                    	<c:if test="${issue.issue_Project_St eq 'inprogress' }">
																			<li data-id="${issue.issue_Board_Id }" data-st="todo" data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-pencil-alt"></i><span>해야할 일</span></a></li>
																			<li data-id="${issue.issue_Board_Id }" data-st="done" data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-check-circle"></i><span>이슈 완료</span></a></li>
												                    	</c:if>

																			<%-- issue_Project_St eq done 이면 --%>
																		<c:if test="${issue.issue_Project_St eq 'done' }">
																			<li data-id="${issue.issue_Board_Id }" data-st="todo" data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-pencil-alt"></i><span>해야할 일</span></a></li>
																			<li data-id="${issue.issue_Board_Id }" data-st="inprogress" data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-spinner"></i><span>이슈 진행</span></a></li>
																		</c:if>
												                    </ul>
												                </div>
					                                        </div>
															<%-- 프로젝트 상태 변경 끝 --%>
					                                    </li>
													<%-- fofEach 끝 --%>
				                                </ol>

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
										<%-- inprogressList 카운트 (비어있으면0 아니면 사이즈 출력) --%>
			                            <span class="issueCount">0</span>
		                                <h5 class="number" style="display:inline-block;">진행중</h5>
			                        </div>

			                        <div class="issueManage" id="div_inprogress" style="height:70vh;">
			                            <div class="dd dd4" id="inprogress">
											<%-- inprogressList 비어있지 않으면 --%>
											<ol class="dd-list">
												<%-- inprogressList forEach var="issue --%>

													<%-- 클릭 시 해당 이슈 상세로 이동하게 하기위해 id에 이슈id를 줌  --%>
					                                    <li class="dd-item" id="${issue.issue_Board_Id }" style="cursor:pointer; margin-top: 20px">

															<div class="dd-handle card" style="height:70vh; padding:10px 20px;height:auto;color:black;border:1px solid rgb(0,0,0,0.2);">
																<div style="margin-bottom: -15px;">

																	<div style="display:inline-block;font-weight: bold;max-width: 85%; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;">
																		<%-- issue_Open_St eq 'open' 라면 --%>
																		<i class="fas fa-info-circle" style="color:green;"></i>

																		<%-- issue_Open_St eq 'close' 라면 --%>
																		<i class="fa fa-check" style="color:red;"></i>

																		<span class="issueTitle" style="font-size:1.1em;">{이슈 타이틀}</span>
																	</div>

																	<%-- 이슈에 업무 연결되어 있으면 노출 --%>
																	<div class="row clearfix" style="margin-top:10px;">
																		<span class="btn btn-secondary" style="height:auto; padding: 0px 3px;font-size:0.8em;margin-top: -10px;"># {업무 번호}</span>
																	</div>
																</div>
																<div class="row clearfix" style="margin-top:20px;">
																	<span># {이슈번호}</span>
																</div>
															</div>

															<%-- 프로젝트 상태 변경 --%>
															<i class="fa fa-ellipsis-h" data-toggle="dropdown" aria-expanded="false" style="cursor: pointer;position: absolute;z-index: 10;top: 25px;font-size: 1.5em;right: 20px;"></i>
															<div class="user-account" style="position: absolute;top:0px;right:150px;">
																<div class="dropdown">
																	<ul class="dropdown-menu dropdown-menu-right account animated flipInY menuProfile" x-placement="bottom-end" style="position: absolute; will-change: transform; top: 0px; left: -100px; padding:10px;transform: translate3d(89px, 42px, 0px);">

																		<li data-id="${issue.issue_Board_Id }" data-st="todo" data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-pencil-alt"></i><span>해야할 일</span></a></li>
																		<li data-id="${issue.issue_Board_Id }" data-st="inprogress" data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-spinner"></i><span>이슈 진행</span></a></li>
																		<li data-id="${issue.issue_Board_Id }" data-st="done" data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-check-circle"></i><span>이슈 완료</span></a></li>

																		<%-- issue_Project_St eq todo 이면 --%>
																		<c:if test="${issue.issue_Project_St eq 'todo' }">
																			<li data-id="${issue.issue_Board_Id }" data-st="inprogress" data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-spinner"></i><span>이슈 진행</span></a></li>
																			<li data-id="${issue.issue_Board_Id }" data-st="done" data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-check-circle"></i><span>이슈 완료</span></a></li>
																		</c:if>

																		<%-- issue_Project_St eq inprogress 이면 --%>
																		<c:if test="${issue.issue_Project_St eq 'inprogress' }">
																			<li data-id="${issue.issue_Board_Id }" data-st="todo" data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-pencil-alt"></i><span>해야할 일</span></a></li>
																			<li data-id="${issue.issue_Board_Id }" data-st="done" data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-check-circle"></i><span>이슈 완료</span></a></li>
																		</c:if>

																		<%-- issue_Project_St eq done 이면 --%>
																		<c:if test="${issue.issue_Project_St eq 'done' }">
																			<li data-id="${issue.issue_Board_Id }" data-st="todo" data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-pencil-alt"></i><span>해야할 일</span></a></li>
																			<li data-id="${issue.issue_Board_Id }" data-st="inprogress" data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-spinner"></i><span>이슈 진행</span></a></li>
																		</c:if>
																	</ul>
																</div>
															</div>
															<%-- 프로젝트 상태 변경 끝 --%>
														</li>
													<%-- fofEach 끝 --%>
				                                </ol>
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
										<%-- inprogressList 카운트 (비어있으면0 아니면 사이즈 출력) --%>
										<span class="issueCount">0</span>

		                                <h5 class="number">완료</h5>
			                        </div>

			                        <div class="issueManage" id="div_done" style="height:70vh;">
			                            <div class="dd dd4" id="done">
											<%-- doneList 비어있지 않으면 --%>
											<ol class="dd-list">
												<%-- doneList forEach var="issue --%>

													<%-- 클릭 시 해당 이슈 상세로 이동하게 하기위해 id에 이슈id를 줌  --%>
													<li class="dd-item" id="${issue.issue_Board_Id }" style="cursor:pointer; margin-top: 20px">

														<div class="dd-handle card" style="height:70vh; padding:10px 20px;height:auto;color:black;border:1px solid rgb(0,0,0,0.2);">
															<div style="margin-bottom: -15px;">

																<div style="display:inline-block;font-weight: bold;max-width: 85%; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;">
																	<%-- issue_Open_St eq 'open' 라면 --%>
																	<i class="fas fa-info-circle" style="color:green;"></i>

																	<%-- issue_Open_St eq 'close' 라면 --%>
																	<i class="fa fa-check" style="color:red;"></i>

																	<span class="issueTitle" style="font-size:1.1em;">{이슈 타이틀}</span>
																</div>

																<%-- 이슈에 업무 연결되어 있으면 노출 --%>
																<div class="row clearfix" style="margin-top:10px;">
																	<span class="btn btn-secondary" style="height:auto; padding: 0px 3px;font-size:0.8em;margin-top: -10px;"># {업무 번호}</span>
																</div>
															</div>
															<div class="row clearfix" style="margin-top:20px;">
																<span># {이슈번호}</span>
															</div>
														</div>

																<%-- 프로젝트 상태 변경 --%>
															<i class="fa fa-ellipsis-h" data-toggle="dropdown" aria-expanded="false" style="cursor: pointer;position: absolute;z-index: 10;top: 25px;font-size: 1.5em;right: 20px;"></i>
															<div class="user-account" style="position: absolute;top:0px;right:150px;">
																<div class="dropdown">
																	<ul class="dropdown-menu dropdown-menu-right account animated flipInY menuProfile" x-placement="bottom-end" style="position: absolute; will-change: transform; top: 0px; left: -100px; padding:10px;transform: translate3d(89px, 42px, 0px);">

																		<li data-id="${issue.issue_Board_Id }" data-st="todo" data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-pencil-alt"></i><span>해야할 일</span></a></li>
																		<li data-id="${issue.issue_Board_Id }" data-st="inprogress" data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-spinner"></i><span>이슈 진행</span></a></li>
																		<li data-id="${issue.issue_Board_Id }" data-st="done" data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-check-circle"></i><span>이슈 완료</span></a></li>

																			<%-- issue_Project_St eq todo 이면 --%>
																		<c:if test="${issue.issue_Project_St eq 'todo' }">
																			<li data-id="${issue.issue_Board_Id }" data-st="inprogress" data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-spinner"></i><span>이슈 진행</span></a></li>
																			<li data-id="${issue.issue_Board_Id }" data-st="done" data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-check-circle"></i><span>이슈 완료</span></a></li>
																		</c:if>

																			<%-- issue_Project_St eq inprogress 이면 --%>
																		<c:if test="${issue.issue_Project_St eq 'inprogress' }">
																			<li data-id="${issue.issue_Board_Id }" data-st="todo" data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-pencil-alt"></i><span>해야할 일</span></a></li>
																			<li data-id="${issue.issue_Board_Id }" data-st="done" data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-check-circle"></i><span>이슈 완료</span></a></li>
																		</c:if>

																			<%-- issue_Project_St eq done 이면 --%>
																		<c:if test="${issue.issue_Project_St eq 'done' }">
																			<li data-id="${issue.issue_Board_Id }" data-st="todo" data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-pencil-alt"></i><span>해야할 일</span></a></li>
																			<li data-id="${issue.issue_Board_Id }" data-st="inprogress" data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-spinner"></i><span>이슈 진행</span></a></li>
																		</c:if>
																	</ul>
																</div>
															</div>
																<%-- 프로젝트 상태 변경 끝 --%>
														</li>
														<%-- fofEach 끝 --%>

				                                </ol>
												<%-- doneList 비어있으면 공백 노출 --%>
			                            </div>
			                        </div>
	                    		</div>
		                    </div>
								<%-- 완료 끝 --%>
						</div>
	                </div>
	            </div>

				<%-- 나의 이슈 목록 시작 --%>
	            <div class="col-sm-3">
	            	<div class="row clearfix" style="font-family: S-CoreDream-7ExtraBold">
		                <div class="col-lg-12 col-md-12">
		                    <div class="card" style="padding:30px 0 0 25px;">
		                    	<h3 style="margin-bottom:20px;display: inline-block">나의 이슈 목록</h3>
								<%-- noList 카운트 (비어있으면0 아니면 사이즈 출력) --%>
		                    	<span class="issueCount" style="margin-top: -13px;margin-left: 10px;">0</span>

		                    	<div class="issueManage" id="div_free" style="padding:0px;">
			                    	<div class="dd dd4" id="free" style="height:80vh;overflow-y:auto;padding:0 20px 20px 0;">
										<%-- noList가 비어있지 않으면 --%>
			                                <ol class="dd-list">

												<%-- noList forEach var="issue --%>

													<%-- 클릭 시 해당 이슈 상세로 이동하게 하기위해 id에 이슈id를 줌  --%>
													<li class="dd-item" id="${issue.issue_Board_Id }" style="cursor:pointer; margin-top: 20px">

														<div class="dd-handle card" style="height:70vh; padding:10px 20px;height:auto;color:black;border:1px solid rgb(0,0,0,0.2);">
															<div style="margin-bottom: -15px;">

																<div style="display:inline-block;font-weight: bold;max-width: 85%; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;">
																	<%-- issue_Open_St eq 'open' 라면 --%>
																	<i class="fas fa-info-circle" style="color:green;"></i>

																	<%-- issue_Open_St eq 'close' 라면 --%>
																	<i class="fa fa-check" style="color:red;"></i>

																	<span class="issueTitle" style="font-size:1.1em;">{이슈 타이틀}</span>
																</div>

																<%-- 이슈에 업무 연결되어 있으면 노출 --%>
																<div class="row clearfix" style="margin-top:10px;">
																	<span class="btn btn-secondary" style="height:auto; padding: 0px 3px;font-size:0.8em;margin-top: -10px;"># {업무 번호}</span>
																</div>
															</div>
															<div class="row clearfix" style="margin-top:20px;">
																<span># {이슈번호}</span>
															</div>
														</div>

														<%-- 프로젝트 상태 변경 --%>
														<i class="fa fa-ellipsis-h" data-toggle="dropdown" aria-expanded="false" style="cursor: pointer;position: absolute;z-index: 10;top: 25px;font-size: 1.5em;right: 20px;"></i>
														<div class="user-account" style="position: absolute;top:0px;right:150px;">
															<div class="dropdown">
																<ul class="dropdown-menu dropdown-menu-right account animated flipInY menuProfile" x-placement="bottom-end" style="position: absolute; will-change: transform; top: 0px; left: -100px; padding:10px;transform: translate3d(89px, 42px, 0px);">

																	<%-- Project_St가 비어있기 때문에 셋 다 이동할 수 있게 --%>
																	<li data-id="${issue.issue_Board_Id }" data-st="todo" data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-pencil-alt"></i><span>해야할 일</span></a></li>
																	<li data-id="${issue.issue_Board_Id }" data-st="inprogress" data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-spinner"></i><span>이슈 진행</span></a></li>
																	<li data-id="${issue.issue_Board_Id }" data-st="done" data-title="${issue.issue_Board_Title }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="fas fa-check-circle"></i><span>이슈 완료</span></a></li>

																</ul>
															</div>
														</div>
														<%-- 프로젝트 상태 변경 끝 --%>
													</li>
													<%-- fofEach 끝 --%>
			                                </ol>
											<%-- noList 비어있으면 공백 노출 --%>
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
<%@ include file="../../include/footer.jsp"%>
</body>
