<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

일정관리 메인페이지입니다.
<html lang="ko"></html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel=" shortcut icon" href="<%=request.getContextPath()%>/resources/image/favicon.ico">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/vendor/css/fullcalendar.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/vendor/css/bootstrap.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/vendor/css/select2.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/vendor/css/bootstrap-datetimepicker.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/vendor/css/fullcalendar.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/main.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/schedule.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:400,500,600">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<title>일정</title>
    <style>
        html, body {
            margin: 0;
            padding: 0;
            font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
            font-size: 14px;
        }

        #external-events {
            position: fixed;
            z-index: 2;
            top: 20px;
            left: 20px;
            width: 150px;
            padding: 0 10px;
            border: 1px solid #ccc;
            background: #eee;
        }

        /* .demo-topbar + #external-events { /* will get stripped out */ */
        /*    top: 60px; */
        /* } */
        nav.navbar.navbar-fixed-top{
            border: 0px;
        }

        #external-events .fc-event {
            cursor: move;
            margin: 3px 0;
        }

        #calendar-container {
            position: relative;
            z-index: 1;
            margin-left: 200px;
            width: 80%;
        }
        .fc-event{
            padding-bottom: 5px;
            margin-right: 5px;
            cursor: move;
        }

        #drag-item{
            float: left;
            width: 20%;
        }


        .sidebar-scroll{
            padding-left: 10px;
            padding-right: 10px;
        }

        .panel-body{
            padding: 0px 15px 15px 15px;
        }

        #type_filter, span.select2-results, .select2-container, .select2-selection, .select2-results__option, .select2-results__options, .select2-type_filter-results, span.select2-dropdown, span.select2-dropdown--below, .groupOption{
            width: 180px;
        }

        .box-container{
            display: flex;
            justify-content: space-between;
            padding-top: 15px;
        }

        #getExcelBtn{
            font-size: 1.1em;
            font-weight: bold;
            margin-left: 12px;
        }

        .text-btn{
            cursor: pointer;
        }

        .input-group{
            width: 400px;
            margin-left: 0px;
            margin-right: 0px;
        }

        #searchType, #keywordInput, #searchBtn{
            height: 36px;
        }
        #type_filter.select2{
            width: 180px;
        }
        #commonHeader{
            margin-top: 100px;
        }
        .privateSp , .commonSp{
            width: 180px;
            font-size: 20px;
            padding: 13px 15px;
        }
        .fc .fc-view-container .fc-list-view .fc-list-item {
            color:black;
        }
        #privateSchedule{
            color: #74c0fc;
            margin: 3px 10px 10px 50px;
            font-size: large;
            float: right;
        }
        #importantSchedule{
            color: #D25565;
            margin: 3px 10px 10px 50px;
            font-size: large;
            float: right;
        }
        #deptSchedule{
            color: #b070db;
            margin: 3px 10px 10px 50px;
            font-size: large;
            float: right;
        }
        #teamSchedule{
            color: #ffa94d;
            margin: 3px 10px 10px 67px;
            font-size: large;
            float: right;
        }
        #companySchedule{
            color: #a9e34b;
            margin: 3px 10px 10px 50px;
            font-size: large;
            float: right;
        }
        strong {
            font-size: 1.2em;
        }
        .scheduleInfo{
            display: flex;
            vertical-align: middle;
            justify-content: space-between;
        }
        .fc-center h2{
            padding-left: 10px;
        }
        .theme-blue #wrapper:before, .theme-blue #wrapper:after, .theme-blue:before, .theme-blue:after{
            background: #449cff00;
        }
        .form-control{
            font-family: S-CoreDream-7ExtraBold;
        }
        .selectSearchDate{
            height: 36px;
        }
        #excelInfo:hover{
            text-decoration: none;
            color:#87cefa;
        }
        nav:before, nav div:before, div:before, ul:before {
            content:none;
        }
        .navbar-brand{
            margin-left: 0px;
            margin-right: 16px;
            padding: 15px 0;
        }
        nav.navbar.navbar-fixed-top{
            border-bottom-width: 0px;
        }
        .navbar-nav>li>a{
            padding-top: 0px;
            padding-bottom: 0px;
        }
        a{
            text-decoration: none;
            color:#2980b9;
        }
        button:hover{
            background-color: #87cefa;
        }
        #zoomDiv{
            position: relative;
            width: 100%;
        }
        #zoomDiv:before {
            content: "";
            display: block;
            padding-top: 100%;
        }
        #zoomContent{
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
        }
        .zoomBtn{
            margin: 0 0 0 10px;
        }
        .metismenu, .metismenu span{
            list-style: none;
            color: #5a5a5a;
        }
        .metismenu li{
            margin: 5px 0;
        }
        .popoverTitleCalendar{
            width: 150px;
            border-radius: 4%;
            text-align: center;
        }
        .popover-header{
            padding: 5px;
            max-width: 170px;
        }
        .popover-body{
            max-width: 170px;
        }
        .importantStrong {
            text-align: center;
        }
    </style>
