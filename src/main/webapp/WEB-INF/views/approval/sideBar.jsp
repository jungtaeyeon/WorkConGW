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
  }
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

        <!--큰버튼이 필요한 페이지에 쓰임-->
        <div class="tab-content p-l-0 p-r-0 text-align" style="font-size: 25px; ">
            <button onclick="approval_go();" style="background-color: #2980b9; color: white; border: 0px; width: 14rem; height: 3.8rem; margin-left: 3.5%; border-radius: 5%; margin-top: 4%; font-family: InfinitySans-RegularA1">기안하기</button>
        </div>
    </br>
        <div class="tab-content p-l-0 p-r-0" style="font-size: 25px; margin-left: 3%; padding-bottom: 0; font-family: S-CoreDream-4Regular">
            나의 결재 목록
        </div>
        </br>
        <div class="tab-content p-l-0 p-r-0" style="font-family: InfinitySans-RegularA1;overflow: auto; height: 310px;">
            <div class="tab-pane animated fadeIn active" id="project_menu">
                <nav class="sidebar-nav">
                    <ul class="main-menu metismenu" style="font-size: 20px;">
                        <li ><a href="<%=request.getContextPath()%>/approval/lists/list" style="font-size: 18px;"><i class="icon-docs" style="font-size: 20px;"></i>모든 결재 문서</a></li>
                        <li ><a href="<%=request.getContextPath()%>/approval/lists/waitList" style="font-size: 18px;"><i class="icon-docs" style="font-size: 20px;"></i>결재 대기 문서 <span class="badge badge-warning float-right">${dataMap.docs.size()}</span></a></li>
                        <li ><a href="<%=request.getContextPath()%>/approval/lists/completeList" style="font-size: 18px;"><i class="icon-docs" style="font-size: 20px;"></i>결재 종료 문서</a></li>
                        <li ><a href="<%=request.getContextPath()%>/approval/lists/draftList" style="font-size: 18px;"><i class="icon-docs" style="font-size: 20px;"></i>기안 문서함 </a></li>
                        <li ><a href="<%=request.getContextPath()%>/approval/lists/temporaryList" style="font-size: 18px;"><i class="icon-docs" style="font-size: 20px;"></i>임시 저장함</a></li>
                        <li ><a href="<%=request.getContextPath()%>/approval/lists/referList" style="font-size: 18px;"><i class="icon-docs" style="font-size: 20px;"></i>참조 문서함</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</div>