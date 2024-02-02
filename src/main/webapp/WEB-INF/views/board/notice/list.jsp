<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>--%>


<%-- 공통으로 뺄 예정 --%>
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
</script>

<head>
  <!-- Font Awesome CDN -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-" crossorigin="anonymous" />
  <!-- VENDOR CSS -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <!-- Bootstrap Datepicker CSS CDN -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/css/bootstrap-datepicker.min.css" integrity="sha512-34s5cpvaNG3BknEWSuOncX28vz97bRI59UnVtEEpFX536A7BtZSJHsDyFoCl8S7Dt2TPzcrCEoHBGeM4SUBDBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
  <!-- jQuery -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <!-- Bootstrap JS -->
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <!-- Bootstrap Datepicker JS CDN -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/js/bootstrap-datepicker.min.js" integrity="sha512-LsnSViqQyaXpD4mBBdRYeP6sRwJiJveh2ZIbW41EBrNmKxgr/LFZIiWT6yr+nycvhvauz8c2nYMhrP80YhG7Cw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</head>


<style>

  .pagination{
    text-align: center;
  }

  #tr1{
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
</style>

<body>

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
                <!--                            <label class="fancy-checkbox"> -->
                <!--                                  <input type="checkbox" id="checkboxState" data="selectState" data-parsley-multiple="checkbox" onchange="changeForm(this);"/> -->
                <!--                                  <span>진행 상태</span> -->
                <!--                            </label> -->

                <!-- 리셋버튼 -->
                <button id="resetBtn" type="reset" class="btn btn-default" title="Refresh" style="display: none;"></button>
                <label onclick="conditionReset();"  style="cursor: pointer;">
                  <i class="fas fa-refresh"></i>검색 조건 초기화
                </label>

                <div style="display:inline-block;margin:5px 15px;font-size: 1.2em;color:gray;">
                  [총 <fmt:formatNumber value="${paginationInfo.totalRecordCount }" type="number"/>개]
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
<%--                    <span>${paginationInfo.currentPageNo} </span>/<span> ${paginationInfo.totalPageCount} 페이지 중</span>--%>
                  </div>
<%--                  <form:select path="searchNoticeVO.pageUnit" class="form-control" style="width:130px;font-size: 1.2em;" onchange="searchNoticeList(1);">--%>
<%--                    <form:options items="${boardFormVO.searchNoticeVO.pageUnitSelector}" itemValue="pageUnitValue" itemLabel="pageUnitLabel"/>--%>
<%--                  </form:select>--%>
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
                    <c:forEach items="${importantNoticeList }" var="notice">
                      <fmt:parseNumber value="${today.time - notice.notice_create_dt.time }" integerOnly="true" var="defferTime"/>
                      <tr class="xl-pink" onclick="OpenWindow('<%=request.getContextPath()%>/board/notice/detail?notice_id=${notice.notice_id}', '글 상세보기', 1150, 800);" >
                        <td id="notice_id" >${notice.notice_id }</td>
                        <c:if test="${notice.notice_important_yn eq 'Y'}">
                          <td id="noticeImportantYN"><span class="badge badge-danger">필독</span></td>
                        </c:if>
                        <td id="noticeTitle" style="text-align: left; padding-left: 80px; " >
                          <span>${notice.notice_title}</span>
                          <c:if test="${defferTime <= (1000*60*30) }">
                            &nbsp<span class="badge badge-danger">방금전</span>
                          </c:if>
                        </td>
                        <td id="noticeCreateDt"><fmt:formatDate value="${notice.notice_create_dt }" pattern="yyyy-MM-dd"/></td>
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
<%--                    고정 필독 글과 구분을 위해 구분선 추가 --%>
                    <tr style="border-bottom: 2px solid black;"></tr>

                    <c:forEach items="${noticeList}" var="notice">
                      <fmt:parseNumber value="${today.time - notice.notice_create_dt.time }" integerOnly="true" var="defferTime"/>
                      <tr onclick="OpenWindow('<%=request.getContextPath()%>/board/notice/detail?notice_id=${notice.notice_id}', '글 상세보기', 1150, 800);" >
                        <td id="notice_id" >${notice.notice_id }</td>
                        <c:if test="${notice.notice_important_yn eq 'Y'}">
                          <td id="noticeImportantYN"><span class="badge badge-danger">필독</span></td>
                        </c:if>
                        <c:if test="${notice.notice_important_yn eq 'E'}">
                          <td id="noticeImportantYN"><span class="badge badge-danger">긴급공지</span></td>
                        </c:if>
                        <c:if test="${notice.notice_important_yn eq 'N'}">
                          <td id="noticeImportantYN"><span class="badge badge-success">공지</span></td>
                        </c:if>
                        <td id="noticeTitle" style="text-align: left; padding-left: 80px; cursor: pointer;" onclick="OpenWindow('<%=request.getContextPath()%>/board/notice/detail?notice_id=${notice.notice_id}', '글 상세보기', 1150, 700);">
                          <span>${notice.notice_title}</span>
                          <c:if test="${defferTime <= (1000*60*5) }">
                            &nbsp<span class="badge badge-danger">방금전</span>
                          </c:if>
                        </td>
                        <td id="noticeCreateDt"><fmt:formatDate value="${notice.notice_create_dt}" pattern="yyyy-MM-dd"/></td>
                        <td id="empName">${notice.emp_Name}&nbsp${notice.officialName }</td>
                        <td>${notice.notice_readcnt }</td>
                        <td>
                          <c:if test="${notice.attachCount ne 0}">
                            <i class="fa fa-file-text fa-2x text-info"></i>
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
              <nav aria-label="Page navigation example" style="height:45px;text-align: center;margin-top:5px;">
                <ul class="pagination" style="display: inline-block;">
