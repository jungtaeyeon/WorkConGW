<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Map, java.util.ArrayList, com.WorkConGW.addbook.dto.AddBookVO" %>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script>
</script>
<body>
  <style>
    .contentConteiner{
		margin:0 2%;
	}
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
    .share_add_book_btn_contain{
      display: flex;
    }
    .share_add_book_btn{
      width: 150px;
      height: 35px;
      background: #f2f2f2;
      border: 1px solid #f2f2f2;
      display: flex;
      justify-content: center;
      align-items: center;
      color: #646464;
      cursor: pointer;
    }
    .share_add_book_btn_on{
      border: 1px solid #2985db;
      color: #2985db;
      background:#fff;
    }
    #EmpInsert{
      margin: 30px 0 1rem;
    }
    .insertBtn{ margin-bottom:30px; }
    .dateWave{
		font-size: 23px;
    display: inline-block;
    margin: 0 15px;
	}
    .custom-file-label::after{content: "파일선택" !important; height: 36px !important; line-height: 2.1 !important;}
    .custom-file label{margin-bottom: 0;}
    .custom-file-label{height: 38px !important;}
  </style>
    <%@ include file="../../include/header.jsp"%>
    <div class="contentConteiner">
        <div class="subTitleText">
            <h2><i class="fa-solid fa-angles-right"></i>사원등록</h2>
        </div>
        <form id="EmpInsert" method="get" action="">

            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="">사원번호</span>
                </div>
                <input type="text" class="form-control"name="" aria-label="사원번호" aria-describedby="">
                <button type="button" class="btn btn-primary">번호생성</button>
            </div>

            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="">사원명</span>
                </div>
                <input type="text" class="form-control" name="" aria-label="사원명" aria-describedby="">
            </div>

            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="">입사날짜</span>
                </div>
                <input type="date" class="form-control" name="" aria-label="입사날짜" aria-describedby="">
            </div>

            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="">부서</span>
                </div>
                <select class="custom-select" name=""> 
                    <option value="0">부서</option>
                    <option value="">경영부</option>
                </select>
            </div>

            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="manage_dept_name">직급</span>
                </div>
                <select class="custom-select" name=""> 
                    <option value="0">직급</option>
                    <option value="">사원</option>
                    <option value="">주임</option>
                    <option value="">대리</option>
                </select>
            </div>

            <div class="input-group mb-3">
              <div class="input-group-prepend">
                <span class="input-group-text" id="manage_official_name">이메일</span>
              </div>
              <input type="text" class="form-control" name="" aria-label="이메일" aria-describedby="">
              <span class="dateWave">@</span>
                <select class="custom-select" name=""> 
                    <option value="0">naver.com</option>
                    <option value="">gmail.com</option>
                </select>
            </div>

            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="">우편번호</span>
                </div>
                <input type="text" class="form-control"name="" aria-label="우편번호" aria-describedby="">
                <button type="button" class="btn btn-primary">주소검색</button>
            </div>

            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="">주소</span>
                </div>
                <input type="text" class="form-control"name="" aria-label="상세주소1" aria-describedby="">
                <input type="text" class="form-control" name="" aria-label="상세주소2" aria-describedby="">
            </div>

            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="">주민등록번호</span>
                </div>
                <input type="text" class="form-control"name="" aria-label="주민등록번호" aria-describedby="">
            </div>

            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="">권한</span>
                </div>
                <select class="custom-select" name=""> 
                    <option value="0">권한</option>
                    <option value="">관리자</option>
                    <option value="">일반</option>
                </select>
            </div>

            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="">이미지업로드</span>
                </div>
                <div class="custom-file">
                    <input type="file" class="custom-file-input" id="inputGroupFile01" aria-describedby="inputGroupFileAddon01">
                    <label class="custom-file-label" for="inputGroupFile01">파일을 선택해주세요</label>
                </div>
            </div>

            
            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="">비밀번호</span>
                </div>
                <input type="text" class="form-control"name="" aria-label="비밀번호" aria-describedby="">
            </div>

            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="">비밀번호확인</span>
                </div>
                <input type="text" class="form-control"name="" aria-label="비밀번호확인" aria-describedby="">
            </div>


        </form>
        <input type="button" class="btn btn-warning insertBtn" data-bs-dismiss="modal" onclick="" value="저장" />
    </div>
    <%@ include file="../../include/footer.jsp"%>
<script>
</script>