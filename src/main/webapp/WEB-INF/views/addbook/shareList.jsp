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
	.serchContain{
		display: flex; 
		align-items: flex-start;
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
	#serchForm{display: flex;}
	.serchSelect{width: 150px;}
	.serchTextGroup{width: 350px;}
	.tableCheckBox{text-align: center; vertical-align: middle !important;}
	.starred{margin-left: 5px;}
</style>
<body>
	<!-- 헤더인클루드 -->
	<%@ include file="../include/header.jsp"%>

	<section class="subPageContain">

		<!-- 사이드바 -->
		<%@ include file="./sideBar.jsp"%>
		
		<!--컨텐츠 영역-->
		<div class="contentConteiner">
			<div class="subTitleText"> <!--컨텐츠 부분 타이틀 클래스(이건 부트스트랩 클래스 아니고 임의로 만든 클래스)--> 
				<h2><i class="fa-solid fa-angles-right"></i> <!--왼쪽 아이콘 폰트어썸-->공유주소록</h2>
			</div>

			<div class="serchContain">  <!--셀렉/검색/버튼 묶는 div클래스 (이건 부트스트랩 클래스 아니고 임의로 만든 클래스)-->
				<form action="addBookSearch" id="serchForm">
					<div class="serchSelect"> <!--select 길이조절 클래스 (이건 부트스트랩 클래스 아니고 임의로 만든 클래스)-->
						<!-- select태그 클래스 --> <select class="custom-select" name="selectSearch"> 
							<option value="0">전체</option>
							<option value="manage_display_name">이름</option>
							<option value="manage_hp">휴대폰</option>
							<option value="manage_official_name">직급</option>
							<option value="manage_dept_name">부서명</option>
						</select>
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
						<th class="tableCheckBox"><input type="checkbox"/></th>
						<th>이름명</th>
						<th>회사</th>
						<th>직급</th>
						<th>부서</th>
            <th>전화번호</th>
            <th>이메일</th>
						<th>태그</th>
					</tr>
				</thead>

				<tbody>
					<tr data-toggle="modal" data-target="#staticBackdrop2">
						<th class="tableCheckBox"><input type="checkbox"/></th>
						<td>테스트<i class="starred fa-solid fa-star"></i></td>
						<td>테스트</td>
						<td>테스트</td>
						<td>테스트</td>
						<td>010-1234-5678</td>
						<td>rkdrhd55@naver.com</td>
						<td>테스트</td>
					</tr>
					<tr data-toggle="modal" data-target="#staticBackdrop2">
						<th class="tableCheckBox"><input type="checkbox"/></th>
						<td>테스트<i class="starred fa-regular fa-star"></i></td>
						<td>테스트</td>
						<td>테스트</td>
						<td>테스트</td>
						<td>010-1234-5678</td>
						<td>rkdrhd55@naver.com</td>
						<td>테스트</td>
					</tr>
				</tbody>

			</table>
		</div>
	</section>
<!-- Modal -->
<div class="modal fade" id="staticBackdrop2" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">홍길동2</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>전화번호 : 010-1234-5678</p>
        <p>전화번호 : 010-1234-5678</p>
        <p>전화번호 : 010-1234-5678</p>
        <p>전화번호 : 010-1234-5678</p>
        <p>전화번호 : 010-1234-5678</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기 </button>
      </div>
    </div>
  </div>
</div>
	<!-- 푸터 인클루드 -->
	<%@ include file="../include/footer.jsp"%>
</body>