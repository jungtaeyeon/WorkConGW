<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>WorkConGW</title>
    <script src="https://kit.fontawesome.com/3a92c85ff9.js" crossorigin="anonymous"></script>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
            crossorigin="anonymous"
    />
    <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
            crossorigin="anonymous"
    ></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <link rel="stylesheet" href="${root}/resources/css/member/join-style.css" />

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Passion+One:wght@400;700&display=swap');

        * {
            padding: 0;
            margin: 0;
            box-sizing: border-box;
        }

        a {
            text-decoration: none;
        }

        body, input {
            font-family: 'Noto Sans KR', sans-serif;
        }

        .container {
            position: relative;
            width: 100%;
            min-height: 100vh;
            background-color: #fff;
            overflow: hidden;
            align-content: center;
            margin: 80px auto;
        }

        .signup-form {
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            overflow: hidden;
        }

        .title a {
            font-size: 3.8rem;
            color: #0f0f0f;
            font-weight: 700;
            font-family: 'Passion One', sans-serif;
        }

        .title a:hover {
            color: #0f0f0f;
        }

        .sub-title {
            margin-bottom: 30px;
            font-size: 1.8rem;
            color: #0f0f0f;
            font-weight: 600;
        }

        .input-field {
            min-width: 500px;
            max-width: 800px;
            width: 80%;
            height: 60px;
            background-color: rgb(241, 239, 239);
            margin: 10px 0;
            border-radius: 15px;
            display: grid;
            grid-template-columns: 27% 73%;
            padding: 0 .4rem;
        }

        .id-field {
            grid-template-columns: 27% 48% 25%;
        }

        .id-field button {
            margin: auto;
        }

        .email-field {
            grid-template-columns: 27% 27% 46%;
            grid-template-rows: 50% 50%;
            height: 120px;
        }

        .usernum-field {
            grid-template-columns: 27% 20% 10% 42%;
        }

        .address-field {
            height: 240px;
        }

        .input-field label,
        .input-field span {
            text-align: center;
            line-height: 60px;
            color: #0f0f0f;
            font-size: 1rem;
            font-weight: 600;
        }

        .input-field span {
            font-weight: 900;
            font-size: 1.2rem;
        }

        .input-field input, .input-field select {
            background: none;
            border: none;
            height: 60px;
            outline: none;
            line-height: 1;
            font-weight: 400;
            font-size: 1rem;
            color: black;
        }

        .input-field input[type=button] {
            border: 1px solid #0f0f0f;
            height: 32px;
            width: 100px;
            border-radius: 5px;
            font-weight: 500;
            font-size: 14px;
            color: #0f0f0f;
        }

        .input-field input[type=button]:hover {
        }

        .input-field select {
            margin: auto;
            margin-left: 0;
            height: 40px;
        }

        .input-field select:checked {
            background: inherit;
        }

        .input-field input::placeholder {
            color: #131212;
            font-weight: 400;
        }

        .btn {
            width: 200px;
            height: 50px;
            border: none;
            outline: none;
            border-radius: 20px;
            cursor: pointer;
            background-color: #0f0f0f;
            color: #fff;
            font-weight: 600;
            font-size: 1.2rem;
            margin: 30px 0;
            transition: .5s;
        }

        .btn:hover {
            color: #fff;
        }

        .input-btn {
            border: 1.5px solid #0f0f0f;
            color: #0f0f0f;
            height: 35px;
            width: 90px;
            border-radius: 10px;
            font-weight: 500;
            font-size: 14px;
        }

        .input-btn:hover {
            background-color: #d9d2ff3d
        }
        /* form태그 */
        form[name='myPageFrm']{
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
        }

        /* 내부 input 요소 focus 시 */
        .myPage-row:focus-within{
            border-bottom-color: #455ba8;
        }


        .profile-image-area{
            width: 150px;
            height: 150px;
            border: 3px solid #ccc;
            border-radius: 50%;

            position: relative;

            overflow: hidden;
            display: flex;
            justify-content: center;
            align-content: center;
        }

        #profileImage{
            height: 100%;
        }
        form[name='myPageFrm']{position: relative;}

        #deleteImage{
            position: absolute;
            top: 0px;
            right: 240px;
            cursor: pointer;
        }

        /* 이미지 버튼 영역 */
        .profile-btn-area{
            width: 230px;
            margin: 20px 0;

            display: flex;
            justify-content: center;
            align-items: center;
        }

        .profile-btn-area > *{
            width: 110px;
            height: 33px;
            padding: 5px 10px;

            border: 1px solid black;
            background-color: white;
            font-size: 14px;
            cursor: pointer;
            text-align: center;
        }

        #imageInput{ display: none;}

        .profile-btn-area > button{
            background-color: #455ba8;
            color : white;
            margin-left: 2px;
        }
    </style>
