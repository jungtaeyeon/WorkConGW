<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script src="<%=request.getContextPath() %>/js/common.js"></script>
<style>

  .pagination{
    text-align: center;
    justify-content: center;
  }

  #tr1{
    text-align: center;
    padding-left: -10px;
  }
  #tr2{
      text-align: center;
      padding-left: -10px;
  }
  #tr2{
      text-align: center;
      padding-left: -10px;
  }

  tbody{
    text-align: center;"
  }

  #td2{
    text-align: left;
  }
  .sidebar-nav .metismenu ul a::before{
    content:'';
  }

  .scrollable-tbody {
    max-height: 300px; /* 원하는 높이 지정 */
    overflow-y: auto; /* 세로 스크롤이 필요한 경우만 스크롤 표시 */
  }
</style>

<body>
<!-- 헤더인클루드 -->
<%@ include file="../../include/header.jsp"%>
<section class="subPageContain">
  <!-- 사이드바 -->
  <%@ include file="../boardSidebar.jsp"%>
  <!--컨텐츠 영역-->

  <div class="contentConteiner">

<!-- 메인 content -->
<div id="main-content" >
  <div class="container-fluid">
    <div class="row clearfix">
      <div class="col-12" style="margin-top: 2%;">
        <h2 style="font-family: S-CoreDream-6Bold"><i class="fa fa-bullhorn" ></i>&nbsp;사내공지</h2>
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
                  <input type="checkbox" data="selectDt" id="dateCheckBox" data-parsley-multiple="checkbox" onchange="changeForm(this);"/>
                  <span>작성 날짜</span>&nbsp&nbsp
                </label>

                <!-- 리셋버튼 -->
                <button id="resetBtn" type="reset" class="btn btn-default" title="Refresh" style="display: none;"></button>
                <label onclick="conditionReset();"  style="cursor: pointer;">
                  <i class="fas fa-refresh"></i>검색 조건 초기화
                </label>

                <div style="display:inline-block;margin:5px 15px;font-size: 1.2em;color:gray;">
                  [총 게시물 <fmt:formatNumber value="${totCnt }" type="number"/>개]
                </div>
              </div>
              <!-- 설정된 검색 조건 입력 폼 표시 -->
              <div>
                <div class="input-group date searchCri searchDt selectDt myConditions" data-date-autoclose="true" data-provide="datepicker" style="font-size:1.2em;width:200px;margin-right:15px;float:left;display:none;">
                  <form:input path="searchNoticeVO.searchDt" id="inputSearchDt" type="text" class="form-control" placeholder="작성날짜 선택" readonly="true"/>
                  <div class="input-group-append">
                    <button class="btn btn-outline-secondary" type="button"><i class="fas fa-calendar"></i></button>
                  </div>
                </div>

                <form:select path="searchNoticeVO.searchCondition" class="form-control selectSearch" style="width:130px;font-size: 0.92em;float:left;">
                  <form:option value="tcm">전체</form:option>
                  <form:option value="t">제목</form:option>
                  <form:option value="c">내용</form:option>
                  <form:option value="m">작성자</form:option>
                </form:select>
                <div id="navbar-search" class="navbar-form search-form selectSearch" style="float:left;">
                  <form:input path="searchNoticeVO.searchKeyword" class="form-control" placeholder="검색어를 입력하세요" type="text" style="width: 168px; height: 36px; display: inline-block;" onkeypress="checkEnter(searchNoticeList);"/>
                  <button type="button" class="btn btn-default" onclick="searchNoticeList();"><i class='fas fa-search'></i></button>
                </div>

                <div class="form-group" style="float:right;">
                  <div style="display: inline-block;float:left;font-size: 1.2em;margin:6px 20px 0 0">
                    <span>${paginationInfo.currentPageNo} </span>/<span> ${totalPageCnt} 페이지 중</span>
                  </div>
                </div>
              </div>
              <div class="body" style="padding: 0;">
                <div class="table-responsive" style="overflow: hidden;">
                  <table class="table table-hover m-b-0">
                    <thead class="shadow-none p-3 mb-5 bg-light rounded">
                      <tr id="tr1">
                        <th style="width:80px;">번호</th>
                        <th>분류</th>
                        <th>제목</th>
                        <th>작성일자</th>
                        <th>작성자</th>
                        <th>조회수</th>
                        <th>첨부파일</th>
                      </tr>
                    </thead>
                    <tbody style="cursor: pointer;">
                    <c:forEach items="${importantNoticeList }" var="notice" varStatus="loop">
                      <fmt:parseNumber value="${(today.time) - (notice.notice_create_dt.time) }" integerOnly="true" var="defferTime"/>
                      <tr class="xl-pink" onclick="window.location.href='<%=request.getContextPath()%>/board/notice/detail?notice_id=${notice.notice_id}';" >
                        <td id="notice_id" >${notice.notice_id }</td>
