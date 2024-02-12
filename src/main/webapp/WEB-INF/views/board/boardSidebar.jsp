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
    }
    .metismenu, .metismenu span{
        list-style: none;
        color: #5a5a5a;
    }

    .metismenuLI a{
        font-family: S-CoreDream-4Regular;
        font-size: 20px;
    }

</style>

<div id="left-sidebar" class="sidebar">
    <div class="sidebar-scroll">

        <div class="tab-content p-l-0 p-r-0 text-align" style="font-size: 20px;text-align: center;">
            <button style="font-family:paybooc-Bold; background-color: #2980b9; color: white; border: 0px; width: 80%; height: 3rem; border-radius: 5%; margin: 4% 0;" onclick="window.location.href='<%=request.getContextPath()%>/board/notice/registForm';">글 작성</button>
        </div>

        <div id="commonHeader" class="tab-content p-l-0 p-r-0" style="font-size: 25px; margin-left: 3%; padding-bottom: 0; font-family: S-CoreDream-4Regular">
            <!--서브메뉴 타이틀-->

            <nav class="sidebar-nav">
                <ul class="main-menu metismenu">
                    <li id="li_notice">
                        <a href="<c:url value="/board/notice/noticeList"/>" style="font-family: InfinitySans-RegularA1; font-size: 23px;"><i class="fa fa-bullhorn" ></i> <span>사내공지</span></a>
                    </li>
                    <li id="li_anony">
                        <a href="<c:url value="/board/anony/list"/>" style="font-family: InfinitySans-RegularA1; font-size: 23px;"><i class="fa fa-comments-o" ></i> <span>익명 게시판</span></a>
                    </li>
                </ul>
            </nav>

        </div>
    </div>
</div>
