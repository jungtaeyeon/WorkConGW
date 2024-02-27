<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<style>
    .pagination{
        text-align: center;
        justify-content: center;
    }
.attachList {
   cursor: pointer;
   font-weight: normal;
}
.attachList:hover {
   color: blue;
   text-decoration: underline;
}
</style>


<body>
<%--헤더--%>
<%@ include file="../../include/header.jsp"%>
<section class="subPageContain">
    <%--    사이드바--%>
    <%@ include file="../issueSidebar.jsp"%>
    <div class="contentConteiner">
<!-- 메인 content -->
<a id="viewModal" href="#defaultModal" data-toggle="modal" data-target="#defaultModal" style="display: none;"></a>

<div id="main-content" >
   <div class="container-fluid" >
      <form:form modelAttribute="boardFormVO" name="detailForm" action="${pageContext.request.contextPath }/board/duty/detail">
         <form:hidden path="dutyVO.pageIndex"/>
         <form:hidden path="dutyVO.duty_Board_Id" />
         <form:hidden path="dutyVO.duty_Board_Title"/>
         <form:hidden path="dutyVO.duty_Board_Content"/>
         <form:hidden path="dutyVO.emp_Name"/>
         <form:hidden path="dutyVO.project_Title"/>
         <form:hidden path="dutyVO.duty_Board_Readcnt"/>
         <form:hidden path="dutyVO.duty_Board_End_Dt"/>
         <form:hidden path="dutyVO.project_Id"/>
<%--         <form:hidden path="dutyVO.searchDeadline"/>--%>
         <form:hidden path="dutyVO.dutyBoardCreateDtStr"/>
         <c:forEach items="${duty.dutyEnforcerList }" var="dutyEnforcer" varStatus="status">
            <form:hidden path="dutyVO.dutyEnforcerList[${status.index }].emp_Id" value="${dutyEnforcer.emp_Id }" class="alarmReceiver"/>
            <form:hidden path="dutyVO.dutyEnforcerList[${status.index }].emp_Name" value="${dutyEnforcer.emp_Name }"/>
            <form:hidden path="dutyVO.dutyEnforcerList[${status.index }].attend_St_Name" value="${dutyEnforcer.attend_St_Name }"/>
            <form:hidden path="dutyVO.dutyEnforcerList[${status.index }].dept_Name" value="${dutyEnforcer.dept_Name }"/>
            <form:hidden path="dutyVO.dutyEnforcerList[${status.index }].officialName" value="${dutyEnforcer.officialName }"/>
         </c:forEach>
         <c:forEach items="${duty.dutyAttachList }" var="dutyAttach" varStatus="status">
            <form:hidden path="dutyVO.dutyAttachList[${status.index }].attach_id" value="${dutyAttach.attach_id }" />
            <form:hidden path="dutyVO.dutyAttachList[${status.index }].attach_path" value="${dutyAttach.attach_path }" />
            <form:hidden path="dutyVO.dutyAttachList[${status.index }].attach_name" value="${dutyAttach.attach_name }" />
            <form:hidden path="dutyVO.dutyAttachList[${status.index }].attach_type" value="${dutyAttach.attach_type }" />
         </c:forEach>
         
         <div class="block-header">
               <div class="row">
                  <div class="col-sm-8">
                      <h2 style="padding-left:10px;font-size:2em;font-family: S-CoreDream-6Bold"><i class="fas fa-sticky-note"></i>&nbsp;업무 상세 #${duty.duty_Board_Id } </h2>
                   </div>
                   <div class="col-sm-4" style="font-family: S-CoreDream-6Bold">
                        <div style="float:right;">
                           <c:if test="${loginUser.emp_Id == duty.emp_Writer_Id || loginUser.emp_Id == dutyEnforcer.emp_Id }">
	                            	<button type="button" class="btn btn-info" style="width:80px;" onclick="modify_go();">수정</button>
	                            <button type="button" class="btn btn-danger" style="width:80px;" onclick="remove_go();">삭제</button>
                           </c:if>
                          <button type="button" onclick="window.location.href='<%=request.getContextPath()%>/board/duty/dutyList'" class="btn btn-secondary" style="width:80px;">목록</button>
                      </div>
                   </div>
               </div>
