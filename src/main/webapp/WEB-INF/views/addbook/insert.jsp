<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Map, java.util.ArrayList, com.WorkConGW.addbook.dto.AddBookVO" %>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% 
List<AddBookVO> addBookGroupList = (List<AddBookVO>)request.getAttribute("addBookGroupList");
%>	
<script>
    const addBookInsert =()=>{
		document.querySelector("#addBookInsert").submit();
	}
</script>
<body>
  <style>
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
  </style>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="<%=request.getContextPath() %>/css/sideBar.css" rel="stylesheet">
    <%@ include file="../include/header.jsp"%>
    <div class="contentConteiner">
        <div class="subTitleText">
            <h2>주소록등록</h2>
        </div>
        <div class="share_add_book_btn_contain">
          <div class="share_add_book_btn share_add_book_btn_on" data-sharecond="0">개인주소록</div>
          <div class="share_add_book_btn" data-sharecond="1">공유주소록</div>
        </div>
        <form id="addBookInsert" method="get" action="/addBook/addBookInsert">
            <div class="form-floating mb-3 mt-3">
              <input
                type="text"
                class="form-control"
                id="manage_display_name"
                name="manage_display_name"
                placeholder="Enter 이름"
              />
              <label for="manage_display_name">이름</label>
            </div>
            <div class="form-floating mb-3 mt-3">
              <input
                type="text"
                class="form-control"
                id="manage_hp"
                name="manage_hp"
                placeholder="Enter 전화번호"
              />
              <label for="manage_hp">전화번호</label>
            </div>
            <div class="form-floating mb-3 mt-3">
                <input
                  type="text"
                  class="form-control"
                  id="manage_email"
                  name="manage_email"
                  placeholder="Enter 이메일"
                />
                <label for="manage_email">이메일</label>
            </div>
            <div class="form-floating mb-3 mt-3">
              <input
                type="text"
                class="form-control"
                id="manage_company_name"
                name="manage_company_name"
                placeholder="Enter 회사"
              />
              <label for="manage_company_name">회사</label>
          </div>
            <div class="form-floating mb-3 mt-3">
                <input
                  type="text"
                  class="form-control"
                  id="manage_dept_name"
                  name="manage_dept_name"
                  placeholder="Enter 부서"
                />
                <label for="manage_dept_name">부서</label>
            </div>
            <div class="form-floating mb-3 mt-3">
              <input
                type="text"
                class="form-control"
                id="manage_official_name"
                name="manage_official_name"
                placeholder="Enter 직급"
              />
            <label for="manage_official_name">직급</label>
            </div>
            <div class="mb-3 mt-3">
                <select id="add_book_id" name="add_book_id" class="form-select" aria-label="Default select example">
                    <option value="0" selected>그룹</option>
                </select>
            </div>
            <div class="form-floating mb-3 mt-3">
                <input
                  type="text"
                  class="form-control"
                  id="manage_remark"
                  name="manage_remark"
                  placeholder="Enter 메모"
                />
                <label for="manage_remark">메모</label>
              </div>
          </form>
          <input
              type="button"
              class="btn btn-warning"
              data-bs-dismiss="modal"
              onclick="addBookInsert()"
              value="저장"
            />
    </div>
    <%@ include file="../include/footer.jsp"%>
</body>
<script>
  function addBookGroupSelect(share_add_book){
    $.ajax({
        type : 'get',              
        url : '/addBook/addBookGroupSelect',  
        data : {
          share_add_book : share_add_book
        },
        success : function(result) {         
          console.log(result);
          $("#add_book_id option").remove(".groupOption");    
          for(let i=0; i<result.length; i++){
            console.log(result[i].add_book_title);
            $("#add_book_id").append("<option class='groupOption' value='"+result[i].add_book_id+"'>"+result[i].add_book_title+"</option>");
          }
        },    
        error : function(request, status, error) {        
          console.log(error)    
        }
      })
  }

  $(".share_add_book_btn").click(function(){
    if(!$(this).hasClass('share_add_book_btn_on')){
      $(".share_add_book_btn").not(this).removeClass("share_add_book_btn_on");
      $(this).addClass('share_add_book_btn_on');
      let share_add_book = $(this).data('sharecond');
      addBookGroupSelect(share_add_book);
    }
  })
  $(document).ready(function(){
    addBookGroupSelect(0);
  })
</script>