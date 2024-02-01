<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>   
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .active {
        background-color: #4876EF; /* 활성화된 메뉴 배경색 설정 */
        color: white; /* 클릭된 메뉴 글씨 색 변경 */
    }

    .side-bar > ul > li.active ul li:hover > a {
        border-left: 6px solid #4876EF; /* 호버 시 왼쪽 테두리 변경 */
    }
    #sidebar{
      width: 255px;
      /* height: 93vh; */
      background-color: white;
      border-right: 1px solid rgb(213, 213, 213);
    }
    

    
    
    /* 노멀라이즈 시작 */
    body, ul, li {
      margin: 0;
      padding: 0;
        /* 해당 태그의 list-style을 none으로 하는 것으로 ●을 제거한다 */
    }
    
    a {
      color: inherit;   /* 부모 엘리먼트의 값을 물려받는다 */
      text-decoration: none;    /* 해당 태그의 text-decoration 속성을 none 값으로 하는 것으로 밑줄을 제거한다 */
    }
    /* 노멀라이즈 끝 */
    
    /* 커스텀 시작 */
    .side-bar > ul ul {
      display: none;
    }
    
    /* 커스텀 끝 */
    
    
    /* 사이드바 시작 */
    /* 사이드바의 너비와 높이를 변수를 통해 통제 */
    :root {
      --side-bar-width: 270px;
      --side-bar-height: 95vh;
    }
    .side-bar {
        position: fixed;
        background-color: #ffffff;
        box-shadow:0px 0px 7px -2px rgba(0, 0, 0, 0.025);
        width: let(--side-bar-width);
        min-height: let(--side-bar-height);   /* 사이드바의 높이를 전체 화면 높이의 90%로 지정 */
        -webkit-user-select:none;    /* 추가 */
        -moz-user-select:none;    /* 추가 */
        -ms-user-select:none;   /* 추가 */
        user-select:none     /* 추가 */
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
        color: #828B9D;
        font-size: 15px;
        font-style: normal;
        font-weight: 400;
        line-height: 152.8%;
        letter-spacing: 0.28px;
        
        padding-top: 20px;
        padding-bottom: 10px;
        padding-left: 50px;
        }
    
    body, input, button, select, a {
        font-family: 'Noto Sans KR', sans-serif;
    }


      .side-bar > ul > li:hover > ul {
        display: block; /* 마우스 호버 시 드롭다운 메뉴 표시 */
      }
    /* 사이드 바 고정 */
    /* 사이드바 끝 */
    /* 커스텀 끝 */
    /*--------------------------------------------------------------------*/
    
    /* 사이드바 토글 방식 */
    .side-bar > ul > li.active > ul {
        display: block;
        background-color: #ffffff;
      }
    /*------------------*/
    
    .side-bar ul ul li a {
        font-size: 13px; 
        color: #B0BCD4;
      }
    
      .side-bar ul ul li a:hover{
        color: #5E687B;
      }
</style>
</head>
<body>

    <aside class="side-bar">
     
        <ul>
        <li>
            <a href="#"> 근태 관리</a>
            <ul>
            <!-- 'ADMIN'을 포함하는 경우에 실행할 내용 -->
			        <li><a href="${root}/attendance/admin/allList">근무 조회</a></li>
			        <li><a href="${root}/attendance/admin/objection">이의신청 조회</a></li>
		            <li><a href="${root}/attendance/main">근무현황</a></li>
		            <li><a href="${root}/attendance/list">근무현황 목록 조회</a></li>
            
            </ul>
        </li>
        <li>
            <a href="#">일정 관리</a>
            <ul>
            <li><a href="${root}/calendar/main">캘린더</a></li>
            <li><a href="${root}/meetingroom/reserve">회의실관리</a></li>
            </ul>
        </li>
        <li>
            <a href="#">업무 할당</a>
            <ul>
            <li><a href="${root}/work/work">업무 할당</a></li>
            </ul>
        </li>
            <li>
                <a href="#">인사 관리</a>
                <ul>
                <li><a href="${root}/employee/enroll">인사등록</a></li>
                <li><a href="${root}/employee/list">인사목록</a></li>
                </ul>
            </li>

        <li>
            <a href="#">프로젝트 관리</a>
            <ul>
            <li><a href="${root}/project/progress">진행중인 프로젝트</a></li>
            </ul>
        </li>
        <li>
            <a href="#">커뮤니티</a>
            <ul>
            <li><a href="${root}/community/board/list/">게시판</a></li>
            <li><a href="${root}/community/vote/">투표</a></li>
            <li><a href="${root}/community/survey/">설문 조사</a></li>
            <li><a onclick="goSuggestion('${loginMember.id}');">건의사항</a></li>
            <li><a onclick="goNotice('${loginMember.id}');">공지사항</a></li>
            </ul>
        </li>
        </ul>
       
    </aside>

</body>
</html>
    <script>
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




        // 현재 클릭된 메뉴의 상태 변경
        if (!isActive) {
                    listItem.classList.add('active');
                }
    </script>