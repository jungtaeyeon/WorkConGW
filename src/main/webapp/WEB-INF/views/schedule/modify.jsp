<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/vendor/css/fullcalendar.min.css" />
    <link rel="stylesheet" href='<%=request.getContextPath() %>/resources/vendor/css/select2.min.css' />


    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:400,500,600">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/main.css">
    <title>일정 수정</title>
    <style>
        #main-content{
            /*margin: 0px;*/
            position: relative;
        }
        *, ::after, ::before{
            box-sizing: border-box;
        }
        .container-fluid-header, .container-fluid-footer{
            display: flex;
            justify-content: space-between;
            padding-top: 15px;
        }
        body {
            padding: 0px 30px 30px 30px;
        }
        .form-header > div {
            margin-top: 20px;
        }
        .col-12 {

            padding: 5px;
        }
        div#main-content{
            border: solid 1px rgba(0,0,0,.03);
            border-radius: 1%;
            background-color: #ffffff;
            padding: 0px 10px 10px;
            margin-top: 20px;
        }
        body{
            padding: 0px 30px 30px 30px;
            background-color: rgba(0,0,0,.03);
        }
        .form-control[disabled], .form-control[readonly], fieldset[disabled] .form-control{
            background-color: #ffffff;
        }
        .form-control{
            width: 100%;
            max-width: 49em;
        }

        .col-12{
            width: 100%;
            max-width: 49em;
        }
        .btn-info {
            color: #fff;
            background-color: #17a2b8;
            border-color: #17a2b8;
        }
        .btn-info:hover {
            color: #fff;
            background-color: #138496;
            border-color: #117a8b;
        }

    </style>
</head>

<body>
<%@ include file="../include/header.jsp"%>
<section class="subPageContain">
<div id="main-content" style="font-family: S-CoreDream-4Regular">
    <div class="container-fluid">
        <div class="">
            <div class="form-header container-fluid-header" style="font-family: S-CoreDream-6Bold">
                <h3 class="form-title">일정 수정</h3>
                <div>
                                        <c:if test="${loginUser.emp_Id eq schedule.username }">
                    <button type="button" class="btn btn-info" onclick="modifySchedule();">수정완료</button>
                                        </c:if>
                    <button type="button" class="btn btn-secondary" onclick="javascript:history.back(-1);" style="border: 1px solid gray">취소</button>
                </div>
            </div>
            <hr>
            <!-- 로그인 사용자로 대체할 것 -->
            <input type="hidden" id="scheduleId" value="${schedule.id}"/>
            <div class="row">
                <div class="col-12" style="margin: 0px 5px;">
                    <label class="col-4 col-form-label" for="edit-important" style="padding: 2px 15px 0px;">중요일정 설정</label>
                    <input id="edit-important" type="checkbox" style="width: 25px; height: 25px;" class="float-left"   ${schedule.imp eq 'true' ? 'checked' : ''}>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <label class="col-4 col-form-label" for="edit-title">일정명</label>
                    <input class="form-control" type="text" name="edit-title" id="edit-title" required="required" value='${schedule.title }' />
                </div>
            </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <label class="col-4 col-form-label" for="edit-start">시작일시</label>
                    <input class="form-control" type="datetime-local" name="edit-start" id="edit-start" value='${schedule.start}'/>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <label class="col-4 col-form-label" for="edit-end">종료일시</label>
                    <input class="form-control" type="datetime-local" name="edit-end" id="edit-end" value='${schedule.end }'/>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <label class="col-4 col-form-label" for="edit-location">장소</label>
                    <input class="form-control" type="text" name="edit-location" id="edit-location" value='${schedule.location }'/>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <label class="col-4 col-form-label" for="edit-type">일정 그룹</label>
                    <input class="form-control" type="text" name="edit-type" id="edit-type" readonly="true" value="${schedule.type}"/>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <label class="col-4 col-form-label" for="edit-content">설명</label>
                    <textarea rows="4" cols="50" class="form-control" name="edit-content" id="edit-content" >${schedule.content }</textarea>
                </div>
            </div>
        </div>
    </div>
</div>
</section>

<%@ include file="../include/footer.jsp"%>

<!-- fullCalendar 기본 js -->



<script src="<%=request.getContextPath() %>/resources/vendor/js/moment.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/vendor/js/fullcalendar.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/vendor/js/ko.js"></script>
<script src="<%=request.getContextPath() %>/resources/vendor/js/select2.min.js"></script>

<%--<script src="<%=request.getContextPath() %>/resources/js/main.js"></script>--%>
<script src="<%=request.getContextPath() %>/resources/js/etcSetting.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/addEvent.js"></script>



<script>
<!-- 공통 js header로 뺐음-->
<%--<script src="<%=request.getContextPath() %>/js/common.js"></script>--%>

<!-- fullCalendar 커스텀 js -->
<%--<script src="<%=request.getContextPath() %>/resources/js/main.js"></script>--%>




    // js에 컨텍스트 패스 주는 함수. 안쓰면 삭제할 것..
    var contextPath = '<%=request.getContextPath()%>'
    //수정
    function modifySchedule(){
        //alert("수정 클릭");
        var fixedSchduleId = $('#scheduleId');
        var fixedUserId = $('#schedule_Writer_Id');
        var editTitle = $('#edit-title');
        var editStart = $('#edit-start')
        var editEnd = $('#edit-end')
        var editImportant = $('#edit-important').prop('checked')
        var editLocation = $('#edit-location');
        var editType = $('#edit-type');
        var editColor = $('#edit-color');
        var editContent = $('#edit-content');

        var selectGroup = '';
        switch(editType.val()){
            case '개인일정':
                selectGroup = 'S01';
                break;
            case '부서일정':
                selectGroup = 'S02';
                break;
            case '팀일정':
                selectGroup = 'S03';
                break;
        }

        var eventData = {
            id:fixedSchduleId.val()
            ,title:editTitle.val()
            ,content:editContent.val()
            ,start:editStart.val()
            ,end:editEnd.val()
            ,imp:editImportant.toString()
            ,username:fixedUserId.val()
            ,location:editLocation.val()
            ,backgroundColor:editColor.val()
            ,type:selectGroup
        }


        eventData.start = moment(eventData.start).format('YYYY-MM-DD HH:mm');
        eventData.end = moment(eventData.end).format('YYYY-MM-DD HH:mm');

        if (eventData.start > eventData.end) {
            alert('끝나는 날짜가 앞설 수 없습니다.');
            return false;
        }

        if (eventData.title === '') {
            alert('일정명은 필수입니다.');
            return false;
        }




//     console.log("보낼 데이터 >> " + JSON.stringify(eventData));



        $.ajax({
            type:"post"
            ,url:"<%=request.getContextPath()%>/schedule/modify"
            ,data:JSON.stringify(eventData)
            ,dataType:"json"
            ,contentType:"application/json;charset=utf-8"

            ,success:function(response){
                console.log(response);
                alert("일정이 수정되었습니다.");
                if(window.opener)  window.opener.location.reload();
                window.location.href = '${pageContext.request.contextPath}' + '/schedule/detail?schedule_Id='+response.scheduleId;

            }
            ,error:function(request, status, error){
                console.log("error 발생 >> " + request +", "+ status+", "+error);
                console.log("날짜" + eventData.start + "," + eventData.end);
            }
        });

    }

</script>
</body>
</html>
