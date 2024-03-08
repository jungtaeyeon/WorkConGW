<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<style>
    .subTitleText {
        margin-bottom: 25px;
    }
    .subTitleText h2 {
        display: flex;
        justify-content: flex-start;
        align-items: center;
        font-size: 27px;
        padding: 10px 0;
        font-family: "Noto Sans KR", sans-serif;
    }
    .subTitleText i {
        font-size: 24px;
        margin-right: 5px;
    }
</style>
<!-- 헤더인클루드 -->
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<section class="subPageContain">
    <!-- 사이드바 -->
    <%@ include file="../sideBar.jsp"%>
    <!--컨텐츠 영역-->
    <div class="contentConteiner">
        <div id="main-content">
            <div class="container-fluid">
                <!-- 메인 content 넣는 곳 -->
                <div class="row clearfix">
                    <div class="col-12" style="padding: 0;">
                        <div class="subTitleText">
                            <h2><i class="fa-solid fa-angles-right"></i>반려문서</h2>
                        </div>
                    </div>
                </div>

                <div class="row clearfix">
                    <div class="col-12" style="padding: 0;">
                        <div>
                            <form:form modelAttribute="approvalFormVO" id = "listForm" name = "listForm" method="get">
                                <div class="body">
                                    <!-- 검색 조건 설정 -->
                                    <h5 style="display:inline-block; font-weight: bold;">검색 조건</h5>
                                    <div class="alert alert-light" role="alert" style="padding: 0; margin: 0;">
                                        <label class="fancy-checkbox" style="font-size:15px;">
                                            <input type="checkbox" data="selectDt" id="dateCheckBox" data-parsley-multiple="checkbox" onchange="changeForm(this);"/>
                                            <span>기안 날짜</span>
                                        </label>
                                        <button id="resetBtn" type="reset" class="btn btn-default" title="Refresh" style="display: none;"></button>
                                        <label onclick="conditionReset();"  style="cursor: pointer; font-size:15px; margin-left: 8px;">
                                            <i class="fa fa-refresh"></i>&nbsp&nbsp검색 조건 초기화
                                        </label>
                                        <div style="display:inline-block;margin:5px 15px;font-size: 1.2em;color:gray;">
                                            [총 <fmt:formatNumber value="${paginationInfo.totalRecordCount }" type="number"/>개]
                                        </div>

                                    </div>

                                    <!-- 설정된 검색 조건 입력 폼 표시 -->
                                    <div style="margin-bottom: 20px;">
                                        <div class="input-group date searchCri searchDt selectDt myConditions" data-date-autoclose="true" data-provide="datepicker" style="font-size:1.2em;width:200px;margin-right:15px;float:left;display:none;">
                                            <form:input path="searchApprovalVO.searchDt" id="inputSearchDt" type="text" class="form-control" placeholder="완료날짜 선택" readonly="true"/>
                                            <div class="input-group-append">
                                                <button class="btn btn-outline-secondary" type="button"><i class="fa fa-calendar"></i></button>
                                            </div>
                                        </div>

                                        <form:select path = "searchApprovalVO.searchCondition" class="form-control selectSearch" style="width:130px;float:left;">
                                            <form:option value="ftd">전체</form:option>
                                            <form:option value="f">양식</form:option>
                                            <form:option value="t">제목</form:option>
                                            <form:option value="d">문서번호</form:option>
                                        </form:select>
                                        <button class="btn btn-secondary" onclick="searchList()" type="button"><i class='fas fa-search'></i>검색</button>

                                        <div id="navbar-search" class="navbar-form search-form selectSearch" style="float:left;">
                                            <form:input path = "searchApprovalVO.searchKeyword" class="form-control" placeholder="검색해주세요." type="text" style="width: 218px;padding-right: 40px;" onkeypress="checkEnter(searchList);"/>
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
                                            <thead class="thead-light">
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
                                            <c:forEach items="${approvalList }" var="doc">
                                                <tr onclick="window.location='<%=request.getContextPath()%>/approval/rejectDetail?docId=${doc.doc_Id}';">
                                                    <td><fmt:formatDate value = "${doc.approval_Recommand_Dt}" pattern="yyyy-MM-dd"/></td>
                                                    <td><span>${doc.form_Name}</span></td>
                                                    <td><span class="text-info">${doc.approval_Title}</span></td>
                                                    <td>
                                                        &nbsp<i class="fa fa-save"></i>&nbsp&nbsp${doc.attachCnt}
                                                    </td>
                                                    <td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp${doc.doc_Id}</td>


                                                    <c:if test="${doc.approval_St eq 1}">
                                                        <td><span class="badge badge-success">결재진행중</span></td>
                                                    </c:if>
                                                    <c:if test="${doc.approval_St eq 2}">
                                                        <td><span class="badge badge-primary">결재완료</span></td>
                                                    </c:if>
                                                    <c:if test="${doc.approval_St eq 3}">
                                                        <td><span class="badge badge-danger">결재반려</span></td>
                                                    </c:if>
                                                </tr>
                                                <c:if test = "${empty approvalList}">
                                                    <tr>
                                                        <td colspan="6" style="text-align: center;"><strong>해당 결재문서가 존재하지 않습니다.</strong></td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                        <!-- Pagination -->
                                        <div class="col-sm-12" style="text-align:right">
                                            <div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate" style="display: flex; justify-content: center; align-items: center;">
                                                <ul class="pagination">

                                                    <c:if test="${searchApprovalVO.prev}">
                                                        <li class="paginate_button page-item previous" id="dataTable_previous">
                                                            <a href="javascript:void(0);" onclick="searchList(${searchApprovalVO.startDate - 1}); return false;" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a>
                                                        </li>
                                                    </c:if>

                                                    <c:forEach var="num" begin="${searchApprovalVO.startDate}" end="${searchApprovalVO.endDate}">
                                                        <li class="paginate_button page-item">
                                                            <a href="javascript:void(0);" onclick="searchList(${num}); return false;" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">${num}</a>
                                                        </li>
                                                    </c:forEach>

                                                    <c:if test="${searchApprovalVO.next}">
                                                        <li class="paginate_button page-item next" id="dataTable_next">
                                                            <a href="javascript:void(0);" onclick="searchList(${searchApprovalVO.endDate + 1}); return false;" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Next</a>
                                                        </li>
                                                    </c:if>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <form:hidden path="searchApprovalVO.pageIndex"/>
                            </form:form>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</section>
