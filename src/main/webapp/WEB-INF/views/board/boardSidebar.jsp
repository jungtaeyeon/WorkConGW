<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
    font-size: 23px;  
    padding-bottom: 0; 
  }
  .subsubmenu{margin-bottom: 10px;}
  .tab-content a{color: #000;}
  .metismenuLI{
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 3px;
  }
  
  .metismenu:last-child{margin-bottom:0 !important;}
  .metismenu .fa-square{color:#2980b9; margin-right: 5px;}
  .addBookGroupLi:hover .fa-ellipsis{opacity: 1;}
  .fa-ellipsis{cursor: pointer; opacity: 0; transition: opacity 0.5s;}
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
    height: 3rem; 
    border-radius: 10px; 
    margin: 0 auto;
    border: none;
    font-size: 20px;
    width: 100%;
  }
  .metismenuLI a{
    font-size: 20px;
  }
  .metismenuLI .dropdown-item{font-size: 16px; transition: 0.3s; margin-bottom: 0; cursor: pointer;}
  .go_btn{margin-bottom: 15px;}
  .modal.show{background-color: rgba(0, 0, 0, 0.7);}
  .modalBtnGroup{
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  .modalBtnGroup:hover .modalBtn{opacity: 1;}
  .modalBtn{cursor: pointer; color:#000 ; opacity: 0; transition: opacity 0.5s;}
  .addBookGroupInput{
    display: flex;
    align-items: center;
  }
  .addBookGroupInput p{
    margin-bottom: 0;
    margin-right: 5%;
  }
  .addBookGroupInput input{width: auto;}
  .dropdown-item.active, .dropdown-item:active, .dropdown-item:focus, .dropdown-item:hover{
    color: #000;
    text-decoration: none;
    background-color: #eff4fc;
  }

</style>

<div id="left-sidebar" class="sidebar">
    <div class="sidebar-scroll">

        <div class="tab-content p-l-0 p-r-0 text-align go_btn">
            <button id="go_btn" onclick="window.location.href='<%=request.getContextPath()%>/board/notice/registForm';">글 작성</button>
        </div>

        <!--서브메뉴 타이틀-->
        <div class="tab-content p-l-0 p-r-0 subsubmenu">
            <a href="<c:url value="/board/notice/noticeList"/>"><span>사내공지</span></a>
        </div>
        <div id="commonHeader" class="tab-content p-l-0 p-r-0 subsubmenu">
            <!--서브메뉴 타이틀-->
            <a href="<c:url value="/board/anony/list"/>"><span>익명 게시판</span></a>
        </div>

    </div>
</div>
