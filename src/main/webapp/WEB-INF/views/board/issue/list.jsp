<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<body>
<!-- 헤더인클루드 -->
<%@ include file="../../include/header.jsp"%>
<section class="subPageContain">
	<!-- 사이드바 -->
	<%@ include file="../issueSidebar.jsp"%>

	<style>
		.columnList {
			position:absolute;
		}
		.columnList:hover{
			background-color: white !important;
			border-color: white white #dee2e6 !important;
		}
		.issueTitle:hover{
			color:#2980b9;
		}
	</style>

	<!--컨텐츠 영역-->
	<div class="contentConteiner">

		<!-- 메인 content -->
		<div id="main-content">
			<div class="container-fluid">
				<div class="row clearfix">
					<div class="col-12" style="margin-top: 2%; font-family: S-CoreDream-6Bold">
						<h2><i class="fa fa-tasks"></i>&nbsp;이슈 목록</h2>
						<hr>
					</div>
				</div>

				<div class="row clearfix" style="font-family: S-CoreDream-7ExtraBold">
					<div class="col-lg-12 col-md-12">
						<div class="card">
							<div class="body project_report">
								<button type="button" class="btn btn-light active" onclick="window.location.href='${pageContext.request.contextPath}/board/issue/list';">이슈</button>
								<button type="button" class="btn btn-light" onclick="window.location.href='${pageContext.request.contextPath}/board/milestone/list';">마일스톤</button>
								<button type="button" class="btn btn-light" onclick="window.location.href='${pageContext.request.contextPath}/board/project/list';">프로젝트</button>

								<label class="fancy-checkbox m-l-30">
									<%-- check 조건 및 함수 필요 --%>
									<input type="checkbox" data-parsley-multiple="checkbox"/>
									<span style="font-size: 15px;">내 이슈만 보기</span>
								</label>

								<div class="serchContain">  <!--셀렉/검색/버튼 묶는 div클래스 (이건 부트스트랩 클래스 아니고 임의로 만든 클래스)-->
									<form action="issueSearch" id="serchForm">
										<div style="margin-top:20px;"> <!--select 길이조절 클래스 (이건 부트스트랩 클래스 아니고 임의로 만든 클래스)-->
											<!-- select태그 클래스 --> <select class="form-control selectSearch" style="width:130px;font-size: 1.2em;float:left;" name="selectSearch">
												<option value="0">전체</option>
												<option value="manage_display_name">제목</option>
												<option value="manage_hp">내용</option>
												<option value="manage_official_name">작성자</option>
											</select>
										</div>
										<div id="navbar-search" class="navbar-form search-form selectSearch" style="float:left;"> <!--input 길이조절 클래스 (이건 부트스트랩 클래스 아니고 개별 클래스)-->
											<!-- 검색명 input 클래스 --> <input type="text" name="searchText" class="form-control" placeholder="입력해주세요" aria-label="입력해주세요">
										</div>
									</form>
									<!-- 검색 button 클래스 --><button class="btn btn-outline-secondary" onclick="serchBtn()" name="serchBtn" type="button">검색</button>

									<div class="tab-content p-l-0 p-r-0 text-align" style="font-size: 16px; float:right; padding-right: 10px;">
										<a href="<%=request.getContextPath()%>/board/issue/registForm" style="display: inline-block; font-family: paybooc-Bold; background-color: #2980b9; color: white; border: 0px; width: 100%; height: 3rem; border-radius: 5%; margin: 4% 0; text-align: center; line-height: 3rem; text-decoration: none; padding: 0 10px;">이슈 등록</a>
									</div>

								<%-- n에 페이지네이션 페이지 개수( 현재페이지 / 총 페이지 ) --%>
									<div class="form-group" style="float:right;">
										<div style="display: inline-block;float:left;font-size: 1.6em;margin:6px 20px 0 0">
											<span> n </span>/<span> n 페이지</span>
										</div>
									</div>
								</div>

								<div class="table-responsive" style="margin-top:20px;">
									<ul class="nav nav-tabs" style="position:absolute;width:97.5%;z-index: 10;">
										<%-- 클릭 시 changeCategory 함수 호출 --%>
												<li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="open" style="font-size: 16px;" onclick="changeCategory(this);"><i class="fas fa-info-circle"></i> <span style="margin-left:5px; font-size: 16px;"></span> Open</a></li>
												<li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="closed" style="font-size: 16px;" onclick="changeCategory(this);"><i class="fa fa-check"></i> <span style="margin-left:5px; font-size: 16px;"></span> Closed</a></li>
									</ul>
									<div class="tab-content p-l-0 p-r-0 p-t-0">
										<!-- Open 이슈 -->
										<div class="tab-pane animated fadeIn active">
											<table class="table table-hover js-basic-example table-custom m-b-0 no-footer" role="grid"> <!-- 부트스트랩 게시판 -->
												<thead class="thead-light"> <!-- 게시판 맨위 색변경 클래스-->
												<tr>
													<th style="width:40%;"></th>
													<th style="width:20%;">마일스톤</th>
													<th style="width:20%;">작성자</th>
													<th style="width:10%;">댓글</th>
													<th style="width:10%;">조회수</th>
												</tr>
												</thead>
												<tbody style="border:hidden;">
												<%-- tbody 이슈 리스트 담을 영역 시작 --%>
												<tr role="row">
													<td class="project-title" style="padding:15px 30px;">
														<a href="${pageContext.request.contextPath }/board/issue/detail">
															<span class="issueTitle" style="cursor:pointer;margin-left:5px;font-size:1.1em;"> 이슈 타이틀 (클릭 시 상세) </span>
														</a>
													</td>
												</tr>

												<%-- 검색 결과가 없을 때 ! --%>
<%--												<c:if test="${empty issueList }">--%>
													<tr role="row">
														<td class="project-title noList" style="text-align:center;font-size:1.2em;font-weight: bold;height:80px;" colspan="8">검색 결과가 없습니다.</td>
													</tr>
<%--												</c:if>--%>
												<%-- tbody 이슈 리스트 담을 영역 끝 --%>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- 메인 content 끝-->
		</div>

		<!--컨텐츠 영역 끝-->
	</div>
</section>
<!-- 푸터 인클루드 -->
<%@ include file="../../include/footer.jsp"%>
</body>