</head>
<body>



<div class="con main-2">
    <div class="content">
        <div>
            <div class="container">
                <div class="signup">
                    <form action="<%=request.getContextPath()%>/emp/empUpdate" method="POST" name="myPageFrm" id="profileFrm" enctype="multipart/form-data">
                        <h2 class="title">사원정보</h2>

                        <div class="profile-image-area">

                            <%-- 프로필 이미지가 없으면 기본 이미지 --%>
                            <c:if test="${empty empVO.emp_Picture}" >
                                <img src="<%=request.getContextPath() %>/pds/user1.jpg" id="profileImage">
                            </c:if>

                            <%-- 프로필 이미지가 있으면 있는 이미지 --%>
                            <c:if test="${!empty empVO.emp_Picture}" >
                                <img src="<%=request.getContextPath() %>/pds/empPicture/${empVO.emp_Picture}" id="profileImage">
                            </c:if>
                        </div>




                    </form>

                    <form action="<%=request.getContextPath()%>/admin/emp/empUpdate" class="signup-form" method="post" id="">


                        <div class="input-field id-field">
                            <label>* 사번</label>
                            <input id = "emp_Id_input" name="emp_Id" type="text" value = "${empVO.emp_Id}" readonly="readonly" />
                        </div>
                        <div class="input-field id-field">
                            <label>* 이메일</label>
                            <input id = "emp_Email" name="emp_Email" type="text" value ="${empVO.emp_Email}" required />
                            <input type="hidden" value="N" id="isDup" />
                        </div>
                        <div class="input-field">
                            <label>* 비밀번호</label>
                            <input id = "emp_Pwd" name="emp_Pwd" type="password" value = "${empVO.emp_Pwd}" readonly="readonly" />
                        </div>

                        <div class="input-field">
                            <label>* 성명</label>
                            <input id = "emp_Name" name="emp_Name" type="text" value = "${empVO.emp_Name}" maxlength="6" required />
                        </div>
                        <div class="input-field usernum-field">
                            <label>* 주민번호</label>
                            <input id = "emp_Regno" name="emp_Regno" type="text" size="6" value="${empVO.emp_Regno}" maxlength="6" required />
                            <span>-</span>
                            <input id = "emp_Regno2" name="emp_Regno2" type="password" size="7" value="${empVO.emp_Regno2}" maxlength="7" required />
                        </div>
                        <div class="input-field">
                            <label>* 휴대전화</label>
                            <input id = "emp_Hp" name="emp_Hp" type="text" value="${empVO.emp_Hp}"  maxlength="11" />
                        </div>

                        <div class="input-field">
                            <label>* 주소</label>
                            <div>
                                <input id = "myAdd1" name="emp_Add1"  type="text" placeholder="우편번호"  value="${empVO.emp_ZipCode}"/>
                                <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" /><br />
                            </div>
                        </div>
                        <div class="input-field"a>
                            <label>* 우편번호</label>
                            <input id = "myAdd3" name="emp_ZipCode" type="text"  value="${empVO.emp_Add1}" required /><br />
                        </div>
                        <div class="input-field">
                            <label>* 상세주소</label>
                            <input id = "myAdd2" name="emp_Add2" type="text"  value="${empVO.emp_Add2}" required /><br />
                        </div>


                        <div class="input-field id-field">
                            <label>* 직속상관</label>
                            <input id = "emp_Sup_Id" name="emp_Sup_Id" type="text" value="${empVO.emp_Sup_Id}"  />
                            <button type="button"  class="input-btn" onclick="OpenWindow('<%=request.getContextPath()%>/organization', 'WorkConGW', 700,700)">조직도</button>
                        </div>

                        <div class="input-field id-field">
                            <label>* 부서</label>
                            <input id = "dept_Id" name="dept_Id" type="text" value="${empVO.dept_Id}"  />
                            <button type="button"  class="input-btn" onclick="OpenWindow('<%=request.getContextPath()%>/organization', 'WorkConGW', 700,700)">조직도</button>
                        </div>

                        <div class="input-field">
                            <label>* 직위 : </label>
                            <select id = "code_Id" name="code_Id" class="form-control" >
                                <option value="${empVO.code_Id}" selected><c:out value="${empVO.code_Name}" /></option>
                                <option value="">===========↑사원 직위===========</option>
                                <option value="c01" >부장</option>
                                <option value="c02" }>차장</option>
                                <option value="c03" }>과장</option>
                                <option value="c04" }>대리</option>
                                <option value="c05" }>사원</option>
                            </select>
                        </div>


                        <div class="input-field">
                            <label>* 권한설정 : </label>
                            <select id = "auth_Id" name="auth_Id" class="form-control">
                                <option value="${empVO.auth_Id}" selected><c:out value="${empVO.auth_Id}" /></option>
                                <option value="">===========↑사원 권한===========</option>
                                <option value="u" >일반사용자 : u</option>
                                <option value="s" }>시스템관리자 : s</option>
                            </select>
                        </div>

                        <div class="input-field">
                            <label>* 상태설정 : </label>
                            <select id = "attendStId" name="attend_St_Id" class="form-control">
                                <option value="${empVO.attend_St_Id}" selected><c:out value="${empVO.attend_St_Name}" /></option>
                                <option value="">===========↑사원 출근상태===========</option>
                                <option value="1">정상출근</option>
                                <option value="0">퇴근</option>
                                <option value="2">지각</option>
                                <option value="3">조퇴</option>
                            </select>
                        </div>

                        <div class="input-field">
                            <label>* 상태 :</label>
                            <select id = "emp_St" name="emp_St" class="form-control">
                                <option value="${empVO.emp_St}" selected>${empVO.emp_St}</option>
                                <option value="">===========↑사원 출근상태===========</option>
                                <option value="1">재직 : 1</option>
                                <option value="2">휴직 : 2</option>
                                <option value="3">퇴사 : 3</option>
                            </select>
                        </div>
                        <span class="float-right" style="padding-right: 36px;">
                            <button class="btn btn-dark" data-type="success" onclick="modify_go()">수정 완료</button>
                            <button type="button" class="btn btn-dark" onclick="list_go();">목록으로</button>
                        </span>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="con main-bottom">
    <div class="foot">
    </div>
