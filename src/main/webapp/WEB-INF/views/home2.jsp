<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<style>
  p{margin-bottom: 0 !important;}
  .mainDashBoard{
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    row-gap: 10px;
    /* row의 간격을 10px로 */
    column-gap: 20px;
    /* column의 간격을 20px로 */
  }
  .gridContent{
    border: 1px solid #d2d2d2;
    height: 300px;
    padding: 2% 3%;
  }
  .gridContent:nth-child(2) {
    grid-column: 2 / span 2; 
  }
  .profilContent{display: flex;}
  .profilName{
    font-size: 24px;
    font-weight: bold;
  }
  .profilCode{
    font-size: 19px;
    margin-left: 4px;
  }
  .profilEmp, .profilDept{font-size: 17px;}
  .profilEmp span, .profilDept span{margin-right: 5px;}
</style>
<%@ include file="./include/header.jsp"%>
${loginUser}
<section class="mainDashBoard">
  <div class="gridContent profilContainer">
    <div class="profilContent">
      <c:if test="${loginUser.emp_Picture != null}">
        <div id="pictureView" style="background-image:url('${pageContext.request.contextPath }/pds/empPicture/${ loginUser.emp_Picture}'); width: 110px; height: 110px;" class="rounded-circle avatar" ></div>
      </c:if>
      <c:if test = "${loginUser.emp_Picture == null}">
        <div id="pictureViewPhoto" style="background-color: #ffffff;" class="rounded-circle user-photo">
        </div>
      </c:if>
      <div class="profilText">
        <p class="profilName">${loginUser.emp_Name}<span class="profilCode">${loginUser.code_Name}</span></p>  
        <p class="profilEmp"><span>[사번]</span>${loginUser.emp_Id}</p>  
        <p class="profilDept"><span>[부서]</span>${loginUser.dept_Name}</p>  
      </div>
    </div>
  </div>
  <div class="gridContent">

  </div>
  <div class="gridContent">

  </div>
  <div class="gridContent">

  </div>
  <div class="gridContent">

  </div>
  <div class="gridContent">

  </div>
  <div class="gridContent">

  </div>
  <div class="gridContent">

  </div>
</section>
<%@ include file="./include/footer.jsp"%>