<%--               <div style="padding:5px 15px 0 15px">--%>
<%--               	<c:set value="0" var="readCount"/>--%>
<%--               	<strong>--%>
<%--	                 <c:forEach items="${duty.dutyEnforcerList }" var="dutyEnforcer" varStatus="status">--%>
<%--	                 	<c:if test="${dutyEnforcer.read_St eq 'Y' }">--%>
<%--	                 		<c:if test="${read_Count eq 0 }">--%>
<%--	                 		[--%>
<%--	                 		</c:if>--%>
<%--	                 		${dutyEnforcer.emp_Name }&nbsp;--%>
<%--	                 		<c:set value="${read_Count + 1 }" var="readCount" />--%>
<%--	                 	</c:if>--%>
<%--	                 </c:forEach>--%>
<%--	                 <c:if test="${readCount ne 0}">--%>
<%--	                		읽음 ]--%>
<%--	               	 </c:if>--%>
<%--                </strong>--%>
<%--               </div>--%>
           </div>
           <div class="row clearfix" style="font-family: S-CoreDream-4Regular">
               <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="body">
                        <div class="row clearfix">
                         <div class="table-responsive" style="padding:5px 15px;">
                     <table class="table table-hover m-b-0">
                        <thead class="shadow-none p-3 mb-5 bg-light rounded">
                           <tr>
                              <td style="width:130px;">
                                 <strong>제목</strong>
                              </td>
                              <td colspan="5">
                                 <div style="padding-left:15px;border-left: 1px dotted gray;">${duty.duty_Board_Title }</div>
                              </td>
                           </tr>
                           <tr>
                               <td style="width:130px;">
                                   <strong>프로젝트 이름</strong>
                               </td>
                               <td colspan="5">
                                   <c:if test="${duty.project_Id != 0}">
                                       <div style="padding-left:15px;border-left: 1px dotted gray;">
                                           <button type="button" class="btn btn-outline-secondary" id="project_Id" onclick="goToProjectDetail(${duty.project_Id})">${duty.project_Title}</button>
                                       </div>
                                   </c:if>
                                   <c:if test="${duty.project_Id == 0}">
                                       <div style="padding-left:15px;border-left: 1px dotted gray;">프로젝트 없음</div>
                                   </c:if>
                               </td>
                           </tr>
                           <tr>
                              <td>
                                 <strong>작성자</strong>
                              </td>
                              <td style="width:200px;">
                                 <div style="padding-left:15px;border-left: 1px dotted gray;">
                                     <button type="button" class="btn btn-outline-secondary" id="${duty.emp_Writer_Id }" onclick="empChecked(this);">${duty.emp_Name }</button>
								 </div>
                              </td>
                              <td style="width:130px;">
                                 <strong>수신자</strong>
                              </td>
                              <td colspan="3">
                                 <div style="padding-left:15px;border-left: 1px dotted gray;">
                                    <c:forEach items="${duty.dutyEnforcerList }" var="dutyEnforcer" varStatus="status">
                                        <button type="button" class="btn btn-outline-secondary" id="${dutyEnforcer.emp_Id }" onclick="empChecked(this);">${dutyEnforcer.emp_Name }</button>
                                    </c:forEach>
                                 </div>
                              </td>
                           </tr>
                           <tr>
                              <td>
                                 <strong>참조자</strong>
                              </td>
                              <td colspan="5">
                                 <div style="padding-left:15px;border-left: 1px dotted gray;">
                                 	<c:choose>
                                 		<c:when test="${empty duty.receptionList }">
                                 			<span style="font-weight: normal;">없음</span>
                                 		</c:when>
                                 		<c:otherwise>
											<c:forEach items="${duty.receptionList }" var="receptioner">
                                                <button type="button" class="btn btn-outline-secondary" id="${receptioner.emp_Id }" onclick="empChecked(this);">${receptioner.emp_Name }</button>
											</c:forEach>
                                 		</c:otherwise>
                                 	</c:choose>
                                 </div>
                              </td>
                           </tr>
                           <tr>
                               <td>
                                   <strong>업무 진행률</strong>
                               </td>
                               <td colspan="5">
                                   <div style="padding-left:15px;border-left: 1px dotted gray;">
                                       <!-- 진행률 -->
                                       <c:if test="${dutyProgressVO.progress_percentage eq 0 }">
                                           <c:set var="percentage" value="0"></c:set>
                                       </c:if>
                                       <c:if test="${dutyProgressVO.progress_percentage ne 0 }">
                                           <fmt:parseNumber var="percentage" value="${dutyProgressVO.progress_percentage }" integerOnly="true" />
                                       </c:if>
                                       <div class="progress progress-xs" style="height:20px;margin-top:5px;background-color:rgb(0,0,0,0.2);">
                                           <div class="progress-bar" role="progressbar" aria-valuenow="${percentage }" aria-valuemin="0" aria-valuemax="100" style="width: ${percentage }%; height:20px;">
                                           </div>
                                       </div>
                                       <span><strong style="font-size:1.1em;">${percentage }%</strong> 진행됨</span>
                                       <span style="margin-left:10px;"><strong style="font-size:1.1em;">${dutyProgressVO.todo_issues }</strong> todo</span>
                                       <span style="margin-left:10px;"><strong style="font-size:1.1em;">${dutyProgressVO.inprogress_issues }</strong> inprogress</span>
                                       <span style="margin-left:10px;"><strong style="font-size:1.1em;">${dutyProgressVO.done_issues }</strong> done</span>
                                   </div>
                               </td>
                           </tr>

                           <tr>
                              <td>
                                 <strong>작성일자</strong>
                              </td>
                              <td>
                                 <div style="padding-left:15px;border-left: 1px dotted gray;">
                                    <fmt:formatDate value="${duty.duty_Board_Create_Dt }" pattern="yyyy-MM-dd"/>
                                 </div>
                              </td>
                              <td>
                                 <strong>완료날짜</strong>
                              </td>
                              <td style="width:200px;">
                                 <div style="padding-left:15px;border-left: 1px dotted gray;" id="searchDeadline">
                                 	<c:if test="${!empty duty.duty_Board_End_Dt }">
	                                    <fmt:formatDate value="${duty.duty_Board_End_Dt }" pattern="yyyy-MM-dd"/>
                                 	</c:if>
                                 	<c:if test="${empty duty.duty_Board_End_Dt }">
                                 		<span>없음</span>
                                 	</c:if>
                                 </div>
                              </td>
                              <td style="width:130px;">
                                 <strong>조회수</strong>
                              </td>
                              <td>
                                 <div style="padding-left:15px;border-left: 1px dotted gray;">${duty.duty_Board_Readcnt }</div>
                              </td>
                           </tr>
                           <tr>
                              <th>
                                 <i class="fa fa-download"></i>
                                 <strong>첨부파일</strong>
                              </th>
                              <th colspan="5">
                                 <div style="padding-left:15px;border-left: 1px dotted gray;">
                                    <c:if test="${duty.dutyAttachList.size() > 0 }">
                                       <c:forEach items="${duty.dutyAttachList }" var="dutyAttach">
                                          <span class="attachList" data-attachId="${dutyAttach.attach_id }" data-filePath="${dutyAttach.attach_path }" onclick="fileDownload(this);" style="font-weight: normal; margin-right:15px;">
                                                     <c:choose>
                                                        <c:when test="${dutyAttach.attach_type eq 'JPG' || dutyAttach.attach_type eq 'PNG' || dutyAttach.attach_type eq 'GIF'}">
                                                           <i class="fa fa-file-photo-o"></i>
                                                        </c:when>
                                                        <c:otherwise>
                                                           <i class="fa fa-file-text-o"></i>
                                                        </c:otherwise>
                                                     </c:choose>
                                             &nbsp;${dutyAttach.attach_name }
                                          </span> 
                                       </c:forEach>
                                    </c:if>
                                    <c:if test="${duty.dutyAttachList.size() == 0 }">
                                       <span style="font-weight: normal;">없음</span>
                                    </c:if>
                                 </div>
                              </th>
                           </tr>
                           <!-- 내용 -->
                           <tr>
                              <th colspan="6" style="padding:15px;">
                                 ${duty.duty_Board_Content }
                              </th>
                           </tr>
                        </thead>
                     </table>
                     </div>
                  </div>
                    </div>
               </div>
           </div>
         </form:form>
         
         
        <!-- 댓글 -->
        <div class="card" style="font-family: S-CoreDream-4Regular">
            <div class="body">
                 <span style="font-weight: bold;">댓글 ${paginationInfo.totalRecordCount}</span>
                 <!-- 댓글 등록 -->
                 <div class="body" style="background-color: #eee;margin-top:15px;">
                    <div class="form-group">
                       <textarea id="reply_Content" rows="3" class="form-control no-resize" placeholder="업무에 대한 댓글을 남기세요."></textarea>
                    </div>
                    <div class="post-toolbar-b align-right">
                        <button class="btn btn-primary" onclick="registDutyReply();">등록</button>
                   </div>
                </div>
                <c:if test="${duty.dutyReplyList.size() == 0 }">
                   <hr>
                   <div style="height:70px;text-align: center;padding:10px;">
                      <span>등록된 댓글이 없습니다.</span>
                   </div>
                </c:if>
                <c:if test="${duty.dutyReplyList.size() > 0 }">
                   <c:forEach items="${duty.dutyReplyList }" var="dutyReply">
                      <hr>
                      <div class="container-fluid" id="replyList_${dutyReply.reply_Id }">
                         <div class="row">
                            <div class="col-12">
                                 <p style="font-weight: bold;margin-bottom:5px;display:inline-block;">${dutyReply.emp_Name }</p>
                                 <span style="color:gray;font-size: revert;padding-left:10px;margin-left:10px;border-left:1px solid gray;"><fmt:formatDate value="${dutyReply.reply_Update_Dt }" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                 <c:if test="${loginUser.emp_Id == dutyReply.emp_Id }">
                                    <div class="float-right">
                                        <a href="javascript:void(0);" onclick="modifyReplyForm(${dutyReply.reply_Id},'${dutyReply.reply_Content }');"><i class="fa fa-edit"></i> 수정</a>
                                        <a href="javascript:void(0);" style="margin-left:10px;" onclick="removeReply(${dutyReply.reply_Id});"><i class="fa fa-trash-o"></i> 삭제</a>
                                    </div>
                
                                 </c:if>
                                 <h6 style="margin-bottom:5px;">${dutyReply.reply_Content }</h6>
                             </div>
                         </div>
                      </div>
                   </c:forEach>
                    <div aria-label="Page navigation example" style="height:45px;text-align: center;margin-top:5px;">
                        <div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate" >
                            <ul class="pagination">
                                <c:if test="${boardFormVO.dutyVO.prev}">
                                    <li class="paginate_button page-item previous" id="dataTable_previous">
                                        <a href="javascript:void(0);" onclick="searchDutyReplyList(${boardFormVO.dutyVO.startDate - 1}); return false;" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a>
                                    </li>
                                </c:if>

                                <c:forEach var="num" begin="${boardFormVO.dutyVO.startDate}" end="${boardFormVO.dutyVO.endDate}">
                                    <li class="paginate_button page-item">
                                        <a href="javascript:void(0);" onclick="searchDutyReplyList(${num}); return false;" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">${num}</a>
                                    </li>
                                </c:forEach>

                                <c:if test="${boardFormVO.dutyVO.next}">
                                    <li class="paginate_button page-item next" id="dataTable_next">
                                        <a href="javascript:void(0);" onclick="searchDutyReplyList(${boardFormVO.dutyVO.endDate + 1}); return false;" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Next</a>
                                    </li>
                                </c:if>
                            </ul>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
   </div>