</head>



<body>
<!-- 사이드바 -->
<div id="left-sidebar" class="sidebar" style="border-right:2px solid rgb(0,0,0,0.1); margin-top: 50px; left:0px;">
    <div class="sidebar-scroll">
        <div class="tab-content p-l-0 p-r-0 text-align" style="font-size: 25px; ">
            <button type="button"  id="schedule_go_btn" onclick="schedule_go()" style="background-color: #2980b9; color: white; border: 0px; width: 14rem; height: 3.8rem; margin-left: 3.5%; border-radius: 5%; margin-top: 12%; font-family: InfinitySans-RegularA1">새 일정</button>
        </div>

        <div class="tab-content p-l-0 p-r-0" style="font-size: 25px; margin-left: 3%; padding-bottom: 0; font-family: S-CoreDream-4Regular">
            나의 일정
        </div>
        <ul class="main-menu metismenu">
            <li id="li_mySchedule">
                <a href="javascript:event.preventDefault();"  style="font-family: S-CoreDream-4Regular; font-size: 20px;"><i class="fa fa-square" id="privateSchedule"></i></i> <span>개인일정</span></a>
            </li>
            <li id="li_importantSchedule">
                <a href="javascript:event.preventDefault();" class="" style="font-family: S-CoreDream-4Regular; font-size: 20px;"><i class="fa fa-square" id="importantSchedule"></i> <span>중요일정</span></a>
            </li>
        </ul>
        <div id="commonHeader" class="tab-content p-l-0 p-r-0" style="font-size: 25px; margin-left: 3%; padding-bottom: 0; font-family: S-CoreDream-4Regular">
            공유 일정
        </div>
        <ul class="main-menu metismenu">
            <li id="li_companySchedule">
                <a href="javascript:event.preventDefault();" class="" style="font-family: S-CoreDream-4Regular; font-size: 20px;"><i class="fa fa-square" id="companySchedule"></i> <span>회사일정</span></a>
            </li>
            <li id="li_deptSchedule">
                <a href="javascript:event.preventDefault();" class="" style="font-family: S-CoreDream-4Regular; font-size: 20px;"><i class="fa fa-square" id="deptSchedule"></i> <span>부서일정</span></a>
            </li>
            <li id="li_teamSchedule">
                <a href="javascript:event.preventDefault();" class="" style="font-family: S-CoreDream-4Regular; font-size: 20px;"><i class="fa fa-square" id="teamSchedule"></i> <span>팀일정</span></a>
            </li>
        </ul>
    </div>
</div>





