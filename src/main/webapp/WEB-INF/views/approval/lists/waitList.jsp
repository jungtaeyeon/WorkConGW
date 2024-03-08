<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<style>
    .subTitleText {
        margin-bottom: 25px;
    }
    .subTitleText h2 {
        display: flex;
        justify-content: flex-start;
        align-items: center;
        font-size: 27px;
        padding: 10px 0;
        font-family: "Noto Sans KR", sans-serif;
    }
    .subTitleText i {
        font-size: 24px;
        margin-right: 5px;
    }
</style>
<!-- 헤더인클루드 -->
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<section class="subPageContain">
    <!-- 사이드바 -->
    <%@ include file="../sideBar.jsp"%>
    <!--컨텐츠 영역-->
    <div class="contentConteiner">
        <div id="main-content">
            <div class="container-fluid">
            <!-- 메인 content 넣는 곳 -->
            <div class="row clearfix">
                <div class="col-12" style="padding: 0;">
                    <div class="subTitleText">
						<h2><i class="fa-solid fa-angles-right"></i>결재대기문서</h2>
					</div>
                </div>
                <c:if test="${empty approvalList}">
                    <div class="col-12" style="font-family:S-CoreDream-6Bold" >
                        <h5>결재 대기 문서가 없습니다.</h5>
                    </div>
                </c:if>

                <c:forEach items="${approvalList}" var = "doc">
                    <div class="col-lg-3 col-md-12" >
                        <div class="card myWithCard" style="cursor: pointer; padding: 10px 15px;" onclick='window.location="<%=request.getContextPath()%>/approval/awaitDocDetail?docId=${doc.doc_Id}"'>
                            <div class="row clearfix">

                            <div class="body" style="margin-left: 12px; ">
                                    <span class="badge badge-primary" style="margin-bottom: 8px; font-size: 15px; font-weight: 500;">결재 대기중</span>
                                    <span class="differentTime" style="font-size:13px;"></span>
                                    <div class="pricing-option" style="margin-left: 4px;">
                                        <div class=waitListTitle style="font-family: S-CoreDream-6Bold">
                                            <h6 style="padding-top: 5px;">${doc.approval_Title}&nbsp&nbsp
                                                    <i class="fa fa-file-o fa-2x text-info" style="font-size: 18px;"></i>
                                                    <span>${doc.attachCnt}</span>
                                            </h6>
                                        </div>

                                        <div class="m-t-30 m-b-30" style="font-family:S-CoreDream-4Regular">
                                            <h6>기안자 : ${doc.emp_Name}&nbsp${doc.emp_Drafter_Official} </h6>
                                            <h6>기안일 : <span class="recommandDt" value="<fmt:formatDate value="${doc.approval_Recommand_Dt}" pattern="yyyy-MM-dd HH:mm:ss"/>"><fmt:formatDate value="${doc.approval_Recommand_Dt}" pattern="yyyy-MM-dd"/></span></h6>
                                            <h6>결재양식 : ${doc.form_Name} </h6>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

        </div>
    </div>
    </div>
</section>
<!-- 푸터 인클루드 -->
<%@ include file="/WEB-INF/views/include/footer.jsp"%>


<script>


    timeAlarm();

    function timeAlarm() {

        var recommandDtLength = $(".recommandDt").length;

        for(var i = 0; i < recommandDtLength; i++){

            var tempDt = new Date($(".recommandDt").eq(i).attr("value"));

            var _differentTime = $(".recommandDt").eq(i).parent().parent().parent().parent().find(".differentTime");

            getTimeDefferFromCurrent(tempDt, _differentTime);

        }

    }

    $(document).on("mouseover",".myWithCard",function(){
        $(this).css("opacity","0.5");
    })

    $(document).on("mouseout",".myWithCard",function(){

        $(this).css("opacity","1");

    });


    function getTimeDefferFromCurrent(tempDt, target) {
        var year = tempDt.getFullYear();
        var month = tempDt.getMonth();
        var date = tempDt.getDate();
        var hours = tempDt.getHours();
        var minutes = tempDt.getMinutes();
        var seconds = tempDt.getSeconds();

        var recommandDt = new Date(year, month, date, hours, minutes, seconds, 0);
        var currentDt = new Date();

        var differentDt = currentDt.getTime() - recommandDt.getTime();
        var differentDay = differentDt / (24 * 60 * 60 * 1000);
        var differentHours = differentDt / (60 * 60 * 1000);
        var differentMinutes = differentDt / (60 * 1000);

        var fiveMinutesByMillisecond = 5 * 60 * 1000;
        var oneHourByMillisecond = 60 * 60 * 1000;
        var oneDayByMillisecond = 24 * 60 * 60 * 1000;

        if (differentDt < fiveMinutesByMillisecond) {
            target.html("<span class='badge badge-danger'>방금 온 결재문서</span>");
            return;
        }

        if (differentDt < oneHourByMillisecond) {
            var hourDiff = Math.floor(differentMinutes / 60);
            var minuteDiff = Math.floor(differentMinutes % 60);
            target.html(hourDiff + "시간 " + minuteDiff + "분 전");
            return;
        }

        if (differentDt < oneDayByMillisecond) {
            target.html(Math.floor(differentHours) + " 시간 전");
            return;
        }

        target.html(Math.floor(differentDay) + " 일 전");
    }



</script>
</body>
</html>
