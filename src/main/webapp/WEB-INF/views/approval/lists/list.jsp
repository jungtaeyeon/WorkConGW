<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Title</title>
</head>

<body>
<!-- 헤더인클루드 -->
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<section class="subPageContain">
    <!-- 사이드바 -->
    <%@ include file="../sideBar.jsp"%>
    <!--컨텐츠 영역-->
    <div class="contentConteiner">
        <div id="main-content" >
            <div class="container-fluid" >
                <!-- 메인 content 넣는 곳 -->
                <div class="row clearfix" >
                    <div class="col-12" style="margin-top: 2%; font-family: S-CoreDream-6Bold" >
                        <h2>모든 결재 문서</h2>
                        <hr>
                    </div>
                </div>

                <div class="row clearfix" style="font-family: S-CoreDream-7ExtraBold" >
                    <div class="col-12" >

                        <div class="card" >
                                <div class="body">
                                    <!-- 검색 조건 설정 -->
                                    <h5 style="display:inline-block; font-weight: bold;">검색 조건</h5>
                                    <div class="alert alert-light" role="alert" style="display:inline-block;padding-top:0;margin-bottom:0;">
                                        <label class="fancy-checkbox">
                                            <input type="checkbox" data="selectDt" id="dateCheckBox" data-parsley-multiple="checkbox" onchange="changeForm(this);"/>
                                            <span>기안 날짜</span>
                                        </label>
                                        <label class="fancy-checkbox">
                                            <input type="checkbox" id="checkboxState" data="selectState" data-parsley-multiple="checkbox" onchange="changeForm(this);"/>
                                            <span>결재 상태</span>
                                        </label>
                                        <button id="resetBtn" type="reset" class="btn btn-default" title="Refresh" style="display: none;"></button>
                                        <label onclick="conditionReset();"  style="cursor: pointer;">
                                            <i class="fa fa-refresh"></i>&nbsp&nbsp검색 조건 초기화
                                        </label>
                                        <div style="display:inline-block;margin:5px 15px;font-size: 1.2em;color:gray;">
                                        </div>

                                    </div>

                                    <!-- 설정된 검색 조건 입력 폼 표시 -->
                                    <div>
                                        <div class="input-group date searchCri searchDt selectDt myConditions" data-date-autoclose="true" data-provide="datepicker" style="font-size:1.2em;width:200px;margin-right:15px;float:left;display:none;">
                                            <div class="input-group-append">
                                                <button class="btn btn-outline-secondary" type="button"><i class="fa fa-calendar"></i></button>
                                            </div>
                                        </div>

                                        <div id="navbar-search" class="navbar-form search-form selectSearch" style="float:left;">
                                            <button type="button" class="btn btn-default" onclick="searchList();"><i class="icon-magnifier"></i></button>
                                        </div>

                                        <div class="form-group" style="float:right;">
                                            <div style="display: inline-block;float:left;font-size: 1.2em;margin:6px 20px 0 0">
                                                <span>${paginationInfo.currentPageNo} </span>/<span> ${paginationInfo.totalPageCount} 페이지 중</span>
                                            </div>
                                        </div>
                                    </div>


                                    <!-- 리스트시작 -->
                                    <div class="table-responsive" style="overflow: inherit;">
                                        <table class="table table-hover m-b-0 c_list">
                                            <thead>
                                            <tr>
                                                <th>상신날짜</th>
                                                <th>사용 양식</th>
                                                <th>기안서 제목</th>
                                                <th>첨부</th>
                                                <th>문서번호</th>
                                                <th>결재상태</th>
                                            </tr>
                                            </thead>
                                            <tbody style="cursor: pointer;">
                                                <%-- 				                                    <tr onclick='OpenWindow("<%=request.getContextPath()%>/approval/completeDocDetail?docId="+${doc.docId}+"", "결재문서" ,1000,900);'> --%>

                                                    <tr >
                                                    <tr>

                                                <td></td>
                                                <td><span>${doc.formName}</span></td>
                                                <td><span class="text-info">${doc.approvalTitle}</span></td>
                                                <td>
                                                        &nbsp<i class="fa fa-save"></i>&nbsp&nbsp${doc.attachCnt}
                                                </td>
                                                <td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp${doc.docId}</td>


                                                                <td><span class="badge badge-info">결재대기중</span></td>
                                                        <td><span class="badge badge-success">결재진행중</span></td>
                                                    <td><span class="badge badge-default">결재완료</span></td>
                                                    <td><span class="badge-purple badge">결재반려</span></td>

                                                </tr>
                                                <tr>
                                                    <td colspan="6" style="text-align: center;"><strong>해당 결재문서가 존재하지 않습니다.</strong></td>
                                                </tr>

                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- Pagination -->
                                <nav aria-label="Page navigation example" style="height:45px;text-align: center;margin-top:5px;">
                                    <ul class="pagination" style="display: inline-block;">
                                    </ul>
                                </nav>

                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</section>
<!-- 푸터 인클루드 -->
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>

</html>