<!-- 메인 content -->
<div id="main-content">
    <div class="container-fluid">
        <div class="row clearfix">
            <div class="col-12" style="margin-top: 2%;font-family: S-CoreDream-6Bold">
                <h2 style="font-size: 2.3rem;"><i class="fa fa-calendar"></i>&nbsp;일정 관리</h2>
                <hr>
            </div>
        </div>
        <div class="row clearfix ">
            <div class="col-lg-12 col-md-12">
                <div class="card">
                    <div class="body schedule_body">
                        <!-- 검색 조건 설정 -->
                        <form:form commandName="scheduleFormVO" id="scheduleForm">
                            <h5 style="display:inline-block; font-weight: bold; font-family: S-CoreDream-7ExtraBold">검색 조건</h5>
                            <div class="alert alert-light" role="alert" style="display:inline-block;padding-top:0;margin-bottom:0; font-family: S-CoreDream-6Bold">
                                <label class="fancy-checkbox">
                                    <input type="checkbox" ${from eq 'home' ? 'checked':''} id="checkboxSearchDate" class="searchCheck filterCheck" data="selectSearchDate" data-parsley-multiple="checkbox" onchange="changeForm(this);searchSetting(this);"/>
                                    <span>날짜검색</span>
                                </label>
                                <label class="fancy-checkbox">
                                    <input type="checkbox" id="checkboxSearchType" class="searchCheck filterCheck" data="selectSearchType" data-parsley-multiple="checkbox" onchange="changeForm(this);searchSetting(this);"/>
                                    <span>일정그룹</span>
                                </label>
                                <label class="fancy-checkbox">
                                    <input type="checkbox" name="important" id="checkboxImportant" class="searchCheck searchElement filterCheck" data-parsley-multiple="checkbox" value="1" onchange="searchSetting(this);"/>
                                    <span>중요일정</span>
                                </label>

                                <!-- 리셋버튼 -->
                                <button id="resetBtn" type="reset" class="btn btn-default" title="Refresh" style="display: none;"></button>
                                <label class="searchElement filter" onclick="conditionReset();"  style="cursor: pointer;">
                                    <i class="fa fa-refresh"></i>&nbsp&nbsp검색 조건 초기화
                                </label>

                                <div class="box float-right" style="font-family: S-CoreDream-7ExtraBold">
                                    <p id="getExcelBtn" class="text-btn" onclick="getExcel()">
                                        <a class="alert alert-info alert-dismissible" id="excelInfo" href="#" data-toggle="popover" data-trigger="hover" data-placement="left" data-html="true" data-content="검색조건 선택 시 해당 일자의 일정목록을 다운로드할 수 있습니다.<br/>조건 미선택 시 조회 중인 달의 목록을 다운로드합니다."
                                           style="font-family: InfinitySans-RegularA1;
								      	 padding-right: 16px;
									     padding-top: 7px;
									     padding-bottom: 6px;
									     padding-left: 14px;">
                                            <i class="fa fa-download"></i>
                                            일정 다운로드
                                        </a>
                                    </p>
                                </div>
                            </div>
                            <div id="keyword" class="box" style="width:350px;">
                                <div class="input-group row" style="width: 75em;">
                                    <!-- 일정 날짜검색 searchDate 의  searchStart, searchEnd -->
                                    <input type="date" value="${not empty today ? today:''}" class="form-control col-md-3 selectSearchDate myConditions searchElement filter  " name="searchStart" id="searchStart"  style="display: none;"/>
                                    <input type="date" value="${not empty tomorrow ? tomorrow:''}"  class="form-control col-md-3 selectSearchDate myConditions searchElement filter  " name="searchEnd" id="searchEnd"  style="display: none;"/>
                                        <%-- 							 <input type="date" value="${not empty today ? today:''}" class="form-control col-md-3 selectSearchDate myConditions searchElement filter  " name="searchStart" id="searchStart" onchange="searchSetting(this);" style="display: none;"/> --%>
                                        <%-- 							 <input type="date" value="${not empty tomorrow ? tomorrow:''}"  class="form-control col-md-3 selectSearchDate myConditions searchElement filter  " name="searchEnd" id="searchEnd" onchange="searchSetting(this);" style="display: none;"/> --%>
                                    <!-- 일정검색타입 searchType -->
                                    <select class="form-control col-md-2 selectSearchType myConditions searchElement filter  " name="searchType" id="searchType" onchange="searchSetting(this);" style="display: none;">
                                        <option value="">전체일정</option>
                                        <option value="S01">개인일정</option>
                                        <option value="S02">회사일정</option>
                                        <option value="S03">부서일정</option>
                                        <option value="S04">팀일정</option>
                                    </select>
                                    <!-- 검색컨디션 검색타입 searchType -->
                                    <select class="form-control col-md-2 filter" name="searchCondition" id="searchCondition" style="font-family: S-CoreDream-7ExtraBold" >
                                        <option value="tc">제목+내용</option>
                                        <option value="t">일정제목</option>
                                        <option value="c">일정내용</option>
                                    </select>
                                    <input  class="form-control col-md-2 filter" type="text" name="searchKeyword" id="keywordInput" placeholder="검색어" onkeypress="checkEnter(searchSetting);event.stopPropagation();" autocomplete="off" style="font-family: S-CoreDream-7ExtraBold"/>
                                    <span class="input-group-append col-me-1">
		                        <button class="btn btn-primary searchElement" type="button" id="searchBtn" onclick="searchSetting(this);"  data-card-widget="search" style="background-color: #2980b9; border-color: #2980b9;">
		                           <i class="fa fa-fw fa-search"></i>
		                        </button>
		                     </span>
                                    <button type="button" class="btn btn-primary float-left zoomBtn" style="font-family: S-CoreDream-4Regular" onclick="zoomIn();"><i class="icon-magnifier-add"></i>&nbsp;확대</button>
                                    <button type="button" class="btn btn-primary float-left zoomBtn" style="font-family: S-CoreDream-4Regular" onclick="zoomOut();"><i class="icon-magnifier-remove"></i>&nbsp;축소</button>
                                </div>
                            </div>
