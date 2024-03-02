<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp"%>

<style>
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
    .tableGroupTit{font-size: 18px;}
    .tableGroopContain{
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin: 3% 0;
    }
    .tableGroup{width: 49%;}
</style>
<section class="subPageContain">

    <!-- 사이드바 -->
    <%@ include file="./sideBar.jsp"%>

    <!--컨텐츠 영역-->
    <div class="contentConteiner">
        <div id="main-content">
            <div class="container-fluid">
                <!-- 메인 content 넣는 곳 -->
                <div class="row clearfix" >
                    <div class="col-12" style="margin-top: 2%; font-family: S-CoreDream-6Bold">
                        <!--                     <h2>전자 결재</h2> -->
                        <h2 style="font-family: S-CoreDream-6Bold"><i class="icon-note" ></i>&nbsp;전자 결재</h2>
                        <hr>
                    </div>



                </div>

                <div class="row clearfix " style="font-family: S-CoreDream-4Regular" >
                    <div class="col-lg-6 col-md-12" style="padding-right: 4px;">

                        <div class="card" >
                            <div class="header">
                                <h5 >
                                    결재 대기 문서
                                    <span class="float-right" style="cursor: pointer; " onclick="location.href='<%=request.getContextPath()%>/approval/lists/waitList'">
		                    		<i class="fa fa-sign-in"></i>
		                    	</span>
                                </h5>

                            </div>
                            <div class="body">
                                <div class="table-responsive" style="overflow: hidden;">
                                    <table class="table table-hover m-b-0 c_list">
                                        <thead>
                                        <tr>
                                            <th>상신날짜</th>
                                            <th>사용 양식</th>
                                            <th>기안서 제목</th>
                                            <th>첨부</th>
                                            <th>문서번호</th>
                                            <th>결재상태</th>
                                        </tr>
                                        </thead>
                                        <tbody style="cursor: pointer;">
                                        <c:forEach items="${dataMap.docs }" var="doc" varStatus="status">
                                            <fmt:parseNumber value="${today.time - doc.approval_Recommand_Dt.time }" integerOnly="true" var="defferTime"/>
                                            <c:if test="${status.count < 4}">
                                                <tr onclick="window.location='<%=request.getContextPath()%>/approval/awaitDocDetail?docId=${doc.doc_Id}';">
                                                <td><fmt:formatDate value="${doc.approval_Recommand_Dt}" pattern="yyyy-MM-dd"/></td>
                                                <td><span>${doc.form_Name}</span></td>
                                                <td>

			                                            		<span class="text-info" style="display: inline-block;font-weight: bold;max-width: 155px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">
                                                                        ${doc.approval_Title}
                                                                </span>

                                                    <c:if test="${defferTime <= (1000*60*30) }">
                                                        &nbsp<span class="badge badge-danger">방금전</span>
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <c:if test="${doc.attachCnt != 0}">
                                                        &nbsp<i class="fa fa-save">&nbsp&nbsp${doc.attachCnt }</i>
                                                    </c:if>
                                                </td>
                                                <td>${doc.doc_Id}</td>
                                                    <td><span class="badge badge-success">결재진행중</span></td>
                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${empty dataMap.docs}">
                                            <tr>
                                                <td colspan="6" style="text-align: center;"><strong>해당 결재문서가 존재하지 않습니다.</strong></td>
                                            </tr>
                                        </c:if>

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="header">
                                <h5>
                                    기안 문서함
                                    <span class="float-right" style="cursor: pointer;" onclick="location.href='<%=request.getContextPath()%>/approval/lists/draftList'">
		                    		<i class="fa fa-sign-in"></i>
		                    	</span>
                                </h5>
                            </div>
                            <div class="body">
                                <div class="table-responsive" style="overflow: hidden;">
                                    <table class="table table-hover m-b-0 c_list">
                                        <thead>
                                        <tr>
                                            <th>상신날짜</th>
                                            <th>사용 양식</th>
                                            <th>기안서 제목</th>
                                            <th>첨부</th>
                                            <th>문서번호</th>
                                            <th>결재상태</th>
                                        </tr>
                                        </thead>
                                        <tbody style="cursor: pointer;">
                                        <c:forEach items="${dataMap.draftDocs }" var="doc" varStatus="status">
                                            <fmt:parseNumber value="${today.time - doc.approval_Recommand_Dt.time }" integerOnly="true" var="defferTime"/>
                                            <c:if test="${status.count < 4}">
                                                <tr onclick="window.location='<%=request.getContextPath()%>/approval/draftDetail?docId=${doc.doc_Id}';">
                                                    <td><fmt:formatDate value="${doc.approval_Recommand_Dt}" pattern="yyyy-MM-dd"/></td>
                                                    <td><span>${doc.form_Name}</span></td>
                                                    <td>
                                                        <span class="text-info" style="display: inline-block;font-weight: bold;max-width: 155px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">${doc.approval_Title}</span>
                                                        <c:if test="${defferTime <= (1000*60*30) }">
                                                            &nbsp<span class="badge badge-danger">방금전</span>
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <c:if test="${doc.attachCnt != 0}">
                                                            &nbsp<i class="fa fa-save">&nbsp&nbsp${doc.attachCnt }</i>
                                                        </c:if>
                                                    </td>
                                                    <td>${doc.doc_Id}</td>
                                                    <c:if test="${doc.approval_St eq 1 }" >
                                                        <td><span class="badge badge-success">결재진행중</span></td>
                                                    </c:if>
                                                    <c:if test="${doc.approval_St eq 2 }" >
                                                        <td><span class="badge badge-primary">결재완료</span></td>
                                                    </c:if>
                                                    <c:if test="${doc.approval_St eq 3 }" >
                                                        <td><span class="badge badge-danger">결재반려</span></td>
                                                    </c:if>

                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${empty dataMap.draftDocs}">
                                            <tr>
                                                <td colspan="6" style="text-align: center;"><strong>해당 결재문서가 존재하지 않습니다.</strong></td>
                                            </tr>
                                        </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>



                    </div>
                    <div class="col-lg-6 col-md-12" style="padding-right: 4px;">
                        <div class="card">
                            <div class="header">
                                <h5>
                                    결재완료문서
                                    <span class="float-right" style="cursor: pointer;" onclick="location.href='<%=request.getContextPath()%>/approval/lists/completeList'">
	                    		<i class="fa fa-sign-in"></i>
	                    	</span>
                                </h5>
                            </div>

                            <div class="body">
                                <div class="table-responsive" style="overflow: hidden;">
                                    <table class="table table-hover m-b-0 c_list">
                                        <thead>
                                        <tr>
                                            <th>상신날짜</th>
                                            <th>사용 양식</th>
                                            <th>기안서 제목</th>
                                            <th>첨부</th>
                                            <th>문서번호</th>
                                            <th>결재상태</th>
                                        </tr>
                                        </thead>
                                        <tbody style="cursor: pointer;">
                                        <c:forEach items="${dataMap.completeDocs }" var="doc" varStatus="status">
                                            <fmt:parseNumber value="${today.time - doc.approval_Recommand_Dt.time }" integerOnly="true" var="defferTime"/>
                                            <c:if test="${status.count < 4}">
                                                <tr onclick="window.location='<%=request.getContextPath()%>/approval/completeDetail?docId=${doc.doc_Id}';">
                                                    <td><fmt:formatDate value="${doc.approval_Recommand_Dt}" pattern="yyyy-MM-dd"/></td>
                                                    <td><span>${doc.form_Name}</span></td>
                                                    <td>
                                                        <span class="text-info" style="display: inline-block;font-weight: bold;max-width: 155px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">${doc.approval_Title}</span>
                                                        <c:if test="${defferTime <= (1000*60*30) }">
                                                            &nbsp<span class="badge badge-danger">방금전</span>
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <c:if test="${doc.attachCnt != 0}">
                                                            &nbsp<i class="fa fa-save">&nbsp&nbsp${doc.attachCnt }</i>
                                                        </c:if>
                                                    </td>
                                                    <td>${doc.doc_Id}</td>
                                                    <c:if test="${doc.approval_St == 2 }">
                                                        <td><span class="badge badge-primary">결재완료</span></td>
                                                    </c:if>
                                                    <c:if test="${doc.approval_St eq '3' }">
                                                        <td><span class="badge-purple badge">결재반려</span></td>
                                                    </c:if>

                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${empty dataMap.completeDocs}">
                                            <tr>
                                                <td colspan="6" style="text-align: center;"><strong>해당 결재문서가 존재하지 않습니다.</strong></td>
                                            </tr>
                                        </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>



                        <div class="card">
                            <div class="header">
                                <h5>
                                    참조 문서함
                                    <span class="float-right" style="cursor: pointer;" onclick="location.href='<%=request.getContextPath()%>/approval/lists/referList'">
	                    		<i class="fa fa-sign-in"></i>
	                    	</span>
                                </h5>
                            </div>

                            <div class="body">
                                <div class="table-responsive" style="overflow: hidden;">
                                    <table class="table table-hover m-b-0 c_list">
                                        <thead>
                                        <tr>
                                            <th>상신날짜</th>
                                            <th>사용 양식</th>
                                            <th>기안서 제목</th>
                                            <th>첨부</th>
                                            <th>문서번호</th>
                                            <th>결재상태</th>
                                        </tr>
                                        </thead>
                                        <tbody style="cursor: pointer;">
                                        <c:forEach items="${dataMap.referDocs }" var="doc" varStatus="status">
                                            <fmt:parseNumber value="${today.time - doc.approval_Recommand_Dt.time }" integerOnly="true" var="defferTime"/>
                                            <c:if test="${status.count < 4}">
                                                <tr onclick="window.location='<%=request.getContextPath()%>/approval/referDetail?docId=${doc.doc_Id}';">
                                                    <td><fmt:formatDate value="${doc.approval_Recommand_Dt}" pattern="yyyy-MM-dd"/></td>
                                                    <td><span>${doc.form_Name}</span></td>
                                                    <td>
                                                        <span class="text-info" style="display: inline-block;font-weight: bold;max-width: 155px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">${doc.approval_Title}</span>
                                                        <c:if test="${defferTime <= (1000*60*30) }">
                                                            &nbsp<span class="badge badge-danger">방금전</span>
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <c:if test="${doc.attachCnt != 0}">
                                                            &nbsp<i class="fa fa-save">&nbsp&nbsp${doc.attachCnt }</i>
                                                        </c:if>
                                                    </td>
                                                    <td>${doc.doc_Id}</td>
                                                    <td><span class="badge badge-info">참조</span></td>
                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${empty dataMap.referDocs}">
                                            <tr>
                                                <td colspan="6" style="text-align: center;"><strong>해당 결재문서가 존재하지 않습니다.</strong></td>
                                            </tr>
                                        </c:if>
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
</section>

<!-- 푸터 인클루드 -->
<%@ include file="../include/footer.jsp"%>