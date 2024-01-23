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
	
</style>
	<%@ include file="../include/header.jsp"%>
	<section class="subPageContain">
		<div class="sideSubNav">
			<!-- 버튼 형식 -->
			<div class="sideButton">
				<a herf="#">주소 추가</a>
			</div>
			<!-- 드롭메뉴 -->
			<ul class="SubMenu">

				<li class="subMenuLi">
					<a class="subMenuLink" href="#">개인주소록</a>
					<ul class="subMenu_subMenu">
						<li class="subMenu_subMenuLi">
							<a class="subMenuLink" href="#">미등록 그룹</a>
						</li>
					</ul>
				</li>

				<li class="subMenuLi">
					<a href="#">회사주소록</a>
					<ul class="subMenu_subMenu">
						<li class="subMenu_subMenuLi">
							<a href="#">미등록 그룹</a>
						</li>
					</ul>
				</li>

			</ul>
		</div>
		<div></div>
	</section>
	<%@ include file="../include/footer.jsp"%>
</body>