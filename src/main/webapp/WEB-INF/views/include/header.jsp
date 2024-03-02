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
	<!-- jquery -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- Popper.js CDN -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha512-ldc1sPu1FZ8smgkgp+HwnYyVb1eRn2wEmKrDg1JqPEb02+Ei4kNzDIQ0Uwh0AJVLQFjJoWwG+764x70zy5Tv4A==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<!-- Bootstrap CSS, js CDN -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<!-- FontAwesome -->
	<script src="https://kit.fontawesome.com/3a92c85ff9.js" crossorigin="anonymous"></script>
	<!-- TreeView -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/js/treeview/jquery.treeview.css" />
	<link rel="stylesheet" href="<%=request.getContextPath() %>/js/treeview/screen.css" />
	<script src="<%=request.getContextPath() %>/js/treeview/jquery.treeview.js"></script>
	<!-- Summernote -->
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>

	<!--Google Fonts-->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/css/font.css" />

	<!-- Bootstrap Datepicker CSS, JS CDN -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/css/bootstrap-datepicker.min.css" integrity="sha512-34s5cpvaNG3BknEWSuOncX28vz97bRI59UnVtEEpFX536A7BtZSJHsDyFoCl8S7Dt2TPzcrCEoHBGeM4SUBDBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/js/bootstrap-datepicker.min.js" integrity="sha512-LsnSViqQyaXpD4mBBdRYeP6sRwJiJveh2ZIbW41EBrNmKxgr/LFZIiWT6yr+nycvhvauz8c2nYMhrP80YhG7Cw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>


	<!-- common.js -->
	<script src="<%=request.getContextPath() %>/js/common.js"></script>






	<title>:: WorkConGW ::</title>

	<style type="text/css">
		@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Passion+One:wght@400;700&display=swap');

		ul.menuList {
			height: 100%; /* 더 높은 높이로 조절 */
			font-size: 1.4em;
			display: flex;
			align-items: center;
		}
		ul.menuList li {
			height:100%;
			display: flex;
			padding: 0 15px;
			justify-content: center;
			align-items: center;
			color: white;
			font-weight: bold;
			transition: 0.3s;
		}
		ul.menuList li:hover {
			background-color: #343a40;
			cursor: pointer;
		}
		#navbar-menu{
			display: flex;
			justify-content: center;
			align-items: center;
		}
		#usernameBox{
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
			margin: 0px 8px 0px 0px;
			background-position: center;
			background-size: cover;
			background-repeat: no-repeat;
		}
		.theme-black #wrapper:before, .theme-black #wrapper:after, .theme-black:before, .theme-black:after{
			background: #449cff00;
			display: none;
		}


		.nav-item.dropdown, #displayAndHiddenOrg, #hiddenMenu {
			position: fixed;
			bottom: 0px;
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

		ul#lvl0 li ul li:hover {
			background-color: white;
		}

		.btn.focus, .btn:focus{
			box-shadow: 0 0 0 0px;
		}
		/*.commonModal-content{*/
		/*	width: 290px;*/
		/*	right: 89.4%;*/
		/*	margin-top: 60%;*/
		/*}*/
		.modal-backdrop.show {
			opacity: .01;
		}

		.user-account{
			display:flex;
			margin: 0px 0px 0 15px;
			justify-content: center;
			align-items: center;
		}
		.menuProfile{
			will-change: transform;
			min-width: 8rem;
			padding: 0.5rem 0.7rem;
			transform: translate3d(-46px, 5px, 0px);
			font-family: InfinitySans-RegularA1
		}
		.menuProfile a{color:#000;}
		.user-name{color: #fff;}
	</style>
</head>
<body class="theme-black" style="">
<a id="viewModal" href="#defaultModal" data-toggle="modal" data-target="#defaultModal" style="display: none;"></a>
<div id='backLayer' style='z-index: 5'></div>
<nav class="navbar navbar-fixed-top" style="top:0px; padding: 0; height: 80px;">
	<div class="container-fluid" style="background-color:#0a1218; height: 100%;">
		<!-- 로고 -->
		<div class="navbar-brand">
			<a href="${pageContext.request.contextPath }/common/home" style="color:white;font-weight: bold;"><span>WorkConGW</span></a>
		</div>

		<!-- 메뉴 -->
		<ul class="nav navbar-nav menuList">
			<li id="home" onclick="location.href='${pageContext.request.contextPath }/common/home';">홈</li>
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
			<div class="user-account">
				<a href="javascript:void(0);" class="user-name" data-toggle="dropdown" aria-expanded="false">

					<c:if test="${loginUser.emp_Picture != null}">
						<div id="pictureView" style="background-image:url('${pageContext.request.contextPath}/pds/empPicture/${loginUser.emp_Picture}'); width: 55px; height: 55px;" class="rounded-circle avatar" ></div>
					</c:if>
					<c:if test = "${loginUser.emp_Picture == null}">
						<div id="pictureViewPhoto" style="background-color: #ffffff;" class="rounded-circle user-photo">
						</div>
					</c:if>
				</a>
				<div class="dropdown" id="usernameBox">
					<a href="javascript:void(0);" class="dropdown-toggle user-name" data-toggle="dropdown" style="font-family: InfinitySans-RegularA1"><strong>${loginUser.emp_Name }&nbsp;님</strong></a>
					<ul class="dropdown-menu dropdown-menu-right account animated flipInY menuProfile" x-placement="bottom-end">

					<c:if test="${loginUser.auth_Id eq 's'}">
						<li><a href="${pageContext.request.contextPath}/admin/main"><i class="icon-direction"></i>관리페이지</a></li>
					</c:if>
						<li><a href="${pageContext.request.contextPath }/common/mypage/modifyform"><i class="icon-user"></i>내정보</a></li>
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
<div class="modal fade commonModal" id="defaultModal" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-dialog-centered" style="max-width: 290px;" role="document">
		<div class="modal-content commonModal-content">
			<div class="modal-header" style="display: block; text-align: center;">
				<h4 class="title" id="defaultModalLabel">직원 상세조회</h4>
			</div>
			<div class="modal-body">
				<div class="body text-center" style="margin-bottom: 10px;">
					<div class="chart easy-pie-chart-1 user-photo" id="emp_Picture" style="width: 100px;height: 100px; border-radius: 50%; margin: 0 auto"></div>
					<h5 id="modalName"></h5>
					<h5 id="modalEmail"></h5>
					<h5 id="modalHp"></h5>
				</div>
				<div class="modal-footer justify-content-center">
					<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
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
				<h4 class="title" id="defaultModalLabelAlarm" style="display:inline-block;">알림 센터</h4>
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
					console.log("menuList : "+menuList)
					let murl = menuList[i].murl; // 디비로 받은 url : /WorkConGW/reservation/main
					console.log("murl :"+murl)
					let menuId = murl.split('/')[2]; // "/"으로 자르면 [WorkConGW,reservation,main]
					console.log("menuId :"+menuId)
					if(menuId == 'board'){
						menuId = murl.split('/')[3]; // noticeList
					}
					let mname = menuList[i].mname; //전자결재
					console.log("mname :"+mname)

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



	$("#modifyPwdBtn").on("click",(e)=>{
		e.preventDefault();
		console.log(e.preventDefault())
		$("#modalFindPwd").modal("show");
	})

	$("#modalFindPwdClose").on("click", (e) => {
		e.preventDefault();
		$("#modalFindPwd").modal("hide");
	});



	function cssManager(){
		// 메뉴바 선택시 색깔 변경
		let menu = location.href.split('WorkConGW/')[1].split('/')[1];
		console.log(menu)

		if(menu == 'emp' || menu == 'official' || menu == 'dept' || menu =='home'){
			$('#home').addClass('Myselected active');
		}
		$('#'+menu).addClass('Myselected active');


	}


</script>

<script>


	function closeModal(){
		$("#modalCloseBtn").click();
	}


</script>


<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>



	function home_go(){
		location.href = "${pageContext.request.contextPath}/common/home";
	}

	function sample6_execDaumPostcode() {
		new daum.Postcode({
			oncomplete: function (data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				let addr = ''; // 주소 변수
				let extraAddr = ''; // 참고항목 변수

				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}

				// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
					}
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if (extraAddr !== '') {
						extraAddr = ' (' + extraAddr + ')';
					}
					// 조합된 참고항목을 해당 필드에 넣는다.
					document.getElementById("myAdd1").value = extraAddr;

				} else {
					document.getElementById("myAdd1").value = '';
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
//             document.getElementById('sample6_postcode').value = data.zonecode;
				document.getElementById("myAdd1").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("myAdd2").focus();
			}
		}).open();
	}


	// function checkSession() {
	// let session = <%=session.getMaxInactiveInterval()%> ;
	// 	if(session > 300){
	// 	11	alert('시간이 만료되었습니다. 로그인해주세요')
	// 		location.href = "<%=request.getContextPath()%>/common/loginForm"
	// 		sessionStorage.clear()
	// 	}
	// 	else{
	// 		document.write(session);
	// 		clearTimeout(orange);
	// 	}
	// }

	// function checkStart() {
	// 	orange = setInterval(checkSession, 300000);
	// 	console.log(orange)
	// }
	// checkStart();




</script>



