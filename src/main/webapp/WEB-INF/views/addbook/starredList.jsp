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
      .manageinterior{
        font-size: 15px;
        font-weight: 500;
        color: #d2d2d2;
      }
      .searchAndDeleteContainer{
        display: flex;
        justify-content: space-between;
        align-items: center;
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
              <!--왼쪽 아이콘 폰트어썸-->중요주소록
            </h2>
          </div>

          <div class="searchAndDeleteContainer">
            <div class="serchContain">
              <!--셀렉/검색/버튼 묶는 div클래스 (이건 부트스트랩 클래스 아니고 임의로 만든 클래스)-->
              <form action="addBookSearch" id="serchForm">
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
                class="btn btn-secondary"
                onclick="serchBtn()"
                name="serchBtn"
                type="button"
              >
                검색
              </button>
            </div>
            <div class="delectBtnGroup">
              <button class="btn btn-primary messageBtn" type="button" >
                메시지 전송
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
                        <th class="tableCheckBox"><input type="checkbox" name="manage_id" data-name="${addBook.manage_display_name}" data-manageempid="${addBook.manage_emp_id}" value="${addBook.manage_id}" class="checkBox manage_id" /></th>
                        <td>
                          ${addBook.manage_display_name}<c:if test="${addBook.manage_emp_id ne null}"><span class="manageinterior">[내부연락처]</span></c:if>
                          <i class="starred fa-star <c:choose><c:when test='${addBook.manage_starred eq 1}'> fa-solid</c:when><c:otherwise> fa-regular</c:otherwise></c:choose>"></i>
                          <input type="hidden" class="manage_id" name="manage_id" value="${addBook.manage_id}"/>
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
                          <c:forEach var="addBookGroup" items="${addBookList}">
                            <c:if test="${addBookGroup.add_book_title ne ' '}"> <span class="groupTag">${addBookGroup.add_book_title}</span></c:if>
                          </c:forEach>
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
                              <a href="addBookListUpdate?manage_id=${addBook.manage_id}&manage_emp_id=${addBook.manage_emp_id}" class="btn btn-primary">수정</a>
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
      <!-- Modal -->
      <div class="modal fade" id="messageModal" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="staticBackdropLabel">메세지 전송</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <form action="messageInsert" id="messageInsert">
                <input type="hidden" name="manage_emp_id[]">
                <p class="manage_emp_name">받는사람 : <span></span></p>
                <div class="input-group mb-3">
                  <div class="input-group-prepend">
                    <span class="input-group-text" id="message_title">제목</span>
                  </div>
                  <input type="text" class="form-control" name="message_title">
                </div>
                <div class="input-group mb-3">
                  <div class="input-group-prepend">
                    <span class="input-group-text">내용</span>
                  </div>
                    <textarea textarea id="messageContent" name="messageContent" maxlength="200" style="border: 1px solid #ced4da; width: 410px; height: 160px; resize: none; font-size: 15px;"></textarea>
                </div>
                <div id="charCount" style="text-align: right; margin-top: -1rem;">0/200</div>
              </form>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
              <button type="button" onclick="messageInsert()" class="btn btn-primary">전송</button>
            </div>
          </div>
        </div>
      </div>
      <!-- 푸터 인클루드 -->
      <%@ include file="../include/footer.jsp"%>
    </body>
    <c:set var="addBookList" value="${addBookList}" />
    
    <script>
      let loginUser = "${loginUser.emp_Id}";
      let addBookList = "${addBookList[0].emp_id}";
      $(".starred").click(function(){
        if(loginUser == addBookList){
          $(this).toggleClass("fa-regular");
          $(this).toggleClass("fa-solid");
          let manageId = $(this).closest('td').find('.manage_id').val();
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
                location.reload();
              }else{
                alert("중요주소록에 삭제되었습니다.");
                location.reload();
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
      $('#checkAll').change(function() {
        // 전체 선택 체크박스의 상태를 가져옵니다.
        let isChecked = $(this).prop('checked');
        
        // tbody 내의 모든 체크박스를 선택 상태로 설정합니다.
        $('.checkBox').prop('checked', isChecked);
      });
      $('.messageBtn').click(function(){
        let manageempid = [];
        let name = "";
        let allIdsAreValid = true; 
        $("input:checkbox[name='manage_id']:checked").each(function() {
          let empId = $(this).data('manageempid');
          if (empId !== '') {
              name += $(this).data('name') + ',';
              manageempid.push(empId);
          } else {
              allIdsAreValid = false; // 적어도 하나의 manageempid가 없는 경우 표시하지 않기 위해 false로 설정
          }
        });
        if (allIdsAreValid && $("input:checkbox[name='manage_id']").is(":checked")) {
        // 모든 manageempid가 유효한 경우
          $('input[name="manage_emp_id[]"]').val(manageempid);

          if (name !== "") {
              name = name.slice(0, -1); // 마지막 쉼표 제거
          }

          $('#messageModal .manage_emp_name span').text(name);
          $('#messageModal').modal('show');
        } else {
          // 적어도 하나의 manageempid가 없는 경우
          alert("내부연락처를 선택해주세요");
        }
      })
      $('#messageContent').on('input', function() {
        var text = $(this).val();
        var charCount = text.length;
        
        if (charCount > 200) {
            $(this).val(text.substring(0, 200));
            charCount = 200;
        }
        
        $('#charCount').text(charCount + '/200');
      });
      const messageInsert= () =>{
        $('#messageInsert').submit();
      }
    </script>