<%--                        <td>${loop.index + boardFormVO.searchNoticeVO.firstIndex +1}</td>--%>
<%--                          <td>${importantNoticeList.size() - loop.index + boardFormVO.searchNoticeVO.firstIndex}</td>--%>
<%--                        <td>${importantNoticeList.size() - loop.index}</td>--%>
                        <c:if test="${notice.notice_important_st eq 1}">
                          <td id="noticeImportantYN"><span class="badge badge-danger">필독</span></td>
                        </c:if>
                        <td id="noticeTitle" style="text-align: left; padding-left: 80px; " >
                          <span>${notice.notice_title}</span>
                          <c:if test="${defferTime <= (1000*60*30) }">
                            &nbsp<span class="badge badge-danger">방금전</span>
                          </c:if>
                        </td>
                        <td id="notice_Create_Dt"><fmt:formatDate value="${notice.notice_create_dt }" pattern="yyyy-MM-dd"/></td>
                        <td id="empName">${notice.emp_Name }&nbsp${notice.officialName }</td>
                        <td>${notice.notice_readcnt }
                        </td>
                        <td>
                          <c:if test="${notice.attachCount ne 0}">
                            <i class="fa fa-file-text fa-2x text-info"></i>
                          </c:if>
                        </td>
                      </tr>
                    </c:forEach>
                    </tbody>
                  </table>

                  <div style="margin-top: 50px;"></div>

                    <%--                    일반 공지 + 필독공지 --%>
                  <table class="table table-hover m-b-0">
                    <thead class="shadow-none p-3 mb-5 bg-light rounded">
                      <tr id="tr2">
                        <th style="width:80px;">번호</th>
                        <th>분류</th>
                        <th>제목</th>
                        <th>작성일자</th>
                        <th>작성자</th>
                        <th>조회수</th>
                        <th>첨부파일</th>
                      </tr>
                    </thead>
                    <tbody style="cursor: pointer;">
                    <c:forEach items="${noticeList}" var="notice" varStatus="loop">
                      <fmt:parseNumber value="${today.time - notice.notice_create_dt.time }" integerOnly="true" var="defferTime"/>
                      <tr onclick="window.location.href='<%=request.getContextPath()%>/board/notice/detail?notice_id=${notice.notice_id}';" >
                        <td id="notice_id" >${notice.notice_id }</td>
