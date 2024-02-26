<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
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
        .serchContain{
            display: flex; 
            align-items: flex-start;
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

			<!-- <div class="serchContain">
				<form action="addBookSearch" id="serchForm">
					<div class="serchSelect">
						<input type="date" name="searchText" class="form-control" placeholder="입력해주세요" aria-label="입력해주세요"> 
					</div>
					<div class="serchTextGroup">
						<input type="text" name="searchText" class="form-control" placeholder="입력해주세요" aria-label="입력해주세요"> 
					</div>
				</form>
				<button class="btn btn-outline-secondary" onclick="serchBtn()" name="serchBtn" type="button">검색</button>
			</div> -->
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
					<p class="attendStatisticText">정상출근 일수 <span>${attendenceCountList.attendenceNormalCountList}</span></p>
					<p class="attendStatisticText">지각 일수 <span>${attendenceCountList.attendenceTardyCountList}</span></p>
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
		let month = currentDate.getMonth() + 1

		let weekdays = getWeekdaysInMonth(year, month);
		let attendenceNormalCountList = "${attendenceCountList.attendenceNormalCountList}";
		console.log("평일 수: " + weekdays);
		let percentage = (attendenceNormalCountList / weekdays) * 100;
		let roundedPercentage = percentage.toFixed(0);
		console.log(roundedPercentage + "%"); // 결과 출력

		$(window).ready(function(){
			draw(roundedPercentage, '.pie-chart2', '#8b22ff');
			$('span.center').text(roundedPercentage + "%");
			$('.attendStatisticPercentText').text(roundedPercentage + "%");
		});

		function draw(max, classname, colorname){
			let i=1;
			let func1 = setInterval(function(){
			if(i<max){
				color1(i,classname,colorname);
				i++;
			} else{
				clearInterval(func1);
			}
			},10);
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
	</script>