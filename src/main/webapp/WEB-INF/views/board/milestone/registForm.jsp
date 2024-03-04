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
                    	<h2 style="padding-left:10px; font-size:2em ; font-family:paybooc-Bold ; "><i class="far fa-sticky-note"></i>&nbsp;마일스톤
						<%-- milestone_Id값이 0이면 생성 / 0이 아니면 수정 --%>
							<c:if test="${milestoneVO.milestone_Id eq 0 }">
								생성
							</c:if>
							<c:if test="${milestoneVO.milestone_Id ne 0 }">
								수정
							</c:if>
                    	</h2>
                    </div>
                    <div class="col-sm-9" >
                   		<div style="float:right;">
                   			<%-- milestone_Id값이 0이면 등록 / 0이 아니면 저장 --%>
								<c:if test="${milestoneVO.milestone_Id eq 0 }">
									<button type="button" class="btn btn-primary" style="width:100px;font-size:1.2em;" onclick="registMilestone();">등록</button>
								</c:if>
								<c:if test="${milestoneVO.milestone_Id ne 0}">
									<button type="button" class="btn btn-primary" style="width:100px;font-size:1.2em; font-family: S-CoreDream-6Bold" onclick="modifyMilestone();">저장</button>
								</c:if>
                        	<button type="button" onclick="window.location.href='${pageContext.request.contextPath}/board/milestone/list';" class="btn btn-secondary" style="width:100px;font-size:1.2em;">목록</button>
                    	</div>
                 	</div>
                </div>
            </div>

			<form:form modelAttribute="milestoneVO" name="registForm">
				<form:hidden path="milestone_Id" />
	            <div class="row clearfix">
	                <div class="col-lg-12 col-md-12 col-sm-12">
	                    <div class="card">
	                        <div class="body">
	                            <div class="row clearfix">
		                             <!-- 본문 -->
		                             <div class="col-md-3 col-sm-12">
		                                 <label>작성자</label>
		                                 <div class="form-group">
											 <%-- ${loginUser.empName} 받아올 예정 --%>
												 <form:hidden path="emp_Id" readonly="true" class="form-control" value="${loginUser.emp_Id }" />
												 <form:input path="emp_Name" readonly="true" class="form-control" value="${loginUser.emp_Name }" />
										 </div>
		                             </div>
								</div>

								<div class="row clearfix">
									 <div class="col-sm-6" style="display: block;">
		                                 <div class="form-group">
		                                 <label>마일스톤 이름</label>
											 <%-- milestone_Name값이 있으면 받아올 예정(수정) --%>
											 <form:input path="milestone_Name" class="form-control" />
		                                 </div>
		                             </div>
								</div>

								<div class="row clearfix">
		                             <div class="col-sm-4">
	                                 	<div class="form-group">
	                                 		<label>마감 기한</label>
	                                 		<div class="input-group date" data-date-autoclose="true" data-provide="datepicker">
												<%-- milestone_End_Dt값이 있으면 받아올 예정(수정) --%>
													<form:input path="milestone_End_Dt" class="form-control" placeholder="마감기한 선택" readonly="true"/>
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
</div>

<script>
// 등록
function registMilestone(){
	$.ajax({
		url: '<c:url value="/board/milestone/regist"/>',
		type:'POST',
		data:$('form[name="registForm"]').serialize(),
		success:function (){
			alert('마일스톤이 생성되었습니다.');
			window.location.href='${pageContext.request.contextPath}/board/milestone/list';
		},
		error:function(){
			alert('등록 실패');
		}
	})
}

// 수정
function modifyMilestone(){
	$.ajax({
		url:'<c:url value="/board/milestone/modify"/>',
		type:'post',
		data:$('form[name="registForm"]').serialize(),
		success:function(){
			alert('마일스톤이 수정되었습니다.');
			window.location.href='${pageContext.request.contextPath}/board/milestone/list?isOpen='+('${milestoneVO.milestone_St}' == 1 ? 'open' : 'closed');
		},
		error:function(){
			alert('등록 실패');
		}
	});
}

// 종료/재시작


</script>
</section>
<!-- 푸터 인클루드 -->
<%@ include file="../../include/footer.jsp"%>
</body>
