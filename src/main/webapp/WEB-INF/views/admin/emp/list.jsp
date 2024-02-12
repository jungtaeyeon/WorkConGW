<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Map, java.util.ArrayList, com.WorkConGW.addbook.dto.AddBookVO" %>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script>
	const serchBtn =()=>{
		document.querySelector("#serchForm").submit();
	}
</script>
<style>
	.subPageContain{
		margin:0 2%;
	}
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
		align-items: flex-end;
		margin-bottom: 1rem;
	}
	#serchForm{margin-bottom: 0;}
	.serchGroup:first-child{margin-bottom: 0.5rem;}
	.serchGroup{display: flex;}
	.serchSelect{width: 150px;}
	.serchTextGroup{width: 350px;}
	.tableCheckBox{text-align: center; vertical-align: middle !important;}
	.dateWave{
		font-size: 23px;
    display: inline-block;
    margin: 0 15px;
	}
</style>
<body>
	<!-- 헤더인클루드 -->
	<%@ include file="../../include/header.jsp"%>

	<section class="subPageContain">
		<!--컨텐츠 영역-->
		<div class="contentConteiner">
			<div class="subTitleText"> <!--컨텐츠 부분 타이틀 클래스(이건 부트스트랩 클래스 아니고 임의로 만든 클래스)--> 
				<h2><i class="fa-solid fa-angles-right"></i> <!--왼쪽 아이콘 폰트어썸-->사원목록</h2>
			</div>

			<div class="serchContain">  <!--셀렉/검색/버튼 묶는 div클래스 (이건 부트스트랩 클래스 아니고 임의로 만든 클래스)-->
				<form action="" id="serchForm">
					<div class="serchGroup">
						<input type="date" name="searchDateStart" class="form-control"> 
						<span class="dateWave">~</span>
						<input type="date" name="searchDateEnd" class="form-control"> 
					</div>
					<div class="serchGroup">
						<div class="serchSelect"> <!--select 길이조절 클래스 (이건 부트스트랩 클래스 아니고 임의로 만든 클래스)-->
							<!-- select태그 클래스 --> <select class="custom-select" name="selectSearch"> 
								<option value="0">전체</option>
								<option value="manage_display_name">이름</option>
								<option value="manage_hp">휴대폰</option>
							</select>
						</div>
						<div class="serchTextGroup"> <!--input 길이조절 클래스 (이건 부트스트랩 클래스 아니고 개별 클래스)-->
							<!-- 검색명 input 클래스 --> <input type="text" name="searchText" class="form-control" placeholder="입력해주세요" aria-label="입력해주세요"> 
						</div>
					</div>
				</form>
				<!-- 검색 button 클래스 --><button class="btn btn-outline-secondary" onclick="serchBtn()" name="serchBtn" type="button">검색</button>
			</div>

			<table class="table table-hover"> <!-- 부트스트랩 게시판 -->

				<thead class="thead-light"> <!-- 게시판 맨위 색변경 클래스-->
					<tr>
						<th class="tableCheckBox"><input type="checkbox"/></th>
						<th>사원번호</th>
						<th>사원명</th>
						<th>입사날짜</th>
						<th>부서</th>
            			<th>직급</th>
						<th>이메일</th>
						<th>전화번호</th>
						<th>주소</th>
						<th>권한</th>
					</tr>
				</thead>

				<tbody>
					<tr>
						<th class="tableCheckBox"><input type="checkbox"/></th>
						<td>xxxxx</td>
						<td>홍길동</td>
						<td>2024년02월12일</td>
						<td>경영부</td>
						<td>대리</td>
						<td>kiwi@hot.co.kr</td>
						<td>010-1234-5678</td>
						<td>주소주소주소주소</td>
						<td>일반</td>
					</tr>
				</tbody>
			</table>
		</div>
	</section>

	<!-- 푸터 인클루드 -->
	<%@ include file="../../include/footer.jsp"%>
</body>