<%--                  <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="searchNoticeList" />--%>
                </ul>
              </nav>
              <form:hidden path="searchNoticeVO.pageIndex" />
            </form:form>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="tab-content p-l-0 p-r-0 text-align" style="font-size: 20px;text-align: center;">
  <button style="font-family:paybooc-Bold; background-color: #2980b9; color: white; border: 0px; width: 80%; height: 3rem; border-radius: 5%; margin: 4% 0;" onclick="OpenWindow('<%=request.getContextPath()%>/board/notice/registForm', '글 등록', 1000, 700);">글 등록</button>
</div>
</body>

<script>
  window.onload=function(){
    // 정렬 아이콘 삭제
    var thList = $('tr[role="row"] > th');
    for(var i=0; i<thList.length; i++){
      thList.eq(i).removeClass();
    }

    // 검색 조건 체크박스 설정
    if($('#inputSearchDt').val()!=""){
      $('#dateCheckBox').attr("checked",true);
      changeForm(document.getElementById('dateCheckBox'));
    }
    if($('#selectSearchState').val()!=""){
      $('#checkboxState').attr("checked",true);
      changeForm(document.getElementById('checkboxState'));
    }

  <%--  paginationCSS(${paginationInfo.currentPageNo},--%>
  <%--          ${paginationInfo.firstPageNoOnPageList},--%>
  <%--          ${paginationInfo.lastPageNoOnPageList},--%>
  <%--          ${paginationInfo.totalPageCount});--%>
  <%--}--%>

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
  function searchNoticeList(pageNo){
    if(!pageNo){
      pageNo = 1;
    }
    var listForm = $('form[name="listForm"]');
    $('input[name="searchNoticeVO.pageIndex"]').val(pageNo);
    listForm.submit();
  }
  function conditionReset() {
    $("#resetBtn").click();
    $('.myConditions').css("display","none");
    $('input#searchNoticeVO.searchKeyword').val("");
    $("input:checkbox:checked").click();
    $("#inputSearchDt").val("");
  }

  // function paginationCSS(currentPageNo, firstPageNoOnPageList, lastPageNoOnPageList, totalPageCount){
  //   var pagination = $('ul.pagination');
  //   pagination.children().each(function(){
  //     var text = $(this).text();
  //     if(text=='[처음]'){
  //       text = '<span class="goPrevPage" aria-hidden="true"><<</span>';
  //     }else if(text=='[이전]'){
  //       text = '<span class="goPrevPage" aria-hidden="true"><</span>';
  //     }else if(text=='[다음]'){
  //       text = '<span class="goNextPage" aria-hidden="true">></span>';
  //     }else if(text=='[마지막]'){
  //       text = '<span class="goNextPage" aria-hidden="true">>></span>';
  //     }
  //     var liTag = '<li class="page-item '
  //             +(currentPageNo==text ? "active" : "")
  //             +'" style="float:left;"><a class="page-link" href="javascript:void(0);" onclick="'+$(this).attr('onclick')+'">'+text+'</a></li>';
  //     pagination.append(liTag);
  //     $(this).remove();
  //   });
  //   if(firstPageNoOnPageList<=1){
  //     $('span.goPrevPage').closest('li').remove();
  //   }
  //   if(lastPageNoOnPageList == totalPageCount){
  //     $('span.goNextPage').closest('li').remove();
  //   }
  // }

  // 엔터키 눌렀을 때 검색 가능하게
  function checkEnter(myFunction){
    if(event.keyCode === 13){
      myFunction();
    }
  }
</script>