</div>



<script>


    const profileImage = document.getElementById("profileImage"); // img 태그
    const deleteImage = document.getElementById("deleteImage"); // x 버튼
    const imageInput = document.getElementById("imageInput"); // input 태그

    let initCheck; // 초기 프로필 이미지 상태를 저장하는 변수
                   // false == 기본 이미지, true == 이전 업로드 이미지

    let deleteCheck = -1;
    // 프로필 이미지가 새로 업로드되거나 삭제되었음을 나타내는 변수
    // -1 == 초기값, 0 == 프로필 삭제(x버튼), 1 == 새 업로드 이미지

    let originalImage; // 초기 프로필 이미지 파일 경로 저장

    if(imageInput != null){ // 화면에 imageInput이 있을 경우

        // 프로필 이미지가 출력되는 img 태그의 src 속성을 저장
        originalImage = profileImage.getAttribute("src");

        // 회원 프로필 화면 진입 시
        // 현재 회원의 프로필 이미지 상태를 확인
        if(originalImage == "/resources/images/user.png"){
            // 기본 이미지인 경우
            initCheck = false;

        } else {
            initCheck = true;
        }

        // change 이벤트 : 값이 변했을 때
        // - input type="file", "checkbox", "radio"에서 많이 사용
        // - text/number 형식 사용 가능
        //  -> 이때 input값 입력 후 포커스를 잃었을 때
        //     이전 값과 다르면 change 이벤트 발생

        imageInput.addEventListener("change", e => {

            // 2MB로 최대 크기 제한
            const maxSize = 1 * 1024 * 1024 * 2; // 파일의 최대 크기 지정(바이트 단위)

            console.log(e.target); // input
            console.log(e.target.value); // 업로드된 파일 경로
            console.log(e.target.files); // 업로드된 파일의 정보가 담긴 배열

            const file = e.target.files[0]; // 업로드한 파일의 정보가 담긴 객체

            // 파일을 한 번 선택한 후 취소했을 때
            if(file == undefined){
                console.log("파일 선택이 취소됨");
                deleteCheck = -1; // 취소 == 파일 없음 == 초기 상태

                // 취소 시 기존 프로필 이미지로 변경
                profileImage.setAttribute("src", originalImage);

                return;
            }

            if(file.size > maxSize){ // 선택된 파일의 크기가 최대 크기를 초과한 경우
                alert("2MB 이하의 이미지를 선택해 주세요.");
                imageInput.value = "";
                // input type="file" 태그에 대입할 수 있는 value는 ""(빈칸) 뿐이다!

                deleteCheck = -1; // 취소 == 파일 없음 == 초기 상태

                // 기존 프로필 이미지로 변경
                profileImage.setAttribute("src", originalImage);

                return;
            }

            // JS에서 파일을 읽는 객체
            // - 파일을 읽고 클라이언트 컴퓨터에 파일을 저장할 수 있음
            const reader = new FileReader();

            reader.readAsDataURL(file);
            // 매개변수에 작성된 파일을 읽어서 저장 후
            // 파일을 나타내는 URL을 result 속성으로 얻어올 수 있게 함

            // 다 읽었을 때
            reader.onload = e => {
                // console.log(e.target);
                // console.log(e.target.result); // 읽은 파일의 URL

                const url = e.target.result;

                // 프로필 이미지(img) 태그에 src 속성으로 추가
                profileImage.setAttribute("src", url);

                deleteCheck = 1;
            }

        });

        // x 버튼 클릭 시
        deleteImage.addEventListener("click", () =>{

            // 프로필 이미지를 기본 이미지로 변경
            profileImage.setAttribute("src", "/resources/images/user.png");

            imageInput.value = ""; // input type="file"의 value 삭제

            deleteCheck = 0;

        });




        // #profileFrm이 제출되었을 때
        document.getElementById("profileFrm").addEventListener("submit", e=>{

            // let initCheck;
            // 초기 프로필 이미지 상태를 저장하는 변수
            // false == 기본 이미지, true == 이전 업로드 이미지

            // let deleteCheck = -1;
            // 프로필 이미지가 새로 업로드되거나 삭제되었음을 나타내는 변수
            // -1 == 초기값, 0 == 프로필 삭제(x버튼), 1 == 새 업로드 이미지

            let flag = true;

            // 프로필 이미지가 없다 -> 있다
            if(!initCheck && deleteCheck == 1) flag = false;

            // 이전 프로필 이미지가 있다 -> 삭제
            if(initCheck && deleteCheck == 0) flag = false;

            // 이전 프로필 이미지가 있다 -> 새 이미지
            if(initCheck && deleteCheck == 1) flag = false;

            if(flag) { // flag == true -> 제출하면 안 되는 경우
                e.preventDefault(); // form 기본 이벤트 제거
                alert('이미지 변경 후 클릭하세요.');
            }
        })
    }


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

    //수정
    function modify_go(){

        let modifyForm = $("#modifyForm")[0];
        let uploadFiles = new FormData(modifyForm);
        if($(".myEmpSign")[0].files[0] !== undefined){
            $.ajax({
                type:"POST",
                url : "<%= request.getContextPath() %>/emp/registSign",
                processData: false,
                contentType: false,
                data : uploadFiles,
                success: function(data) {
                    console.log(data);
                },
                error: function(e) {
                    console.log(e);
                }
            });
        }
        alert("수정이 완료되었습니다.");

        document.modifyForm.submit();

    }

    function list_go()
    {
        location.href = "<%=request.getContextPath()%>/admin/emp/empList"
    }

</script>


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //다음 주소api
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function (data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                let addr = ""; // 주소 변수
                let extraAddr = ""; // 참고항목 변수
                let zipCode = data.zonecode;

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === "R") {
                    // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else {
                    // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if (data.userSelectedType === "R") {
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if (data.bname !== "" && /[동|로|가]$/g.test(data.bname)) {
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if (data.buildingName !== "" && data.apartment === "Y") {
                        extraAddr += extraAddr !== "" ? ", " + data.buildingName : data.buildingName;
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if (extraAddr !== "") {
                        extraAddr = "(" + extraAddr + ")";
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.

                    document.getElementById("myAdd1").value = extraAddr;
                } else {
                    document.getElementById("myAdd1").value = "";
                }

                document.getElementById("myAdd3").value = zipCode;
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("myAdd1").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("myAdd2").focus();

            },
        }).open();
    }

</script>


</body>
</html>