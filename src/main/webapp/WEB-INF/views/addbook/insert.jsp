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
    #addBookInsert{
      margin: 30px 0 1rem;
    }
    .insertBtn{ margin-bottom:30px; }
  </style>
    <%@ include file="../include/header.jsp"%>
  <section class="subPageContain">

    <%@ include file="./sideBar.jsp"%>

    <div class="contentConteiner">
        <div class="subTitleText">
            <h2><i class="fa-solid fa-angles-right"></i>주소록등록</h2>
        </div>
        <div class="share_add_book_btn_contain">
          <div class="share_add_book_btn share_add_book_btn_on" data-sharecond="0">개인주소록</div>
          <div class="share_add_book_btn" data-sharecond="1">공유주소록</div>
        </div>
        <form id="addBookInsert" method="get" action="addBookInsert">
            <div class="input-group mb-3">
              <div class="input-group-prepend">
                <span class="input-group-text" id="manage_display_name">이름</span>
              </div>
              <input type="text" class="form-control"name="manage_display_name" aria-label="이름" aria-describedby="manage_display_name">
            </div>
            <div class="input-group mb-3">
              <div class="input-group-prepend">
                <span class="input-group-text" id="manage_hp">전화번호</span>
              </div>
              <input type="text" class="form-control" name="manage_hp" aria-label="전화번호" aria-describedby="manage_hp">
            </div>
            <div class="input-group mb-3">
              <div class="input-group-prepend">
                <span class="input-group-text" id="manage_email">이메일</span>
              </div>
              <input type="text" class="form-control" name="manage_email" aria-label="이메일" aria-describedby="manage_email">
            </div>
            <div class="input-group mb-3">
              <div class="input-group-prepend">
                <span class="input-group-text" id="manage_company_name">회사</span>
              </div>
              <input type="text" class="form-control" name="manage_company_name" aria-label="회사" aria-describedby="manage_company_name">
            </div>
            <div class="input-group mb-3">
              <div class="input-group-prepend">
                <span class="input-group-text" id="manage_dept_name">부서</span>
              </div>
              <input type="text" class="form-control" name="manage_dept_name" aria-label="부서" aria-describedby="manage_dept_name">
            </div>
            <div class="input-group mb-3">
              <div class="input-group-prepend">
                <span class="input-group-text" id="manage_official_name">직급</span>
              </div>
              <input type="text" class="form-control" name="manage_official_name" aria-label="직급" aria-describedby="manage_official_name">
            </div>

            <div class="mb-3 mt-3">
                <select id="add_book_id" name="add_book_id" class="custom-select" aria-label="그룹">
                    <option value="0" selected>그룹</option>
                </select>
            </div>
            <div class="input-group mb-3">
              <div class="input-group-prepend">
                <span class="input-group-text">메모</span>
              </div>
              <textarea class="form-control" name="manage_remark" aria-label="메모"></textarea>
            </div>
          </form>
          <input
              type="button"
              class="btn btn-warning insertBtn"
              data-bs-dismiss="modal"
              onclick="addBookInsert()"
              value="저장"
            />
    </div>
  </section>
    <%@ include file="../include/footer.jsp"%>
</body>
<script>
  function addBookGroupSelect(share_add_book){
    $.ajax({
        type : 'get',              
        url : '/WorkConGW/addBook/addBookGroupSelect',  
        data : {
          share_add_book : share_add_book
        },
        success : function(result) {         
          $("#add_book_id option").remove(".groupOption");    
          for(let i=0; i<result.length; i++){
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