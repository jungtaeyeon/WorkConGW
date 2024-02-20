<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
    <title>업무관리</title>
<style>
    .noList:hover{
        background-color: white;
        cursor: default;
    }
</style>

</head>

<body>
<%--헤더--%>
<%@ include file="../../include/header.jsp"%>
<section class="subPageContain">
<%--    사이드바--%>
    <%@ include file="../issueSidebar.jsp"%>

    <!-- 메인 content -->
<div id="main-content" style="width: 100%">
    <div class="container-fluid">
        <div class="row clearfix">
            <div class="col-12" style="margin-top: 2%; font-family: S-CoreDream-6Bold">
                <h2>
                    <c:choose>
                        <c:when test="${empty param.dutyType }">
                            <i class="fa fa-th-list"></i>&nbsp;업무 목록
                        </c:when>
                        <c:otherwise>
                            <c:if test="${param.dutyType eq 'receive' }">
                                <i class="fas fa-envelope"></i>&nbsp;받은 업무목록
                            </c:if>
                            <c:if test="${param.dutyType eq 'send' }">
                                <i class="fa fa-send-o"></i>&nbsp;보낸 업무목록
                            </c:if>
                            <c:if test="${param.dutyType eq 'reception' }">
                                <i class="fa fa-chain"></i>&nbsp;참조 업무목록
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </h2>
                <hr>
            </div>
        </div>

        <div class="row clearfix" style="font-family: S-CoreDream-7ExtraBold">
            <div class="col-lg-12 col-md-12">
                <div class="card">
                    <div class="body project_report">
                        <form:form modelAttribute="boardFormVO" id="listForm" name="listForm">
                            <!-- 검색 조건 설정 -->
                            <h5 style="display:inline-block; font-weight: bold;">검색 조건</h5>
                            <div class="alert alert-light" role="alert" style="display:inline-block;padding-top:0;margin-bottom:0;">
                                <label class="fancy-checkbox">
                                    <input type="checkbox" id="checkboxDeadline" data="selectDeadline" data-parsley-multiple="checkbox" onchange="changeForm(this);"/>
                                    <span>완료 기한(까지)</span>
                                </label>
                                <label class="fancy-checkbox">
                                    <input type="checkbox" id="checkboxState" data="selectState" data-parsley-multiple="checkbox" onchange="changeForm(this);"/>
                                    <span>진행 상태</span>
                                </label>

                                <!-- 리셋버튼 -->
                                <label onclick="conditionReset();"  style="cursor: pointer;">
                                    <i class="fa fa-refresh"></i>&nbsp;&nbsp;검색 조건 초기화
                                </label>

                                <div style="display:inline-block;margin:5px 15px;font-size: 1.2em;color:gray;">
                                    [총 <fmt:formatNumber value="${paginationInfo.totalRecordCount }" type="number"/>개]
                                </div>
                            </div>

                            <!-- 설정된 검색 조건 입력 폼 표시 -->
                            <div>
                                <div class="input-group date selectDeadline myConditions" data-date-autoclose="true" data-provide="datepicker" style="font-size:1.2em;width:200px;margin-right:15px;float:left;display:none;">
                                    <form:input path="searchDutyVO.searchDeadline" id="inputSearchDeadline" type="text" class="form-control selectDeadline" placeholder="완료날짜 선택" readonly="true"/>
                                    <div class="input-group-append">
                                        <button class="btn btn-outline-secondary" type="button"><i class="fas fa-calendar"></i></button>
                                    </div>
                                </div>
                                <form:select path="searchDutyVO.searchState" id="selectSearchState" class="form-control selectState myConditions" style="width:200px;font-size: 1.2em;margin-right:15px;float:left;display: none;">
                                    <form:option value="">진행 상태 선택</form:option>
                                    <form:option value="Y">진행중</form:option>
                                    <form:option value="N">종료</form:option>
                                </form:select>

<%--                                백단 끝나면 form태그 사용 select는 임시로 화면만 짜놓은것--%>
                                <form:select path="searchDutyVO.searchCondition" class="form-control selectSearch" style="width:130px;font-size: 1.2em;float:left;">
                                    <form:option value="tcmn">전체</form:option>
                                    <form:option value="t">제목</form:option>
                                    <form:option value="c">내용</form:option>
                                    <form:option value="m">담당자</form:option>
                                    <form:option value="n">업무번호</form:option>
                                </form:select>

                                <div id="navbar-search" class="navbar-form search-form selectSearch" style="float:left;">
                                    <form:input path="searchDutyVO.searchKeyword" class="form-control" placeholder="검색어 입력" type="text" style="display: inline-block; width: 400px;height:36px;padding-right: 40px;" onkeypress="checkEnter(searchDutyList);"/>
                                    <button type="button" class="btn btn-default" onclick="searchDutyList();"><i class="fas fa-search"></i></button>
                                </div>

                                <div class="form-group" style="float:right;">
                                    <div style="display: inline-block;float:left;font-size: 1.2em;margin:6px 20px 0 0">
                                        <span>${paginationInfo.currentPageNo} </span>/<span> ${totalPageCnt} 페이지 중</span>
                                    </div>
