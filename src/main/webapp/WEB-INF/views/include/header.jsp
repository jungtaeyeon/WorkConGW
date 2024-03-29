<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="shortcut icon" href="${pageContext.request.contextPath }/resources/image/logo.ico">
	<title>:: WorkConGW ::</title>

	<style type="text/css">
		ul.menuList { 
			position: absolute;
			left: 50%;
			margin-left: -550px !important;
			height:70px;
			font-size:1.4em;
		}
		ul.menuList li {
			height:100%;
			padding:25px 15px 0px;
			text-align: center;
			color: white;
			font-weight: bold;
		}
		ul.menuList li:hover {
			background-color: #132029;
			cursor: pointer;
		}
		#navbar-menu{
			margin-right: 75px;
		}
		#usernameBox{
			position: relative;
		    right: -72px;
		    top: -41px;
		    color: #ffffff;
		    font-size: 1.2em;
		}
		.navbar-nav ul.notifications li{
			border-bottom: 1px solid rgb(0,0,0,0.1) !important;
		}
		.navbar-nav ul.notifications .alarm-list:hover {
			background-color: aliceblue;
		}
		#allAlarmList .media:hover {
			cursor: pointer;
			background-color: aliceblue;
		}
		span.deleteAlarmBtn{
			font-size:0.8em;
			cursor: pointer;
		}
		span.deleteAlarmBtn:hover {
			color:black;
		}
		.noAlarm:hover{
			cursor: default;
			background-color: white;
		}
		#pictureView{
			border-radius: 50%;
			border: 1px solid gray; 
			margin: 0px 20px 0px 0px;
			background-position: center;
			background-size: cover;
			background-repeat: no-repeat;
		}
		.theme-blue #wrapper:before, .theme-blue #wrapper:after, .theme-blue:before, .theme-blue:after{
			background: #449cff00;
			display: none;
		}
		.page-item.active .page-link{
		    z-index: 3;
		    color: #fff;
		    background-color: #2980b9;
		    border-color: #2980b9;
		}
		
		.nav-item.dropdown, #displayAndHiddenOrg, #hiddenMenu {
			position: fixed;
			bottom: 0px;
		}
		#displayAndHiddenOrg{
			border: 1px solid #2980b9;
			background-color: #2980b9;
			color: #ffffff;
			width: 13.4%;
			text-align: center;
			font-weight: bold;
			display: flex;
			justify-content: space-between;
		}
		#userPictureDiv{
			background-position: center;
			background-size: cover;
			background-repeat: no-repeat;
		    margin: auto;
		}
		.card{
			width: 100%;
			margin-bottom:10px;
		}
		div.dropdown-item:active, div.dropdown-item:hover{
			background-color: #007bff00;
			color: #000000;
		}
		ul#lvl0 li ul li:hover{
			background-color: #0000001a;
		}
		#hiddenMenu {
			width: 15.6em;
		}
		#emergencyCloseBtn{
			cursor: pointer;
		}
		#displayAndHiddenOrg{
			border: 1px solid #2980b9;
			background-color: #2980b9;
			color: #ffffff;
			text-align: center;
			font-weight: bold;
			display: flex;
			justify-content: space-between;
		}
		ul#lvl0 li ul li:hover {
		    background-color: white;
		}
		.btn-primary, .btn-primary:focus {
		    color: #fff;
		    background-color: #2980b9;
		    border-color: #2980b9;
	    }
		.btn-primary:hover{
		    background-color: rgb(54 159 223);
		    border-color: rgb(54 159 223);
		    box-shadow: 0 0 0 0px;
	    }
	    .btn.focus, .btn:focus{
		    box-shadow: 0 0 0 0px;
	    }
	    .commonModal-content{
	        width: 290px;
		    right: 89.4%;
		    margin-top: 60%;
	    }
	    .modal-backdrop.show {
		    opacity: .01;
		}
	</style>
</head>

