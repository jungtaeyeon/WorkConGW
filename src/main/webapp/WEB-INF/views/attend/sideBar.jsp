<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <style>
    
  a{text-decoration: none;}
  .sidebar{
    border-right:2px solid rgb(0,0,0,0.1);
    margin-right: 10px;
  }
  .sidebar-scroll{
    padding:0 10px 20px;
    width: 250px;
  }
  .subPageContain{
    display: flex;
  }
  .contentConteiner{
    width: 100%;
    padding:0 10px;
  }
  .tab-content{
    font-size: 25px; 
    margin-left: 3%; 
    padding-bottom: 0; 
    font-family: S-CoreDream-4Regular
  }
  .subsubmenu{margin-bottom: 20px;}
  .tab-content a{color: #000;}
  .metismenu:last-child{margin-bottom:0 !important;}
  .metismenu i{color:#2980b9;}
  .metismenu, .metismenu span{
    list-style: none;
    color: #5a5a5a;
  }
  #go_btn{
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: #2980b9; 
    color: white; 
    width: 14rem; 
    height: 3.8rem; 
    border-radius: 5%; 
    font-family: InfinitySans-RegularA1;
  }
  .metismenuLI a{
    font-family: S-CoreDream-4Regular; 
    font-size: 20px;
  }
  .go_btn{margin-bottom: 15px;}
  .attendTimeTitle{
    font-size: 26px;
    text-align: center;
    margin-bottom: 0;
  }
  .attendTimeContent{
    font-size: 33px;
    text-align: center;
    font-weight: bold;
    color: #0069d9;
    margin-bottom: 0;
  }
  .attendTextGroup{
    padding-bottom: 15px;
    margin-bottom: 15px;
    border-bottom: 1px solid #d2d2d2;
  }
  .subsubmenu .btn{width: 48%;}
  </style>
  <div id="left-sidebar" class="sidebar">
    <div class="sidebar-scroll">

        <div class="attendTextGroup">
          <p class="attendTimeTitle">근무시간</p>
          <p id="attendTimeContent" class="attendTimeContent">00:00:00</p>
        </div>
        <!--큰버튼이 필요한 페이지에 쓰임-->

        <div class="tab-content p-l-0 p-r-0 subsubmenu">
          <button type="button" class="btn btn-success attendStartBtn">출근</button>
          <button type="button" class="btn btn-danger attendEndBtn">퇴근</button>
        </div>

        <div class="tab-content p-l-0 p-r-0 subsubmenu">
          <!--서브메뉴 타이틀-->
          <a href="main">내 근태조회</a>
        </div>
        <div class="tab-content p-l-0 p-r-0 subsubmenu">
          <!--서브메뉴 타이틀-->  
          <a href="attentEmpList">부서 근태조회</a>
        </div>
    </div>
</div>

<script>  
let history_Attend_Time = "${loginUser.history_Attend_Time}";
let history_Leaving_Time = "${loginUser.history_Leaving_Time}";
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
    if(history_Leaving_Time != ""){
      alert('이미퇴근하셨습니다.');
      return;
    }
    else if(history_Attend_Time != ""){
      $.ajax({
        type : 'get',              
        url : '/WorkConGW/attend/attendEnd',  
        data : {
        },
        success : function(result) { 
          alert('퇴근체크되었습니다.');
          updateTimer();
          clearInterval(timerId);
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
  console.log(timerInterval);
  timerId = setInterval(updateTimer, timerInterval);
}else{
  updateTimer();
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
// 시간 형식 맞추기 (한 자리 숫자일 경우 앞에 0 붙이기)
function padTime(time) {
    return (time < 10 ? "0" : "") + time;
}

</script>