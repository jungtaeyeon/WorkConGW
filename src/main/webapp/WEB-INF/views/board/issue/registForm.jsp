
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>




<body>
<!-- 헤더인클루드 -->
<%@ include file="../../include/header.jsp"%>


<section class="subPageContain">
	<!-- 사이드바 -->
	<%@ include file="../issueSidebar.jsp"%>

	<!--컨텐츠 영역-->
	<div class="contentConteiner">

		<div id="main-content">
			<div class="container-fluid">
				<div class="block-header">
					<div class="row">
						<div class="col-sm-3">
							<h2 style="padding-left: 10px; font-size: 2em; font-family: paybooc-Bold;">
								<i class="fas fa-sticky-note"></i>&nbsp;이슈 등록
							</h2>
						</div>
						<div class="col-sm-9" style="font-family: S-CoreDream-4Regular">
							<div style="float: right;">
								<button type="button" class="btn btn-primary"
										style="width: 100px; font-size: 1.2em;" onclick="submit_go();">등록</button>
								<button type="button" onclick="goBackToList();"
										class="btn btn-secondary"
										style="width: 100px; font-size: 1.2em;">취소</button>
							</div>
						</div>
					</div>
				</div>

				<div class="row clearfix" style="font-family: S-CoreDream-4Regular">
					<div class="col-lg-12 col-md-12 col-sm-12">
						<div class="card">
							<div class="body">
								<div id="fileUploadForm"></div>
								<div id="deleteFile"></div>
								<div class="row clearfix" style="padding: 10px;">

									<!-- 본문 -->
									<div class="col-md-3 col-sm-12 formGroup noticeForm cacForm dutyForm issueForm ">
										<label class="boardWriter" style="font-size: 14px; font-weight: bold;">작성자</label>
										<div class="form-group">
											<input type="text" readonly class="form-control"
												   placeholder="" value="${loginUser.empName }">
										</div>
									</div>
									<div class="col-md-3 col-sm-12 formGroup issueForm">
										<label style="font-size: 14px; font-weight: bold;">관련 업무 번호(선택)</label>
										<div class="form-group">
											<input type="text" id="dutyBoardIdForIssue"
												   class="form-control" placeholder="업무 글번호를 입력하세요."
												   maxlength="6">
										</div>
									</div>
									<div class="col-md-3 col-sm-12 formGroup issueForm">
										<label style="font-size: 14px; font-weight: bold;">프로젝트(선택)</label>
										<select id="projectStForIssue" class="form-control show-tick">
											<option value="">없음</option>
											<option value="todo">todo</option>
											<option value="inprogress">inprogress</option>
											<option value="done">done</option>
										</select>
									</div>
									<div class="col-md-3 col-sm-12 formGroup issueForm">
										<label style="font-size: 14px; font-weight: bold;">공개 여부 설정</label>
										<select id="issueOpenStForIssue" class="form-control show-tick">
										<option value="Y">공개</option>
										<option value="N">비공개</option>
									</select>
									</div>
									<div>
										<div class="col-sm-12 formGroup noticeForm cacForm anonyForm dutyForm issueForm">
											<div class="form-group">
												<label class="boardTitle" style="font-size: 14px; font-weight: bold;">제목</label>
												<input type="text" id="boardTitle" class="form-control" placeholder="">
											</div>
										</div>
										<!-- 내용 입력 -->
										<div class="col-sm-12 formGroup noticeForm cacForm anonyForm dutyForm issueForm">
											<div class="summernote" id="summernote" style="height: 200px;"></div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 업무 이슈 -->
	<form name="issueRegistForm" method="post">
		<input type="hidden" name="issueBoardTitle" />
		<input type="hidden" name="issueBoardContent" />
		<input type="hidden" type="hidden" name="emp_Id" value="${loginUser.emp_Id }" />
		<input type="hidden" name="duty_Board_Id" />
		<input type="hidden" name="issueOpenSt" />
	</form>

	<script>
		function goBackToList() {
			location.href = "${pageContext.request.contextPath}/board/issue/list";
		}
	</script>

</section>
<!-- 푸터 인클루드 -->
<%@ include file="../../include/footer.jsp"%>
</body>