</div>

<form name="fileForm" action="${pageContext.request.contextPath }/common/getFile" method="post">
   <input type="hidden" name="fileUploadPath"/>
   <input type="hidden" name="attachId"/>
</form>

<form name="replyRegistForm">
   <input type="hidden" name="dutyReplyVO.duty_Board_Id" value="${duty.duty_Board_Id }" />
   <input type="hidden" name="dutyReplyVO.emp_Id" value="${loginUser.emp_Id }"/>
   <input type="hidden" name="dutyReplyVO.reply_Content" />
</form>

<script type="text/javascript">
window.onload=function(){

}

function empChecked(obj) {
    var empId = $(obj).attr("id");

    $.ajax({
        type:"POST",
        url:"<c:url value='/emp/getEmp'/>",
        contentType:"application/json",
        data : empId,
        processData:true,
        success: function(data) {
            var attendStName = data.attend_St_Name;
            var deptName = data.dept_Name;
            var empEmail = data.emp_Email;
            var empHp = data.emp_Hp;
            var officialName = data.code_Name;
            var empName = data.emp_Name;
            var empId = data.emp_Id;
            var stSpan = "";
            var empPicture = data.emp_Picture;

            $("#defaultModalLabel").html(deptName);
            $("#modalName").html(empName+' '+officialName);
            $("#modalName").attr("value",empName+' '+officialName);
            $("#modalName").attr("data-empId",empId);
            $("#modalEmail").html(empEmail);
            $("#modalHp").html(empHp);
            if(attendStName === '휴가중'){
                stSpan = "&nbsp<span class='badge badge-warning'>"+attendStName+"</span>";
            }else{
                stSpan = "&nbsp<span class='badge badge-success'>"+attendStName+"</span>";
            }
            $("#modalName").append(stSpan);
            getModalPicture(empPicture);
        },
        error: function(e) {
            console.log(e);
        }
    });
    $("#viewModal").click();
}

