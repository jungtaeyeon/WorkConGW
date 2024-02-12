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
        .serchTextGroup{width: 240px;}
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
		/* 모달 css */
		.show{background-color: rgba(0, 0, 0, 0.7);}
		.modalBtn{cursor: pointer;}
		.modal-body p{font-size: 16px;}
		.modal-body .modalSubTit{
			display: inline-block;
    		margin-right: 15px;
			vertical-align: top;
            width: 69px;
		}
        .share_add_book_btn_contain{
            display: flex;
            margin-bottom: 3%;
        }
        .share_add_book_btn{
            width: 150px;
            height: 35px;
            background: #f2f2f2;
            border: 1px solid #f2f2f2;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #646464;
            cursor: pointer;
        }
        .share_add_book_btn_on{
            background-color: #2985db;
            color: #fff;
        }
        .treeviewGroup{width: 100%; height: 500px; border:1px solid #000;}
        .subContentContainer{display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 5%;}
        .serchContainer{margin-right: 2%;}
    </style>
    <%@ include file="../include/header.jsp"%>

	<section class="subPageContain">

		<!-- 사이드바 -->
		<%@ include file="./sideBar.jsp"%>
		
		<!--컨텐츠 영역-->
		<div class="contentConteiner">
			<div class="subTitleText"> <!--컨텐츠 부분 타이틀 클래스(이건 부트스트랩 클래스 아니고 임의로 만든 클래스)--> 
				<h2><i class="fa-solid fa-angles-right"></i> <!--왼쪽 아이콘 폰트어썸-->부서 근태관리</h2>
			</div>
            <div class="subContentContainer">
                <div class="serchContainer">
                    <div class="share_add_book_btn_contain">
                        <div class="share_add_book_btn share_add_book_btn_on" data-sharecond="0">부서별</div>
                        <div class="share_add_book_btn" data-sharecond="1">직원별</div>
                    </div>
                    <div class="serchContain">  <!--셀렉/검색/버튼 묶는 div클래스 (이건 부트스트랩 클래스 아니고 임의로 만든 클래스)-->
                        <form action="addBookSearch" id="serchForm">
                            <div class="serchTextGroup"> <!--input 길이조절 클래스 (이건 부트스트랩 클래스 아니고 개별 클래스)-->
                                <!-- 검색명 input 클래스 --> <input type="text" name="searchText" class="form-control" placeholder="입력해주세요" aria-label="입력해주세요"> 
                            </div>
                        </form>
                        <button class="btn btn-outline-secondary" onclick="serchBtn()" name="serchBtn" type="button">검색</button>
                    </div>
                    <div class="treeviewGroup">조직도 출력</div>
                </div>
                <table class="table table-hover"> <!-- 부트스트랩 게시판 -->

                    <thead class="thead-light"> <!-- 게시판 맨위 색변경 클래스-->
                        <tr>
                            <th>날짜</th>
                            <th>이름</th>
                            <th>직급</th>
                            <th>출근시간</th>
                            <th>퇴근시간</th>
                            <th>상태</th>
                            <th>지각사유</th>
                        </tr>
                    </thead>

                    <tbody>

                        <tr class="modalBtn" data-toggle="modal" data-target="#staticBackdrop">
                            <td>날짜</td>
                            <td>홍길동</td>
                            <td>대리</td>
                            <td>출근시간</td>
                            <td>퇴근시간</td>
                            <td><span class="goWork">정상출근</span></td>
                            <td>지각사유.....</td>
                        </tr>
                        <tr class="modalBtn" data-toggle="modal" data-target="#staticBackdrop">
                            <td>날짜</td>
                            <td>홍길동</td>
                            <td>대리</td>
                            <td>출근시간</td>
                            <td>퇴근시간</td>
                            <td><span class="tardy">지각</span></td>
                            <td>지각사유.....</td>
                        </tr>
                    </tbody>

                </table>
            </div>
		</div>
	</section>

	<!-- Modal -->
	<div class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
		  <div class="modal-content">
			<div class="modal-header">
			  <h5 class="modal-title" id="staticBackdropLabel">홍길동</h5>
			  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			  </button>
			</div>
			<div class="modal-body">
                <p><span class="modalSubTit">날짜</span>09:30</p>
                <p><span class="modalSubTit">직급</span>대리</p>
                <p><span class="modalSubTit">출근시간</span>09:30</p>
                <p><span class="modalSubTit">퇴근시간</span>18:30</p>
                <p><span class="modalSubTit">출근상태</span>정상출근</p>
                <p><span class="modalSubTit">지각사유</span><span style="display: inline-block;">텍스트텍스트텍스트텍스트텍스트<br>텍스트텍스트텍스트텍스트</span></p>
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
        $(".share_add_book_btn").click(function(){
            if(!$(this).hasClass('share_add_book_btn_on')){
            $(".share_add_book_btn").not(this).removeClass("share_add_book_btn_on");
            $(this).addClass('share_add_book_btn_on');
            }
        })
    </script>