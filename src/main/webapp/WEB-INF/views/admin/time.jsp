<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="root" value="<%=request.getContextPath() %>" scope="application"/>

<html>
<head>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/js/treeview/jquery.treeview.css" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/js/treeview/screen.css" />
    <script src="<%=request.getContextPath() %>/js/treeview/jquery.treeview.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>

    <script src="https://kit.fontawesome.com/3a92c85ff9.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
</head>
<style>
    .subPageContain {
        display: flex;
    }

    .contentConteiner {
        flex: 1; /* 콘텐츠 컨테이너가 남은 공간을 채우도록 설정 */
        padding: 50px;
    }
    .side-bar {
        /*position: fixed;*/
        /*background-color: rgba(255, 255, 255, 0.95);*/
        background-color: #0c1e35;
        color: white;
        box-shadow: 0px 0px 7px -2px rgba(0, 0, 0, 0.025);
        width: var(--side-bar-width);
        min-height: var(--side-bar-height);
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
    }

    #time {
        /* 원하는 너비 값을 설정합니다. */
        width: 200px; /* 예시로 200px로 설정합니다. */
        /* 기타 필요한 스타일을 추가할 수 있습니다. */
    }


</style>
<body>
<section class="subPageContain">
    <!-- 사이드바 -->
    <%@ include file="./sidebar.jsp"%>
    <!--컨텐츠 영역-->
    <div class="contentConteiner">
        <!-- 메인 content -->
        <div class="container-fluid">
            <div class="row clearfix">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="header">
                            <span style="color: #a9a9a9; font-family: S-CoreDream-4Regular">업무시간 관리</span>
                            <h3 style="font-family: S-CoreDream-6Bold">업무시간 설정</h3>
                            <div class="box-container">
                                <form name="timeForm" action="${pageContext.request.contextPath}/admin/time/modify">
                                    <div class="card" style="background-color: aliceblue;margin:20px 0;padding:10px;">
                                        <div class="header" style="font-family: S-CoreDream-6Bold">
                                            <h5 style="font-weight: bold;">출근/퇴근/점심시간 설정</h5>
                                        </div>
                                        <div class="body" style="font-family: S-CoreDream-4Regular">
                                            <div class="form-group" style="padding:0 15px;">
                                                <h2>출근 시간</h2>
                                                <div class="form-group" style="margin-top:15px;">
                                                    <div class="row clearfix">
                                                        <div class="col-lg-3 col-md-6">
                                                            <div class="input-group mb-3">
                                                                <input type="time" class="form-control" name="attend_Time" style="font-size:1.4em;" value="${time.attend_Time }">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group" style="padding:0 15px;">
                                                <h2>점심 시간</h2>
                                                <div class="form-group" style="margin-top:15px;">
                                                    <div class="row clearfix">
                                                        <div class="col-lg-3 col-md-6">
                                                            <div class="input-group mb-3">
                                                                <input type="time" class="form-control" name="lunch_Start_Time" style="font-size:1.4em;"  size=10; value="${time.lunch_Start_Time }">
                                                            </div>
                                                        </div>
                                                        <span style="font-size:2em;">~</span>
                                                        <div class="col-lg-3 col-md-6">
                                                            <div class="input-group mb-3">
                                                                <input type="time" class="form-control" name="lunch_End_Time" style="font-size:1.4em;" value="${time.lunch_End_Time }">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group" style="padding:0 15px;">
                                                <h2>퇴근 시간</h2>
                                                <div class="form-group" style="margin-top:15px;">
                                                    <div class="row clearfix">
                                                        <div class="col-lg-3 col-md-6">
                                                            <div class="input-group mb-3">
                                                                <input type="time" class="form-control" name="leaving_Time" style="font-size:1.4em;" value="${time.leaving_Time }">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <button type="button" class="btn btn-primary" style="float:right; font-family: S-CoreDream-6Bold" onclick="modifyTime();" >변경사항 저장</button>
                                    <div style="clear:both;"></div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

</body>
<script>
    function modifyTime(){
        let form = $('form[name="timeForm"]')[0];
        $.ajax({
            url:form.action,
            type: 'post',
            data : new FormData(form),
            contentType : false,
            processData : false,
            success:function ()
            {
            },
            error:function ()
            {
                alert('변경사항이 완료되었습니다.')
            }
        })
    }
</script>
</html>