<body class="theme-blue" style="min-width: 1400px;">
<a id="viewModal" href="#defaultModal" data-toggle="modal" data-target="#defaultModal" style="display: none;"></a>
<div id='backLayer' style='z-index: 5'></div>
<nav class="navbar navbar-fixed-top" style="min-width: 1400px; top:0px;">
    <div class="container-fluid" style="background-color:#0a1218;">
    	<!-- 로고 -->
        <div class="navbar-brand">
            <a href="${pageContext.request.contextPath }" style="color:white;font-weight: bold;"><span>WorkConGW</span></a>                
        </div>
        
        	<!-- 메뉴 -->
       		<ul class="nav navbar-nav menuList">
       			<li id="home" onclick="location.href='${pageContext.request.contextPath }/common/home';">홈</li>
             <!-- ========================================================================삭제예정 jqeury로 Ajax 처리 해야함==================================================================================== -->
             <!-- <li id="home" onclick="location.href='${pageContext.request.contextPath }/common/home';">업무관리</li>
             <li id="home" onclick="location.href='${pageContext.request.contextPath }/common/home';">전자결재</li>
             <li id="home" onclick="location.href='${pageContext.request.contextPath }/common/home';">주소록</li>
             <li id="home" onclick="location.href='${pageContext.request.contextPath }/common/home';">시설예약</li>
             <li id="home" onclick="location.href='${pageContext.request.contextPath }/common/home';">일정관리</li>
             <li id="home" onclick="location.href='${pageContext.request.contextPath }/common/home';">게시판</li>
             <li id="home" onclick="location.href='${pageContext.request.contextPath }/common/home';">근태관리</li>
             <li id="home" onclick="location.href='${pageContext.request.contextPath }/common/home';">문서관리</li>
             <li id="home" onclick="location.href='${pageContext.request.contextPath }/common/home';">조직도</li> -->
