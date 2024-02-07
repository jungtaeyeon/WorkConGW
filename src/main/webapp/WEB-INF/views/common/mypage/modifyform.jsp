<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
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
            background-color: #d9d2ff3d
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
            background-color: #0f0f0f;
            color: #fff;
        }

        .input-btn {
            border: 1.5px solid #0f0f0f;
            background-color: #fff;
            color: #0f0f0f;
            height: 35px;
            width: 90px;
            border-radius: 10px;
            font-weight: 500;
            font-size: 14px;
        }

        .input-btn:hover {
            background-color: #0f0f0f;
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


  


  <div class="con">
    <div class="top-bar">
      <%@ include file="/WEB-INF/views/include/header.jsp" %>
    </div>
</div>

<div class="con main-2">
    <div class="side-bar">
        <div><%@ include file="/WEB-INF/views/include/sideBar.jsp" %></div>        
    </div>
    <div class="content">
        <div>
          <div class="container">
            <div class="signup">
              <form action="<%=request.getContextPath()%>/common/profile" method="POST" name="myPageFrm" id="profileFrm" enctype="multipart/form-data">
                  <h2 class="title">내 정보</h2>
                  
                  <div class="profile-image-area">

                    <%-- 프로필 이미지가 없으면 기본 이미지 --%>
                    <c:if test="${empty loginUser.emp_Picture}" >
                      <img src="<%=request.getContextPath() %>/pds/user1.jpg" id="profileImage">
                    </c:if>

                    <%-- 프로필 이미지가 있으면 있는 이미지 --%>
                    <c:if test="${!empty loginUser.emp_Picture}" >
                        <img src="<%=request.getContextPath() %>/pds/empPicture/${loginUser.emp_Picture}" id="profileImage">
                    </c:if>
                  </div>

                <span id="deleteImage">x</span>

                <div class="profile-btn-area">
                    <label for="imageInput">이미지 선택</label>
                    <input type="file" name="profileImage" id="imageInput" accept="image/*">
                    <button>변경하기</button>
                </div>
              </form>

              <form action = "<%=request.getContextPath()%>/common/mypage/modify" class="signup-form" id="modifyForm" name="modifyForm" method="get" enctype="multipart/form-data">
                <div class="input-field">
                  <label>* 이름 : </label>
                  <input type="text" id = "empName" name="emp_Name" value = "${loginUser.emp_Name}"  />
                </div>
                <div class="input-field">
                  <label>* 상태설정 : </label>
                  <select id = "attendStId" name="attend_St_Id" class="form-control">
                    <option value="1" ${loginUser.attend_St_Id eq '1'? 'selected' : '' }>정상출근</option>
                    <option value="4" ${loginUser.attend_St_Id eq '4'? 'selected' : '' }>휴가중</option>
                    <option value="5" ${loginUser.attend_St_Id eq '5'? 'selected' : '' }>외근</option>
                    <option value="6" ${loginUser.attend_St_Id eq '6'? 'selected' : '' }>야근</option>
                  </select>
                </div>

                <div class="input-field id-field">
                  <label>* 비밀번호 : </label>
                  <input id = "empPwd" name="emp_Pwd" type="password" value="${loginUser.emp_Pwd}" required />
                  <button id="modifyPwdBtn" class="input-btn">비밀번호변경</button>
                  <input type="hidden" value="o" id="isDup" />
                </div>
                <div class="input-field">
                  <label>* 사번</label>
                  <input id ="empId" name="emp_Id" type="text" maxlength="6" value = ${loginUser.emp_Id} readonly />
                </div>
                <div class="input-field">
                  <label>* 부서</label>
                  <input id="deptName"  name="dept_Name" type="text" maxlength="6" value = ${loginUser.dept_Name} readonly />
                </div>
                <div class="input-field">
                  <label>* 직위</label>
                  <input id ="codeName" name="code_Name" type="text" maxlength="6" value = ${loginUser.code_Name} readonly />
                </div>
                <div class="input-field">
                  <label>* 휴대전화</label>
                  <input id = "empHp"name="emp_Hp" type="text" value="${loginUser.emp_Hp}" required maxlength="20" />
                </div>
                <div class="input-field">
                  <label>* 이메일</label>
                  <input id = "empEmail" name="emp_Email" type="text" value ="${loginUser.emp_Email}"placeholder="'@' 을 포함한 이메일 주소 전체를 입력해주세요" required />
                </div>
                <div class="input-field">
                  <label>* 주소</label>
                  <div>
                    <input id = "myAdd1" name="emp_Add1" value = "${loginUser.emp_Add1}" type="text" placeholder="우편번호" required />
                    <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" /><br />
                  </div>
                </div>
                  <div class="input-field">
                    <label>* 상세주소</label>
                    <input id = "myAdd2" name="emp_Add2" type="text" value="${loginUser.emp_Add2}" placeholder="상세주소" required /><br />
                  </div>

                  <div class="input-field">
                    <label>*필수 서명 &nbsp&nbsp(png만 가능)</label>
                    <div class = "input-group">
                      <input id="myFileName" type="text" class="form-control" name="myEmpSign" style="cursor: pointer;" value="${loginUser.emp_Sign}" onclick="addEmpSign();" required readonly>
										<input type="file" id = "myEmpSign"class="myEmpSign" onchange="myAddSignFile(this);" name="myEmpSign" style="display: none;"> 
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fa fa-file-o" ></i> </span> 
                      </div>
                    </div>
                  </div>

                  <span class="float-right" style="padding-right: 36px;">
                    <button class="btn btn-dark" data-type="success" onclick="modify_go()">수정 완료</button>
                    <button type="button" class="btn btn-dark" onclick="home_go();">홈으로</button>
                  </span>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>

<div class="con main-bottom">
    <div class="foot">
      <%@ include file="/WEB-INF/views/common/mypage/mypage-sidebar.jsp" %>
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

  function myAddSignFile(obj) {
    if($(".myEmpSign")[0].files[0]){
      let empSign = $(obj)[0].files[0].name;
      
      let extension = getExtensionOfFilename(empSign);
      console.log(extension);
      
      if(!(extension == 'png')){
        alert("지원하지 않는 파일 형식입니다.");
        return false;
      }
      $("#myFileName").val(empSign);
    }else{
      $("#myFileName").val("");
      return false;
    }
  }

  function addEmpSign(){
    $(".myEmpSign").click();
  }

  //파일 확장자 추출 함수
function getExtensionOfFilename(filename) {
	 
  let _fileLen = filename.length;

  let _lastDot = filename.lastIndexOf('.');

  let _fileExt = filename.substring(_lastDot+1, _fileLen).toLowerCase();

  return _fileExt;
}



 //수정
function modify_go(){
	let msg = "";
	//사인 파일 있는지 없는지 체크
	$.ajax({
		type:"POST",
    url : "<%=request.getContextPath()%>/emp/checkEmpUpdateYn",
		processData: false,  
		contentType: false,
		async: false,
		success: function(data) {
			msg = data;
		},
		error: function(e) {
			console.log(e);
		}
	});
	
	console.log(msg);
	
	if(msg == 'fail' && $(".myEmpSign")[0].files[0] === undefined){
		alert("첫 방문 시 사인을 필수로 등록하셔야 합니다.");
		$(".myEmpSign").click();
		return false;
	}
	
	
	
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