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
            <button style="font-family:paybooc-Bold; background-color: #2980b9; color: white; border: 0px; width: 80%; height: 3rem; border-radius: 5%; margin: 4% 0;" onclick="window.location.href='<%=request.getContextPath()%>/board/duty/registForm';">업무 작성</button>
        </div>

        <div class="tab-content p-l-0 p-r-0" style="font-size: 25px; margin-left: 3%; padding-bottom: 0; font-family: S-CoreDream-4Regular">
            <!--서브메뉴 타이틀-->
            업무 관리
            <ul class="main-menu metismenu">
                <li class="metismenuLI">
                    <a id="a_list" href="<c:url value="../duty/dutyList"/>"><i class="fa fa-th-list" style="font-size:1.1em;"></i>업무목록</a>
                </li>
                <li class="metismenuLI">
                    <a id="a_receive" href="<c:url value="../duty/dutyList?dutyType=receive"/>"><i class="fas fa-envelope" style="font-size:1.1em;"></i>받은 업무목록</a>
                </li>
                <li class="metismenuLI">
                    <a id="a_send" href="<c:url value="../duty/dutyList?dutyType=send"/>"><i class="fa fa-send-o" style="font-size:1.1em;"></i>보낸 업무목록</a>
                </li>
                <li class="metismenuLI">
                    <a id="a_reception" href="<c:url value="../duty/dutyList?dutyType=reception"/>"><i class="fa fa-chain" style="font-size:1.1em;"></i>참조 업무목록</a>
                </li>
            </ul>
        </div>
        <div id="commonHeader" class="tab-content p-l-0 p-r-0" style="font-size: 25px; margin-left: 3%; padding-bottom: 0; font-family: S-CoreDream-4Regular">
            <!--서브메뉴 타이틀-->
            이슈 관리
            <ul class="main-menu metismenu">
                <li class="metismenuLI">
                    <a id="a_issue" href="<c:url value="/board/issue/list"/>"><i class="fa fa-tasks" style="font-size:1.1em;"></i>이슈목록</a>
                </li>
                <li class="metismenuLI">
                    <a id="a_milestone" href="<c:url value="/board/milestone/list"/>"><i class="fa-solid fa-signs-post" style="font-size:1.1em;"></i>마일스톤</a>
                </li>
                <li class="metismenuLI">
                    <a id="a_project" href="<c:url value="/board/project/list"/>"><i class="fa fa-clipboard" style="font-size:1.1em;"></i>프로젝트</a>
                </li>
            </ul>
        </div>
    </div>
</div>