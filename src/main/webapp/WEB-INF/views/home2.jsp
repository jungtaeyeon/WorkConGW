<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<style>
  p{margin-bottom: 0 !important;}
  #pictureView{
	border: none !important;
	box-shadow: 0px 0px 5px 2px rgba(0,0,0,0.15);
  }
  .mainDashBoard{
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    row-gap: 20px;
    column-gap: 20px;
    margin: 2% 15px 3%;
  }
  .gridContent{
    box-shadow: 0 0 5px 0 rgba(0,0,0,0.15);
    height: 325px;
    padding: 2% 3%;
  }
  .gridContent:nth-child(2) {
    grid-column: 2 / span 2;
	padding: 1% 1.5%; 
  }
  .profilImgTextGroup{display: flex; align-items: center;}
  .profilContent{display: flex; justify-content: space-between; padding-bottom: 15px; border-bottom: 2px solid #c4c4c4; margin-bottom: 13px;}
  .profilText{margin-left: 6px;}
  .profilName{
    font-size: 24px;
    font-weight: bold;
  }
  .profilCode{
    font-size: 19px;
    margin-left: 4px;
  }
  .profilEmp, .profilDept{font-size: 17px; font-weight: 500;line-height: 1.2; color: #34495E;}
  .profilEmp span, .profilDept span{margin-right: 5px;}
  .dashBoardUpdateBtn .btn-primary{
    background-color: rgb(52, 152, 219) !important;
    border: 1px solid rgb(52, 152, 219) !important;
  }
  .attendContent{
	display: flex;
    align-items: flex-end;
    justify-content: space-between;
  }
  .attendTimeBtnGroup{display:flex;}
  .attendTimeBtnGroup .btn{margin-right: 10px; width: 130px; border-radius: 30px;}
  .attendTimeBtnGroup .btn-primary{background-color: #0CAD50; border:none;}
  .attendTimeBtnGroup .btn-primary:hover{background-color: #0CAD50; border:none;}
  .attendTimeBtnGroup .btn-secondary{background-color: #C0392B; border:none;}
  .attendTimeBtnGroup .btn-secondary:hover{background-color: #C0392B; border:none;}
  .attendTodayText{
	font-size: 19px;
    font-weight: 500;
  }
  .attendTodayDayText{font-size: 14px;}
  .attendTodayTime{
	font-size: 40px;
    line-height: 1.2;
    font-weight: 400;
  }
  .attendStartTimeGroup{margin-top: 10px;}
  .attendTimeContentGroup,.attendEndTimeGroup,.attendStartTimeGroup{
	font-size: 16px;
  }
  .attendStartTimeText,.attendEndTimeText, .attendTimeContentText{margin-right: 9px;}
  .calendar {
    width: 280px;
}

.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
}
.header h2{
	font-size: 26px;
	padding: 0;
}
.header button{border: none; font-size: 18px; background-color: transparent;}
.header button:focus{outline: none;}

.weekdays {
    display: flex;
	justify-content: space-around;
}

.weekdays div {
    width: 42px;
    padding: 5px;
    text-align: center;
    font-weight: bold;
}

.days {
    display: grid;
    grid-template-columns: repeat(7, 1fr);
}

.days div {
	height: 40px;
	display: flex;
    justify-content: center;
    align-items: center;
    text-align: center;
	cursor: pointer;
}
.days .on{
	background-color: #1663C0;
	border-radius: 50%;
	color: #fff;
	opacity: 1;
}
.prev-date, .next-date{opacity: 0.5;}
.scheduleContainer{display: flex;}
.scheduleRightContainer{
	width: calc(100% - 266px);
    margin-left: 14px;
    background: #E8E8E8;
    padding: 11px 22px;
	box-shadow: 0 0 2px 0 rgba(0,0,0,0.15);
}
.scheduleTit{
	font-size: 17px;
    font-weight: 500;
}
.scheduleText{
	font-size: 15px;
	margin-bottom: 3px !important;
}
.girdContentTitGroup{
	padding-bottom: 7px;
    border-bottom: 2px solid #c4c4c4;
    margin-bottom: 7px;
	display: flex;
    align-items: center;
    justify-content: space-between;
}
.girdContentTitGroup i{font-size: 17px; cursor: pointer;}
.gridContentTit{font-size: 20px; font-weight: 500;}

.girdContentGroup i{
    margin-right: 4px;
}
.girdContentGroup div{
	margin-bottom:3px;

}
#privateSchedule{color: #74c0fc;}
#importantSchedule{color: #D25565;}
#companySchedule{color: #a9e34b;}
#deptSchedule{color: #b070db;}

</style>
<%@ include file="./include/header.jsp"%>
<section class="mainDashBoard">
  <div class="gridContent profilContainer">
    <div class="profilContent">
      <div class="profilImgTextGroup">
        <c:if test="${loginUser.emp_Picture != null}">
          <div id="pictureView" style="background-image:url('${pageContext.request.contextPath }/pds/empPicture/${ loginUser.emp_Picture}'); width: 110px; height: 110px;" class="rounded-circle avatar" ></div>
        </c:if>
        <c:if test = "${loginUser.emp_Picture == null}">
          <div id="pictureViewPhoto" style="background-color: #ffffff;" class="rounded-circle user-photo">
          </div>
        </c:if>
        <div class="profilText">
          <p class="profilName">${loginUser.emp_Name}<span class="profilCode">${loginUser.code_Name}</span></p>  
          <p class="profilEmp"><span>[사번]</span>${loginUser.emp_Id}</p>  
          <p class="profilDept"><span>[부서]</span>${loginUser.dept_Name}</p>  
        </div>
      </div>
      <div class="dashBoardUpdateBtn">
        <button type="button" class="btn btn-primary ">대시보드 수정</button>
      </div>
    </div>
    <div class="attendContent">
      <div class="attendTimeGroup">
        <p class="attendTodayTextGroup">
			<span class="attendTodayText"></span>
			<span class="attendTodayDayText"></span>
		</p>
        <p class="attendTodayTime"></p>
        <p class="attendStartTimeGroup">
			<span class="attendStartTimeText">출근시간</span>
			<span class="attendStartTime">00:00:00</span>
		</p>
        <p class="attendEndTimeGroup">
			<span class="attendEndTimeText">퇴근시간</span>
			<span class="attendEndTime">00:00:00</span>
		</p>
        <p class="attendTimeContentGroup">
			<span class="attendTimeContentText">근무시간</span>
			<span id="attendTimeContent">00:00:00</span>
		</p>
      </div>
      <div class="attendTimeBtnGroup">
          <button type="button" class="btn btn-primary attendStartBtn">출근하기</button>
          <button type="button" class="btn btn-secondary attendEndBtn">퇴근하기</button>
      </div>
    </div>
  </div>
  <div class="gridContent scheduleContainer">
	<div class="scheduleLeftContainer">
		<div class="calendar">
			<div class="header">
				<button id="prev">&#10094;</button>
				<h2 id="month-year"></h2>
				<button id="next">&#10095;</button>
			</div>
			<div class="weekdays">
				<div>Sun</div>
				<div>Mon</div>
				<div>Tue</div>
				<div>Wed</div>
				<div>Thu</div>
				<div>Fri</div>
				<div>Sat</div>
			</div>
			<div class="days" id="days"></div>
		</div>
	</div>
	<div class="scheduleRightContainer">
		<div class="girdContentTitGroup">
			<p class="gridContentTit">일정관리</p>
		</div>
		<div class="girdContentGroup">
			<div class="privateScheduleGroup"></div>
			<div class="companySchedule"></div>
			<div class="deptScheduleGroup"></div>
		</div>
	</div>
  </div>
  <div class="gridContent">
	<div class="girdContentTitGroup">
		<p class="gridContentTit">공지사항</p>
		<i class="fa fa-sign-in" aria-hidden="true" onclick="location.href='<%=request.getContextPath()%>/board/notice/noticeList'"></i>
	</div>
	
  </div>
  <div class="gridContent">
	<div class="girdContentTitGroup">
		<p class="gridContentTit">전자결재</p>
	</div>
  </div>
  <div class="gridContent">
	<div class="girdContentTitGroup">
		<p class="gridContentTit">오늘의날씨</p>
	</div>
  </div>
  <div class="gridContent">
	<div class="girdContentTitGroup">
		<p class="gridContentTit">업무관리</p>
	</div>
  </div>
  <div class="gridContent">
	<div class="girdContentTitGroup">
		<p class="gridContentTit">이슈관리</p>
	</div>
  </div>
  <div class="gridContent">
	<div class="girdContentTitGroup">
		<p class="gridContentTit">프로젝트</p>
	</div>
  </div>
</section>
<%@ include file="./include/footer.jsp"%>

<script>
	let history_Attend_Time = "${loginUser.history_Attend_Time}";
	let history_Leaving_Time = "${loginUser.history_Leaving_Time}";
	let splitDateTime = history_Attend_Time.split(" ");
	let splitDateTime1 = history_Leaving_Time.split(" ");
	let attendTodayText = splitDateTime[0];
	let attendStartTime = splitDateTime[1];
	let attendEndTime = splitDateTime1[1];
	// 주어진 날짜를 Date 객체로 변환
	let formattedDate = new Date();
	let attendTodayDate = formattedDate.getFullYear() + '-' + ('0' + (formattedDate.getMonth() + 1)).slice(-2) + '-' + ('0' + formattedDate.getDate()).slice(-2);
	// 요일을 가져오기 위해 getDay() 메서드를 사용
	let attendTodayDayOfWeek = formattedDate.getDay();
	let dayText;
	switch (attendTodayDayOfWeek) {
	case 0:
		dayText = '일';
		break;
	case 1:
		dayText = '월';
		break;
	case 2:
		dayText = '화';
		break;
	case 3:
		dayText = '수';
		break;
	case 4:
		dayText = '목';
		break;
	case 5:
		dayText = '금';
		break;
	case 6:
		dayText = '토';
		break;
	}
	let startTime;
	let now;
	let stopboolean = "${loginUser.attend_St_Id}"; 
	let timerId;
	// 공백을 기준으로 문자열을 나누고, 각 부분을 '-'와 ':'로 다시 나누어서 배열로 만듭니다.
	let parts = history_Attend_Time.split(/[\s-:]/);
	let parts1 = history_Leaving_Time.split(/[\s-:]/);
	// parts 배열의 원소들을 숫자로 변환하여 Date 객체 생성자에 넣습니다.
	startTime = new Date(parts[0], parts[1] - 1, parts[2], parts[3], parts[4], parts[5]);
	now = new Date(parts1[0], parts1[1] - 1, parts1[2], parts1[3], parts1[4], parts1[5]);
	// 타이머를 표시할 요소
	let timerElement = document.getElementById("attendTimeContent");

	// 타이머 갱신 주기 (1초)
	let timerInterval = 1000;
	
	$('.attendTodayText').text(attendTodayDate);
	$('.attendStartTime').text(attendStartTime);
	$('.attendEndTime').text(attendEndTime);
	$('.attendTodayDayText').text("("+ dayText +")")
	todayTimer();
	updateTimer();
	setInterval(todayTimer, timerInterval);
	$('.attendStartBtn').click(function(){
		if(history_Attend_Time == ""){
		$.ajax({
			type : 'get',              
			url : '/WorkConGW/attend/attendStart',  
			data : {
			},
			success : function(result) { 
			alert('출근체크되었습니다.');
			startTimer();
			location.reload();
			},    
			error : function(request, status, error) {        
			console.log(error);
			}
		})
		}else{
		alert('이미출근하셨습니다.');
		return;
		}
	})
	$('.attendEndBtn').click(function(){
		if(history_Attend_Time != ""){
		$.ajax({
			type : 'get',              
			url : '/WorkConGW/attend/attendEnd',  
			data : {
			},
			success : function(result) { 
			alert('퇴근체크되었습니다.');
			updateTimer();
			clearInterval(timerId);
			location.reload();
			},    
			error : function(request, status, error) {        
			console.log(error);
			}
		})
		}else{
		alert('출근부터해주세요');
		return;
		}
	})

	if(stopboolean == '1' || stopboolean == '2'){
	timerId = setInterval(updateTimer, timerInterval);
	}else{
	updateTimer();
	}
  // 타이머 갱신 함수
	function todayTimer() {
		// 현재 시간
		let todaynow = new Date();
		// 시, 분, 초 계산
		let hours = todaynow.getHours();
    	let minutes = todaynow.getMinutes();
    	let seconds = todaynow.getSeconds();
		// 시간 형식 맞추기
		hours = padTime(hours);
		minutes = padTime(minutes);
		seconds = padTime(seconds);
		if(hours == "NaN"){
		hours = '00';
		minutes = '00';
		seconds = '00';
		}
		// 타이머 업데이트
		$('.attendTodayTime').text(hours + ":" + minutes + ":" + seconds);
	}
	
	// 타이머 갱신 함수
	function updateTimer() {
		if (!startTime) return;
		// 현재 시간
		if(history_Leaving_Time == ''){
		now = new Date().getTime();
		}
		// 경과 시간 (밀리초)
		let elapsedTime = now - startTime;
		// 시, 분, 초 계산
		let hours = Math.floor(elapsedTime / (1000 * 60 * 60));
		let minutes = Math.floor((elapsedTime % (1000 * 60 * 60)) / (1000 * 60));
		let seconds = Math.floor((elapsedTime % (1000 * 60)) / 1000);
		// 시간 형식 맞추기
		hours = padTime(hours);
		minutes = padTime(minutes);
		seconds = padTime(seconds);
		if(hours == "NaN"){
		hours = '00';
		minutes = '00';
		seconds = '00';
		}
		// 타이머 업데이트
		timerElement.textContent = hours + ":" + minutes + ":" + seconds;
	}

	// 타이머 시작 함수
	function startTimer() {
		startTime = new Date().getTime(); // 현재 시간 설정
		timerId = setInterval(updateTimer, timerInterval); // 주기적으로 타이머 업데이트
	}

	const prevButton = $('#prev');
    const nextButton = $('#next');
    const monthYear = $('#month-year');
    const daysContainer = $('#days');

    let dateCalendar = new Date();

    function renderCalendar() {
		let renderCalendartoday = new Date(); // 오늘 날짜 가져오기
		let lastDay = new Date(dateCalendar.getFullYear(), dateCalendar.getMonth() + 1, 0).getDate();
		let firstDayIndex = new Date(dateCalendar.getFullYear(), dateCalendar.getMonth(), 1).getDay();
		let lastDayIndex = new Date(dateCalendar.getFullYear(), dateCalendar.getMonth() + 1, 0).getDay();
		let prevLastDay = new Date(dateCalendar.getFullYear(), dateCalendar.getMonth(), 0).getDate();
		let months = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'];

		monthYear.text(dateCalendar.getFullYear() + '.' + months[dateCalendar.getMonth()] );

		let days = '';

		for (let i = firstDayIndex; i > 0; i--) {
			days += '<div class="prev-date" data-calender='+dateCalendar.getFullYear()+'-'+ padTime(months[dateCalendar.getMonth()] -1)+'-'+ padTime((prevLastDay - i + 1))+'>' + (prevLastDay - i + 1) + '</div>';
		}

		for (let i = 1; i <= lastDay; i++) {
			if (i === dateCalendar.getDate() && dateCalendar.getMonth() === new Date().getMonth()) {
				days += '<div class="today on" data-calender='+dateCalendar.getFullYear()+'-'+ padTime(months[dateCalendar.getMonth()])+'-'+ padTime(i)+'>' + i + '</div>';
			} else {
				days += '<div data-calender='+dateCalendar.getFullYear()+'-'+ padTime(months[dateCalendar.getMonth()])+'-'+ padTime(i)+'>' + i + '</div>';
			}
		}

		for (let i = lastDayIndex; i < 6; i++) {
			days += '<div class="next-date" data-calender='+dateCalendar.getFullYear()+'-'+ padTime(months[dateCalendar.getMonth()] +1)+'-'+ padTime((i - lastDayIndex + 1))+'>' + (i - lastDayIndex + 1) + '</div>';
		}
		daysContainer.html(days);
		let calenderdata = {schedule_Start_Dt : $('.days .on').data('calender')};
		homeScheduleList(calenderdata);
		$('.days div').click(function(){
			$('.days div').not(this).removeClass('on');
			$(this).addClass('on');
			console.log($(this).data('calender'));
			calenderdata = {schedule_Start_Dt : $(this).data('calender')}
			homeScheduleList(calenderdata);
		})
	}

    renderCalendar();
    prevButton.on('click', function () {
        dateCalendar.setMonth(dateCalendar.getMonth() - 1);
        renderCalendar();
    });

    nextButton.on('click', function () {
        dateCalendar.setMonth(dateCalendar.getMonth() + 1);
        renderCalendar();
    });
	// 시간 형식 맞추기 (한 자리 숫자일 경우 앞에 0 붙이기)
	function padTime(time) {
		return (time < 10 ? "0" : "") + time;
	}
	function homeScheduleList(data){
        $.ajax({
            type: "get",
            url: "/WorkConGW/common/homescheduleList",
            data: data,
            success: function(response) {
				$('.privateScheduleGroup').find('p').remove();
				$('.importantScheduleGroup').find('p').remove();
				$('.companyScheduleGroup').find('p').remove();
				$('.deptScheduleGroup').find('p').remove();
				let privateScheduled;
				let companySchedule;
				let deptSchedule;
				response.forEach(function(e, i){
					let text;
					if(e.CODE_ID == 'S01' && !privateScheduled){
						text = `<p class="scheduleTit">나의일정</p>`
						$('.privateScheduleGroup').append(text);
						privateScheduled = true;
					}else if(e.CODE_ID == 'S02' && !companySchedule){
						text = `<p class="scheduleTit">부서일정</p>`
						$('.companyScheduleGroup').append(text);
						companySchedule = true;
					}else if(e.CODE_ID == 'S03' && !deptSchedule){
						text = `<p class="scheduleTit">팀일정</p>`
						$('.deptScheduleGroup').append(text);
						deptSchedule = true;
					}	
					if(e.CODE_ID == 'S01' && e.SCHEDULE_IMP == 0){//개인일정
						text = `<p class="scheduleText"><i class="fa fa-square" id="privateSchedule" aria-hidden="true"></i><span>`+e.SCHEDULE_TITLE+`</span></p>`;
						$('.privateScheduleGroup').append(text);
					}else if(e.CODE_ID == 'S01' && e.SCHEDULE_IMP == 1){//
						text = `<p class="scheduleText"><i class="fa fa-square" id="importantSchedule" aria-hidden="true"></i><span>`+e.SCHEDULE_TITLE+`</span></p>`;
						$('.privateScheduleGroup').append(text);
					}else if(e.CODE_ID == 'S02'){
						text = `<p class="scheduleText"><i class="fa fa-square" id="companySchedule" aria-hidden="true"></i><span>`+e.SCHEDULE_TITLE+`</span></p>`;
						$('.companyScheduleGroup').append(text);
					}else if(e.CODE_ID == 'S03'){
						text = `<p class="scheduleText"><i class="fa fa-square" id="deptSchedule" aria-hidden="true"></i><span>`+e.SCHEDULE_TITLE+`</span></p>`;
						$('.deptScheduleGroup').append(text);
					} 
				})	
            },
            error: function(xhr, status, error) {
            // 오류 처리
            console.error(xhr.responseText);
            }
        });
    }
</script>