<%--                            <form:hidden path="scheduleCommand.searchKeyword"/>--%>
<%--                            <form:hidden path="scheduleCommand.searchCondition"/>--%>
<%--                            <form:hidden path="scheduleCommand.searchImportant"/>--%>
<%--                            <form:hidden path="scheduleCommand.searchType"/>--%>
                        </form:form>
                        <div id="zoomDiv">
                            <div id="zoomContent">
                                <div class="card mb-4" style="font-family: S-CoreDream-4Regular">
                                    <div id="wrapper">
                                        <div id="loading"></div>
                                        <div id="calendar" style="font-family: S-CoreDream-4Regular"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /.container -->
                        <!--             </div> -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<form id="excelForm" name="excelForm" method="post" enctype="multipart/form-data">
    <!-- 목록 받을 날짜타입 넘기기 -->
    <input type="hidden" id="startForExcel" name="start" />
    <input type="hidden" id="endForExcel" name="end" />
</form>


<script src="<%=request.getContextPath()%>/resources/vendor/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/vendor/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/vendor/js/moment.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/vendor/js/fullcalendar.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/vendor/js/ko.js"></script>
<script src="<%=request.getContextPath()%>/resources/vendor/js/select2.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/vendor/js/bootstrap-datetimepicker.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/main.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/addEvent.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/etcSetting.js"></script>
<%--<script src="<%=request.getContextPath() %>/resources/js/common.js"></script>--%>



<script> // 전역 셋팅
//검색, 이벤트 조회 등을 위한 전역변수 셋팅
var viewStart = ''; // 조회 중인 시작 날짜
var viewEnd = '';
var setCondition = '';
var setKeyword = '';
var setType = '';
var searchDate = ''; // 날짜검색 체크박스 여부
var searchStart = '';
var searchEnd = '';
var setTimezone = '';
var setImportant = '';
var setCallback;
<%--var loginId = '<%=((EmpVO)request.getSession().getAttribute("loginUser")).getEmpId()%>';--%>

$('.filterCheck').on('change',function(){
    filtering();
});

function popoverSchedule(event){
// 	alert('렌더링 발생')

}

</script>