function getModalPicture(empPicture){
    var imageURL = "${pageContext.request.contextPath }/pds/empPicture/"+empPicture;
    $('div#emp_Picture').css({'background-image':'url('+imageURL+')',
        'background-position':'center',
        'background-size':'cover',
        'background-repeat':'no-repeat'
    }).trigger("create");
}

function goToProjectDetail(project_Id){
    window.location.href ="<%=request.getContextPath()%>/board/project/detail?project_Id="+project_Id
}

// 파일 다운로드
function fileDownload(obj){
   var fileForm = $('form[name="fileForm"]');
   $('input[name="attachId"]').val($(obj).attr('data-attachId'));
   $('input[name="fileUploadPath"]').val($(obj).attr('data-filePath'));
   fileForm.submit();
}

// 댓글 등록
function registDutyReply(){
   if($.trim($('textarea#reply_Content').val())==""){
      alert('내용을 입력하세요.');
      $('textarea#reply_Content').focus();
      return;
   }
   
   $('input[name="dutyReplyVO.reply_Content"]').val($('textarea#reply_Content').val());
   
   $.ajax({
      url:'<c:url value="/board/duty/reply/regist"/>',
      type:'post',
      data:$('form[name="replyRegistForm"]').serialize(),
      success:function(){
         alert('댓글 등록 완료');
         window.location.reload(true);
      },
      error:function(){
         alert('댓글 등록이 실패했습니다.');
          window.location.reload(true);
      }
   });
}

