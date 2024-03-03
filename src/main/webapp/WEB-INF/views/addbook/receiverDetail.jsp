<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> 
<%@ page import="java.util.List, java.util.Map,
java.util.ArrayList, com.WorkConGW.addbook.dto.AddBookVO" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 

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
.container {
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
}

.message-detail {
    background-color: #fff;
    border-radius: 5px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    padding: 20px;
}

.message-detail h1 {
    font-size: 24px;
    color: #333;
    margin-bottom: 20px;
}

.message {
    border-top: 2px solid #ccc;
    padding-top: 20px;
}

.message h2 {
    font-size: 20px;
    color: #333;
    margin-bottom: 10px;
}

.message p {
    font-size: 16px;
    color: #666;
    margin-bottom: 10px;
    line-height: 1.5;
}
.messageDetailcontainer{margin-bottom: 25px;}
</style>
<%@ include file="../include/header.jsp"%>
<section class="subPageContain">
  <!-- 사이드바 -->
  <%@ include file="./sideBar.jsp"%>

    <div class="contentConteiner">
        <div class="subTitleText">
            <h2><i class="fa-solid fa-angles-right"></i>받은메세지함</h2>
        </div>
        <div class="messageDetailcontainer">
            <input type="hidden" id="message_id" name="message_id" value="${receiverDetail[0].message_id}"/>
            <div class="message-detail">
                <h1>${receiverDetail[0].message_title}</h1>
                <div class="message">
                    <p>FROM: ${receiverDetail[0].emp_name}</p>
                    <p>Date: ${receiverDetail[0].message_start_dt}</p>
                    <p>Content: ${receiverDetail[0].message_content}</p>
                </div>
                <div style="text-align: right;">
                    <a href="receiverList" type="button" class="btn btn-outline-dark">목록</a>
                    <button type="button" onclick="deleteBtn()" class="btn btn-outline-danger">삭제</button>
                </div>
            </div>
        </div>
    </div>
</section>
<%@ include file="../include/footer.jsp"%>
<script>
  function deleteBtn(){
            let result = confirm('삭제하시겠습니까?');
            if (result) {
                let recordIds = [];
                $("#message_id").each(function() {
                    recordIds.push($(this).val());
                });
                console.log(recordIds);
                if(recordIds.length != 0){
                    $.ajax({
                    type: "get",
                    url: "/WorkConGW/addBook/receiverDelete",
                    data: { message_id: recordIds},
                    success: function(response) {
                        // 성공적으로 처리된 후에 수행할 작업
                        console.log(response);
                        if(response !== 0){
                            alert('삭제되었습니다');
                            location.href = '/WorkConGW/addBook/receiverList';
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
</script>