<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<!-- 풀켈린더 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">




<style>
#calendar {
    width: 300px;
    margin: 0 auto;
    font-size: 10px;
}
.fc-toolbar {
    font-size: 2px;
    width: 350px;
}
.fc-toolbar h2 {
    font-size: 12px;
    white-space: normal !important;
}
/* click +2 more for popup */
.fc-more-cell a {
    display: block;
/*     width: 95%;  */
    margin: 1px auto 0 auto;
    border-radius: 3px;
    background: grey;
    color: transparent;
    overflow: hidden;
    height: 4px;
}

.fc-view-month .fc-event, .fc-view-agendaWeek .fc-event, .fc-content {
    font-size: 0;
/*     overflow: hidden; */
    height: 2px;
}
.fc-view-agendaWeek .fc-event-vert {
    font-size: 0;
    overflow: hidden;
    width: 2px !important;
}
.fc-agenda-axis {
    width: 20px !important;
    font-size: 5px;
}



/* .fc-button-content { */
/*     padding: 0; */
/* } */
.fc-content-skeleton table{
   width: 100%;   
}
.fc-month-view{
   overflow-y: scroll;
}
.fc-view-container{
   width: 397px;
}
.fc-view{
   overflow: hidden;
   margin-left: 41px;
}

.fc-left{
   margin-left: 41px;
}



.CurrIcon, .CurrTemp{
    display: inline-block;
    font-size: 2rem;
    text-align: center;
}
.CurrIcon{
    margin-right: 2px;
}
.City{
    font-size: 1.2rem;
    text-align: center;
}
.fc-day{
   text-align: center;
}
#displayAndHiddenOrg{
	border: 1px solid #2980b9;
	background-color: #2980b9;
	color: #ffffff;
	width: 15%;
	text-align: center;
	font-weight: bold;
	display: flex;
	justify-content: space-between;
	left: 24px;
}
#hiddenMenu {
	width: 17.8em;
}
.commonModal-content {
    right: 78.6%;
}
.fancy-checkbox input[type="checkbox"]+span:before{
	width:20px;
	height:20px;
}
.issueTitle:hover{
	color:#5c8ed4;
}
.fa-sort-down:before, .fa-sort-desc:before, .dd4 .dd-item > button[data-action="collapse"]:before, .dd4 .dd-item > button:before{
	content:"";
}
</style>
<body>



    <%@ include file="./include/header.jsp"%>
    