<!-- ====================================================================================삭제예정 jqeury로 Ajax 처리 해야함=========================================================================================== -->
            </ul>




          
            <div id="navbar-menu">
                <ul class="nav navbar-nav">                        

                    <!-- 메인메뉴 알림창 드롭다운 메뉴 -->
                    <li class="dropdown">
                    	<div id="dropdownDiv" data-toggle="dropdown"></div>
                        <a href="javascript:void(0);" onclick="updateAlarm('${pageContext.request.contextPath}','${loginUser.emp_Id }');">
                            <span style="color:white;">
                            	<i class="fa fa-bell fa-2x" aria-hidden="true" style="vertical-align: middle;"></i>
                            	<span id="alarmIcon" style="position:absolute;top:-8px;left:1rem;border-radius: 50%;background-color: red;width:20px;height:20px;color:white;text-align: center;font-size:small;display:none;">0</span>
                            </span>
                        </a>
                        <ul class="dropdown-menu notifications" style="background-color: white; font-family: GoyangIlsan">
                            <li class="header" style="padding-bottom:10px;" onclick="event.stopPropagation();">
                            	<div>
	                            	<strong style="color:black;">알림 센터</strong>
	                            	<i class="icon-settings" style="font-size: 1em;vertical-align: middle;margin-left: 5px;cursor: pointer;" onclick="showAlarmSetting('${pageContext.request.contextPath}');"></i>
	                            	<span style="font-size: 3em;float: right;cursor: pointer;width: 30px;line-height: 0.8;" onclick="document.body.click();">&times;</span>
                            	</div>
                            	<!-- 알림 온오프 설정 -->
                            	<div class="alarmSetting" style="padding:15px;display:none;">
                            		<strong>알림 켜기/끄기</strong>
                            		<button type="button" class="btn btn-primary" style="width: 45px;padding: 1px;margin-left:10px;" onclick="saveAlarmSetting('${pageContext.request.contextPath}','${loginUser.emp_Id }');">저장</button>
                            		<div style="margin-top:10px;">
										      <label class="fancy-checkbox">
				                            <input type="checkbox" data-colName="alarmDuty" class="alarmSettingEl" />
				                            <span>업무관리</span>
				                        </label>
										      <label class="fancy-checkbox">
				                            <input type="checkbox" data-colName="alarmApproval" class="alarmSettingEl" />
				                            <span>전자결재</span>
				                        </label>
										      <label class="fancy-checkbox">
				                            <input type="checkbox" data-colName="alarmReservation" class="alarmSettingEl" />
				                            <span>시설예약</span>
				                        </label>
										      <label class="fancy-checkbox">
				                            <input type="checkbox" data-colName="alarmBoard" class="alarmSettingEl" />
				                            <span>게시판</span>
				                        </label>
									      	<label class="fancy-checkbox" style="margin-bottom:0px;">
				                            <input type="checkbox" data-colName="alarmSchedule" class="alarmSettingEl" />
				                            <span>일정알림</span>
				                        </label>
										    <label class="fancy-checkbox" style="margin-bottom:0px;">
				                            <input type="checkbox" data-colName="alarmAttend" class="alarmSettingEl" />
				                            <span>근태관리</span>
				                        </label>
                            		</div>
                            	</div>
                            	<span class="deleteAlarmBtn" onclick="removeAlarm('${pageContext.request.contextPath}','${loginUser.emp_Id }','check');">읽은 알림 삭제</span>
                            	<span class="deleteAlarmBtn" onclick="removeAlarm('${pageContext.request.contextPath}','${loginUser.emp_Id }');" style="border-left: 1px solid gray;padding-left: 10px;margin-left: 10px;">전체 삭제</span>
                           	</li>
                            <div id="alarm-list">
                            	<!-- 알람 목록 뜨는곳 -->
                            </div>
                            <li class="footer"><a href="javascript:void(0);" id="alarmBtn" data-toggle="modal" data-target="#alarmModal" style="float:right;color:gray;padding-top:15px;">더보기</a></li>
                        </ul>
                    </li>
                </ul>
                    <div class="user-account" style="display:inline-block;margin: 10px 0px 0 15px;vertical-align: middle;height:60px;">
                    	<a href="javascript:void(0);" class="user-name" data-toggle="dropdown" aria-expanded="false">
		                 	<div id="pictureView" style="width: 55px; height: 55px;" class="rounded-circle avatar" ></div>
			                <div id="pictureView" style="background-color: #ffffff;" class="rounded-circle user-photo"></div>
                    	</a>
		                <div class="dropdown" id="usernameBox">
		                	<a href="javascript:void(0);" class="dropdown-toggle user-name" data-toggle="dropdown" style="font-family: InfinitySans-RegularA1"><strong>${loginUser.emp_Name }&nbsp;님</strong></a>                    
		                    <ul class="dropdown-menu dropdown-menu-right account animated flipInY menuProfile" x-placement="bottom-end" style="position: absolute; will-change: transform; top: 0px; left: -100px; transform: translate3d(89px, 42px, 0px); font-family: InfinitySans-RegularA1">
		                        <li><a href=""><i class="icon-direction"></i>관리페이지</a></li>
		                        <li><a href=''><i class="icon-user"></i>내정보</a></li>
		                        <li></i>권한위임</a></li>
		                        <li><a href=""><i class="icon-note"></i>결재할 문서</a></li>
		                        <li><a href=""><i class="icon-calendar"></i>오늘의 일정</a></li>
		                        <li class="divider"></li>
		                        <li><a href="javascript:sessionStorage.clear();window.location.href='${pageContext.request.contextPath }/common/logout';"><i class="icon-power"></i>로그아웃</a></li>
		                    </ul>
		                </div>
		            </div>
            </div>
        </div>
    </div>
</nav>

<!--직원상세 모달창 -->
<div class="modal fade commonModal" id="defaultModal" tabindex="-1" role="dialog" style="font-family: InfinitySans-RegularA1">
	<div class="modal-dialog" role="document">
	    <div class="modal-content commonModal-content" style="width:290px;">
	        <div class="modal-header" style="display: block; text-align: center;">
	            <h4 class="title" id="defaultModalLabel">직원 상세조회</h4>
	        </div>
	        <div class="modal-body">
	                  <div class="body text-center" style="margin-bottom: 10px;">
	                      <div class="chart easy-pie-chart-1 user-photo" id="emp_Picture" style="width: 100px;height: 100px; border-radius: 50%;"></div>
	                        <h5 id="modalName"></h5>
	                        <h5 id="modalEmail"></h5>
	                        <h5 id="modalHp"></h5>
	                        <button class="btn btn-primary" style="width: 76%;" onclick="dutyIndication(this);">업무제안</button>
	                  </div>
	          </div>
	      </div>
	</div>
