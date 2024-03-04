<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> 
<%@ page import="java.util.List, java.util.Map,
java.util.ArrayList, com.WorkConGW.addbook.dto.AddBookVO" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
    <script>
      const serchBtn = () => {
        document.querySelector("#serchForm").submit();
      };
      
    </script>
    <style>
      .table td{
        vertical-align: middle !important;
      }
      .subTitleText {
        margin-bottom: 25px;
      }
      .subTitleText h2 {
        display: flex;
        justify-content: flex-start;
        align-items: center;
        font-size: 27px;
      }
      .subTitleText i {
        font-size: 24px;
        margin-right: 5px;
      }
      .serchContain {
        display: flex;
        align-items: flex-start;
      }
      #serchForm {
        display: flex;
      }
      .serchSelect {
        width: 150px;
      }
      .serchTextGroup {
        width: 350px;
      }
      .tableCheckBox {
        text-align: center;
        vertical-align: middle !important;
      }
      .starred {
        margin-left: 5px;
        cursor: pointer;
      }
      .starred.fa-solid{
        color:#fdc036;
      }
      .listModalBtn{cursor: pointer;}

      .modal-body p{font-size:16px;}
      .groupTag{
        display: inline-block;
        background-color: rgb(52, 152, 219);
        color: #fff;
        padding: 0px 10px;
        box-sizing: border-box;
        line-height: 30px;
        text-align: center;
        border-radius: 9px;
        margin: 0 3px;
      }
      .searchAndDeleteContainer{
        display: flex;
        justify-content: space-between;
        align-items: center;
      }
      .manageinterior{
        font-size: 15px;
        font-weight: 500;
        color: #d2d2d2;
      }
    </style>
    <body>
      <!-- 헤더인클루드 -->
      <%@ include file="../include/header.jsp"%>

      <section class="subPageContain">
        <!-- 사이드바 -->
        <%@ include file="./sideBar.jsp"%>

        <!--컨텐츠 영역-->
        <div class="contentConteiner">
          <div class="subTitleText">
            <!--컨텐츠 부분 타이틀 클래스(이건 부트스트랩 클래스 아니고 임의로 만든 클래스)-->
            <h2>
              <i class="fa-solid fa-angles-right"></i>
              <!--왼쪽 아이콘 폰트어썸-->공유주소록
            </h2>
          </div>
          <div class="searchAndDeleteContainer">
            <div class="serchContain">
              <!--셀렉/검색/버튼 묶는 div클래스 (이건 부트스트랩 클래스 아니고 임의로 만든 클래스)-->
              <form action="addBookSearchShare" id="serchForm">
                <div class="serchSelect">
                  <!--select 길이조절 클래스 (이건 부트스트랩 클래스 아니고 임의로 만든 클래스)-->
                  <!-- select태그 클래스 -->
                  <select class="custom-select" name="selectSearch">
                    <option value="all">전체</option>
                    <option value="manage_display_name">이름</option>
                    <option value="manage_hp">휴대폰</option>
                    <option value="manage_official_name">직급</option>
                    <option value="manage_dept_name">부서명</option>
                  </select>
                </div>
                <div class="serchTextGroup">
                  <!--input 길이조절 클래스 (이건 부트스트랩 클래스 아니고 개별 클래스)-->
                  <!-- 검색명 input 클래스 -->
                  <input
                    type="text"
                    name="searchText"
                    class="form-control"
                    placeholder="입력해주세요"
                    aria-label="입력해주세요"
                  />
                </div>
              </form>

              <!-- 검색 button 클래스 --><button
                class="btn btn-outline-secondary"
                onclick="serchBtn()"
                name="serchBtn"
                type="button"
              >
              검색
              </button>
            </div>

            <div class="delectBtnGroup">
              <button class="btn btn-primary delectBtn" onclick="deleteBtn()" name="serchBtn" type="button" >
                주소록 삭제
              </button>
            </div>
          </div>
          <table class="table table-hover">
            <!-- 부트스트랩 게시판 -->

            <thead class="thead-light">
              <!-- 게시판 맨위 색변경 클래스-->
              <tr>
                <th class="tableCheckBox"><input type="checkbox" id="checkAll"/></th>
                <th>이름명</th>
                <th>회사</th>
                <th>직급</th>
                <th>부서</th>
                <th>전화번호</th>
                <th>이메일</th>
                <th>그룹</th>
              </tr>
            </thead>
            
            <tbody>
              <tr>
            <c:forEach var="entry" items="${groupedByManageId}" varStatus="status">
              <c:set var="manageId" value="${entry.key}" />
              <c:set var="addBookList" value="${entry.value}" />
              <!-- 해당 manageId가 이전에 처리되었는지 확인 -->
              <c:if test="${not empty manageId and not fn:contains(processedIds, manageId)}"> 
                <c:set var="processedIds" value="${processedIds},${manageId}" />
                <c:forEach var="addBook" items="${addBookList}" varStatus="loop">
                      <c:if test="${loop.index == 0}">
                        <th class="tableCheckBox"><input type="checkbox" name="manage_id" value="${addBook.manage_id}" class="checkBox manage_id" /></th>
                        <td>
                          ${addBook.manage_display_name}<c:if test="${addBook.manage_emp_id ne null}"><span class="manageinterior">[내부연락처]</span></c:if>
                        </td>
                        <td class="listModalBtn" data-toggle="modal" data-target="#staticBackdrop${status.index}">
                          ${addBook.manage_company_name}
                        </td>
                        <td class="listModalBtn" data-toggle="modal" data-target="#staticBackdrop${status.index}">
                          ${addBook.manage_official_name}
                        </td>
                        <td class="listModalBtn" data-toggle="modal" data-target="#staticBackdrop${status.index}">
                          ${addBook.manage_dept_name}
                        </td>
                        <td class="listModalBtn" data-toggle="modal" data-target="#staticBackdrop${status.index}">
                          ${addBook.manage_hp}
                        </td>
                        <td class="listModalBtn" data-toggle="modal" data-target="#staticBackdrop${status.index}">
                          ${addBook.manage_email}
                        </td>
                        <td class="listModalBtn" data-toggle="modal" data-target="#staticBackdrop${status.index}">
                          <c:if test="${addBook.add_book_title ne ' '}"> <span class="groupTag">${addBook.add_book_title}</span></c:if>
                        </td>
                      </tr>
                      <!-- Modal -->
                      <div class="modal fade" id="staticBackdrop${status.index}" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                          <div class="modal-content">
                            <div class="modal-header">
                              <h5 class="modal-title" id="staticBackdropLabel">${addBook.manage_display_name}</h5>
                              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                              </button>
                            </div>
                            <div class="modal-body">
                              <p>회사명 :  ${addBook.manage_company_name}</p>
                              <p>직급 : ${addBook.manage_official_name}</p>
                              <p>부서 : ${addBook.manage_dept_name}</p>
                              <p>전화번호 : ${addBook.manage_hp}</p>
                              <p>이메일 : ${addBook.manage_email}</p>
                              <c:if test="${addBook.add_book_title ne ' '}">  
                                <p>그룹 : 
                                  <c:forEach var="addBookGroup" items="${addBookList}">
                                    <span class="groupTag">${addBookGroup.add_book_title}</span>
                                  </c:forEach>
                                </p>
                              </c:if>
                              <p>메모 : ${addBook.manage_remark}</p>
                            </div>
                            <div class="modal-footer">
                              <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                            </div>
                          </div>
                        </div>
                      </div>
                  </c:if>
                </c:forEach>
              </c:if>
            </c:forEach>
            </tbody>
          </table>
        </div>
      </section>
      <!-- 푸터 인클루드 -->
      <%@ include file="../include/footer.jsp"%>
    </body>


    
    <script>
      
      let loginUser = "${loginUser.emp_Id}";
      let addBookList = "${groupedByManageId}";
      console.log(addBookList);
      console.log("${loginUser.emp_Id}");
      $(".starred").click(function(){
        if(loginUser == addBookList){
          $(this).toggleClass("fa-regular");
          $(this).toggleClass("fa-solid");
          let manageId = $(this).closest('tr').find('.manage_id').val();
          let starred = $(this).hasClass("fa-solid");
          let starredNum;
          if(starred == true){
            starredNum = 1;
          }else{
            starredNum = 0;
          }
          console.log(manageId);
          console.log(starredNum);
          $.ajax({
            type : 'get',              
            url : '/WorkConGW/addBook/addBookStarredUpdate',  
            data : {
              manage_starred : starredNum,
              manage_id : manageId
            },
            success : function(result) {
              if(starredNum == 1){
                alert("중요주소록에 등록되었습니다.");
              }else{
                alert("중요주소록에 삭제되었습니다.");
              }         
              
            },    
            error : function(request, status, error) {        
              console.log(error)    
            }
          })
        }else{
          alert("권한이 없습니다.");
        }
      })
      const deleteBtn = () =>{
        let result = confirm('삭제하시겠습니까?');
        if (result) {
          var recordIds = [];
          $("input:checkbox[name='manage_id']:checked").each(function() {
                  recordIds.push($(this).val());
          });
          console.log(recordIds);
          if(recordIds.length != 0){
            $.ajax({
              type: "get",
              url: "/WorkConGW/addBook/addBookDelete",
              data: { manage_id: recordIds },
              success: function(response) {
                  // 성공적으로 처리된 후에 수행할 작업
                  if(response !== 0){
                    alert('삭제되었습니다');
                    location.reload();
                  }
              },
              error: function(xhr, status, error) {
                  // 오류 처리
                  console.error(xhr.responseText);
              }
            });
          }else{
            alert("선택된게 없습니다.");
          }
        }
      }
      $('#checkAll').change(function() {
        // 전체 선택 체크박스의 상태를 가져옵니다.
        let isChecked = $(this).prop('checked');
        
        // tbody 내의 모든 체크박스를 선택 상태로 설정합니다.
        $('.checkBox').prop('checked', isChecked);
      });
    </script>