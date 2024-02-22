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
  </style>
  <div id="left-sidebar" class="sidebar">
    <div class="sidebar-scroll">

        <!--큰버튼이 필요한 페이지에 쓰임(주소록, 전자결재, 일정관리 등)-->
        <div class="tab-content p-l-0 p-r-0 text-align go_btn">
            <a href="addBookInsertPage"  id="go_btn">주소록등록</a>
        </div>
        <!--큰버튼이 필요한 페이지에 쓰임-->

        <div class="tab-content p-l-0 p-r-0 subsubmenu">
          <!--서브메뉴 타이틀-->
          <a href="addBookStarred">중요주소록</a>
          <div>
            <i class="fa-solid fa-plus"></i>
          </div>
        </div>

        <div class="tab-content p-l-0 p-r-0 subsubmenu">
          <!--서브메뉴 타이틀-->
          <a href="addBookList">개인주소록</a>
          <ul class="main-menu metismenu">
              <li id="li_importantSchedule" class="metismenuLI">
                  <!--이동 주소 적기--><a href="addBookList" class=""><i class="fa fa-square" id="importantSchedule"></i> <span> <!--이동할 메뉴 이름 적기-->미등록그룹</span></a>
              </li>
          </ul>
        </div>
        <div class="tab-content p-l-0 p-r-0 subsubmenu">
          <!--서브메뉴 타이틀-->  
          <a href="addBookShare">공유주소록</a>
            <ul class="main-menu metismenu">
              <li id="li_deptSchedule" class="metismenuLI"> 
                  <!--이동 주소 적기--><a href="addBookShare" class=""><i class="fa fa-square" id="deptSchedule"></i> <span><!--이동할 메뉴 이름 적기-->미등록그룹</span></a>
              </li>
          </ul>
        </div>
    </div>
</div>