</div>
<!-- 알림 목록 -->
<div class="modal fade" id="alarmModal" tabindex="-1" role="dialog" style="display: none;" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="font-family: GoyangIlsan">
            <div class="modal-header" style="height:90px;">
                <h4 class="title" id="defaultModalLabel" style="display:inline-block;">알림 센터</h4>
                <span id="modalCloseBtn" style="font-size: 3em;line-height: 0.8;cursor: pointer;" data-dismiss="modal">&times;</span>
	            <div style="position:absolute;top:50px;font-size:20px;">
		            <span class="deleteAlarmBtn" onclick="removeAlarm('${pageContext.request.contextPath}','${loginUser.emp_Id }','check');event.stopPropagation();">읽은 알림 삭제</span>
		            <span class="deleteAlarmBtn" onclick="removeAlarm('${pageContext.request.contextPath}','${loginUser.emp_Id }');event.stopPropagation();" style="border-left: 1px solid gray;padding-left: 10px;margin-left: 10px;">전체 삭제</span>
	            </div>
            </div>
            <div id="allAlarmList" style="max-height: 80vh;overflow-y: auto;">
            <!-- 알림 목록 -->
            </div>
        </div>
    </div>
</div>

<!-- 메인 content -->
<div style="margin-top:15px;">

	<!-- 긴급공지 -->
	<div class="container-fluid" style="font-family: S-CoreDream-4Regular;position:fixed;top:70px;z-index: 10;">
		<div class="row clearfix">
	      	<div class="col-lg-12 emergencyArea" style="padding:11px;height:50px;background-color:rgb(0,0,0,0.5);color:white;display:none;">
	      		<div id="emergencyText" style="width:97%;display:inline-block;">
	            	
	      		</div>
	      		<span id="emergencyCloseBtn" onclick="closeEmergency();"><i class="fa fa-times fa-2x"></i></span>
	        </div>
	    </div>
	</div>


</div>

<!-- Page Loader -->
<div class="page-loader-wrapper">
    <div class="loader">
        <div class="m-t-30"></div>
        <p></p>        
    </div>
</div>

<form>

</form>





<script>



$(document).ready(function (){
	// 긴급공지창 보이기
	//showEmergency('${pageContext.request.contextPath}');
	
	// 메뉴 보이기
	showMenu('${pageContext.request.contextPath}');
	
});

function showMenu(contextPath){
	$.ajax({
		url:contextPath+'/common/menu/list',
		type:'post',
		success:function(menuList){
			for(let i=0; i<menuList.length; i++){
				let murl = menuList[i].murl;
				let menuId = murl.split('/')[2]; //notice
				if(menuId == 'board'){
					menuId = murl.split('/')[3]; // noticeList
				}
				let mname = menuList[i].mname; //전자결재
				
				let menuTag = '<li id="'+menuId+'" ';
					if(menuList[i].mstate == 'N'){
						menuTag += 'style="color:rgb(255,255,255,0.3);" onclick="alert(\'해당 서비스가 현재 점검중입니다.\');"';
					}else{
						menuTag += 'onclick="location.href=\''+murl+'\';"';
					}
					menuTag += '>'+mname+'</li>';
				
				$('.menuList').append(menuTag);
			}
		},
		error:function(){
			alert('메뉴 가져오기 실패');
		},
		complete:function(){
			cssManager();
		}
	});
}


</script>

<script>

$(document).on("click","#alarmBtn",function(){
	$(".modal-backdrop").css("opacity",0.5);
});

$(document).on("click","#alarmModal",function(){
	$(".modal-backdrop").css("opacity",'');
	$(".modal-backdrop").click();
});

function closeModal(){
	$("#modalCloseBtn").click();
}


</script>

</body>
</html>