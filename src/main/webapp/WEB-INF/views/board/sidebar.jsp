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
        <div class="tab-content p-l-0 p-r-0 text-align" style="font-size: 20px; text-align: center;">
            <button style="font-family: paybooc-Bold; background-color: #2980b9; color: white; border: 0px; width: 80%; height: 3rem; border-radius: 5%; margin: 4% 0;" onclick="location.href='<%=request.getContextPath()%>/board/registForm'">글 작성</button>
        </div>

        <div class="tab-content p-l-0 p-r-0" style="font-size: 25px; margin-left: 3%; padding-bottom: 0; font-family: S-CoreDream-4Regular">
            <a href="<c:url value="/board/notice/list"/>" style="font-family: InfinitySans-RegularA1; font-size: 23px;"><i class="fa fa-bullhorn" ></i> <span>사내공지</span></a>
        </div>
        </br>
        <div id="commonHeader" class="tab-content p-l-0 p-r-0" style="font-size: 25px; margin-left: 3%; padding-bottom: 0; font-family: S-CoreDream-4Regular">
          <!--서브메뉴 타이틀-->
            <a href="<c:url value="/board/anony/list"/>" style="font-family: InfinitySans-RegularA1; font-size: 23px;"><i class="fa fa-comments-o" ></i> <span>익명 게시판</span></a>

        </div>
    </div>
</div>