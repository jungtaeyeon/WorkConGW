<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Map, java.util.ArrayList, com.WorkConGW.addbook.dto.AddBookVO" %>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script>
    const addBookInsert =()=>{
		document.querySelector("#addBookInsert").submit();
	}
</script>
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
        <form id="addBookInsert" method="get" 
        action="
        <c:choose>
          <c:when test='${addBookListUpdate ne null}'>addBookUpdate</c:when>
          <c:otherwise>addBookInsert</c:otherwise>
        </c:choose>
        "> 
        <input type="hidden" name="manage_id" value="${param.manage_id}">
            <div class="input-group mb-3">
              <div class="input-group-prepend">
                <span class="input-group-text" id="manage_display_name">이름</span>
              </div>
              <input type="text" class="form-control"name="manage_display_name" value="${addBookListUpdate[0].MANAGE_DISPLAY_NAME}" aria-label="이름" aria-describedby="manage_display_name">
            </div>
            <div class="input-group mb-3">
              <div class="input-group-prepend">
                <span class="input-group-text" id="manage_hp">전화번호</span>
              </div>
              <input type="text" class="form-control" name="manage_hp" value="${addBookListUpdate[0].MANAGE_HP}" aria-label="전화번호" aria-describedby="manage_hp">
            </div>
            <div class="input-group mb-3">
              <div class="input-group-prepend">
                <span class="input-group-text" id="manage_email">이메일</span>
              </div>
              <input type="text" class="form-control" name="manage_email" value="${addBookListUpdate[0].MANAGE_EMAIL}" aria-label="이메일" aria-describedby="manage_email">
            </div>
            <div class="input-group mb-3">
              <div class="input-group-prepend">
                <span class="input-group-text" id="manage_company_name">회사</span>
              </div>
              <input type="text" class="form-control" name="manage_company_name" value="${addBookListUpdate[0].MANAGE_COMPANY_NAME}" aria-label="회사" aria-describedby="manage_company_name">
            </div>
            <div class="input-group mb-3">
              <div class="input-group-prepend">
                <span class="input-group-text" id="manage_dept_name">부서</span>
              </div>
              <input type="text" class="form-control" name="manage_dept_name" value="${addBookListUpdate[0].MANAGE_DEPT_NAME}" aria-label="부서" aria-describedby="manage_dept_name">
            </div>
            <div class="input-group mb-3">
              <div class="input-group-prepend">
                <span class="input-group-text" id="manage_official_name">직급</span>
              </div>
              <input type="text" class="form-control" name="manage_official_name" value="${addBookListUpdate[0].MANAGE_OFFICIAL_NAME}" aria-label="직급" aria-describedby="manage_official_name">
            </div>

            <div class="mb-3 mt-3">
                <select id="add_book_id" name="add_book_id" class="custom-select" aria-label="그룹">
                    <option value="">그룹</option>
                </select>
            </div>
            <div class="input-group mb-3">
              <div class="input-group-prepend">
                <span class="input-group-text">메모</span>
              </div>
              <textarea class="form-control" name="manage_remark" aria-label="메모">${addBookListUpdate[0].MANAGE_REMARK}</textarea>
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
  <script>
    function addBookGroupSelect(share_add_book){
      let add_book_id = "${param.add_book_id}";
      $.ajax({
          type : 'get',              
          url : '/WorkConGW/addBook/addBookGroupSelect',  
          data : {
            share_add_book : share_add_book
          },
          success : function(result) {         
            $("#add_book_id option").remove(".groupOption");    
            for(let i=0; i<result.length; i++){
              if(add_book_id != null && result[i].add_book_id == add_book_id){
                $("#add_book_id").append("<option class='groupOption' value='"+result[i].add_book_id+"' selected>"+result[i].add_book_title+"</option>");
              }
              else{
                $("#add_book_id").append("<option class='groupOption' value='"+result[i].add_book_id+"'>"+result[i].add_book_title+"</option>");
              }
              
            }
          },    
          error : function(request, status, error) {        
            console.log(error)    
          }
        })
    }
    $(document).ready(function(){
      addBookGroupSelect(0);
    })
  </script>
  <%@ include file="../include/footer.jsp"%>