// 댓글 수정창 표시
function modifyReplyForm(replyId, reply_Content){
   if($('#replyListModify_'+replyId).children().length>0){
      return;
   }
   var modifyForm = '<div id="replyListModify_'+replyId+'" class="body" style="background-color: #eee;margin-top:15px;">'
                   +'<div class="form-group">'
                         +'<textarea id="reply_Content" rows="3" class="form-control no-resize">'+reply_Content+'</textarea>'
                   +'</div>'
                   +'<div class="post-toolbar-b align-right">'
                       +'<button class="btn btn-info" onclick="modifyReply('+replyId+');">수정</button>'
                       +'<button style="margin-left:5px;" class="btn btn-secondary" onclick="modifyCancel('+replyId+');">취소</button>'
                  +'</div>'
               +'</div>'
   $('#replyList_'+replyId).append(modifyForm);
}

// 댓글 수정
function modifyReply(reply_Id){
   var textarea = $('#replyListModify_'+reply_Id+' textarea');
   if($.trim(textarea.val()) == ""){
      alert('내용을 입력하세요.');
      textarea.focus();
      return;
   }
   
   $.ajax({
      url:'<c:url value="/board/duty/reply/modify"/>',
      type:'post',
      data:{'reply_Id':reply_Id,'reply_Content':textarea.val()},
      success:function(){
         alert('댓글이 수정되었습니다.');
         window.location.reload(true);
      },
      error:function(){
         alert('댓글 수정 실패');
         window.location.reload(true);
      }
   });
}

