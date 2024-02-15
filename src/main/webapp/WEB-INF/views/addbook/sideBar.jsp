<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
  <style>
  a{text-decoration: none;}
  .sidebar{
    border-right:2px solid rgb(0,0,0,0.1);
    margin-right: 10px;
  }
  .sidebar-scroll{
    padding:0 10px 20px;
    width: 250px;
  }
  .subPageContain{
    display: flex;
  }
  .contentConteiner{
    width: 100%;
    padding:0 10px;
  }
  .tab-content{
    font-size: 25px; 
    margin-left: 3%; 
    padding-bottom: 0; 
    font-family: S-CoreDream-4Regular
  }
  .subsubmenu{margin-bottom: 20px;}
  .tab-content a{color: #000;}
  .metismenu:last-child{margin-bottom:0 !important;}
  .metismenu i{color:#2980b9;}
  .metismenu, .metismenu span{
    list-style: none;
    color: #5a5a5a;
  }
  #go_btn{
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: #2980b9; 
    color: white; 
    width: 14rem; 
    height: 3.8rem; 
    border-radius: 5%; 
    font-family: InfinitySans-RegularA1;
  }
  .metismenuLI a{
    font-family: S-CoreDream-4Regular; 
    font-size: 20px;
  }
  .go_btn{margin-bottom: 15px;}
  .modal.show{background-color: rgba(0, 0, 0, 0.7);}
  .modalBtnGroup{
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  .modalBtn{cursor: pointer; color:#000 !important;}
  </style>
  <script>
    const addBookGroupInsert = () => {
      document.querySelector("#addBookGroupInsert").submit();
    }
  </script>
  <div id="left-sidebar" class="sidebar">
    <div class="sidebar-scroll">

        <!--큰버튼이 필요한 페이지에 쓰임(주소록, 전자결재, 일정관리 등)-->
        <div class="tab-content p-l-0 p-r-0 text-align go_btn">
            <a href="addBookInsertPage"  id="go_btn">주소록등록</a>
        </div>

        <!--큰버튼이 필요한 페이지에 쓰임-->
        <div class="tab-content p-l-0 p-r-0 subsubmenu">
          <!--서브메뉴 타이틀-->
            <a href="addBookStarred">중요주소록</a>
        </div>

        <div class="tab-content p-l-0 p-r-0 subsubmenu">
          <div class="modalBtnGroup">
          <!--서브메뉴 타이틀-->
            <a href="addBookList">개인주소록</a>
            <i class="fa-solid fa-plus modalBtn" data-toggle="modal" data-target="#staticBackdrop"></i>
          </div>
            <ul class="main-menu metismenu addBook">
                <c:forEach var="list" items="${addBookGroupList}">
                  <c:if test="${list.share_add_book_yn eq '0'}">
                    <li id="li_importantSchedule" class="metismenuLI addBookGroupLi">
                      <a href="addBookList?add_book_id=${list.add_book_id}" class=""><i class="fa fa-square" id="importantSchedule"></i><span>${list.add_book_title}</span></a>
                    </li>
                  </c:if>
                </c:forEach>
                <li id="li_importantSchedule" class="metismenuLI noGroup">
                    <a href="addBookList?add_book_id=noGroup" class=""><i class="fa fa-square" id="importantSchedule"></i><span>미등록그룹</span></a>
                </li>
            </ul>
          
        </div>
        <div class="tab-content p-l-0 p-r-0 subsubmenu">
            <div class="modalBtnGroup">
              <!--서브메뉴 타이틀--> 
              <a href="addBookShare">공유주소록</a>
            </div>
            <ul class="main-menu metismenu shareAddBook">
              <c:forEach var="list" items="${addBookGroupList}">
                  <c:if test="${list.share_add_book_yn eq '1'}">
                    <li id="li_importantSchedule" class="metismenuLI addBookGroupLi">
                      <a href="addBookList?add_book_id=${list.add_book_id}" class=""><i class="fa fa-square" id="importantSchedule"></i><span>${list.add_book_title}</span></a>
                    </li>
                  </c:if>
                </c:forEach>
          </ul>
        </div>
    </div>
</div>


<!-- Modal -->
<div class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">그룹추가</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form id="addBookGroupInsert" action="addBookGroupInsert" method="get">
          <p style="font-size: 18px;">그룹명<input type="text" name="add_book_title" class="form-control"></p>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary" onclick="addBookGroupInsert()">저장</button>
      </div>
    </div>
  </div>
</div>