<!-- 푸터 인클루드 -->
<%@ include file="/WEB-INF/views/include/footer.jsp"%>

<script>

    function OpenWindow(UrlStr, WinTitle, WinWidth, WinHeight){
        winleft = (screen.width - WinWidth) / 2;
        wintop = (screen.height - WinHeight) / 2;
        var winX      = window.screenX || window.screenLeft || 0;// 현재창의 x좌표
        var winY      = window.screenY || window.screenTop || 0; // 현재창의 y좌표

        winleft = winX + winleft;
        wintop = winY + wintop;

        var win = window.open(UrlStr, WinTitle, "scrollbars=yes,width="+ WinWidth +", "
            +"height="+WinHeight + ", top=" + wintop +", left="
            + winleft +", resizable=yes, status=yes");
        win.focus();
    }

    // 검색 및 페이지네이션
    function searchList(pageNo){
        if(!pageNo){
            pageNo = 1;
        }
        let listForm = $('form[name="listForm"]');
        $('input[name="searchApprovalVO.pageIndex"]').val(pageNo);

        listForm.submit();

    }


    $(document).ready(function() {

        let thisIndex = "${searchApprovalVO.pageIndex}"
        $(".pagination li a").each(function(){
            let idx = $(this).parent().index();
            let thistitle = $(this).attr("title");
            if(thistitle == thisIndex){
                $(".pagination").find("li").eq(idx).addClass("active");
            }
        });

    });

    function changeForm(obj){
        var searchCri = $(obj).attr('data');

        if($(obj).is(':checked')==true){
            $('.'+searchCri).css('display','');
        }else{
            $('.'+searchCri).css('display','none');
            $('.'+searchCri).val("");
        }
    }

    function conditionReset()
    {
        $("#resetBtn").click()
        $(".myConditions").css('display','none')
        $("input:checkbox:checked").click()
        $("#inputSearchDt").val("")
    }

    window.onload = function() {
        // 검색 조건 체크박스 설정
        if($('#inputSearchDt').val()!=""){
            $('#dateCheckBox').attr("checked",true);
            changeForm(document.getElementById('dateCheckBox'));
        }
        if($('#selectSearchState').val()!=""){
            $('#checkboxState').attr("checked",true);
            changeForm(document.getElementById('checkboxState'));
        }}



</script>

</body>
</html>
