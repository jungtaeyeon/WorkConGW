<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<body>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="<%=request.getContextPath() %>/css/sideBar.css" rel="stylesheet">
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
	<%@ include file="../include/header.jsp"%>
	<section class="subPageContain">
		<!-- 사이드바 -->
		<%@ include file="../include/sideBar.jsp"%>
		<!-- 사이드바 -->
		<div class="contentConteiner">
			<table class="table caption-top">
				<thead>
					<tr>
						<th scope="col">#</th>
						<th scope="col">First</th>
						<th scope="col">Last</th>
						<th scope="col">Handle</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th scope="row">1</th>
						<td>Mark</td>
						<td>Otto</td>
						<td>@mdo</td>
					</tr>
					<tr>
						<th scope="row">2</th>
						<td>Jacob</td>
						<td>Thornton</td>
						<td>@fat</td>
					</tr>
					<tr>
						<th scope="row">3</th>
						<td>Larry</td>
						<td>the Bird</td>
						<td>@twitter</td>
					</tr>
				</tbody>
			</table>
		</div>
	</section>
	<%@ include file="../include/footer.jsp"%>
</body>