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
        margin-bottom: 10px;
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
      .serchTextGroup{display: flex;}
        .serchTextGroup span{
            font-size: 19px;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0px 10px;
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
              <!--왼쪽 아이콘 폰트어썸-->보낸메세지함
            </h2>
          </div>
          <div class="searchAndDeleteContainer" style="justify-content: flex-end; margin-bottom: 10px;">
            <!-- <div class="serchContain">
                <div class="serchTextGroup">
                    <input type="date" name="startTime" class="form-control"> 
                    <span>~</span>
                    <input type="date" name="endTime" class="form-control"> 
                </div>
                <button class="btn btn-outline-dark" style="width: 60px;" onclick="serchBtn()" name="serchBtn" type="button">검색</button>
                <button class="btn btn-outline-dark" style="width: 75px; margin-left: 6px;" onclick="initializeButton()" name="serchBtn" type="button">초기화</button>
            </div> -->
            <div class="delectBtnGroup">
              <button class="btn btn-primary delectBtn" onclick="deleteBtn()" name="serchBtn" type="button" >
                메세지 삭제
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
                <th>내용</th>
                <th>날짜</th>
                <th>조회여부</th>
              </tr>
            </thead>
            <tbody>
                <c:forEach var="messageList" items="${messageList}" varStatus="loop">
                    <tr>
                        <th class="tableCheckBox"><input type="checkbox" name="manage_id" value="${messageList.message_id}" data-messageempid="${messageList.emp_id}" class="checkBox manage_id" /></th>
                        <td class="listModalBtn" onclick="location.href='messageDetail?message_id=${messageList.message_id}&message_emp_id=${messageList.emp_id}'">
                            ${messageList.emp_name}
                        </td>
                        <td class="listModalBtn" onclick="location.href='messageDetail?message_id=${messageList.message_id}&message_emp_id=${messageList.emp_id}'">
                            ${messageList.message_title}
                        </td>
                        <td class="listModalBtn" onclick="location.href='messageDetail?message_id=${messageList.message_id}&message_emp_id=${messageList.emp_id}'">
                            ${messageList.message_start_dt}
                        </td>
                        <td class="listModalBtn" onclick="location.href='messageDetail?message_id=${messageList.message_id}&message_emp_id=${messageList.emp_id}'">
                            <c:if test="${messageList.receiver_read eq 0}">미확인</c:if>
                            <c:if test="${messageList.receiver_read eq 1}">확인</c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
          </table>
        </div>
      </section>
      <!-- 푸터 인클루드 -->
    <%@ include file="../include/footer.jsp"%>
    </body>

    <script>
        function initializeButton() {
            $('input[name="startTime"]').val('');
            $('input[name="endTime"]').val('');
        }

        function deleteBtn(){
            let result = confirm('삭제하시겠습니까?');
            if (result) {
                if($("input:checkbox[name='manage_id']").is(":checked")){
                let recordIds = [];
                $("input:checkbox[name='manage_id']:checked").each(function() {
                    recordIds.push($(this).val());
                });
                console.log(recordIds);
                if(recordIds.length != 0){
                    $.ajax({
                    type: "get",
                    url: "/WorkConGW/addBook/messageDelete",
                    data: { message_id: recordIds},
                    success: function(response) {
                        // 성공적으로 처리된 후에 수행할 작업
                        console.log(response);
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
                }else{
                    alert('체크된 메세지가 없습니다.')
                }
            }
        }
    </script>