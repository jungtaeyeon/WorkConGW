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
          <p class="attendTimeContent">00:00:00</p>
        </div>
        <!--큰버튼이 필요한 페이지에 쓰임-->

        <div class="tab-content p-l-0 p-r-0 subsubmenu">
          <button type="button" class="btn btn-success attendStartBtn">출근</button>
          <button type="button" class="btn btn-danger">퇴근</button>
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
  let history_Attend_Time = '${loginUser.history_Attend_Time}';
  
  $('.attendStartBtn').click(function(){
    if(history_Attend_Time == ""){
      $.ajax({
        type : 'get',              
        url : '/WorkConGW/attend/attendStart',  
        data : {
        },
        success : function(result) { 
          alert('출근체크되었습니다.');
        },    
        error : function(request, status, error) {        
          console.log(error)    
        }
      })
    }else{
      alert('이미출근하셨습니다.');
      return;
    }
    
  })
</script>