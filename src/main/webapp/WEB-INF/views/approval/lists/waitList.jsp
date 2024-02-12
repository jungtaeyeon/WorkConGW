<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
    <title>Title</title>
</head>
<body>
<!-- 헤더인클루드 -->
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<section class="subPageContain">
    <!-- 사이드바 -->
    <%@ include file="../sideBar.jsp"%>
    <!--컨텐츠 영역-->
    <div class="contentConteiner">
        <div id="main-content">
            <div class="container-fluid" style="font-family: S-CoreDream-6Bold"">
            <!-- 메인 content 넣는 곳 -->
            <div class="row clearfix">
                <div class="col-12" style="margin-top: 2%; font-family: S-CoreDream-6Bold">
                    <h2>결재 대기 문서</h2>
                    <hr>
                </div>
                    <div class="col-12" style="font-family:S-CoreDream-6Bold" >
                        <h5>결재 대기 문서가 없습니다.</h5>
                    </div>

                    <div class="col-lg-3 col-md-12" >
                        <div class="card myWithCard" style="cursor: pointer;">
                            <div class="row clearfix">

                                <div class="body" style="margin-left: 12px; ">
                                    <span class="badge badge-primary" style="margin-bottom: 8px; font-family:S-CoreDream-4Regular">결재 대기중</span>
                                    <span class="differentTime"></span>
                                    <div class="pricing-option" style="margin-left: 4px;">
                                        <div class=waitListTitle style="font-family: S-CoreDream-6Bold">
                                            <h6 style="padding-top: 5px; ">${doc.approvalTitle}&nbsp&nbsp
                                                    <i class="fa fa-file-o fa-2x text-info" style="font-size: 18px;"></i>
                                                    <span>${doc.attachCnt}</span>
                                            </h6>
                                        </div>

                                        <div class="m-t-30 m-b-30" style="font-family:S-CoreDream-4Regular">
                                            <h6>기안자 : ${doc.empDrafterName}&nbsp${doc.empDrafterOfficial} </h6>
                                            <h6>기안일 : <span class="recommandDt" ></span></h6>
                                            <h6>결재양식 : ${doc.formName} </h6>
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
</section>
<!-- 푸터 인클루드 -->
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>
