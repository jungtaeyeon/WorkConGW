<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<body>
<!-- 헤더인클루드 -->
<%@ include file="../../include/header.jsp"%>
<section class="subPageContain">
	<!-- 사이드바 -->
	<%@ include file="../issueSidebar.jsp"%>

	<div class="contentConteiner">
		<div id="main-content">
			<div class="container-fluid">
				<div class="block-header">
					<div class="row" >
						<div class="col-sm-3" >
							<h2 style="padding-left:10px; font-size:2em ; font-family:paybooc-Bold ; "><i class="fa fa-clipboard"></i>&nbsp;프로젝트
								<c:if test="${projectVO.project_Id eq 0 }">
									생성
								</c:if>
								<c:if test="${projectVO.project_Id ne 0 }">
									수정
								</c:if>
							</h2>
						</div>
						<div class="col-sm-9" >
							<div style="float:right;">
								<c:if test="${projectVO.project_Id eq 0 }">
									<button type="button" class="btn btn-primary" style="width:100px;font-size:1.2em;" onclick="registProject();">등록</button>
								</c:if>
								<c:if test="${projectVO.project_Id ne 0}">
									<button type="button" class="btn btn-primary" style="width:100px;font-size:1.2em;" onclick="modifyProject();">저장</button>
								</c:if>
								<button type="button" onclick="window.location.href='${pageContext.request.contextPath}/board/project/list'" class="btn btn-secondary" style="width:100px;font-size:1.2em; font-family: S-CoreDream-6Bold">취소</button>
							</div>
						</div>
					</div>
				</div>

				<form:form modelAttribute="projectVO" name="registForm">
					<form:hidden path="project_Id" />
					<div class="row clearfix">
						<div class="col-lg-12 col-md-12 col-sm-12">
							<div class="card">
								<div class="body">
									<div class="row clearfix" style="margin-left: 5px">
										<!-- 본문 -->
										<div class="col-md-3 col-sm-12" style="margin-top: 5px">
											<label>작성자</label>
											<div class="form-group">
												<form:hidden path="emp_Id" readonly="true" class="form-control" value="${loginUser.emp_Id }" />
												<c:if test="${projectVO.emp_Name == null }">
												<form:input path="emp_Name" readonly="true" class="form-control" value="${loginUser.emp_Name }" />
												</c:if>
												<c:if test="${projectVO.emp_Name != null }">
												<form:input path="emp_Name" readonly="true" class="form-control" value="${projectVO.emp_Name }" />
												</c:if>
											</div>
										</div>
									</div>
									<div class="row clearfix" style="margin-left: 5px">
										<div class="col-sm-6" style="display: block;">
											<div class="form-group">
												<label>프로젝트 이름</label>
												<form:input path="project_Title" id="projectTitle" class="form-control" />
											</div>
										</div>
									</div>
									<div class="row clearfix" style="margin-left: 5px">
										<div class="col-sm-4">
											<div class="form-group">
												<label>마감 기한(선택)</label>
												<div class="input-group date" data-date-autoclose="true" data-provide="datepicker" data-title ="ssss">
													<form:input path="project_End_Dt" id="projectEndDt" class="form-control" placeholder="마감기한 선택" readonly="true"/>
													<div class="input-group-append">
														<button class="btn btn-outline-secondary" type="button"><i class="fas fa-calendar"></i></button>
													</div>
												</div>
											</div>
										</div>
									</div>

								</div>
							</div>
						</div>
					</div>
				</form:form>
			</div>
		</div>

		<script>
			// datepicker 내일 이전 날짜 선택 막기
			$(document).ready(function(){
				var tomorrow = new Date();
				tomorrow.setDate(tomorrow.getDate() + 1); // 내일의 날짜를 가져옴
				$('.date').datepicker({
					startDate: tomorrow, // 내일 이후의 날짜만 선택 가능하도록 설정
				});
			});
			// 등록
			function registProject(){
				// 마감기한을 가져오기
				let projectEndDt = $('#projectEndDt').val();
				let projectTitle = $('#projectTitle').val();

				if(projectTitle==''){
					alert('제목을 입력하세요.');
					return;
				}
				if(projectEndDt==''){
					alert('마감기한을 선택하세요.');
					return;
				}

				$.ajax({
					url:'<c:url value="/board/project/regist"/>',
					type:'post',
					data:$('form[name="registForm"]').serialize(),
					success:function(){
						alert('프로젝트가 생성되었습니다.');
						window.location.href='${pageContext.request.contextPath}/board/project/list';
					},
					error:function(){
						alert('등록 실패');
					}
				});
			}

			// 수정
			function modifyProject(){
				$.ajax({
					url:'<c:url value="/board/project/modify"/>',
					type:'post',
					data:$('form[name="registForm"]').serialize(),
					success:function(){
						alert('프로젝트가 수정되었습니다.');
						window.location.href='${pageContext.request.contextPath}/board/project/list?isOpen='+('${projectVO.project_St}' == 1 ? 'open' : 'closed');
					},
					error:function(){
						alert('등록 실패');
					}
				});
			}

			// 종료/재시작
			function changeProject(){
				$.ajax({
					url:'<c:url value="/board/project/modify"/>',
					type:'post',
					data:{projectId:'${projectVO.project_Id}',projectSt:('${projectVO.project_St}' == 1 ? 'N' : 'Y')},
					success:function(){
						window.opener.location.href='${pageContext.request.contextPath}/board/project/list?isOpen='+('${projectVO.project_St}' == 1 ? 'closed' : 'open');
						window.close();
					},
					error:function(){
						alert('등록 실패');
					}
				});
			}
		</script>
	</div>
</section>
<!-- 푸터 인클루드 -->
<%@ include file="../../include/footer.jsp"%>
</body>