<%--                                    <form:select path="searchDutyVO.pageUnit" class="form-control" style="width:130px;font-size: 1.2em;" onchange="searchDutyList(1);">--%>
<%--                                        <form:options items="${boardFormVO.searchDutyVO.pageUnitSelector}" itemValue="pageUnitValue" itemLabel="pageUnitLabel"/>--%>
<%--                                    </form:select>--%>
                                </div>
                            </div>

                            <!-- 게시판 목록 -->
                            <div class="table-responsive">
                                <table class="table table-hover js-basic-example dataTable table-custom m-b-0 no-footer" id="DataTables_Table_0" role="grid" aria-describedby="DataTables_Table_0_info">
                                    <thead>
                                    <tr role="row">
                                        <th class="sorting_desc" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" aria-sort="descending" aria-label="Deadline: activate to sort column descending" style="width: 50px;text-align: center;">업무 번호</th>
                                        <th class="sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" aria-label="Project: activate to sort column ascending" style="width: 300px;">업무 제목</th>
                                        <th class="sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" aria-label="Deadline: activate to sort column ascending" style="width: 100px;">완료 기한</th>
                                        <th class="sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" aria-label="Deadline: activate to sort column ascending" style="width: 80px;">진행 상태</th>
                                        <th class="sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" aria-label="Lead: activate to sort column ascending" style="width: 67px;">작성자</th>
                                        <th class="sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" aria-label="Team: activate to sort column ascending" style="width: 100px;">수신자</th>
                                        <th class="sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" aria-label="Status: activate to sort column ascending" style="width: 60px;text-align: center;">참조자</th>
                                        <th class="sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" aria-label="Status: activate to sort column ascending" style="width: 60px;text-align: center;">조회수</th>
                                        <th class="sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" aria-label="Action: activate to sort column ascending" style="width: 60px;text-align: center;">프로젝트</th>
                                    </tr>
                                    </thead>
                                    <tbody style="cursor: pointer;">
                                    <c:if test="${dutyList.size() > 0 }">
                                        <c:forEach items="${dutyList }" var="duty">
