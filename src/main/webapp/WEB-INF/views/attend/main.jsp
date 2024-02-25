<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
			background: green;
			color: #fff;
			padding: 5px 10px;
			border-radius: 6px;
		}
		.donut {
			width: 50%;
			padding-bottom: 50%;
			border-radius: 50%;
			position: relative;
			text-align: center;
			transition: background .3s ease-in-out;
			background: conic-gradient(#3F8BC9 0% 72%, #F2F2F2 72% 100%);
		}

		.donut::before {
			color: #fff;
			width: 70%;
			padding: calc(35% - .64vw) 0;
			background: #264057;
			border-radius: 50%;
			position: absolute;
			left: 15%;
			top: 13%;
			display: block;
			content: attr(data-percent)'%';
			transform: skew(-0.03deg);
			margin: auto;
			font-size: 1.1vw;
			font-size: 2vw;
			padding: calc(35% - 1.3vw) 0;
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
				<h2><i class="fa-solid fa-angles-right"></i> <!--왼쪽 아이콘 폰트어썸-->근태관리</h2>
			</div>

			<div class="serchContain">  <!--셀렉/검색/버튼 묶는 div클래스 (이건 부트스트랩 클래스 아니고 임의로 만든 클래스)-->
				<form action="addBookSearch" id="serchForm">
					<div class="serchSelect"> <!--select 길이조절 클래스 (이건 부트스트랩 클래스 아니고 임의로 만든 클래스)-->
						<input type="date" name="searchText" class="form-control" placeholder="입력해주세요" aria-label="입력해주세요"> 
					</div>
					<div class="serchTextGroup"> <!--input 길이조절 클래스 (이건 부트스트랩 클래스 아니고 개별 클래스)-->
						<!-- 검색명 input 클래스 --> <input type="text" name="searchText" class="form-control" placeholder="입력해주세요" aria-label="입력해주세요"> 
					</div>
				</form>
				<!-- 검색 button 클래스 --><button class="btn btn-outline-secondary" onclick="serchBtn()" name="serchBtn" type="button">검색</button>
			</div>

			<table class="table table-hover"> <!-- 부트스트랩 게시판 -->

				<thead class="thead-light"> <!-- 게시판 맨위 색변경 클래스-->
					<tr>
						<th>날짜</th>
						<th>출근시간</th>
						<th>퇴근시간</th>
						<th>출근상태</th>
            			<th>지각사유</th>
					</tr>
				</thead>

				<tbody>
					<tr class="modalBtn" data-toggle="modal" data-target="#staticBackdrop">
						<td>날짜</td>
						<td>출근시간</td>
						<td>퇴근시간</td>
						<td><span class="goWork">정상출근</span></td>
						<td>지각사유.....</td>
					</tr>
					<tr class="modalBtn" data-toggle="modal" data-target="#staticBackdrop">
						<td>날짜</td>
						<td>출근시간</td>
						<td>퇴근시간</td>
						<td><span class="tardy">지각</span></td>
						<td>지각사유.....</td>
					</tr>

				</tbody>
			</table>

		</div>
		<div class="attendStatistics">
			<div class="attendStatisticsGroup">
				<div class="donut" data-percent="85.4"></div>
				<div class="attendStatisticTextGroup">
					<p class="attendStatisticTit">이달의 근태통계</p>
					<p class="attendStatisticText">정상출근 일수 <span>15</span></p>
					<p class="attendStatisticText">지각 일수 <span>3</span></p>
					<p class="attendStatisticText">정상 출근율 <span>72%</span></p>
				</div>
			</div>
			<div class="lateReasonGroup">
				<form>
					<div class="attendStatisticsGroup">
						<p class="lateReasonTit">근태 사유 작성</p>
						<button type="button" class="btn btn-primary">제출</button>
					</div>
					<input type="date" class="form-control" name="" aria-label="입사날짜" aria-describedby="">
					<textarea rows="10" class="form-control" name="manage_remark" aria-label="메모"></textarea>
				</form>
			</div>
		</div>
	</section>
	  
	  <!-- Modal -->
	  <div class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
		  <div class="modal-content">
			<div class="modal-header">
			  <h5 class="modal-title" id="staticBackdropLabel">날짜출력</h5>
			  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			  </button>
			</div>
			<div class="modal-body">
			  <p>출근시간<span>09:30</span></p>
			  <p>퇴근시간<span>18:30</span></p>
			  <p>출근상태<span>정상출근</span></p>
			  <p>지각사유<span>텍스트텍스트텍스트텍스트텍스트<br>텍스트텍스트텍스트텍스트</span></p>
			</div>
			<div class="modal-footer">
			  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		  </div>
		</div>
	  </div>
	<!-- 푸터 인클루드 -->
	<%@ include file="../include/footer.jsp"%>

	<script>
		const donut = document.querySelector(".donut")
		donut.dataset.percent = totalMinwon
		donut.style.background = `conic-gradient(#3F8BC9 0% ${totalMinwon}%, #F2F2F2 ${totalMinwon}% 100%)`
	</script>