// 댓글 수정 취소
function modifyCancel(reply_Id){
   $('#replyListModify_'+reply_Id).remove();
}

// 댓글 삭제
function removeReply(reply_Id){
   var chk = confirm('댓글을 삭제하시겠습니까?');
   if(!chk) return;
   
   $.ajax({
      url:'<c:url value="/board/duty/reply/remove"/>',
      type:'post',
      data:{'reply_Id':reply_Id},
      success:function(){
         alert('댓글이 삭제되었습니다.');
         window.location.reload(true);
      },
      error:function(){
         alert('댓글 삭제 실패');
          window.location.reload(true);
      }
   });
}

// 댓글 페이지네이션
function searchDutyReplyList(pageNo){
   if(!pageNo){
      pageNo = 1;
   }
   var detailForm = document.detailForm;
   $('input[name="dutyVO.pageIndex"]').val(pageNo);
   detailForm.submit();
}

// 수정 페이지
function modify_go(){
   var dutyModifyForm = document.detailForm;
   dutyModifyForm.action = '${pageContext.request.contextPath }/board/duty/modifyForm';
   
   <%--$('input[name="dutyVO.searchDeadline"]').val('<fmt:formatDate value="${duty.duty_Board_End_Dt }" pattern="yyyy-MM-dd"/>');--%>
   $('input[name="dutyVO.dutyBoardCreateDtStr"]').val('<fmt:formatDate value="${duty.duty_Board_Create_Dt }" pattern="yyyy-MM-dd"/>');
   $('input[name="dutyVO.project_Title"]').val('${duty.project_Title}');

   dutyModifyForm.submit();
}

// 게시글 삭제
function remove_go(){
   var check = confirm('업무 제안글을 삭제하시겠습니까?');
   if(!check) return;
   
   var detailForm = document.detailForm;
   detailForm.action = '${pageContext.request.contextPath }/board/duty/remove';
   
   var form = new FormData(detailForm);
   
   $.ajax({
      url:detailForm.action,
      type:'post',
      data:form,
      processData:false,
      contentType:false,
      success:function(){
         alert('글이 삭제되었습니다.');

         window.location.href="<%=request.getContextPath()%>/board/duty/dutyList"
      },
      error:function(){
         alert('삭제 실패');
      }
   });
}
</script>
        </div>
</section>
</body>