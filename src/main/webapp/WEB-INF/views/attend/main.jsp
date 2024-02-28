<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
    <style>
	
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
        .serchContain{
          display: flex; 
          align-items: flex-start;
					margin-bottom:3%;
        }
        #serchForm{display: flex;}
        .serchSelect{width: 150px;}
        .serchTextGroup{width: 350px;}
        .tableCheckBox{text-align: center; vertical-align: middle !important;}
		.tardy{
			background: red;
			color: #fff;
			padding: 5px 10px;
			border-radius: 6px;
		}
		.goWork{
			color: #fff;
			padding: 5px 10px;
			border-radius: 6px;
		}
		.goWork0{background-color: #77af9c;}
		.goWork1{background: green;}
		.goWork2{background-color: #ce6d39;}
		.goWork3{background-color: #c82333;}
		.goWork4{background-color: #6aafe6;}
		.goWork5{background-color: #ff5f2e;}

		.pie-chart {
			position: relative;
			display:inline-block;
			width: 150px;
			height: 150px;
			border-radius: 50%;
			transition: 0.3s;
		}
		span.center{
			background: #fff;
			display : block;
			position: absolute;
			top:50%; left:50%;
			width:100px; height:100px;
			border-radius: 50%;
			text-align:center; 
			line-height: 100px;
			font-size:30px;
			transform: translate(-50%, -50%);
		}
		.attendStatistics{
			width: 30%;
			margin-left: 2%;
		}
		.attendStatisticsGroup{display: flex; justify-content: space-between; margin-bottom: 5%;}
		.attendStatisticTextGroup{
			width: 50%;
		}
		.attendStatisticTit{
			font-size: 20px;
			color: #fff;
			background: #000;
			padding: 5px;
		}
		.attendStatisticText{
			font-size: 18px;
			padding: 5px;
			margin-bottom: 0%;
		}
		.lateReasonGroup{
			background: #d2d2d2;
			padding: 4% 6%;
    		margin: 5% 0;
		}
		.lateReasonTit{
			font-size: 25px;
			margin-bottom: 0;
		}
		.lateReasonSubTit{font-size: 15px;}
		/* 모달 css */
		.show{background-color: rgba(0, 0, 0, 0.7);}
		.modalBtn{cursor: pointer;}
		.modal-body p{font-size: 16px;}
		.modal-body span{
			display: inline-block;
    		margin-left: 15px;
			vertical-align: top;
		}
		.sec_cal {
				width: 360px;
				margin: 0 auto;
				font-family: "NotoSansR";
		}

		.sec_cal .cal_nav {
				display: flex;
				justify-content: center;
				align-items: center;
				font-weight: 700;
				font-size: 48px;
				line-height: 78px;
		}

		.sec_cal .cal_nav .year-month {
				width: 185px;
				text-align: center;
				line-height: 1;
				font-size: 30px;
		}

		.sec_cal .cal_nav .nav {
				display: flex;
				border: 1px solid #333333;
				border-radius: 5px;
		}	
		.sec_cal .cal_nav .go-prev,
		.sec_cal .cal_nav .go-next {
				display: block;
				width: 50px;
				height: 30px;
				font-size: 0;
				display: flex;
				justify-content: center;
				align-items: center;
		}

		.sec_cal .cal_nav .go-prev::before,
		.sec_cal .cal_nav .go-next::before {
				content: "";
				display: block;
				width: 15px;
				height: 15px;
				border: 3px solid #000;
				border-width: 3px 3px 0 0;
				transition: border 0.1s;
		}

		.sec_cal .cal_nav .go-prev:hover::before,
		.sec_cal .cal_nav .go-next:hover::before {
				border-color: #ed2a61;
		}

		.sec_cal .cal_nav .go-prev::before {
				transform: rotate(-135deg);
		}

		.sec_cal .cal_nav .go-next::before {
				transform: rotate(45deg);
		}
    </style>
    <%@ include file="../include/header.jsp"%>

	<section class="subPageContain">

		<!-- 사이드바 -->
		<%@ include file="./sideBar.jsp"%>
		
		<!--컨텐츠 영역-->
		<div class="contentConteiner">
			<div class="subTitleText"> <!--컨텐츠 부분 타이틀 클래스(이건 부트스트랩 클래스 아니고 임의로 만든 클래스)--> 
				<h2><i class="fa-solid fa-angles-right"></i> <!--왼쪽 아이콘 폰트어썸-->내 근태관리</h2>
			</div>

			<div class="serchContain">
				<div class="sec_cal">
					<div class="cal_nav">
						<a href="javascript:;" class="nav-btn go-prev">prev</a>
						<div class="year-month"></div>
						<a href="javascript:;" class="nav-btn go-next">next</a>
					</div>
				</div>
			</div>
			<table class="table table-hover"> <!-- 부트스트랩 게시판 -->

				<thead class="thead-light"> <!-- 게시판 맨위 색변경 클래스-->
					<tr>
						<th>날짜</th>
						<th>출근시간</th>
						<th>퇴근시간</th>
						<th>출근상태</th>
            			<th>근태사유</th>
					</tr>
				</thead>

				<tbody>
					<c:forEach var="attendenceList" items="${attendenceList}" varStatus="status">
						<tr class="modalBtn" data-toggle="modal" data-target="#staticBackdrop${status.index}">
							<td><fmt:formatDate value="${attendenceList.history_attend_time}" pattern="yyyy-MM-dd" /></td>
							<td><fmt:formatDate value="${attendenceList.history_attend_time}" pattern="HH:mm" /></td>
							<td><fmt:formatDate value="${attendenceList.history_leaving_time}" pattern="HH:mm" /></td>
							<td><span class="goWork goWork${attendenceList.attend_st_id}">${attendenceList.attend_st_name}</span></td>
							<td>${attendenceList.history_reason}</td>
						</tr>
						<!-- Modal -->
						<div class="modal fade" id="staticBackdrop${status.index}" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
							<div class="modal-dialog modal-dialog-centered">
							<div class="modal-content">
								<div class="modal-header">
								<h5 class="modal-title" id="staticBackdropLabel"><fmt:formatDate value="${attendenceList.history_attend_time}" pattern="yyyy-MM-dd" /></h5>
								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
								</div>
								<div class="modal-body">
								<p>출근시간<span><fmt:formatDate value="${attendenceList.history_attend_time}" pattern="HH:mm" /></span></p>
								<p>퇴근시간<span><fmt:formatDate value="${attendenceList.history_leaving_time}" pattern="HH:mm" /></span></p>
								<p>출근상태<span class="goWork goWork${attendenceList.attend_st_id}">${attendenceList.attend_st_name}</span></p>
								<p>지각사유<span>${attendenceList.history_reason}</span></p>
								</div>
								<div class="modal-footer">
								<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
								</div>
							</div>
							</div>
						</div>	
					</c:forEach>
				</tbody>
			</table>

		</div>
		<div class="attendStatistics">
			<div class="attendStatisticsGroup">
				<div class="pie-chart pie-chart2"><span class="center">50%</span></div>
				<div class="attendStatisticTextGroup">
					<p class="attendStatisticTit">이달의 근태통계</p>
					<p class="attendStatisticText">정상출근 일수 <span class="attendenceNormalCountList">${attendenceCountList.attendenceNormalCountList}</span></p>
					<p class="attendStatisticText">지각 일수 <span class="attendenceTardyCountList">${attendenceCountList.attendenceTardyCountList}</span></p>
					<p class="attendStatisticText">정상 출근율 <span class="attendStatisticPercentText">72%</span></p>
				</div>
			</div>
			<div class="lateReasonGroup">
				<form id="historyReasonInsert" method="get" action="historyReasonInsert">
					<div class="attendStatisticsGroup">
						<p class="lateReasonTit">근태 사유 작성</p>
						<button type="button" class="btn btn-primary" onclick="historyReasonInsert()">제출</button>
					</div>
					<input type="date" class="form-control" name="history_reason_date" aria-label="날짜" aria-describedby="">
					<textarea rows="10" class="form-control" name="history_reason" aria-label="메모"></textarea>
				</form>
			</div>
		</div>
	</section>
	<!-- 푸터 인클루드 -->
	<%@ include file="../include/footer.jsp"%>

	<script>
		let currentDate = new Date();
		let year = currentDate.getFullYear(); // 현재 연도 가져오기 (네 자릿수)
		let month = currentDate.getMonth() + 1;
		let now_utc = Date.now()
		let timeOff = new Date().getTimezoneOffset()*60000;
		let history_reason_date_today = new Date(now_utc-timeOff).toISOString().split("T")[0];
		let weekdays = getWeekdaysInMonth(year, month);
		let attendenceNormalCount = "${attendenceCountList.attendenceNormalCountList}";
		

		$(window).ready(function(){
			roundedPercentage(attendenceNormalCount);
			$('.year-month').text(year + '.' + month);
			$('input[name="history_reason_date"]').val(new Date().toISOString().substring(0, 10));
			$('input[name="history_reason_date"]').attr("max",history_reason_date_today);
		});
		$('.go-prev').on('click', function() {
        thisMonth = new Date(year, month - 2, 1);
        renderCalender(thisMonth);
				month = month - 1;
    });
		$('.go-next').click(function(){
			thisMonth = new Date(year, month, 1);
			renderCalender(thisMonth);
			month = month + 1;
		})
		function roundedPercentage (aa){
			let percentage = (aa / weekdays) * 100;
			let roundedPercentage = percentage.toFixed(0);
			console.log(roundedPercentage);
			draw(roundedPercentage, '.pie-chart2', '#8b22ff');
			$('span.center').text(roundedPercentage + "%");
			$('.attendStatisticPercentText').text(roundedPercentage + "%");
		}
		function draw(max, classname, colorname){
			let i=1;
			if(i<max){
				let func1 = setInterval(function(){
					if(i<max){
						color1(i,classname,colorname);
						i++;
					}else{
						clearInterval(func1);
					}
				},10);	
			}else if(max==0){
				color1('0',classname,colorname);
			}
			
		}
		function color1(i, classname,colorname){
		$(classname).css({
				"background":"conic-gradient("+colorname+" 0% "+i+"%, #ffffff "+i+"% 100%)"
		});
		}

		function historyReasonInsert(){
			document.querySelector('#historyReasonInsert').submit();
		}

		function getWeekdaysInMonth(year, month) {
			let countWeekdays = 0;
			let date = new Date(year, month - 1, 1);
			let endDate = new Date(year, month, 0);

			while (date <= endDate) {
				if (date.getDay() !== 0 && date.getDay() !== 6) {
					countWeekdays++;
				}
				date.setDate(date.getDate() + 1);
			}

			return countWeekdays;
		}

		function renderCalender(thisMonth) {
			// 렌더링을 위한 데이터 정리
			currentYear = thisMonth.getFullYear();
			currentMonth = thisMonth.getMonth() + 1;

			console.log(currentYear);
			console.log(currentMonth);
			// 현재 월 표기
			$('.year-month').text(currentYear + '.' +currentMonth);
			weekdays = getWeekdaysInMonth(currentYear, currentMonth);
			currentMonth = (currentMonth < 10 ? "0" : "") + currentMonth
			$('.table tbody').find('.modalBtn').remove();
      $('.modalContainer').find('.modal').remove();
			$.ajax({
        type : 'get',
        url : '/WorkConGW/attend/attendMainSelect',
        data : {
					attendDay : currentYear + '-' + currentMonth
        },
        success : function(result) {
					console.log(result);
					attendenceNormalCount = result[result.length - 1].attendenceNormalCountList;
					let attendenceTardyCountList = result[result.length - 1].attendenceTardyCountList;
					roundedPercentage(attendenceNormalCount);
					$('.attendenceNormalCountList').text(attendenceNormalCount);
					$('.attendenceTardyCountList').text(attendenceTardyCountList);
					result.forEach(function(e, i) {
						if (i < result.length - 1) {
							e.HISTORY_ATTEND_DAY = e.HISTORY_ATTEND_DAY || '';
							e.EMP_NAME = e.EMP_NAME || '';
							e.CODE_NAME = e.CODE_NAME || '';
							e.HISTORY_ATTEND_TIME = e.HISTORY_ATTEND_TIME || '';
							e.HISTORY_LEAVING_TIME = e.HISTORY_LEAVING_TIME || '';
							e.ATTEND_ST_NAME = e.ATTEND_ST_NAME || '';
							e.HISTORY_REASON = e.HISTORY_REASON || '';
							let text = `
								<tr class="modalBtn" data-toggle="modal" data-target="#staticBackdrop`+i+`">
									<td>`+e.HISTORY_ATTEND_DAY+`</td>
									<td>`+e.HISTORY_ATTEND_TIME+`</td>
									<td>`+e.HISTORY_LEAVING_TIME+`</td>
									<td><span class="goWork goWork`+e.ATTEND_ST_ID+`">`+e.ATTEND_ST_NAME+`</span></td>
									<td>`+e.HISTORY_REASON+`</td>
								</tr>
							`;
							$('tbody').append(text);
							let modal = `
								<div class="modal fade" id="staticBackdrop`+i+`" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
									<div class="modal-dialog modal-dialog-centered">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title" id="staticBackdropLabel">`+e.HISTORY_ATTEND_DAY+`</h5>
												<button type="button" class="close" data-dismiss="modal" aria-label="Close">
													<span aria-hidden="true">&times;</span>
												</button>
											</div>
											<div class="modal-body">
												<p><span class="modalSubTit">출근시간</span>`+e.HISTORY_ATTEND_TIME+`</p>
												<p><span class="modalSubTit">퇴근시간</span>`+e.HISTORY_LEAVING_TIME+`</p>
												<p><span class="modalSubTit">출근상태</span><span class="goWork goWork`+e.ATTEND_ST_ID+`">`+e.ATTEND_ST_NAME+`</span></p>
												<p><span class="modalSubTit">지각사유</span><span style="display: inline-block;">`+e.HISTORY_REASON+`</span></p>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
											</div>
										</div>
									</div>
								</div>
							`;
							$('.modalContainer').append(modal);	
						}
					});
        },
        error : function(request, status, error) {
          console.log(error);
      	}
      })
		}		
	</script>