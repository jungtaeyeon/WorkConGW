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
                    			생성 or 수정
                    	</h2>
                    </div>
                    <div class="col-sm-9" >
                   		<div style="float:right;">
                   			<%-- milestone_Id값이 0이면 등록 / 0이 아니면 저장 --%>
	                        	<button type="button" class="btn btn-primary" style="width:100px;font-size:1.2em;" onclick="registMilestone();">등록</button>
<%--	                        	<button type="button" class="btn btn-primary" style="width:100px;font-size:1.2em;" onclick="modifyMilestone();">저장</button>--%>
                        	<button type="button" onclick="window.location.href='${pageContext.request.contextPath}/board/milestone/list';" class="btn btn-secondary" style="width:100px;font-size:1.2em;">목록</button>
                    	</div>
                 	</div>
                </div>
            </div>

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
											 <input type="text" name="emp_Name" readonly="true" class="form-control" value="{로그인 사원이름}" />
										 </div>
		                             </div>
								</div>

								<div class="row clearfix">
									 <div class="col-sm-6" style="display: block;">
		                                 <div class="form-group">
		                                 <label>마일스톤 이름</label>
											 <%-- milestone_Name값이 있으면 받아올 예정(수정) --%>
											 <input type="text" class="form-control" name="milestone_Name" />
		                                 </div>
		                             </div>
								</div>

								<div class="row clearfix">
		                             <div class="col-sm-4">
	                                 	<div class="form-group">
	                                 		<label>마감 기한(선택)</label>
	                                 		<div class="input-group date" data-date-autoclose="true" data-provide="datepicker">
												<%-- milestone_End_Dt값이 있으면 받아올 예정(수정) --%>
												<input type="text" class="form-control" name="milestone_End_Dt" placeholder="마감기한 선택" readonly="true" />
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
		</div>
	</div>
	</div>

<script>
// 등록
function registMilestone(){

}

// 수정
function modifyMilestone(){

}
</script>
</section>
<!-- 푸터 인클루드 -->
<%@ include file="../../include/footer.jsp"%>
</body>
