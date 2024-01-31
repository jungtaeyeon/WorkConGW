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
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="<%=request.getContextPath() %>/css/sideBar.css" rel="stylesheet">
    <%@ include file="../include/header.jsp"%>
    <div class="contentConteiner">
        <div class="subTitleText">
            <h2>주소록등록</h2>
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
                <select name="add_book_id" class="form-select" aria-label="Default select example">
                    <option selected>그룹</option>
                    <% for (AddBookVO abGroupList : addBookGroupList) { %>
                    <option value="<%= abGroupList.getAdd_book_id() %>"><%= abGroupList.getAdd_book_title() %></option>
                    <% } %>
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