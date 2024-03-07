<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>

    * {
        padding: 0;
        margin: 0;
        box-sizing: border-box;
    }

    .subPageContain {
        display: flex;
    }

    .chat-list .loginUserList:hover {
        background-color:#f1f1f1;
    }
    .input-group-text:hover {
        cursor: pointer;
    }
    .noticeFormGroup{
        min-width: 100%;
    }
    .hiddenFillBtn:hover{ background-color: #ffffff; }

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
    .serchContain{
        display: flex;
        align-items: flex-start;
    }
    #serchForm{display: flex;}
    .serchSelect{width: 150px;}
    .serchTextGroup{width: 350px;}
    .tableCheckBox{text-align: center; vertical-align: middle !important;}
    .tardy{
        background: red;
        color: #fff;
        padding: 5px 10px;
        border-radius: 6px;
    }
    .goWork{
        color: #fff;
        padding: 5px 10px;
        border-radius: 6px;
    }
    .goWork0{background-color: #77af9c;}
    .goWork1{background: green;}
    .goWork2{background-color: #ce6d39;}
    .goWork3{background-color: #c82333;}
    .goWork4{background-color: #6aafe6;}
    .goWork5{background-color: #ff5f2e;}

    .pie-chart {
        position: relative;
        display:inline-block;
        width: 150px;
        height: 150px;
        border-radius: 50%;
        transition: 0.3s;
    }
    span.center{
        background: #fff;
        display : block;
        position: absolute;
        top:50%; left:50%;
        width:100px; height:100px;
        border-radius: 50%;
        text-align:center;
        line-height: 100px;
        font-size:30px;
        transform: translate(-50%, -50%);
    }
    .attendStatistics{
        width: 30%;
        margin-left: 2%;
    }
    .attendStatisticsGroup{display: flex; justify-content: space-between; margin-bottom: 5%;}
    .attendStatisticTextGroup{
        width: 50%;
    }
    .attendStatisticTit{
        font-size: 20px;
        color: #fff;
        background: #000;
        padding: 5px;
    }
    .attendStatisticText{
        font-size: 18px;
        padding: 5px;
        margin-bottom: 0%;
    }
    .lateReasonGroup{
        background: #d2d2d2;
        padding: 4% 6%;
        margin: 5% 0;
    }
    .lateReasonTit{
        font-size: 25px;
        margin-bottom: 0;
    }
    .lateReasonSubTit{font-size: 15px;}
    /* 모달 css */
    .show{background-color: rgba(0, 0, 0, 0.7);}
    .modalBtn{cursor: pointer;}
    .modal-body p{font-size: 16px;}
    .modal-body span{
        display: inline-block;
        margin-left: 15px;
        vertical-align: top;
    }


</style>





<body>


<section class="subPageContain">
<%--    사이드바--%>
    <div class="side-bar">
    <div><%@ include file="./sidebar.jsp"%></div>
    </div>

<%--컨텐츠--%>
<div class="container-fluid">
    <div class="row clearfix">
        <div class="col-lg-8 col-md-12">

            <div class="card" style="margin-bottom:15px; padding: 10px 15px;">
                <div class="body" style="font-family: S-CoreDream-6Bold">
                    <div class="row clearfix" >
                        <div class="col-6" style="font-family: S-CoreDream-4Regular">
                            <div class="head" style="margin-bottom: 10px;">
                                <h5>사내공지
                                    <span class="float-right" style="cursor: pointer;" onclick="location.href='<%=request.getContextPath()%>/board/notice/noticeList'">
                                    <i class="fa fa-sign-in"></i>
                                 </span>
                                </h5>
                            </div>
                            <div class="table-responsive" style="overflow:hidden;">
                                <table class="table table-hover m-b-0 c_list">
                                    <thead class="thead-light">
                                    <tr>
                                        <th>게시날짜</th>
                                        <th>제목</th>
                                        <th>작성자</th>
                                    </tr>
                                    </thead>
                                    <tbody style="cursor: pointer;">
                                    <c:if test="${!empty noticeList}">
                                        <c:forEach items="${noticeList}" var="notice">
                                            <tr onclick="window.location.href='<%=request.getContextPath()%>/board/notice/detail?notice_id=${notice.notice_id }'">
                                                <td><fmt:formatDate value="${notice.notice_create_dt}" pattern="yyyy-MM-dd"/></td>
                                                <td><span style="display: inline-block;font-weight: bold;max-width: 155px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">
                                              			<c:if test="${notice.notice_important_st eq '1'}">
                                                            <span class="badge badge-danger">필독</span>
                                                        </c:if>

                                                        <c:if test="${notice.notice_important_st eq '0'}">
                                                            <span class="badge badge-success">공지</span>
                                                        </c:if>


                                                        ${notice.notice_title}</span></td>
                                                <td><span>${notice.emp_Name}&nbsp;${notice.officialName}</span></td>
                                            </tr>
                                        </c:forEach>
                                    </c:if>

                                    <c:if test="${empty noticeList}">
                                        <tr>
                                            <td colspan="6" style="text-align: center;"><strong>사내공지가 존재하지 않습니다.</strong></td>
                                        </tr>
                                    </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="col-6"  style="font-family: S-CoreDream-4Regular">
                            <div class="head" style="margin-bottom: 10px;">
                                <h5>민원함
                                    <span class="float-right" style="cursor: pointer;" onclick="location.href='${pageContext.request.contextPath}/reservation/adminMain';">
                                 	<i class="fa fa-sign-in"></i>
                                 </span>
                                </h5>
                            </div>
                            <div class="table-responsive" style="overflow: hidden;">
                                <table class="table table-hover m-b-0 c_list">
                                    <thead class="thead-light">
                                    <tr>
                                        <th>날짜</th>
                                        <th>제목</th>
                                        <th>작성자</th>
                                    </tr>
                                    </thead>
                                    <tbody style="cursor: pointer;">
                                    <!-- 민원 리스트 출력 -->
                                    <c:if test="${!empty complainList}">
                                        <c:forEach items="${complainList}" var="complain">
                                            <tr onclick="window.location.href='${pageContext.request.contextPath}/reservation/complain/detail?complain_Id=${complain.complain_Id}'">
                                                <td>${complain.complain_Create_Date}</td>
                                                <td><span style="display: inline-block;font-weight: bold;max-width: 200px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">
                                              			<span class="badge badge-danger">New</span>${complain.complain_Content}</span>
                                                </td>
                                                <td><span>${complain.emp_Name}&nbsp;${complain.auth_Name}</span></td>
                                            </tr>
                                        </c:forEach>
                                    </c:if>

                                    <c:if test="${empty complainList}">
                                        <tr>
                                            <td colspan="3" style="text-align: center;"><strong>민원이 존재하지 않습니다.</strong></td>
                                        </tr>
                                    </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card" style="padding: 10px 15px;">
                <div class="header" style="font-family: S-CoreDream-4Regular">
                    <h5>공지글 작성</h5>
                    <button type="button" class="btn hiddenFillBtn" onclick="presentationFill_1();" style="position:absolute;right:0px;top:0px;color:#ffffff">시연용버튼 1</button>
                </div>
                <div class="body" style="padding-top:0px;">
                    <form name="noticeRegistForm" method="post">
                        <input type="hidden" name="noticeVO.notice_content">
                        <input type="hidden" name="noticeVO.emp_writer_id" value="${loginUser.emp_Id }">
                        <input type="hidden" name="noticeVO.notice_update_id" value="${loginUser.emp_Id }">
                        <div class="row clearfix" style="font-family: S-CoreDream-6Bold;">
                            <!-- 게시판 선택 -->
                            <div class="col-md-3">
                                <label>분류</label>
                                <div class="form-group">
                                    <select id="selectBoard" class="form-control noticeFormGroup" onchange="changeCategory(this);">
                                        <option value="default">-- 분류 선택 --</option>
                                        <option value="notice">사내공지</option>
                                    </select>
                                </div>
                            </div>

                            <!-- 본문 -->
                            <div class="col-md-3 col-sm-12">
                                <label class="boardWriter">작성자</label>
                                <div class="form-group">
                                    <input type="text" readonly class="form-control noticeFormGroup" placeholder="" value="${loginUser.emp_Name }" >
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-12 formGroup noticeForm" style="display:none;">
                                <label>필독여부</label>
                                <div class="form-group">
                                    <select name="noticeVO.notice_important_st" id="notice_important_st" class="form-control noticeFormGroup">
                                        <option value="0">일반</option>
                                        <option value="1">필독</option>
                                    </select>
                                </div>
                            </div>

                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="boardTitle">제목</label>
                                    <input type="text" name="noticeVO.notice_title" id="emergencyInput" class="form-control noticeFormGroup" style="max-width: 100%;" placeholder="">
                                </div>
                            </div>
                        </div>
                        <!-- 내용 입력 -->
                        <div class="col-sm-12 formGroup defaultForm noticeForm meetroomForm" style="padding:0px; font-family: S-CoreDream-4Regular">
                            <div class="summernote" style="height: 200px; "></div>
                        </div>

                        <div class="m-t-10">
                            <button type="button" class="btn btn-primary float-right" style="width:100px;font-family: S-CoreDream-6Bold;" onclick="registNotice();">등록</button>
                            <button type="reset" onclick="resetBtn();" class="btn btn-dark float-right" style="margin-right:10px;font-family: S-CoreDream-6Bold;"><i class="fa fa-refresh"></i> <span>초기화</span></button>
                            <div style="clear: both;"></div>
                        </div>
                    </form>
                </div>
            </div>
        </div>


        <!-- 우측 메뉴 -->
        <div class="col-lg-4 col-md-12 right-box" style="padding-left:0px; ">
            <div class="card" style="margin-bottom:15px; padding: 10px 15px;">
                <div class="body">
                    <div class="row clearfix" style="margin-bottom:15px;">
                        <div class="col-12" style="font-family: S-CoreDream-4Regular">
                            <div class="head">
                                <h5 style="display:inline;">현재 접속중인 사용자</h5>
                                <span id="loginUserCount" style="margin-left:15px;">[${loginUserList.size() }명]</span>
                                <span id="loginUserReload" style="margin-left:15px;cursor:pointer;" onclick="reloadLoginUser(this);"><i class="fa fa-refresh"></i><span> 새로고침</span></span>
                            </div>
                        </div>
                    </div>

                    <!-- 접속중인 사용자 -->
                    <div class="people_list" style="position:relative;padding:10px 0px;display:inline-block;">
                        <div class="search">
                            <div class="input-group m-b-0">
                                <div class="input-group-prepend">
                                    <span class="input-group-text" onclick="searchLoginUser();"><i class="icon-magnifier"></i></span>
                                </div>
                                <input type="text" id="searchLoginUserName" class="form-control" placeholder="Search..." onkeypress="checkEnter(searchLoginUser);">
                            </div>
                        </div>
                        <ul class="list-unstyled chat-list mt-2 mb-0" style="max-height:40vh;overflow-y:auto;">
                            <c:forEach items="${loginUserList }" var="user">
                                <li class="loginUserList" style="margin:0px;padding:10px;" data-deptId="${user.dept_Id }" data-empId="${user.emp_Id }">
                                    <div id="pictureView" style="background-image:url('${pageContext.request.contextPath }/pds/empPicture/${user.emp_Picture}');width: 50px; height: 50px;float:left;margin:0px;" ></div>
                                    <div class="about"  >
                                        <div class="name"><strong style="color:black;">${user.emp_Name } ${user.code_Name }</strong></div>
                                        <div class="status">${user.dept_Name } </div>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div style="display: inline-block;float: right;width: 40%;padding:10px 5px;">
                        <h6 style="font-family: S-CoreDream-6Bold;">부서별 접속 현황</h6>
                        <hr>
                        <div style="max-height:40vh;overflow-y:auto;">
                            <table style="width:100%;">
                                <thead>
                                <tr>
                                    <th style="width:70%;"></th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${deptList}" var="dept">
                                        <tr>
                                            <td>${dept.dept_Name}</td>
                                            <td id="dept_${dept.dept_Id }" class="deptNum" style="text-align: center;">0</td>
                                        </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>




                </div>

            </div>

            <div>
                <!--차트가 그려질 부분-->
                <canvas id="myChart"></canvas>
            </div>

        </div>
    </div>
</div>
</section>



<script type="text/javascript">


    $(document).ready(function() {
        dataGraph(); // 화면이 로딩될 때 dataGraph() 함수 실행
    });

    function colorize() {
        let r = Math.floor(Math.random()*200);
        let g = Math.floor(Math.random()*200);
        let b = Math.floor(Math.random()*200);
        let color = 'rgba(' + r + ', ' + g + ', ' + b + ', 0.7)';
        return color;
    }


    function dataGraph(){






        $.ajax({
        url : "<%=request.getContextPath()%>/admin/graphEmp",
        type : "post",
        dataType : "json",
        success : function (data)
        {

            let labelList = new Array();
            let valueList = new Array();
            let colorList = new Array();
            console.log(data)

            for(let i = 0; i <data.length; i++)
            {
                let d = data[i]
                labelList.push(d.ID);
                valueList.push(d.Count);
                colorList.push(colorize());


            }
            console.log(labelList)
            console.log(valueList)
            console.log(colorList)

            new Chart(document.getElementById("myChart"), {
                type: 'bar', // 차트의 형태
                data: { // 차트에 들어갈 데이터
                    labels:
                        labelList
                    ,
                    datasets: [{
                        label : "graph",
                        backgroundColor: colorList,
                        data : valueList
                    }],


                },
                options: {

                    title:{
                        display : true,
                        text : '이번 달 신규입사자 수'

                    }

                }

            });



        },error : function (e){
            console.log(e)
            alert('에러')
        }
    })


    // let ctx1 = document.getElementById("myChart").getContext('2d')
    // new Chart(xtx1, {
    //     type:'pie',
    //     data : data
    // })


    }



</script>



<script>

    function registNotice()
    {
        let form = $('form[name="noticeRegistForm"]');
        let category = $('select#selectBoard').val();
        if(category == null)
        {
            alert('글 종류를 선택하세요.')
            return;
        }


        if(category == 'notice')
        {
            form.action = '<c:url value="/board/notice/regist"/>'
            $('input[name="noticeVO.notice_content"]').val($('.note-editable').html());
        }


        $.ajax({
            url:form.action,
            type:'post',
            data:form.serialize(),
            success:function ()
            {
                alert('공지가 등록되었습니다.')
                if(category == 'notice')
                {
                    window.location.reload(true);

                }
            },error:function(){
                alert('공지 등록 실패')
    }
        })


    }

    // 팝업창들 띄우기
    // 새로운 window창을 open할 경우 사용되는 함수( arg : 주소, 창타이틀, 넓이, 길이)
    function OpenWindow(UrlStr, WinTitle, WinWidth, WinHeight){
        winleft = (screen.width - WinWidth) / 2;
        wintop = (screen.height - WinHeight) / 2;
        var winX      = window.screenX || window.screenLeft || 0;// 현재창의 x좌표
        var winY      = window.screenY || window.screenTop || 0; // 현재창의 y좌표

        winleft = winX + winleft;
        wintop = winY + wintop;

        var win = window.open(UrlStr, WinTitle, "scrollbars=yes,width="+ WinWidth +", "
            +"height="+WinHeight + ", top=" + wintop +", left="
            + winleft +", resizable=yes, status=yes");
        win.focus();
    }

    //팝업창 닫기
    function CloseWindow(){
        location.href='<%=request.getContextPath()%>/reservation/adminMain';
    }


    window.onload=function(){
        setDeptNum();
    }

    // 부서원 수 초기화
    function setDeptNum(){
        $('.chat-list li').each(function(){ // 클래스chat-list인 요소의 내의 각 li 요소에 대해 반복한다.
            let deptId = $(this).attr('data-deptId'); //현재 반복되고 있는 li요소에서 data-deptId 속성 값을 가져와서 deptId에 저장
            let deptNum = $('#dept_'+deptId).text()*1;
            $('#dept_'+deptId).text(deptNum+1);
        });
    }

    // 공지 입력 폼 변경
    function changeCategory(obj){
        $('.formGroup').css('display','none');
        $('.'+obj.value+'Form').css('display','');
    }

    // 리셋 버튼
    function resetBtn(){
        $('.note-editable').text("");
    }


    //엔터키 입력시 함수 실행
    function checkEnter(searchLoginUser) {
        var keyCode = event.keyCode || event.which;
        if (event.keyCode === 13) {
            searchLoginUser();
        }
    }





    // 로그인 사용자 리로드
    function reloadLoginUser(obj){
        $(obj).find('i').addClass('fa-spin');
        $(obj).find('span').text(' 불러오는중..');

        $('input#searchLoginUserName').val(""); // input태그에 값을 넣어두고 새로고침 누르면 값이 초기화된다.

        setTimeout(() => {
            searchLoginUser('reload'); // reload를 넣어  사용자 목록을 새로 고친다.

            $(obj).find('i').removeClass('fa-spin');
            $(obj).find('span').text(' 새로고침');
        },1000);
    }

    // 로그인 사용자 검색
    function searchLoginUser(category){
        let emp_Name = $('input#searchLoginUserName').val();

        $.ajax({
            url:'<c:url value="/admin/emp/search"/>',
            type:'post',
            data:{emp_Name:emp_Name},
            success:function(searchLoginUserList){
                $('.chat-list').children().remove();

                let liTag = '';

                if(searchLoginUserList.length == 0){
                    liTag += '<li style="margin:0px;padding:50px 10px;cursor:inherit;">'
                        +'<div style="text-align: center;">'
                        +'<strong>해당 사용자는 접속중이 아닙니다.</strong>'
                        +'</div>'
                        +'</li>';
                }
                else{
                    for(let i=0; i<searchLoginUserList.length; i++){ //for문을 돌면서 사용자1명 씩 그려줘야된다.
                        let user = searchLoginUserList[i];
                        console.log('여기들어오니?')
                        liTag += '<li class="loginUserList" style="margin:0px;padding:10px;" data-deptId="'+user.dept_Id+'" data-empId="'+user.emp_Id+'">'
                            +'<div id="pictureView" style="background-image:url(\'${pageContext.request.contextPath}/pds/empPicture/'+user.emp_Picture+'\'); width: 40px; height: 40px;float:left;margin:0px;" class="rounded-circle avatar"></div>'
                            +'<div class="about">'
                            +'<div class="name"><strong style="color:black;">'+user.emp_Name+' '+user.code_Name+'</strong></div>'
                            +'<div class="status">'+user.dept_Name+'</div>'
                            +'</div>'
                            +'</li>';
                    }
                }
                $('.chat-list').append(liTag);
                if(category == 'reload'){
                    // 사용자수 변경
                    $('#loginUserCount').text('['+$('.chat-list').children().length+'명]');

                    // 부서원 수 변경
                    setDeptNum();
                }

            }
        });
    }


</script>


</body>