<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Map, java.util.ArrayList, com.WorkConGW.addbook.dto.AddBookVO" %>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% 
	List<AddBookVO> abList = (List<AddBookVO>)request.getAttribute("abList");
	int i = 0;
%>	
<script>
	const serchBtn =()=>{
		document.querySelector("#serchForm").submit();
	}
</script>
<body>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="<%=request.getContextPath() %>/css/sideBar.css" rel="stylesheet">
<style>
</style>
	<%@ include file="../include/header.jsp"%>
	<section class="subPageContain">
		<!-- 사이드바 -->
		<%@ include file="../include/sideBar.jsp"%>
		<!-- 사이드바 -->
		<div class="contentConteiner">
			<div class="subTitleText">
				<h2>주소록</h2>
			</div>
			<div class="serchContain" style="display: flex; align-items: flex-start;">
				<form action="addBookSearch" id="serchForm">
					<input type="hidden" name="empId" value="rkdrhd98">
					<select name="selectSearch">
						<option>전체</option>
						<option value="manage_display_name">이름</option>
						<option value="manage_hp">휴대폰</option>
						<option value="manage_official_name">직급</option>
						<option value="manage_dept_name">부서명</option>
					</select>
					<input type="text" name="searchText" placeholder="입력해주세요"/>
				</form>
				<button type="button" onclick="serchBtn()" name="serchBtn">검색 </button>
			</div>

			<table class="table caption-top">
				<thead>
					<tr>
						<th scope="col">순번</th>
						<th scope="col">이름명</th>
						<th scope="col">전화번호</th>
						<th scope="col">이메일</th>
						<th scope="col">직급</th>
						<th scope="col">부서명</th>
						<th scope="col">그룹이름</th>
						<th scope="col">메모</th>
					</tr>
				</thead>
				<tbody>
					<% for (AddBookVO addBook : abList) { i++; %>
					<tr>
						<th scope="row"><%= i %></th>
						<td><%= addBook.getManage_display_name() %></td>
						<td><%= addBook.getManage_hp() %></td>
						<td><%= addBook.getManage_email() %></td>
						<td><%= addBook.getManage_official_name() %></td>
						<td><%= addBook.getManage_dept_name() %></td>
						<td><%= addBook.getAdd_book_title() %></td>
						<td><%= addBook.getManage_remark() %></td>
					</tr>
					<% } %>
				</tbody>
			</table>
		</div>
	</section>
	<%@ include file="../include/footer.jsp"%>
</body>