<div id="main-content" style="width: 100%;">
   <div class="container-fluid" >
      <!-- 메인 content 넣는 곳 -->
      
        <div class="row clearfix">
         <!-- 왼쪽줄 시작 -->
            <div class="col-2">
               <div class="card" id="profileCard" style="font-family: InfinitySans-RegularA1">
               		<ul class="nav nav-tabs" style="font-family: InfinitySans-RegularA1">
		                <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#profile_menu" onclick="changeSettingMode(this);">프로필</a></li>
		                <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#setting_menu" onclick="changeSettingMode(this);">대시보드 설정</a></li>
		            </ul>
		            <div class="tab-content p-l-0 p-r-0">
			            <div class="tab-pane animated fadeIn active" id="profile_menu" style="height:47vh;">
	                        <div class="body text-center">
								<div class="profile-image m-b-15" id="userPictureDiv" style="height: 250px; width: 75%; border-radius: 50%;"></div>

								<div class="profile-image m-b-15" id="userPictureDiv" style="height: 12em; width: 70%;"></div>
	                            
	                            <div style="margin-top:25px;">
	                                <h4 class="m-b-0" style="margin: 10px;">
	                                   <strong>&nbsp;</strong>
	                                </h4>
			                                <span style="font-size:1.5em;"></span>
			                                <span style="font-size:1.5em;"></span>
	                            </div>
	                            <div class="m-t-15" style="font-size:1.1em;">
	                               <div>
	                               		결재할 문서 :  &nbsp;
	                               		<a href="<%=request.getContextPath() %>/approval/lists/waitList">
	                               			<i class="icon-share-alt"></i>
	                               		</a>
	                               </div>
	                               
	                               <div id="scheduleFormDiv">
	                               		오늘의 일정 :  &nbsp;
	                               		<a href="<%=request.getContextPath() %>/schedule/main?from=home">
		                               		<i class="icon-share-alt"></i>
	                               		</a>
	                               </div>
	                            </div>                            
	                        </div>
	                    </div>
	                    
	                    <div class="tab-pane animated fadeIn" id="setting_menu" style="height:47vh;padding:0 15px;">
	                    	<h5 style="display:inline-block;">개인 대시보드 설정</h5>
	                    	<a data-toggle="popover" data-trigger="hover" data-placement="left" data-html="true" data-content="내 대시보드에 표시할 항목을 3개까지 선택할 수 있습니다.<br/>선택한 항목이 3개 이하일 경우 기본값으로 설정됩니다." style="cursor:pointer;font-family: InfinitySans-RegularA1" data-original-title="" title="">
								<i class="fa fa-question-circle" style="font-size: 1.5em;margin-left:5px;"></i>
							</a>
							
							<!-- 대시보드 설정화면 -->
							<div style="margin-top:10px;">
								<h6>업무관리</h6>
								<label class="fancy-checkbox">
		                            <input type="checkbox" class="dashboardEl" name="dashboardDuty" >
		                            <span>업무제안 목록</span>
		                        </label>
								<label class="fancy-checkbox">
		                            <input type="checkbox" class="dashboardEl defaultDashboard" name="dashboardIssue" >
		                            <span>업무이슈 목록</span>
		                        </label>
								<label class="fancy-checkbox">
		                            <input type="checkbox" class="dashboardEl" name="dashboardProject" >
		                            <span>프로젝트 관리</span>
		                        </label>
							</div>
							<div style="margin-top:10px;">
								<h6>전자결재</h6>
								<label class="fancy-checkbox">
		                            <input type="checkbox" class="dashboardEl" name="dashboardApproval" >
		                            <span>결재대기문서 | 기안문서</span>
		                        </label>
							</div>
							<div style="margin-top:10px;">
								<h6>시설예약</h6>
								<label class="fancy-checkbox">
		                            <input type="checkbox" class="dashboardEl defaultDashboard" name="dashboardReservation">
		                            <span>회의실 예약 현황</span>
		                        </label>
							</div>
							<div style="margin-top:10px;">
								<h6>게시판</h6>
								<label class="fancy-checkbox">
		                            <input type="checkbox" class="dashboardEl defaultDashboard" name="dashboardBoard" >
		                            <span>사내공지 | 경조사</span>
		                        </label>
							</div>
							<button type="button" class="btn btn-primary" style="width:100%;margin-top:15px;" onclick="saveDashboard(this);">저장</button>
	                    </div>
                    </div>
               </div>
               
               <div class="card" style="font-family: S-CoreDream-4Regular">
                  <div class="head text-center" style="margin-top: 20px;">
                     <h2>근태관리</h2>
                     <span></span>
                     <h4 style="margin-top: 10px;"><i class="fa  fa-clock-o fa-1x"></i> 근무 시간</h4>
                     <div class="body" style="margin: 0;padding: 0;">
                         <div class="content" style="text-align: center;">
                            <div><h3 class=" align-center" style="font-size:2.3em;  color:#3672ff; font-family: S-CoreDream-6Bold" id="worked"></h3></div>
                            <small style="color: red;" id="endWorked"></small>
                         </div>
                     </div>
                     
                  </div>
                        <div class="body">
                            <div class="text-center">
                                <h4 class="m-b-0">
                                   <strong></strong>
                                </h4>
                            </div>
                            <div class="m-t-25">
                               <div class="row clearfix">
                           <div class="col-lg-6" id="startWork">
                               <button onclick="insertStartWork(this);" type="button" class="btn btn-primary" style="width: 100%;"><i class="fa fa-check-circle"></i>출근하기</button>
                           </div>
                           <div class="col-lg-6" id="endWork">
                               <button onclick="insertEndWork(this);" type="button" class="btn btn-secondary" style="width: 100%;"><i class="fa fa-home"></i>퇴근하기</button>
                           </div>
                        </div>
                            </div>                            
                       <div class="m-t-15"  style="font-family: GoyangDeogyang;">
                        <div class="row clearfix" style="margin-bottom: 5px; ">
                           <div class="col-lg-6">
                              <span>출근시간</span>
                           </div>
                           <div class="col-lg-6">
                                 <span></span>
                                 <span>미등록</span>
                           </div>
                        </div>
                        <div class="row clearfix" style="margin-bottom: 5px;">
                           <div class="col-lg-6">
                              <span>퇴근시간</span>
                           </div>
                           <div class="col-lg-6">
                                 <span></span>
                                 <span>미등록</span>
                           </div>
                        </div>
                        <div class="row clearfix" style="margin-bottom: 30px;">
                           <div class="col-lg-6">
                              <span>필요근무시간</span>
                           </div>
                           <div class="col-lg-6 attendTime" >
                                 <span id="weeklyDefferTime" value="${attendenceVO.weeklyAttendMilliSec}"></span><span> </span>
                                 <span id="weeklyDefferTime" value="${attendenceVO.weeklyAttendMilliSec}">0시간 0분</span>&nbsp;<span></span>
                                 <br><span class="badge badge-info" style="margin: 0;">초과근무 중</span><br><span class="excessTime"></span>
                           </div>
                        </div>
                            </div>                            
                        </div>
               </div>
               
               <div class="card text-center" style="font-family: GoyangIlsan">
                  <h2 style="margin-top: 20px;">오늘날씨</h2>
                  <div class="head text-center" style="margin-top: 20px; margin-bottom: 20px;">
                     <div class = 'weather'>
                         <div class="CurrIcon"></div> 
                         <div class="CurrTemp"></div>
                         <div class="City" style="font-size: 27px;"></div>
                     </div>
                  </div>
               </div>
            </div>
            
         <!-- 왼쪽줄 끝 -->   
            
         <!-- 가운데줄 시작 -->
            <div class="col-7" style="padding:0px;">
            <div class="dd dd4">
	            <ol class="dd-list">
					<li class="dd-item" id="dashboardBoard" data-order="" >
		               <div class="card">
		                  <div class="header" style="padding-bottom:0px;font-family: GoyangIlsan ">
		                          <h3 style="display:inline-block;">
		                              게시판
		                          </h3>
		                          <span class="dd-handle" style="display:none;font-size:1.5em;cursor:pointer;float:right;color: gray;padding: 0px;background-color: white;line-height: 0;height: auto;margin:0px;"><i class="icon-cursor-move"></i></span>
		                        </div>
		                           <div class="body">
		                               <div class="row clearfix">
		                           <div class="col-6" style="font-family: S-CoreDream-4Regular">
		                              <div class="head">
		                                 <h5>
		                                    사내공지
		                                    <span class="float-right" style="cursor: pointer;" onclick="location.href='<%=request.getContextPath()%>/board/notice/list'">
		                                            <i class="fa fa-sign-in"></i>
		                                         </span>
		                                 </h5>
		                              </div>
		                               <div class="table-responsive" style="overflow:hidden;">
		                                         <table class="table table-hover m-b-0 c_list">
		                                             <thead>
		                                                 <tr>
		                                                     <th>게시날짜</th>
		                                                     <th>제목</th>
		                                                     <th>작성자</th>
		                                                     <th>조회수</th>
		                                                 </tr>
		                                             </thead>
		                                             <tbody style="cursor: pointer;">
		                                                         <tr onclick="OpenWindow('<%=request.getContextPath()%>/board/notice/detail?noticeId=${notice.noticeId }', '글 상세보기', 800, 700);">
		                                                              <td></td>
		                                                                    <td><span style="display: inline-block;font-weight: bold;max-width: 155px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;"><span class="badge badge-danger">필독</span></span></td>
		                                                         <td><span style="display: inline-block;font-weight: bold;max-width: 155px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;"></span></td>
		                                                              <td><span>&nbsp;</span></td>
		                                                              <td><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></td>
		                                                          </tr>
		                                                
		                                                   <tr>
		                                                        <td colspan="6" style="text-align: center;"><strong>해당 공지가 존재하지 않습니다.</strong></td>
		                                                    </tr>
		                                             </tbody>
		                                         </table>
		                                     </div>
		                           </div>
		                           <div class="col-6"  style="font-family: S-CoreDream-4Regular">
		                              <div class="head">
		                                 <h5>
		                                    경조사
		                                    <span class="float-right" style="cursor: pointer;" onclick="location.href='<%=request.getContextPath()%>/board/cac/list'">
		                                            <i class="fa fa-sign-in"></i>
		                                         </span>
		                                 </h5>
		                              </div>
		                               <div class="table-responsive" style="overflow: hidden;">
		                                         <table class="table table-hover m-b-0 c_list">
		                                             <thead>
		                                                 <tr>
		                                                     <th>분류</th>
		                                                     <th>제목</th>
		                                                     <th>시작 날짜</th>
		                                                     <th>종료 날짜</th>
		                                                     <th>작성자</th>
		                                                 </tr>
		                                             </thead>
		                                             <tbody style="cursor: pointer;">
		                                                         <tr onclick="OpenWindow('<%=request.getContextPath()%>/board/cac/detail?cacBoardId=${cac.cacBoardId }', '글 상세보기', 950, 850);">
		                                                                    <td><span class="badge badge-dark">부고</span></td>
		                                                                    <td><span class="badge badge-warning">결혼</span></td>
		                                                                    <td><span class="badge badge-secondary">기타</span></td>
		                                                              <td><span style="display: inline-block;font-weight: bold;max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;"></span></td>
		                                                              <td></td>
		                                                              <td></td>
		                                                              <td><span>&nbsp;</span></td>
		                                                          </tr>
		                                             
		                                                   <tr>
		                                                        <td colspan="6" style="text-align: center;"><strong>해당 결재문서가 존재하지 않습니다.</strong></td>
		                                                    </tr>
		                                             </tbody>
		                                         </table>
		                                     </div>
			                           </div>
			                         </div>
			                               
		                           </div>
		                       </div>
					        </li>

					<li class="dd-item" id="dashboardDuty" data-order="">
                       <div class="card">
                       <div class="header"  style="padding-bottom:0px;font-family: GoyangIlsan">
                          <h3 style="display: inline-block;">
                             업무제안 목록
                          </h3>
                          <span class="dd-handle" style="display:none;font-size:1.5em;cursor:pointer;float:right;color: gray;padding: 0px;background-color: white;line-height: 0;height: auto;margin:0px;"><i class="icon-cursor-move"></i></span>
                          <span style="cursor: pointer;font-size: 1.8em;vertical-align: middle;margin-left: 5px;" onclick="location.href='<%=request.getContextPath()%>/board/duty/list'">
                             <i class="fa fa-sign-in"></i>
                          </span>
                        </div>
                           <div class="body" style="padding-top:10px;font-family: S-CoreDream-4Regular">
                               <div class="table-responsive">
                                      <table class="table table-hover m-b-0 c_list">
                                       <thead>
                                           <tr>
                                               <th>업무번호</th>
                                               <th>업무제목</th>
                                               <th>완료 기한</th>
                                               <th>진행 상태</th>
                                               <th>팀장</th>
                                               <th>담당자</th>
                                           </tr>
                                       </thead>
                                       <tbody style="cursor: pointer;">
                                                   <tr role="row" onclick="OpenWindow('<%=request.getContextPath()%>/board/duty/detail?dutyBoardId=${duty.dutyBoardId }', 'WorkConGW', 1000, 700);">
                                                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                                        <td class="project-title sorting_1">
                                                            <h6 style="display:inline-block;font-weight: bold;max-width: 400px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;margin-bottom:3px;"></h6>
                                                               <i class="icon-bubble text-info" style="margin-left:5px; font-weight: bold"><span class="m-l-5" style="font-weight: bold;"></span></i>
                                                            <br>
                                                            <span>
                                                            </span>
                                                        </td>
                                                        <td>
				                                    
	                                                  		<span class="badge badge-danger">마감임박</span>
                                                         
                                                        </td>
                                                        <td>
                                                                 <span class="badge badge-success">진행중</span>
                                                                 <span class="badge badge-danger">종료</span>
                                                        </td>
                                                        <td>
                                                           <div class="dutyEmpImg" value="${duty.empId}" data-toggle="tooltip" data-placement="top" title="" data-original-title="${duty.empName }" style="width: 40px;height: 40px; border-radius: 50%; display: inline-block; margin: 0;padding: 0;"></div>
                                                        </td>
                                                        <td>
                                                           			<div class="dutyManagerEmpImg" value="${dutyManager.empId}" data-toggle="tooltip" data-placement="top" title="" data-original-title="${dutyManager.empName }" style="width: 40px;height: 40px; border-radius: 50%; display: inline-block; margin: 0;padding: 0;"></div>
                                                            		<div style="width: 40px; border-radius: 50%; display: inline-block; margin: 0;padding: 0;">외 명</div>
                                                        </td>
                                                    </tr>
                                       
                                       
                                             <tr>
                                                  <td colspan="6" style="text-align: center;"><strong>해당 업무게시물이 존재하지 않습니다.</strong></td>
                                              </tr>
                                       </tbody>
                                   </table>
                               </div>
                           </div>
                       </div>
					</li>
					<li class="dd-item" id="dashboardReservation" data-order="">
                       <div class="card">
                       <div class="header" style="padding-bottom:0px;font-family: GoyangIlsan">
                          <h3 style="display:inline-block;">
                             회의실 예약 현황
                          </h3>
                          <span class="dd-handle" style="display:none;font-size:1.5em;cursor:pointer;float:right;color: gray;padding: 0px;background-color: white;line-height: 0;height: auto;margin:0px;"><i class="icon-cursor-move"></i></span>
                          <span style="cursor: pointer;font-size: 1.8em;vertical-align: middle;margin-left: 5px;" onclick="location.href='<%=request.getContextPath()%>/reservation/reservationList'">
                             <i class="fa fa-sign-in"></i>
                          </span>
                        </div>
                        <div class="body" style="padding-top:10px;font-family: S-CoreDream-4Regular">
                        	<h5 id="today" style="margin-left: 50px;margin-bottom: 20px;"></h5>
                        	<i class="fa fa-angle-left fa-4x" style="position:absolute;left:20px;top:170px;cursor: pointer;" onclick="prevTime();"></i>
                        	<i class="fa fa-angle-right fa-4x" style="position:absolute;right:20px;top:170px;cursor: pointer;" onclick="nextTime();"></i>
                        	<div style="width: calc(100% - 80px); overflow: hidden; margin: 0 40px;">
	                            <ul id="meetroomReservationTime" style="padding:0px;width:2420px;">
		                                <li style="display:inline-block;width:220px;border: 1px solid rgb(0,0,0,0.2);border-radius:15px;padding: 10px;height: 20vh;">
		                                    <h5>00</h5>
		                                    <div class="reservationList" style="height:15vh;overflow-y: auto;">
			                                    
		                                    </div>
		                                </li>
	                            </ul>						
                        	</div>
	                    </div>
							                        
                       </div>
					</li>
					<li class="dd-item" id="dashboardIssue" data-order="">
                       <div class="card">
	                       <div class="header" style="padding-bottom:0px;font-family: GoyangIlsan">
	                          <h3 style="display:inline-block;">
	                             업무이슈 목록
	                          </h3>
	                          <span class="dd-handle" style="display:none;font-size:1.5em;cursor:pointer;float:right;color: gray;padding: 0px;background-color: white;line-height: 0;height: auto;margin:0px;"><i class="icon-cursor-move"></i></span>
	                          <span style="cursor: pointer;font-size: 1.8em;vertical-align: middle;margin-left: 5px;" onclick="location.href='<%=request.getContextPath()%>/board/issue/list'">
	                             <i class="fa fa-sign-in"></i>
	                          </span>
	                        </div>
	                       <div class="row clearfix" style="margin:10px;">
		                       <div class="col-lg-6 col-md-6" style="padding:10px 20px;font-family: S-CoreDream-4Regular">
	                               <div class="table-responsive">
			                        	<ul class="nav nav-tabs" style="position:absolute;width:93%;z-index: 10;">
							                <li class="nav-item" style="cursor:pointer;"><a class="nav-link active" data-toggle="tab" href="#openIssueList"><i class="icon-info"></i> Open</a></li>
							                <li class="nav-item" style="cursor:pointer;"><a class="nav-link" data-toggle="tab" href="#closedIssueList"><i class="fa fa-check"></i> Closed</a></li>
							            </ul>
							            <div class="tab-content p-l-0 p-r-0 p-t-0">
							            	<!-- Open 이슈 -->
							                <div class="tab-pane animated fadeIn active" id="openIssueList">
				                                <table class="table table-hover js-basic-example table-custom m-b-0 no-footer" role="grid">
				                                	<thead>
				                                		<tr>
				                                			<th style="width:60%;"></th>
				                                			<th style="width:40%;">작성자</th>
				                                		</tr>
				                                	</thead>
				                                    <tbody style="border:hidden;">
								                                    <tr role="row" class="issueList" style="cursor: pointer;" data-id="" onclick="showIssueHistory(this);">
							                                            <td class="project-title" style="padding:15px;">
							                                            	<div>
								                                                <h6 style="display:inline-block;font-weight: bold;max-width: 200px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;">
								                                                	<i class="icon-info" style="color:green;"></i>
								                                                	<span class="issueTitle" style="cursor:pointer;margin-left:5px;font-size:1.1em;" onclick="OpenWindow('${pageContext.request.contextPath }/board/issue/detail?issueBoardId=${issue.issueBoardId }', '이슈 상세보기', 1200, 700);"></span>
								                                                </h6>
									                                            	<i class="icon-bubble" style="margin-left:5px;"></i> 
							                                            	</div>
							                                                <span style="margin-left:25px;"></span>
							                                                <span style="margin-left:5px;"></span>
							                                            </td>
							                                            <td class="project-actions">
							                                            			<div id="pictureView" style="display:inline-block;vertical-align:middle;margin-right:10px;width: 45px; height: 45px;" class="rounded-circle avatar" data-toggle="tooltip" data-placement="top" data-original-title=""></div>
							                                            			<div style="display:inline-block;vertical-align:middle;">
														                                <strong></strong>
														                                <div> <span></span></div>
														                            </div>
							                                            </td>
							                                        </tr>
					                                        
				                                    	<!-- 목록이 없을때 -->
				                                    		<tr role="row">
					                                            <td class="project-title noList" style="text-align:center;font-size:1.2em;font-weight: bold;height:80px;" colspan="2">등록된 이슈가 없습니다.</td>
				                                            </tr>
			                                        </tbody>
				                                </table>
							                </div>
							                
							                <!-- Closed 이슈 -->
							                <div class="tab-pane animated fadeIn" id="closedIssueList">
				                                <table class="table table-hover js-basic-example table-custom m-b-0 no-footer" role="grid">
				                                	<thead>
				                                		<tr>
				                                			<th style="width:60%;"></th>
				                                			<th style="width:40%;">작성자</th>
				                                		</tr>
				                                	</thead>
				                                    <tbody style="border:hidden;">
								                                    <tr role="row" class="issueList" style="cursor: pointer;" data-id="${issue.issueBoardId }" onclick="showIssueHistory(this);">
							                                            <td class="project-title" style="padding:15px;">
							                                            	<div>
								                                                <h6 style="display:inline-block;font-weight: bold;max-width: 200px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;">
								                                                	<i class="icon-check" style="color:red;"></i>
								                                                	<span class="issueTitle" style="cursor:pointer;margin-left:5px;font-size:1.1em;" onclick="OpenWindow('${pageContext.request.contextPath }/board/issue/detail?issueBoardId=${issue.issueBoardId }', '이슈 상세보기', 1200, 700);"></span>
								                                                </h6>
									                                            	<i class="icon-bubble" style="margin-left:5px;"></i> 
							                                            	</div>
							                                                <span style="margin-left:25px;"></span>
							                                                <span style="margin-left:5px;"></span>
							                                            </td>
							                                            <td class="project-actions">
							                                            			<div id="pictureView" style="display:inline-block;vertical-align:middle;margin-right:10px; width: 45px; height: 45px;" class="rounded-circle avatar" data-toggle="tooltip" data-placement="top" data-original-title=""></div>
							                                            			<div style="display:inline-block;vertical-align:middle;">
														                                <strong></strong>
														                                <div> <span></span></div>
														                            </div>
							                                            </td>
							                                        </tr>
					                                        
				                                    	<!-- 목록이 없을때 -->
				                                    		<tr role="row">
					                                            <td class="project-title noList" style="text-align:center;font-size:1.2em;font-weight: bold;height:80px;" colspan="2">등록된 이슈가 없습니다.</td>
				                                            </tr>
			                                        </tbody>
				                                </table>
							                </div>
							            </div>
			                        </div>
		                       </div>
		                       <div class="col-lg-6 col-md-6 issueHistory" style="padding:10px 20px;font-family: S-CoreDream-4Regular">
		                       		<div style="text-align:center;margin-top:150px;font-size:1.3em;">
			                       		<strong>히스토리를 조회할 이슈를 선택하세요.</strong>
		                       		</div>
		                       		<!-- 히스토리 뷰 -->
		                       </div>
	                       </div>
                       </div>
					</li>
					<li class="dd-item" id="dashboardProject" data-order="">
                       <div class="card">
                       <div class="header" style="padding-bottom:0px;font-family: GoyangIlsan">
                          <h3 style="display:inline-block;">
                             프로젝트 관리
                          </h3>
                          <span class="dd-handle" style="display:none;font-size:1.5em;cursor:pointer;float:right;color: gray;padding: 0px;background-color: white;line-height: 0;height: auto;margin:0px;"><i class="icon-cursor-move"></i></span>
                          <span style="cursor: pointer;font-size: 1.8em;vertical-align: middle;margin-left: 5px;" onclick="location.href='<%=request.getContextPath()%>/board/project'">
                             <i class="fa fa-sign-in"></i>
                          </span>
                        </div>
                           <div class="body" style="padding:0 30px;font-family: S-CoreDream-4Regular">
		                   		<div class="progress-container m-t-10">
		                           <div class="progress progress-xs" style="height:15px;background-color:rgb(0,0,0,0.2);text-align: center;display: block;">
                                        <div class="progress-bar" role="progressbar" aria-valuenow="86" aria-valuemin="0" aria-valuemax="100" style="width: 86%; height: 15px; border-radius: 2px;">
		                               </div>
		                               <span id="percentage" style="color: white;font-size: 1.1em;line-height: 1.2em;position: absolute;top:71px;"></span>
		                           </div>
		                       	</div>
                           </div>
                           
                           <div>
                           		<div class="row clearfix" style="margin:10px; padding-bottom:10px; font-family:S-CoreDream-4Regular ">
			                    	<div class="top_counter col-lg-4 col-md-6" style="border-right: 1px solid rgb(0,0,0,0.2);">
			                    		<div style="height:40vh;">
					                        <div class="body" style="padding:10px;">
				                                <h5 style="display:inline-block;">해야할 일</h5>
					                        	<span style="font-size:1.3em;margin-left:5px;"></span>
					                        </div>    
					                        <div style="height: 33vh;overflow-y: auto;padding: 0 10px;">
				                                        <div class="card" style="height:70vh;padding:10px 20px;height:auto;color:black;border:1px solid rgb(0,0,0,0.2);">
			                                            	<div style="margin-bottom: -15px;">
				                                                <h6 style="display:inline-block;font-weight: bold;max-width:100%; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;">
					                                                	<i class="icon-info" style="color:green;"></i>
					                                                	<i class="icon-check" style="color:red;"></i>
				                                                	<span class="issueTitle" style="font-size:1.1em;cursor:pointer;" onclick="OpenWindow('${pageContext.request.contextPath }/board/issue/detail?issueBoardId=${issue.issueBoardId}', '이슈 상세보기',1200,900);"></span>
				                                                </h6>
					                                                <span class="btn btn-secondary" style="height:auto;padding: 0px 3px;font-size:0.8em;margin-left:5px;margin-top: -10px;"></span>
			                                            	</div>
			                                            	<div style="margin-top:8px;margin-left:5px;">
				                                                <span></span>
				                                                <span style="margin-left:5px;"></span>
			                                            	</div>
				                                        </div>
						                    		<div style="text-align: center;padding:20px;">
						                    			<strong style="font-size:1.2em;">이슈가 없습니다.</strong>
						                    		</div>
					                        </div>
			                    		</div>
				                    </div>
			                    	<div class="top_counter col-lg-4 col-md-6" style="border-right: 1px solid rgb(0,0,0,0.2);">
			                    		<div style="height:40vh;">
					                        <div class="body" style="padding:10px;">
				                                <h5 style="display:inline-block;">진행중</h5>
					                        	<span style="font-size:1.3em;margin-left:5px;"></span>
					                        </div>    
					                        <div style="height: 33vh;overflow-y: auto;padding: 0 10px;">
				                                        <div class="card" style="height:70vh;padding:10px 20px;height:auto;color:black;border:1px solid rgb(0,0,0,0.2);">
			                                            	<div style="margin-bottom: -15px;">
				                                                <h6 style="display:inline-block;font-weight: bold;max-width:100%; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;">
					                                                	<i class="icon-info" style="color:green;"></i>
					                                                	<i class="icon-check" style="color:red;"></i>
				                                                	<span class="issueTitle" style="font-size:1.1em;cursor: pointer;" onclick="OpenWindow('${pageContext.request.contextPath }/board/issue/detail?issueBoardId=${issue.issueBoardId}', '이슈 상세보기',1200,900);"></span>
				                                                </h6>
					                                                <span class="btn btn-secondary" style="height:auto;padding: 0px 3px;font-size:0.8em;margin-left:5px;margin-top: -10px;"></span>
			                                            	</div>
			                                            	<div style="margin-top:8px;margin-left:5px;">
				                                                <span></span>
				                                                <span style="margin-left:5px;"></span>
			                                            	</div>
				                                        </div>
					                    			<div style="text-align: center;padding:20px;">
						                    			<strong style="font-size:1.2em;">이슈가 없습니다.</strong>
						                    		</div>
					                        </div>
			                    		</div>
				                    </div>
			                    	<div class="top_counter col-lg-4 col-md-6">
			                    		<div style="height:40vh;">
					                        <div class="body" style="padding:10px;">
				                                <h5 style="display:inline-block;">완료</h5>
					                        	<span style="font-size:1.3em;margin-left:5px;"></span>
					                        </div>    
					                        <div style="height: 33vh;overflow-y: auto;padding: 0 10px;">
				                                        <div class="card" style="height:70vh;padding:10px 20px;height:auto;color:black;border:1px solid rgb(0,0,0,0.2);">
			                                            	<div style="margin-bottom: -15px;">
				                                                <h6 style="display:inline-block;font-weight: bold;max-width:100%; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;">
					                                                	<i class="icon-info" style="color:green;"></i>
					                                                	<i class="icon-check" style="color:red;"></i>
				                                                	<span class="issueTitle" style="font-size:1.1em;cursor: pointer;" onclick="OpenWindow('${pageContext.request.contextPath }/board/issue/detail?issueBoardId=${issue.issueBoardId}', '이슈 상세보기',1200,900);"></span>
				                                                </h6>
					                                                <span class="btn btn-secondary" style="height:auto;padding: 0px 3px;font-size:0.8em;margin-left:5px;margin-top: -10px;"></span>
			                                            	</div>
			                                            	<div style="margin-top:8px;margin-left:5px;">
				                                                <span></span>
				                                                <span style="margin-left:5px;"></span>
			                                            	</div>
				                                        </div>
					                    			<div style="text-align: center;padding:20px;">
						                    			<strong style="font-size:1.2em;">이슈가 없습니다.</strong>
						                    		</div>
					                        </div>
			                    		</div>
				                    </div>
                        		</div>
                           </div>
                       </div>
					</li>
					
					<li class="dd-item" id="dashboardApproval" data-order="">
		               <div class="card">
		                  <div class="header" style="padding-bottom:0px;font-family: GoyangIlsan ">
		                          <h3 style="display:inline-block;">
		                             전자결재
		                          </h3>
		                          <span class="dd-handle" style="display:none;font-size:1.5em;cursor:pointer;float:right;color: gray;padding: 0px;background-color: white;line-height: 0;height: auto;margin:0px;"><i class="icon-cursor-move"></i></span>
		                        </div>
		                           <div class="body">
		                               <div class="row clearfix">
		                           <div class="col-6" style="font-family: S-CoreDream-4Regular">
		                              <div class="head">
		                                 <h5>
		                                    결재대기문서
		                                    <span class="float-right" style="cursor: pointer;" onclick="location.href='<%=request.getContextPath()%>/approval/lists/waitList'">
	                                            <i class="fa fa-sign-in"></i>
	                                         </span>
		                                 </h5>
		                              </div>
			                            <div class="table-responsive" style="overflow: hidden;">
			                                <table class="table table-hover m-b-0 c_list">
			                                    <thead>
			                                        <tr>
			                                            <th>상신날짜</th>
			                                            <th>사용 양식</th>
			                                            <th>기안서 제목</th>
			                                            <th>결재상태</th>
			                                        </tr>
			                                    </thead>
			                                    <tbody style="cursor: pointer;">
						                                        <tr onclick='OpenWindow("${pageContext.request.contextPath }/approval/waitDocDetail?docId=${doc.docId}", "결재문서" ,900,900);'>
						                                            <td></td>
						                                            <td><span style="display: inline-block;max-width: 80px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;"></span></td>
						                                            <td>
						                                            	<span class="text-info" style="display: inline-block;font-weight: bold;max-width: 120px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">
						                                            		
						                                            	</span>
					                                                  		&nbsp;<span class="badge badge-danger">방금전</span>
						                                            </td>
						                                            <td><span class="badge badge-primary">결재대기</span></td>
						                                        </tr>
				                                    	<tr>
				                                            <td colspan="4" style="text-align: center;"><strong>결재 대기문서가 존재하지 않습니다.</strong></td>
				                                        </tr>
			                                        
			                                    </tbody>
			                                </table>
			                            </div>
		                           </div>
		                           <div class="col-6"  style="font-family: S-CoreDream-4Regular">
		                              <div class="head">
		                                 <h5>
		                                    기안문서
		                                    <span class="float-right" style="cursor: pointer;" onclick="location.href='<%=request.getContextPath()%>/approval/lists/draftList'">
	                                            <i class="fa fa-sign-in"></i>
	                                         </span>
		                                 </h5>
		                              </div>
		                               <div class="table-responsive" style="overflow: hidden;">
		                                <table class="table table-hover m-b-0 c_list">
		                                    <thead>
		                                        <tr>
		                                            <th>상신날짜</th>
		                                            <th>사용 양식</th>
		                                            <th>기안서 제목</th>
		                                            <th>결재상태</th>
		                                        </tr>
		                                    </thead>
		                                    <tbody style="cursor: pointer;">
					                                        <tr onclick='OpenWindow("${pageContext.request.contextPath }/approval/completeDocDetail?docId=${doc.docId}", "결재문서" ,900,900);'>
					                                            <td></td>
					                                            <td><span style="display: inline-block;max-width: 80px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;"></span></td>
					                                            <td>
					                                            	<span class="text-info" style="display: inline-block;font-weight: bold;max-width: 120px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;"></span>
				                                                  		&nbsp;<span class="badge badge-danger">방금전</span>
					                                            </td>
					                                            	<td><span class="badge badge-success">결재진행중</span></td>
					                                            	<td><span class="badge badge-default">결재완료</span></td>
					                                            	<td><span class="badge-purple badge">결재반려</span></td>
					                                        </tr>
			                                    	<tr>
			                                            <td colspan="4" style="text-align: center;"><strong>해당 결재문서가 존재하지 않습니다.</strong></td>
			                                        </tr>
		                                    </tbody>
		                                </table>
		                            </div>
			                           </div>
			                         </div>
			                               
		                           </div>
		                       </div>
					</li>
	            </ol>
            </div>
            
                       
                       
                       
               </div>
               <!-- 가운데줄 끝 -->
               
               <!-- 오른쪽줄 시작 -->
               <div class="col-3">
                  <div class="card">
                           <div class="header"  style="padding-bottom:0px;font-family: GoyangIlsan">
                          <h5>
                             공지사항<span class="badge badge-danger" style="font-family: S-CoreDream-4Regular">필독</span>
                             <span class="float-right" style="cursor: pointer;" onclick="location.href='<%=request.getContextPath()%>/board/notice/list'">
                                <i class="fa fa-sign-in"></i>
                             </span>
                          </h5>
                        </div>
                           <div class="body" style="font-family: S-CoreDream-4Regular">
                               <div class="table-responsive" style="overflow-x: hidden;">
                                   <table class="table table-hover m-b-0 c_list">
                                       <thead>
                                           <tr>
                                               <th>날짜</th>
                                               <th>제목</th>
                                               <th>작성자</th>
                                           </tr>
                                       </thead>
                                       <tbody style="cursor: pointer;">
                                                   <tr onclick="OpenWindow('<%=request.getContextPath()%>/board/notice/detail?noticeId=${notice.noticeId }', '글 상세보기', 800, 700);">
                                                        <td></td>
                                                        <td><span style="display:inline-block;font-weight: bold;max-width: 130px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"></span></td>
                                                        <td><span>&nbsp;</span></td>
                                                    </tr>
                                       
                                             <tr>
                                                  <td colspan="6" style="text-align: center;"><strong>해당 공지사항이 존재하지 않습니다.</strong></td>
                                              </tr>
                                       </tbody>
                                   </table>
                               </div>
                           </div>
                  </div>
                  
                  <div class="card" style="height: 440px;">
                            <div class="header text-center" style="font-family: GoyangIlsan">
                               <h5 style="display: inline-block; margin-left: 100px;">일정관리</h5>
                               <span class="float-right" style="margin-right: 25px;"><i class="fa fa-circle" style="color: pink;"></i>일정표시</span>
                           </div>
                           <div id="calendar" style="margin: 0; padding: 0; font-family: GoyangDeogyang">
                           </div>
                  </div>
                  
                  <div class="card" style="font-family: S-CoreDream-4Regular">
                           <div class="body">
                              <div class="row clearfix list1">
                                    <div class="myShowHiddenDiv col-12">
                                       <span class="float-right">
                                          <span style="background-color: pink; border-radius: 50%;padding: 0 5px 0 5px; margin-right: 3px;" ></span>
                                          <span class="showHiddenBtn" style="cursor: pointer;"><i class="fa fa-plus"></i></span>
                                       </span>
                                    </div>
                              <div class="col-3 text-center">
                                 <span class="oneDate"></span>&nbsp;
                                 <span class="oneDayName"></span>
                                    </div>
                              <div class="col-9 scheduleList1">
                                       <div class="hiddenSchedule" style="display: none;">
                                          <strong style="display: inline-block;font-weight: bold;max-width: 240px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;"><i class="fa fa-check-circle"></i></strong><br>
                                          <span>
                                        
                                          </span><br>
                                       </div>   
                                       <div>
                                          <strong style="display: inline-block;font-weight: bold;max-width: 240px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;"><i class="fa fa-check-circle"></i></strong><br>
                                          <span>
                                             
                                          </span><br><br>
                                       </div>
                                          <tr>
                                               <td colspan="6" style="text-align: center;"><strong>해당 일정이 존재하지 않습니다.</strong></td>
                                           </tr>
                                    </div>
                              </div>
                           </div>
                  </div>
                  
                  <div class="card" style="font-family: S-CoreDream-4Regular">
                           <div class="body ">
                              <div class="row clearfix list2">
                                 <div class="myShowHiddenDiv col-12">
                                    <span class="float-right">
                                       <span style="background-color: pink; border-radius: 50%;padding: 0 5px 0 5px; margin-right: 3px;" ></span>
                                       <span class="showHiddenBtn" style="cursor: pointer;"><i class="fa fa-plus"></i></span>
                                    </span>
                                 </div>
                              
                           <div class="col-3 text-center">
                              <span class="twoDate"></span>&nbsp;
                              <span class="twoDayName"></span>
                                 </div>
                           <div class="col-9 scheduleList2" >
                                       <i class="fa fa-sort-desc moreSchedule"></i>
                                       <div class="hiddenSchedule" style="display: none;">
                                          <strong style="display: inline-block;font-weight: bold;max-width: 240px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;"><i class="fa fa-check-circle"></i></strong><br>
                                          <span>

                                          </span><br>
                                       </div>   
                                       <div>
                                          <strong style="display: inline-block;font-weight: bold;max-width: 240px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;"><i class="fa fa-check-circle"></i></strong><br>
                                          <span>
                                             
                                          </span><br><br>
                                       </div>
                                          <tr>
                                               <td colspan="6" style="text-align: center;"><strong>해당 일정이 존재하지 않습니다.</strong></td>
                                           </tr>
                                 </div>
                              </div>
                           </div>
                  </div>
                  
                  <div class="card"  style="font-family: S-CoreDream-4Regular">
                           <div class="body ">
                              <div class="row clearfix list3">
                                 <div class="myShowHiddenDiv col-12">
                                    <span class="float-right">
                                       <span style="background-color: pink; border-radius: 50%;padding: 0 5px 0 5px; margin-right: 3px;" ></span>
                                       <span class="showHiddenBtn" style="cursor: pointer;"><i class="fa fa-plus"></i></span>
                                    </span>
                                 </div>
                              
                           <div class="col-3 text-center">
                              <span class="threeDate"></span>&nbsp;
                              <span class="threeDayName"></span>
                                 </div>
                           <div class="col-9 scheduleList3">
                                       <i class="fa fa-sort-desc moreSchedule"></i>
                                       <div class="hiddenSchedule" style="display: none;">
                                          <strong style="display: inline-block;font-weight: bold;max-width: 240px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;"><i class="fa fa-check-circle"></i></strong><br>
                                          <span>
                                            
                                          </span><br>
                                       </div>   
                                       <div>
                                          <strong style="display: inline-block;font-weight: bold;max-width: 240px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;"><i class="fa fa-check-circle"></i></strong><br>
                                          <span>
                                            
                                          </span><br><br>
                                       </div>
                                          <tr>
                                               <td colspan="6" style="text-align: center;"><strong>해당 일정이 존재하지 않습니다.</strong></td>
                                           </tr>
                                 </div>
                              </div>
                           </div>
                  </div>
               </div>
               <!-- 오른쪽줄 끝 -->
               
         </div>
      
     </div>
