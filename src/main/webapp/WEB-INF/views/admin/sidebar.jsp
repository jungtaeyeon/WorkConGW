<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
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
    <title>관리자 메인 페이지</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Passion+One:wght@400;700&display=swap');
        .active {
            background-color: #4876EF; /* 활성화된 메뉴 배경색 설정 */
            color: white; /* 클릭된 메뉴 글씨 색 변경 */
        }

        .side-bar > ul > li.active ul li:hover > a {
            border-left: 6px solid #4876EF; /* 호버 시 왼쪽 테두리 변경 */
        }
        /*#sidebar{*/
        /*    width: 255px;*/
        /*    !* height: 93vh; *!*/
        /*    background-color: white;*/
        /*    border-right: 1px solid rgb(213, 213, 213);*/
        /*}*/




        /* 노멀라이즈 시작 */
        body, ul, li {
            margin: 0;
            padding: 0;
            /* 해당 태그의 list-style을 none으로 하는 것으로 ●을 제거한다 */
        }

        a {
            color: inherit;   /* 부모 엘리먼트의 값을 물려받는다 */
            text-decoration: none;    /* 해당 태그의 text-decoration 속성을 none 값으로 하는 것으로 밑줄을 제거한다 */
            display: block;
            /*color: #828B9D;*/
            font-size: 15px;
            font-style: normal;
            font-weight: 400;
            line-height: 152.8%;
            letter-spacing: 0.28px;

            padding-top: 20px;
            padding-bottom: 10px;
            padding-left: 50px;
        }
        /* 노멀라이즈 끝 */

        /* 커스텀 시작 */
        .side-bar > ul ul {
            display: none;
        }

        p {
            display: block;
            /*color: #828B9D;*/
            font-size: 15px;
            font-style: normal;
            font-weight: 400;
            line-height: 152.8%;
            letter-spacing: 0.28px;

            padding-top: 0px;
            padding-bottom: 0px;
            padding-left: 10px;
        }



        /* 커스텀 끝 */


        /* 사이드바 시작 */
        /* 사이드바의 너비와 높이를 변수를 통해 통제 */
        :root {
            --side-bar-width: 270px;
            --side-bar-height: 95vh;
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


        body {
            -webkit-user-select:none;
            -moz-user-select:none;
            -ms-user-select:none;
            user-select:none
        }



        /* 자식의 position이 absolute일 때 자식을 영역 안에 가두어 준다 */
        .side-bar > ul > li {
            position: relative;
        }

        /* 모든 메뉴의 a에 속성값 부여 */
        .side-bar ul > li > a {
            display: block;
            /*color: #828B9D;*/
            font-size: 15px;
            font-style: normal;
            font-weight: 400;
            line-height: 152.8%;
            letter-spacing: 0.28px;

            padding-top: 20px;
            padding-bottom: 10px;
            padding-left: 50px;
        }





        /* 사이드 바 고정 */
        /* 사이드바 끝 */
        /* 커스텀 끝 */
        /*--------------------------------------------------------------------*/

        /* 사이드바 토글 방식 */
        .side-bar > ul > li.active > ul {
            display: block;
            /*background-color: #ffffff;*/
            background-color: #0b1a2c;
        }
        /*------------------*/

        .side-bar ul ul li a {
            font-size: 13px;
            color: #B0BCD4;
        }

        .side-bar ul ul li a:hover{
            color: #5E687B;
        }
        ul.menuList {
            height: 100%; /* 더 높은 높이로 조절 */
            font-size: 1.5em;
            display: flex;
            align-items: center;
        }
        ul.menuList li {
            height:100%;
            display: flex;
            padding: 0 15px;
            justify-content: center;
            align-items: center;
            color: white;
            font-weight: bold;
            transition: 0.3s;
        }
        ul.menuList li:hover {
            background-color: #343a40;
            cursor: pointer;
        }
        #navbar-menu{
            display: flex;
            justify-content: center;
            align-items: center;
        }
        #usernameBox{

            color: #ffffff;
            font-size: 1.2em;
        }
        .navbar-nav ul.notifications li{
            border-bottom: 1px solid rgb(0,0,0,0.1) !important;
        }
        .navbar-nav ul.notifications .alarm-list:hover {
            background-color: aliceblue;
        }
        #allAlarmList .media:hover {
            cursor: pointer;
            background-color: aliceblue;
        }
        span.deleteAlarmBtn{
            font-size:0.8em;
            cursor: pointer;
        }
        span.deleteAlarmBtn:hover {
            color:black;
        }
        .noAlarm:hover{
            cursor: default;
            background-color: white;
        }
        #pictureView{
            border-radius: 50%;
            border: 1px solid gray;
            margin: 0px 8px 0px 0px;
            background-position: center;
            background-size: cover;
            background-repeat: no-repeat;
        }
        .theme-black #wrapper:before, .theme-black #wrapper:after, .theme-black:before, .theme-black:after{
            background: #449cff00;
            display: none;
        }


        .nav-item.dropdown, #displayAndHiddenOrg, #hiddenMenu {
            position: fixed;
            bottom: 0px;
        }

        #userPictureDiv{
            background-position: center;
            background-size: cover;
            background-repeat: no-repeat;
            margin: auto;
        }
        .card{
            width: 100%;
            margin-bottom:10px;
        }
        div.dropdown-item:active, div.dropdown-item:hover{
            background-color: #007bff00;
            color: #000000;
        }
        ul#lvl0 li ul li:hover{
            background-color: #0000001a;
        }
        #hiddenMenu {
            width: 15.6em;
        }
        #emergencyCloseBtn{
            cursor: pointer;
        }

        ul#lvl0 li ul li:hover {
            background-color: white;
        }

        .btn.focus, .btn:focus{
            box-shadow: 0 0 0 0px;
        }
        .commonModal-content{
            width: 290px;
            right: 89.4%;
            margin-top: 60%;
        }
        .modal-backdrop.show {
            opacity: .01;
        }

        .user-account{
            display:flex;
            margin: 0px 0px 0 15px;
            justify-content: center;
            align-items: center;
        }
        .menuProfile{
            will-change: transform;
            min-width: 8rem;
            padding: 0.5rem 0.7rem;
            transform: translate3d(-46px, 5px, 0px);
            font-family: InfinitySans-RegularA1
        }
        .menuProfile a{color:#000;}
        .user-name{color: #fff;}

        .profile-picture {
            width: 100px; /* 이미지의 너비 설정 */
            height: 100px; /* 이미지의 높이 설정 */
            border-radius: 50%; /* 원 모양으로 이미지를 만듭니다 */
            overflow: hidden; /* 이미지가 넘치는 부분을 숨깁니다 */
            margin-right: 10px;
        }
        .profile-info {
            display: flex;
            align-items: center;
        }
        .greeting {
            font-size: 10px;
        }

        .profile-picture img {
            width: 100%; /* 이미지를 부모 요소에 맞춰서 표시합니다 */
            height: auto; /* 이미지의 높이를 자동으로 조절합니다 */
        }

    </style>
</head>
<body>

<aside class="side-bar">

    <div class="side-text">
    <h3>관리자 페이지</h3>
    <h3>WorkConGW</h3>
    </div>
        <br>

    <div class="profile-info">
    <div class="profile-picture">
        <img src="/resources/static/images/WorkCon2.jpg">
    </div>

    <div class="greeting">
    <h4>반갑습니다,</h4>
        <h4>${loginUser.emp_Name}님</h4>
    </div>

    </div>



   <br>
       <p><i class="fa-solid fa-bars"></i> 관리자 메뉴</p>


    <ul>

        <a href="<%=request.getContextPath()%>/admin/main"><i class="fa-solid fa-cat"></i> 대시보드</a>


        <li>
            <a href="#"><i class="fa-solid fa-user"></i> 조직 관리</a>
            <ul>
                <li><a href="${root}/calendar/main">사원등록</a></li>
                <li><a href="${root}/meetingroom/reserve">회의실관리</a></li>
            </ul>
        </li>
        <li>
            <a href="#">메뉴바 설정</a>
            <ul>
                <li>
                    <a href="${root}/work/work">업무 할당</a>
                </li>
            </ul>
        </li>

        <li>
            <a href="#">업무시간 설정</a>
            <ul>
                <li><a href="${root}/employee/enroll">인사등록</a></li>
                <li><a href="${root}/employee/list">인사목록</a></li>
            </ul>
        </li>

        <li>
            <a href="#">자원 관리</a>
            <ul>
                <li><a href="<%=request.getContextPath()%>/admin/resource/loginlog">로그인 기록</a></li>

            </ul>
        </li>


    </ul>


</aside>

</body>
</html>
<script>
    $(document).ready(function() {
        summernote_start('.summernote', '<%= request.getContextPath() %>');
    });


    function summernote_start(content,contextPath){
        $(content).summernote({
            placeholder:'여기에 내용을 적으세요.',
            height:250,
            disableResizeEditor: true,
            callbacks:{
                onImageUpload : function(files, editor, welEditable) {
                    //alert("image insert!!");
                    //file size check!
                    for (var i = files.length - 1; i >= 0; i--) {
                        if(files[i].size > 1024*1024*5){
                            alert("이미지는 5MB 미만입니다.");
                            return;
                        }
                    }

                    //file sending
                    for (var i = files.length - 1; i >= 0; i--) {
                        sendImg(files[i], this,contextPath+'/common/summernote/uploadImg.do');
                    }
                },
                onMediaDelete : function(target) {
                    //alert(target[0].src);
                    var answer=confirm("정말 이미지를 삭제하시겠습니다.");
                    if(answer){
                        deleteImg(target[0].src,contextPath+'/common/summernote/deleteImg.do');
                    }
                }
            }
        });
    }

    // side-bar 토글 형식
    document.addEventListener('DOMContentLoaded', function() {
        let menuItems = document.querySelectorAll('.side-bar > ul > li > a');

        menuItems.forEach(function(item) {
            item.addEventListener('click', function(e) {
                e.preventDefault();

                // 현재 클릭된 메뉴의 부모 요소 (li)
                let listItem = this.parentNode;

                // 현재 클릭된 메뉴가 활성화되어 있는지 여부
                let isActive = listItem.classList.contains('active');

                // 모든 메뉴 비활성화
                menuItems.forEach(function(otherItem) {
                    let otherListItem = otherItem.parentNode;
                    if (otherListItem !== listItem) {
                        otherListItem.classList.remove('active');
                    }
                });

                if (!isActive) {
                    listItem.classList.add('active');
                }
                // 클릭된 요소의 글씨 색을 하얀색으로 변경
                menuItems.forEach(function(otherItem) {
                    if (otherItem !== item) {
                        otherItem.style.color = ''; // 기본 색상으로 되돌리기
                    }
                });
                item.style.color = 'white'; // 클릭된 요소의 글씨 색 변경
            });
        });
    });


    //건의사항 주소
    function goSuggestion(id){
        if(id == 'admin'){
            location.href = '${root}/admin/suggestion/list';
        }else if(id != 'admin'){
            location.href = '${root}/suggestion/list';
        }
    }

    //공지사항 주소
    function goNotice(id){
        if(id == 'admin'){
            location.href = '${root}/admin/notice/list';
        }else if(id != 'admin'){
            location.href = '${root}/notice/list';
        }
    }


</script>