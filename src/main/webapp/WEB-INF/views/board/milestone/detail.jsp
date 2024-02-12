<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/fonts/font.css">

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
tr:hover{
	background-color: white;
}
</style>
	<div class="contentConteiner">
<!-- 메인 content -->
<div id="main-content">
	<div class="container-fluid">
			<div class="row clearfix">
                <div class="col-12" style="margin-top: 2%; font-family: S-CoreDream-6Bold">
                    <h2><i class="fas fa-tasks"></i>&nbsp;마일스톤 상세</h2>
                    <hr>
                </div>
		 	</div>

            <div class="row clearfix">
                <div class="col-lg-12 col-md-12" style="font-family: S-CoreDream-4Regular">
                    <div class="card">
                        <div class="body project_report">
                        	<button type="button" class="btn btn-light" onclick="window.location.href='${pageContext.request.contextPath}/board/issue/list';" style="font-family: S-CoreDream-6Bold">이슈</button>
                        	<button type="button" class="btn btn-light active" onclick="window.location.href='${pageContext.request.contextPath}/board/milestone/list';" style="font-family: S-CoreDream-6Bold">마일스톤</button>
                        	<button type="button" class="btn btn-light" onclick="window.location.href='${pageContext.request.contextPath}/board/project';">프로젝트</button>

                        	<button type="button" class="btn btn-danger float-right m-r-5" onclick="removeMilestone('${milestone.milestoneId}');">삭제</button>
                        	<button type="button" class="btn btn-info float-right m-r-5" onclick="window.location.href='${pageContext.request.contextPath }/board/milestone/modifyForm';">수정</button>
                        	<hr>
                        	
                        	<!-- 마일스톤 제목 -->
                           	<div style="margin-top:20px;">
                                <h4 style="width:90%;">
                                	<span style="margin-bottom:5px;font-weight: bold;vertical-align: middle;margin-left:5px;font-size:1.1em;">${milestone.milestone_Name }</span>
                                </h4>
                           	</div>
                           	
							<!-- 진행률 -->
							<%-- 오픈이슈 카운트 + 클로즈이슈 카운트 = 0이면: percentage 벨류값0 부터 시작 --%>
							<c:set var="percentage" value="0"></c:set>

							<%-- 오픈이슈 카운트 + 클로즈이슈 카운트 = 0이 아니면: --%>
							<%-- 클로즈이슈 / 전체이슈(오픈이슈+클로즈이슈) * 100 --%>


							<%-- 진행률 progress bar 영역 --%>
                            <div class="progress progress-xs" style="height:10px;margin:15px 5px 10px;width:30%;background-color:rgb(0,0,0,0.2);">
                                <div class="progress-bar" role="progressbar" aria-valuenow="${percentage }" aria-valuemin="0" aria-valuemax="100" style="width: ${percentage }%; height:10px;"></div>
                            </div>

                            <!-- 텍스트 -->
                           	<div style="font-size: 1.1em;">
								<i class="far fa-clock"></i><span style="margin-left:5px;">마감일
								<%-- 마감일 if문 작성 영역 --%>
								없음
                                </span>
                                <span style="margin-left:20px;"><strong style="font-size:1.1em;">${percentage }%</strong> 진행됨</span>
                           	</div>
                        	
                        	<!-- 이슈 리스트 -->
	                            <div class="table-responsive" style="margin-top:20px;">
		                        	<ul class="nav nav-tabs">
											<%-- 클릭 시 changeCategory 함수 호출 --%>
										<li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="open" onclick="changeCategory(this);"><i class="fas fa-info-circle"></i> <span style="margin-left:5px;"></span> Open</a></li>
										<li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="closed" onclick="changeCategory(this);"><i class="fa fa-check"></i> <span style="margin-left:5px;"></span> Closed</a></li>
						            </ul>
						            
						            <div class="tab-content p-l-0 p-r-0 p-t-0">
						            	<!-- 마일스톤 뷰-->
						                <div class="tab-pane animated fadeIn active">
			                                <table class="table table-hover js-basic-example table-custom m-b-0 no-footer" role="grid">
			                                    <tbody style="border:hidden;">
				                                        	<tr role="row">
					                                            <td class="project-title" style="padding:15px 30px;">
					                                            	<div style="margin-bottom:5px;">
						                                                <h6 style="display:inline-block;font-weight: bold;max-width: 400px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;">
																			<%-- 이슈 상태 open일 때 --%>
							                                                	<i class="fas fa-info-circle" style="color:green;"></i>
																					<%-- 이슈 상태 close일 때 --%>
							                                                	<i class="fa fa-check" style="color:red;"></i>
																				<%-- 클릭 시 해당 이슈 상세 이동?? --%>
						                                                	<span class="issueTitle" style="cursor:pointer;margin-left:5px;font-size:1.1em;" >{이슈 타이틀}</span>
						                                                </h6>
																		<%-- 이슈에 업무 엮여있을 때: 클릭 시, 업무 상세? --%>
								                                                <span class="btn btn-secondary" style="padding: 0px 3px;margin-left:5px;"># {업무 id}</span>

					                                            	</div>
					                                                <span style="margin-left:25px;"># {이슈 id}</span><br>
																	<i class="far fa-clock"></i><span style="margin-left:5px;">{이슈 생성 일자}</span>
					                                            </td>
					                                            <td class="project-actions" style="font-size:1.3em;">
																	<%-- 이슈 댓글 있는 경우 --%>
						                                            	<i class="far fa-comment-alt" style="margin-left:5px;"></i> n
					                                            </td>
					                                        </tr>

			                                    	<!-- 이슈가 없을때 -->
<%--			                                    	<c:if test="${empty milestone.issueList }">--%>
			                                    		<tr role="row">
				                                            <td class="project-title noList" style="text-align:center;font-size:1.2em;font-weight: bold;height:80px;">이슈가 존재하지 않습니다.</td>
			                                            </tr>
<%--			                                    	</c:if>--%>
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
</div>
	</div>

<script>


// 마일스톤 삭제
function removeMilestone(milestone_Id){

}

</script>

</section>
<!-- 푸터 인클루드 -->
<%@ include file="../../include/footer.jsp"%>
</body>
