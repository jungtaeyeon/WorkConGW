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
        <div class="tab-content p-l-0 p-r-0 text-align go_btn">
          <a href="<%=request.getContextPath()%>/approval/registDocForm"  id="go_btn">기안하기</a>
        </div>
        <div class="tab-content p-l-0 p-r-0 subsubmenu">
          <!--서브메뉴 타이틀-->
          <a href="#">내가받은결재</a>
          <ul class="main-menu metismenu">
            <li id="li_importantSchedule" class="metismenuLI">
                <a href="<%=request.getContextPath()%>" class=""><i class="fa fa-square" id="importantSchedule"></i> <span>결재대기문서</span></a>
            </li>
            <li id="li_importantSchedule" class="metismenuLI">
              <a href="addBookList" class=""><i class="fa fa-square" id="importantSchedule"></i> <span>결재완료문서</span></a>
            </li>
          </ul>
        </div>
        <div class="tab-content p-l-0 p-r-0 subsubmenu">
          <!--서브메뉴 타이틀-->  
          <a href="#">내가올린결재</a>
          <ul class="main-menu metismenu">
            <li id="li_importantSchedule" class="metismenuLI">
              <a href="<%=request.getContextPath()%>/approval/lists/draftList" class=""><i class="fa fa-square" id="importantSchedule"></i> <span>상신문서</span></a>
            </li>
            <li id="li_importantSchedule" class="metismenuLI">
              <a href="addBookList" class=""><i class="fa fa-square" id="importantSchedule"></i> <span>임시문서</span></a>
            </li>
            <li id="li_importantSchedule" class="metismenuLI">
              <a href="addBookList" class=""><i class="fa fa-square" id="importantSchedule"></i> <span>결재완료문서</span></a>
            </li>
            <li id="li_importantSchedule" class="metismenuLI">
              <a href="addBookList" class=""><i class="fa fa-square" id="importantSchedule"></i> <span>반려문서</span></a>
            </li>
          </ul>
        </div>
        <div class="tab-content p-l-0 p-r-0 subsubmenu">
          <!--서브메뉴 타이틀-->  
          <a href="#">참조문서함</a>
          <ul class="main-menu metismenu">
            <li id="li_importantSchedule" class="metismenuLI">
              <a href="addBookList" class=""><i class="fa fa-square" id="importantSchedule"></i> <span>참조문서</span></a>
            </li>
          </ul>
        </div>
    </div>
</div>