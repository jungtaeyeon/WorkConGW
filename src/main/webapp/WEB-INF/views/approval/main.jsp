<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp"%>

<style>
    .subTitleText{
        margin-bottom: 25px;
    }
    .subTitleText h2{
        display: flex;
        justify-content: flex-start;
        align-items: center;
        font-size: 27px;
    }
    .subTitleText i{
        font-size: 24px;
        margin-right: 5px;
    }
    .tableGroupTit{font-size: 18px;}
    .tableGroopContain{
        display: flex; 
        justify-content: space-between;
        align-items: center;
        margin: 3% 0;
    }
    .tableGroup{width: 49%;}
</style>
<section class="subPageContain">

    <!-- 사이드바 -->
    <%@ include file="./sideBar.jsp"%>
    
    <!--컨텐츠 영역-->
    <div class="contentConteiner">
        <div class="subTitleText"> <!--컨텐츠 부분 타이틀 클래스(이건 부트스트랩 클래스 아니고 임의로 만든 클래스)--> 
            <h2><i class="fa-solid fa-angles-right"></i> <!--왼쪽 아이콘 폰트어썸-->전자결재</h2>
        </div>

        <div class="tableGroopContain">
            <div class="tableGroup">
                <p class="tableGroupTit"><i class="fa fa-square" id="importantSchedule"></i> <span>결재 대기 문서</span></p>
                <table class="table table-hover"> <!-- 부트스트랩 게시판 -->
                    <thead class="thead-light"> <!-- 게시판 맨위 색변경 클래스-->
                        <tr>
                            <th>품의번호</th>
                            <th>문서분류</th>
                            <th>제목</th>
                            <th>기안자</th>
                            <th>기안일</th>
                            <th>상태</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>xx-xxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                        </tr>
                        <tr>
                            <td>xx-xxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="tableGroup">
                <p class="tableGroupTit"><i class="fa fa-square" id="importantSchedule"></i> <span>기안 문서함</span></p>
                <table class="table table-hover"> <!-- 부트스트랩 게시판 -->
                    <thead class="thead-light"> <!-- 게시판 맨위 색변경 클래스-->
                        <tr>
                            <th>품의번호</th>
                            <th>문서분류</th>
                            <th>제목</th>
                            <th>기안자</th>
                            <th>기안일</th>
                            <th>상태</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>xx-xxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                        </tr>
                        <tr>
                            <td>xx-xxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="tableGroopContain">
            <div class="tableGroup">
                <p class="tableGroupTit"><i class="fa fa-square" id="importantSchedule"></i> <span>수신 문서함</span></p>
                <table class="table table-hover"> <!-- 부트스트랩 게시판 -->
                    <thead class="thead-light"> <!-- 게시판 맨위 색변경 클래스-->
                        <tr>
                            <th>품의번호</th>
                            <th>문서분류</th>
                            <th>제목</th>
                            <th>기안자</th>
                            <th>기안일</th>
                            <th>상태</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>xx-xxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                        </tr>
                        <tr>
                            <td>xx-xxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="tableGroup">
                <p class="tableGroupTit"><i class="fa fa-square" id="importantSchedule"></i> <span>결재 완료 문서</span></p>
                <table class="table table-hover"> <!-- 부트스트랩 게시판 -->
                    <thead class="thead-light"> <!-- 게시판 맨위 색변경 클래스-->
                        <tr>
                            <th>품의번호</th>
                            <th>문서분류</th>
                            <th>제목</th>
                            <th>기안자</th>
                            <th>기안일</th>
                            <th>상태</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>xx-xxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                        </tr>
                        <tr>
                            <td>xx-xxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="tableGroopContain">
            <div class="tableGroup">
                <p class="tableGroupTit"><i class="fa fa-square" id="importantSchedule"></i> <span>임시 문서</span></p>
                <table class="table table-hover"> <!-- 부트스트랩 게시판 -->
                    <thead class="thead-light"> <!-- 게시판 맨위 색변경 클래스-->
                        <tr>
                            <th>품의번호</th>
                            <th>문서분류</th>
                            <th>제목</th>
                            <th>기안자</th>
                            <th>기안일</th>
                            <th>상태</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>xx-xxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                        </tr>
                        <tr>
                            <td>xx-xxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="tableGroup">
                <p class="tableGroupTit"><i class="fa fa-square" id="importantSchedule"></i> <span>참조문서함</span></p>
                <table class="table table-hover"> <!-- 부트스트랩 게시판 -->
                    <thead class="thead-light"> <!-- 게시판 맨위 색변경 클래스-->
                        <tr>
                            <th>품의번호</th>
                            <th>문서분류</th>
                            <th>제목</th>
                            <th>기안자</th>
                            <th>기안일</th>
                            <th>상태</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>xx-xxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                        </tr>
                        <tr>
                            <td>xx-xxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>

<!-- 푸터 인클루드 -->
<%@ include file="../include/footer.jsp"%>