</div>

<form name="dashboardForm">
</form>


<%@ include file="./include/footer.jsp"%>
</body>

<script>
	window.onload = function(){
		// 대시보드 순서 변경
		let orderList = new Array();
		$('.dd-item').each(function(){
			if($(this).css('display') != 'none'){
				let dashboardVO = {};
				let id = $(this).attr('id');
				let order = $(this).attr('data-order');
				dashboardVO.id = id;
				dashboardVO.order = order;
				orderList.push(dashboardVO);
			}
		});
		// 정렬
		let sortingField = "order";
		orderList.sort(function(a, b) { // 오름차순
			return a[sortingField] - b[sortingField];
		});
		// 재배치
		$('#'+orderList[1].id).insertAfter('#'+orderList[0].id);
		$('#'+orderList[2].id).insertAfter('#'+orderList[1].id);
		
		// 회의실 예약 현황 현재 날짜 표시
		let now = new Date();
		let month = (now.getMonth()+1).toString().length == 1 ? '0'+ (now.getMonth()+1) : (now.getMonth()+1) ;
		let date = now.getDate().toString().length == 1 ? '0'+now.getDate() : now.getDate();
		let day = now.getDay();
		let dayArr = ['일','월','화','수','목','금','토'];
		$('#today').text(month+'/'+date+' '+dayArr[day]+'요일');
		
	
		
	   $(".fc-day-number").removeAttr("data-goto");
	   getTime();
	   showStaus();//페이지 켜질때 근무시간 계산시작하게하기
	   
	   // 대시보드 설정 변경시
	   $('.dashboardEl').change(function(){
		  if($(this).is(':checked')){
			  $('#'+$(this).attr('name')).css('display','');
		  }else{
			  $('#'+$(this).attr('name')).css('display','none');
		  }
	   });
	}
	
	
	
	</script>
	<!-- 근태 -->
	<script>
	function setNowDate() {
		 tellMonth();
		 getAttendence();
	}
	
	/*근무 시간을 밀리세컨즈로 가져온다*/
	let workStartTime =  Date();
	function showStaus(){
		  $.ajax({
			 url : "<%=request.getContextPath()%>/attend/getStartTime",
			 type : "get",
			 success : function (data) {
				 let millis = parseInt(data.milllis)
				 let endMillis = data.endMilllis;
				 if ('N'!== endMillis) {
					 parseInt(endMillis);
				 }
				 sessionStorage.setItem("endMillis", endMillis);
				 sessionStorage.setItem("millis", millis);
			 },
			 error : function (data) {
			 }
		 });
	}
	
	/*받은 밀리세컨즈를 조건에 맞게 계산해서 시간으로 출력*/
	setInterval(getTime, 1000);
	
	function getTime(){
	  let mill = sessionStorage.getItem("millis");
	  let endMillis = sessionStorage.getItem("endMillis");
		if (endMillis ==='N' && mill > 0) {
			let time = ((Date.now() - mill)/1000);
			let hour = dateFormat(Math.floor(time/3600));
			let minute = dateFormat(Math.floor(time%3600/60));
			let second = dateFormat(Math.floor(time%3600%60));
			$('#worked').text(hour+":"+minute+":"+second);
		}else if(endMillis !=='N'){
			let time = ((endMillis - mill)/1000);
			let hour = dateFormat(Math.floor(time/3600));
			let minute = dateFormat(Math.floor(time%3600/60));
			let second = dateFormat(Math.floor(time%3600%60));
			$('#worked').text(hour+":"+minute+":"+second);
			$('#endWorked').text("근무중이 아닙니다");
		}else {
			$('#worked').text("00"+":"+"00"+":"+"00");
		}
	}
	function dateFormat(time){
	  return time < 10 ? "0"+time : time;
	}
	
	//출근
	/*근무 시간 입력*/
	function insertStartWork(obj){
	  $.ajax({
			 url : "<%=request.getContextPath()%>/attend/insertStartWork",
			 type : "get",
			 dataType:"text",
			 success : function (result) {
				 alert(result);
				 location.reload();
			 },
			 error : function (data) {
				 alert("실패");
			 }
		 });
		  
	}
	
	
	//퇴근
	/*퇴근시간 입력*/
	function insertEndWork(){
		 $.ajax({
			 url : "<%=request.getContextPath()%>/attend/insertEndWork",
			 type : "get",
			 success : function (data) {
				 alert("퇴근 시간이 입력되었습니다");
				 location.reload();
			 },
			 error : function (data) {
				 alert("실패");
			 }
		 });
	}
	
	// 대시보드 설정탭 클릭시
	function changeSettingMode(obj){
		if($(obj).attr('href') == '#setting_menu'){
			$('.dd-handle').css('display','');
		}else{
			$('.dd-handle').css('display','none');
		}
	}
	
	// 대시보드 설정 저장
	function saveDashboard(obj){
		if($('.dashboardEl:checked').length > 3){
			alert('대시보드에 표시할 항목은 최대 3개까지만 가능합니다.');
			return;
		}else if($('.dashboardEl:checked').length < 3){
			alert('선택된 항목이 3개 미만일 경우 기본값으로 설정됩니다.');
			
			let cnt = $('.dashboardEl:checked').length;
			$('.defaultDashboard').each(function(){
				if(cnt == 3) return false;
				if($(this).is(':checked') == false){
					$(this).prop('checked',true);
					$('#'+$(this).attr('name')).css('display','');
					cnt++;
				}
			});
		}
		$(obj).text(' 저장중..');
		$(obj).prepend($('<i class="fa fa-spinner fa-spin"></i>'));
		
		let form = $('form[name="dashboardForm"]');
		form.children().remove();
		
		let order = 1;
		$('.dd-item').each(function(){
			if($(this).css('display') != 'none'){
				let inputTag = $('<input>').attr({'type':'hidden','name':$(this).attr('id'),'value':order++});
			}else{
				let inputTag = $('<input>').attr({'type':'hidden','name':$(this).attr('id'),'value':''});
			}
			
			form.append(inputTag);
		});
		
		form.append($('<input>').attr({'type':'hidden','name':'emp_Id','value':'${loginUser.emp_Id}'}));
		
		$.ajax({
			url:'<c:url value="/common/saveDashboard"/>',
			type:'post',
			data:form.serialize(),
			success:function(){
				alert('설정이 저장되었습니다.');
				$(obj).text('저장');
			}
		});
	}
	
	

	
	
	let meetroomFlag = 0;
	let distance = 900;
	// 회의실 예약시간 이전버튼
	function prevTime(){
		let move = meetroomFlag == 2 ? distance : distance-500;
		if(meetroomFlag > 0){
			meetroomFlag--;
			$('#meetroomReservationTime').animate({
				marginLeft : $('#meetroomReservationTime').css('margin-left').split('px')[0]*1 + move+"px"
			});
		}
	}
	
	// 회의실 예약시간 다음버튼
	function nextTime(){
		let move = meetroomFlag == 0 ? distance : distance-500;
		if(meetroomFlag < 2){
			meetroomFlag++;
			$('#meetroomReservationTime').animate({
				marginLeft : $('#meetroomReservationTime').css('margin-left').split('px')[0]*1 - move+"px"
			});
		}
		
	}
	</script>