<%--                        <td>${loop.index + boardFormVO.searchNoticeVO.firstIndex +1}</td>--%>

                        <c:if test="${notice.notice_important_st eq 1}">
                          <td id="noticeImportantYN"><span class="badge badge-danger">필독</span></td>
                        </c:if>
                        <c:if test="${notice.notice_important_st eq 0}">
                          <td id="noticeImportantYN"><span class="badge badge-success">공지</span></td>
                        </c:if>
                        <td id="noticeTitle" style="text-align: left; padding-left: 80px; cursor: pointer;" onclick="window.location.href='<%=request.getContextPath()%>/board/notice/detail?notice_id=${notice.notice_id}';">
                          <span>${notice.notice_title}</span>
                          <c:if test="${defferTime <= (1000*60*5) }">
                            &nbsp<span class="badge badge-danger">방금전</span>
                          </c:if>
                        </td>
                        <td id="notice_Create_Dt"><fmt:formatDate value="${notice.notice_create_dt}" pattern="yyyy-MM-dd"/></td>
                        <td id="empName">${notice.emp_Name}&nbsp${notice.officialName }</td>
                        <td>${notice.notice_readcnt }</td>
                        <td>
                          <c:if test="${notice.attachCount ne 0}">
                            <i class="fa fa-file-text fa-1x text-info"></i>
                          </c:if>
                        </td>
                      </tr>
                    </c:forEach >
                    <c:if test="${empty noticeList}" >
                      <tr>
                        <td colspan="7" style="text-align: center;"><strong>해당 공지 게시물이 존재하지 않습니다.</strong></td>
                      </tr>
                    </c:if>
                    </tbody>
                  </table>
                </div>
              </div>
              <!-- Pagination -->
              <div class="col-sm-12 col-md-12" style="text-align:right">
                <div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate" >
                  <ul class="pagination">

                    <c:if test="${boardFormVO.searchNoticeVO.prev}">
                      <li class="paginate_button page-item previous" id="dataTable_previous">
                        <a href="javascript:void(0);" onclick="searchNoticeList(${boardFormVO.searchNoticeVO.startDate - 1}); return false;" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a>
                      </li>
                    </c:if>

                    <c:forEach var="num" begin="${boardFormVO.searchNoticeVO.startDate}" end="${boardFormVO.searchNoticeVO.endDate}">
                      <li class="paginate_button page-item">
                        <a href="javascript:void(0);" onclick="searchNoticeList(${num}); return false;" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">${num}</a>
                      </li>
                    </c:forEach>

                    <c:if test="${boardFormVO.searchNoticeVO.next}">
                      <li class="paginate_button page-item next" id="dataTable_next">
                        <a href="javascript:void(0);" onclick="searchNoticeList(${boardFormVO.searchNoticeVO.endDate + 1}); return false;" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Next</a>
                      </li>
                    </c:if>
                  </ul>
                </div>
              </div>

              <form:hidden path="searchNoticeVO.pageIndex" />
            </form:form>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
  </div>
</section>
<%-- 푸터 인클루드 --%>
</body>

<script>

  window.onload=function() {
    // 정렬 아이콘 삭제
    var thList = $('tr[role="row"] > th');
    for (var i = 0; i < thList.length; i++) {
      thList.eq(i).removeClass();
    }
  }

    // 검색 조건 체크박스 설정
    if ($('#inputSearchDt').val() != "") {
      $('#dateCheckBox').attr("checked", true);
      changeForm(document.getElementById('dateCheckBox'));
    }
    if ($('#selectSearchState').val() != "") {
      $('#checkboxState').attr("checked", true);
      changeForm(document.getElementById('checkboxState'));
    }


    // 검색 조건 설정 변화
    function changeForm(obj) {
      var searchCri = $(obj).attr('data');

      if ($(obj).is(':checked') == true) {
        $('.' + searchCri).css('display', '');
      } else {
        $('.' + searchCri).css('display', 'none');
        $('.' + searchCri).val("");
      }
    }

    // 검색 및 페이지네이션
    function searchNoticeList(pageNo) {
      if (!pageNo) {
        pageNo = 1;
      }
      var listForm = $('form[name="listForm"]');
      $('input[name="searchNoticeVO.pageIndex"]').val(pageNo);
      listForm.submit();
    }

    function conditionReset() {
      $("#resetBtn").click();
      $('.myConditions').css("display", "none");
      $('input#searchNoticeVO.searchKeyword').val("");
      $("input:checkbox:checked").click();
      $("#inputSearchDt").val("");
    }

    // 엔터키 눌렀을 때 검색 가능하게
    function checkEnter(myFunction) {
      if (event.keyCode === 13) {
        myFunction();
      }
    }
</script>