<%--                                            <fmt:parseNumber value="${myToday.time - duty.duty_Board_Create_Dt.time }" integerOnly="true" var="defferTime"/>--%>
                                            <tr role="row" onclick="OpenWindow('<%=request.getContextPath()%>/board/duty/detail?duty_Board_Id=${duty.duty_Board_Id }', 'JoinWorkGW', 1000, 700);">
                                                <td style="text-align:center;">${duty.duty_Board_Id }</td>
                                                <td class="project-title sorting_1">
                                                    <span>${duty.duty_Board_Title }</span>
                                                    <c:if test="${defferTime <= (1000*60*30) }">
                                                        &nbsp<span class="badge badge-danger">방금전</span>
                                                    </c:if>
                                                    <c:if test="${duty.reply_Count != 0 }">
                                                        <i class="fas fa-comment text-info" style="margin-left:5px; font-size: 1.2em; font-weight: bold"><span class="m-l-5" style="vertical-align: text-top; margin-left: 3px;"><fmt:formatNumber value="${duty.reply_Count }" type="number"/></span></i>
                                                    </c:if>
                                                    <c:if test="${duty.attachCount ne 0}">
                                                        <i class="fa fa-file-o fa-2x text-info" style="margin-left:5px; font-size: 1.2em; font-weight: bold">&nbsp<fmt:formatNumber value="${duty.attachCount }" type="number"/></i>
                                                    </c:if>
                                                    <br>
                                                    <small>
                                                        생성일: <fmt:formatDate value="${duty.duty_Board_Create_Dt }" pattern="yyyy.MM.dd"/>
                                                    </small>
                                                </td>
                                                <td>
                                                    <c:if test="${!empty duty.duty_Board_End_Dt }">
                                                        <fmt:formatDate value="${duty.duty_Board_End_Dt }" pattern="yyyy.MM.dd"/>
                                                    </c:if>
                                                    <fmt:parseNumber value="${myToday.time / (1000*60*60*24)}" integerOnly="true" var="strDate"></fmt:parseNumber>
                                                    <fmt:parseNumber value="${duty.duty_Board_End_Dt.time / (1000*60*60*24)}" integerOnly="true" var="endDate"></fmt:parseNumber>
                                                    <c:if test="${(endDate-strDate) < 3 && (endDate-strDate) >= 0 && duty.duty_Board_End_Dt.getTime() >= today}">
                                                        <span class="badge badge-danger">마감임박</span>
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${empty duty.duty_Board_End_Dt || duty.duty_Board_End_Dt.getTime() >= today }">
                                                            <span class="badge badge-success">진행중</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge badge-danger">종료</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <span>${duty.emp_Name}</span>
                                                </td>
                                                <td>
                                                    <ul class="list-unstyled team-info">
                                                        <c:forEach items="${duty.dutyEnforcerList}" var="dutyEnforcer" varStatus="myStatus">
                                                            <c:if test="${myStatus.first}">
                                                                <li>${dutyEnforcer.emp_Name }
                                                                    <c:if test="${not myStatus.last}">
                                                                        외 ${duty.dutyEnforcerList.size() - 1}명
                                                                    </c:if>
                                                                </li>
                                                            </c:if>
                                                        </c:forEach>
                                                    </ul>
                                                </td>
                                                <td style="text-align:center;">
                                                        ${duty.dept_Cnt + duty.emp_Cnt }명
                                                </td>
                                                <td style="text-align:center;">${duty.duty_Board_Readcnt }</td>
                                                <td class="project-actions" style="text-align:center;">
                                                <c:if test="${duty.project_Id == 0 }">
                                                    없음
                                                </c:if>
                                                <c:if test="${duty.project_Id != 0 }">
                                                    # ${duty.project_Id}
                                                </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:if>
                                    <c:if test="${dutyList.size() == 0 }">
                                        <tr>
                                            <td class="noList" style="text-align:center;font-size:1.2em;font-weight: bold;height:80px;" colspan="8">검색 결과가 없습니다.</td>
                                        </tr>
                                    </c:if>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Pagination -->
                            <div aria-label="Page navigation example" style="height:45px;text-align: center;margin-top:5px;">
                                <div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate" >
                                <ul class="pagination">
                                    <c:if test="${boardFormVO.searchDutyVO.prev}">
                                        <li class="paginate_button page-item previous" id="dataTable_previous">
                                            <a href="javascript:void(0);" onclick="searchDutyList(${boardFormVO.searchDutyVO.startDate - 1}); return false;" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a>
                                        </li>
                                    </c:if>

                                    <c:forEach var="num" begin="${boardFormVO.searchDutyVO.startDate}" end="${boardFormVO.searchDutyVO.endDate}">
                                        <li class="paginate_button page-item">
                                            <a href="javascript:void(0);" onclick="searchDutyList(${num}); return false;" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">${num}</a>
                                        </li>
                                    </c:forEach>

                                    <c:if test="${boardFormVO.searchDutyVO.next}">
                                        <li class="paginate_button page-item next" id="dataTable_next">
                                            <a href="javascript:void(0);" onclick="searchDutyList(${boardFormVO.searchDutyVO.endDate + 1}); return false;" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Next</a>
                                        </li>
                                    </c:if>
                                </ul>
                                </div>
                            </div>
                            <form:hidden path="searchDutyVO.pageIndex" />
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</section>

<script>
    window.onload=function(){
        // 정렬 아이콘 삭제
        var thList = $('tr[role="row"] > th');
        for(var i=0; i<thList.length; i++){
            thList.eq(i).removeClass();
        }

        // 검색 조건 체크박스 설정
        if($('#inputSearchDeadline').val()!=""){
            $('#checkboxDeadline').attr("checked",true);
            changeForm(document.getElementById('checkboxDeadline'));
        }
        if($('#selectSearchState').val()!=""){
            $('#checkboxState').attr("checked",true);
            changeForm(document.getElementById('checkboxState'));
        }
    }

    // 검색 조건 설정 변화
    function changeForm(obj){
        var searchCri = $(obj).attr('data');

        if($(obj).is(':checked')==true){
            $('.'+searchCri).css('display','');
        }else{
            $('.'+searchCri).css('display','none');
            $('.'+searchCri).val("");
        }
    }

    // 검색 및 페이지네이션
    function searchDutyList(pageNo){
        if(!pageNo){
            pageNo = 1;
        }
        var listForm = $('form[name="listForm"]');
        $('input[name="searchDutyVO.pageIndex"]').val(pageNo);
        listForm.submit();
    }

    // 검색조건 초기화
    function conditionReset() {
        $('.myConditions').css("display","none");
        $('input#checkboxDeadline').prop('checked',false);
        $('input#checkboxState').prop('checked',false);
        $('input[name="searchDutyVO.searchKeyword"]').val("");
        $('select[name="searchDutyVO.searchCondition"]').val('tcmn');
        $('form[name="listForm"]').submit();
    }
</script>
</body>
</html>