<script>
    // 버튼으로 새 일정 등록
    /**
    차이점:
        openWindow은 새로운 창이나 탭을 열 때 사용되고, location.href는 현재 창이나 탭의 URL을 변경할 때 사용됩니다.
        openWindow은 새로운 브라우저 창을 열 수 있지만, location.href는 현재 창이나 탭에서 페이지를 새로운 URL로 이동시킵니다.
        */
    function schedule_go(){

        location.href = "/schedule/registForm";

    }

    // 검색조건들을 전역변수 혹은 hidden에 셋팅
    function searchSetting(searchOptions){
        setKeyword = $('#keywordInput').val();
        setCondition = $('#searchCondition option:selected').val();
        var typeCheckBox = $('#checkboxSearchType').is(':checked');
        if(typeCheckBox == false){
            setType = '';
        }

        setType = $('#searchType option:selected').val();
        setImportant = $('#checkboxImportant').is(':checked');
        if(setImportant == false){
            setImportant = '';
        }

        searchDate = $('#checkboxSearchDate').is('checked'); // true false
        searchStart = $('#searchStart').val();
        searchEnd = $('#searchEnd').val();

        $('#calendar').fullCalendar('gotoDate', '2021-03');
        filtering();
    }

    //검색 조건 설정 변화
    function changeForm(obj){
        var searchCri = $(obj).attr('data');

        if($(obj).is(':checked')==true){
            $('.'+searchCri).css('display','');
        }else{
            $('.'+searchCri).css('display','none');
            $('.'+searchCri).val('');
        }
    }

    //검색조건 초기화
    function conditionReset() {
        $("#resetBtn").click();
        $('.myConditions').css("display","none");
        $('input[name="searchKeyword"]').val("");
        $('#checkboxSearchDate').removeAttr('checked');
        $('#searchStart').val('');
        $('#searchEnd').val('');
        searchStart = '';
        searchEnd = '';
        setType = '';
        setCondition = '';
        setImportant = false;

        filtering();
    }

    /**
     //엑셀 다운로드
     function getExcel(){
     // 	alert("getExcel click");
     $('#startForExcel').val(searchStart);
     $('#endForExcel').val(searchEnd);
     $('#typeForExcel').val(setType);
     $('#importantForExcel').val(setImportant);

     // 	console.log("엑셀 다운 시 가져갈 날짜 >> " + viewStart + " ~ " + viewEnd);

     var excelForm = $('<form></form>');

     excelForm.attr("name","excelForm");
     excelForm.attr("method","post");
     excelForm.attr("action","<%=request.getContextPath()%>/schedule/getExcel");


     if(searchStart && searchEnd){
     excelForm.append($('<input/>',{type:"hidden", name:"start", value:searchStart}));
     excelForm.append($('<input/>',{type:"hidden", name:"end", value:searchEnd}));
     excelForm.append($('<input/>',{type:"hidden", name:"username", value:loginId}));
     }else{
     excelForm.append($('<input/>',{type:"hidden", name:"start", value:viewStart}));
     excelForm.append($('<input/>',{type:"hidden", name:"end", value:viewEnd}));
     excelForm.append($('<input/>',{type:"hidden", name:"username", value:loginId}));
     }

     excelForm.appendTo('body');

     excelForm.submit();
     }

     window.onload = function(){
     // 	searchSetting();

     //홈에서 왔다면 오늘날짜로 포커스
     if('${from}' && $("#searchStart").val()){
     changeForm($("#checkboxSearchDate"));
     searchSetting();
     setTimeout(function(){
     $(".fc-day[data-date="+$("#searchStart").val()+"]")[0].scrollIntoView();
     history.pushState(null, null, "/JoinWorkGW/schedule/main");//일정 다시 로드시 파라미터 초기화

     },200)

     }else{
     $("#searchStart").val('');
     $("#searchEnd").val('');
     }
     }

     var nowZoom = 100;
     function zoomOut(){
     nowZoom = nowZoom - 10;
     if(nowZoom > 100 ) nowZoon = 150;
     zooms();
     }

     function zoomIn(){
     nowZoom = nowZoom + 10;
     if(nowZoom < 50) nowZoom = 50;
     zooms();
     }

     function zooms(){
     $('#zoomDiv').css('width', nowZoom+'%');
     if(nowZoom > 100){
     alert('더 이상 확대할 수 없습니다.');
     nowZoom = 100;
     $('#zoomDiv').css('width', nowZoom+'%');
     return;
     }
     if(nowZoom < 50){
     alert('더 이상 축소할 수 없습니다.');
     nowZoom = 50;
     $('#zoomDiv').css('width', nowZoom+'%');
     return;
     }

     }
     -- 액셀 다운로드
     **/



</script>
</body>

