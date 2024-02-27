
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<style>
#boardFormVO {
	padding: 15px 15px;
}
.formGroup {
	display: none;
}
.hiddenFillBtn:hover{background-color: #f4f7f6;}
</style>

<body>
<%--헤더--%>
<%@ include file="../../include/header.jsp"%>
<section class="subPageContain">
	<%--    사이드바--%>
	<%@ include file="../issueSidebar.jsp"%>
		<div class="contentConteiner">
	<div id="main-content">
		<div class="container-fluid">
			<div class="block-header">
				<div class="row">
					<div class="col-sm-3">
						<h2
							style="padding-left: 10px; font-size: 2em; font-family: paybooc-Bold;">
							<i class="far fa-sticky-note"></i>&nbsp;업무 작성
						</h2>
					</div>
					<div class="col-sm-9" style="font-family: S-CoreDream-4Regular">
						<div style="float: right;">
							<button type="button" class="btn btn-primary" style="width: 100px; font-size: 1.2em;" onclick="submit_go();">등록</button>
							<button type="button" onclick="window.location.href='${pageContext.request.contextPath }/board/duty/dutyList'" class="btn btn-secondary" style="width: 100px; font-size: 1.2em;">취소</button>
						</div>
					</div>
				</div>
			</div>

			<div class="row clearfix" style="font-family: S-CoreDream-4Regular">
				<div class="col-lg-12 col-md-12 col-sm-12">
					<div class="card">
						<div class="body">
							<form:form modelAttribute="boardFormVO" name="boardRegistForm">
								<!-- 업무 지시 -->
								<form:hidden path="dutyVO.duty_Board_Title" id="duty_Board_Title" />
								<form:hidden path="dutyVO.duty_Board_Content" id="duty_Board_Content" />
								<form:hidden path="dutyVO.duty_Updater_Id" value="${loginUser.emp_Id }" />
								<form:hidden path="dutyVO.emp_Writer_Id" value="${loginUser.emp_Id }" />
								<form:hidden path="dutyVO.duty_Board_End_Dt" id="duty_Board_End_Dt"/>
								<form:hidden path="dutyVO.project_Id" id="project_Id"/>
								<div id="fileUploadForm"></div>
								<div id="deleteFile"></div>
								<div class="row clearfix">
									<!-- 게시판 선택 -->
									<div class="col-md-3">
										<label>업무선택</label>
										<div class="form-group">
											<select id="selectBoard" class="form-control show-tick"
												onchange="changeCategory(this);">
												<option value="default">업무 선택</option>
												<option value="duty">업무 제안</option>
												<option value="issue">업무 이슈</option>
											</select>
										</div>
									</div>

									<!-- 본문 -->
									<div class="col-md-3 col-sm-12 formGroup dutyForm issueForm ">
										<label class="boardWriter">작성자</label>
										<div class="form-group">
											<input type="text" readonly class="form-control" placeholder="" value="${loginUser.emp_Name }">
										</div>
									</div>
									<div class="col-md-3 col-sm-12 formGroup issueForm">
										<label>관련 업무 번호(선택)</label>
										<div class="form-group">
											<input type="text" id="dutyBoardIdForIssue"
												class="form-control" placeholder="업무 글번호를 입력하세요."
												maxlength="6">
										</div>
									</div>
									<div class="col-md-3 col-sm-12 formGroup issueForm">
										<label>공개 여부 설정</label> <select id="issueBoardStForIssue"
											class="form-control show-tick">
											<option value=1>공개</option>
											<option value=2>비공개</option>
										</select>
									</div>
									<div class="col-md-3  col-sm-12 formGroup dutyForm">
										<div class="form-group">
											<label>완료 기한</label>
											<div class="input-group date" data-date-autoclose="true" data-provide="datepicker">
												<input type="text" style="display: inline-block" class="form-control" id="boardEndDt" placeholder="완료일자 선택" readonly="readonly">
												<div class="input-group-append">
													<button class="btn btn-outline-secondary" type="button">
														<i class="fa fa-calendar"></i>
													</button>
												</div>
											</div>
										</div>
									</div>
									<div class="col-md-3 col-sm-12 formGroup dutyForm ">
										<label class="boardWriter">프로젝트 선택</label>
										<div class="form-group">
											<select id="selectProject" class="form-control show-tick">
												<option value="0">프로젝트 선택</option>
												<c:forEach items="${projectList }" var="project">
													<option style="padding:5px;" value="${project.project_Id }">${project.project_Title }</option>
												</c:forEach>
											</select>
										</div>
									</div>
									<div class="col-sm-12 formGroup dutyForm">
										<div class="form-group">
											<label class="" style="margin-right: 15px;">수신자</label>
											<a href="#largeModal" id="addManager" data-toggle="modal" data-target="#managerModal"> + 수신자 추가하기</a><br>
											<div class="empFinish" id="myEmpFinish">
											</div>
										</div>
									</div>
									<div class="col-sm-12 formGroup dutyForm">
										<div class="form-group">
											<label class="" style="margin-right: 15px;">참조자</label>
											<a href="#largeModal" id="addReceptioner" data-toggle="modal" data-target="#managerModal"> + 참조자 추가하기</a><br>
											<div class="empReception">
											</div>
										</div>
									</div>
									<div class="col-sm-6 formGroup dutyForm issueForm">
										<div class="form-group">
											<label class="boardTitle">제목</label> <input type="text" id="boardTitle" class="form-control" placeholder="">
										</div>
									</div>
								<div class="clearfix" style="width: 100%">

									<div class="col-12 formGroup dutyForm">
										<input type="file" id="fileInput" style="display: none;" />
										<button type="button" class="btn btn-secondary" style="margin-bottom:5px;" onclick="myFileUpload();">파일 추가</button>
										<span class="float-right" style="margin:15px 10px 0 0;">파일 개수 <span id="fileCount">${empty boardFormVO.dutyVO.dutyAttachList ? 0 : boardFormVO.dutyVO.dutyAttachList.size()}</span>/5</span>
										<div style="border:1px solid gray;height:200px;overflow-y: scroll;">
											<table class="table table-hover center-aligned-table" style="margin-bottom: 0;">
												<thead style="height:50px;">
												<tr>
													<th style="width:200px;">타입</th>
													<th style="width:300px;">파일명</th>
													<th style="width:200px;">확장자</th>
													<th style="width:100px;"><i class="fas fa-trash-alt" style="cursor: pointer;" onclick="removeAll();"></i>
													</th>
												</tr>
												</thead>
												<tbody id="appendTbody">
												<!-- 파일 입력 -->
												<c:if test="${!empty boardFormVO.dutyVO.dutyAttachList }">
													<c:forEach items="${boardFormVO.dutyVO.dutyAttachList }" var="dutyAttach" varStatus="status">
														<tr>
															<td>
																<c:choose>
																	<c:when test="${dutyAttach.attach_type eq 'JPG' || dutyAttach.attach_type eq 'PNG' || dutyAttach.attach_type eq 'GIF'}">
																		이미지
																	</c:when>
																	<c:otherwise>
																		파일
																	</c:otherwise>
																</c:choose>
															</td>
															<td style="font-weight: normal;">
																	${dutyAttach.attach_name }
															</td>
															<td style="font-weight: normal;">
																	${dutyAttach.attach_type }
															</td>
															<td>
																<i class="fas fa-times" data-id="${status.index }" data-attach_id="${dutyAttach.attach_id }" style="cursor: pointer;" onclick="removeEl(this)"></i>
															</td>
														</tr>
													</c:forEach>
												</c:if>
												</tbody>
											</table>
										</div>
									</div>

									<!-- 내용 입력 -->
									<div class="col-sm-12 formGroup dutyForm issueForm">
										<div class="summernote" id="summernote" style="height: 200px;"></div>
									</div>
								</div>
							</form:form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>



	<!----------------------------------------------- 모달--------------------------------------------->
	<!-- Modal -->
	<div class="modal fade" id="managerModal" tabindex="-1" role="dialog"
		style="display: none;" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="title" id="largeModalLabel">수신자 추가</h4>
				</div>
				<div class="modal-body">
					<!-- 모달 수신자 등록 폼 -->
					<div style="width: 300px; height: 300px; display: inline-block;">
						<div class="body" style="padding: 6px;">
							<ul class="nav nav-tabs">
								<li class="nav-item"><a class="nav-link show active" data-toggle="tab" href="#org">조직도</a></li>
							</ul>
							<div class="tab-content" style="padding: 0;">
								<!-- 조직도 -->
								<div class="tab-pane show active" id="org">
									<div class="header" style="height: 60px; margin-top: 15px;">
										<input oninput="searchOrg(this);" type="search" class="form-control" placeholder="이름으로 검색" style="display: inline-block; width: 75%;">
										<button type="button" class="btn btn-dark" onclick="searchOrg(this);">
											<i class="fas fa-search"></i>
										</button>
									</div>
									<div class="body" style="overflow-y: scroll; height: 300px;">
										<div>
											<ul id="codeList" class="treeview">
												<li>
													WorkCon 조직도&nbsp
													<ul id="lvl0"></ul>
												</li>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- 수신자 등록 폼 -->
					<div style="width: calc(100% - 305px); height: 300px; display: inline-block; top: 0px;">
						<div class="body" style="padding: 6px;">
							<h4 id="myDutyList">수신자 목록</h4>
							<div class="tab-content" style="padding: 0;">
								<!-- 조직도 -->
								<div class="tab-pane show active" id="org">
									<div class="header" style="height: 60px; margin-top: 15px;">
										<input type="search" id="selectemp_Name" class="form-control" readonly="readonly" placeholder="이름/부서/상태" style="display: inline-block; width: 75%;"> <input type="hidden" id="selectemp_Id">
										<button type="button" class="btn btn-dark" onclick="addEmpList();" style="width: 20%;">
											<i class="fa fa-sort-desc"></i>
										</button>
									</div>
									<div class="body" style="overflow-y: scroll; height: 300px;">
										<div class="table-responsive">
											<table class="table table-hover empListTable">
												<thead>
													<tr>
														<th style="width: 130px;">이름/직위</th>
														<th style="width: 120px;">부서</th>
														<th style="text-align: center;">상태</th>
														<th class="deleteAllEmp" style="cursor: pointer; text-align: center;" onclick="removeAllElement();">
															<i class="fa fa-trash-o"></i>
														</th>
													</tr>
												</thead>
												<tbody>
													<tr class="noEmpList" style="text-align: center; display: none;">
														<td colspan="4">선택된 수신자가 없습니다.</td>
													</tr>
													<tr class="noReceptionList" style="text-align: center; display: none;">
														<td colspan="4">선택된 참조자가 없습니다.</td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="addEmp">추가</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal" id="closeModal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>


	<!-- Javascript -->


	<!-- 업무 이슈 -->
	<form name="issueRegistForm" method="post">
		<input type="hidden" name="issue_Board_Title" />
		<input type="hidden" name="issue_Board_Content" />
		<input type="hidden" name="issue_Board_Updater_Id" value="${loginUser.emp_Id }" />
		<input type="hidden" name="emp_Id" value="${loginUser.emp_Id }" />
		<input type="hidden" name="duty_Board_Id" />
		<input type="hidden" name="issue_Board_St" />
	</form>

	<script>
window.onload = function(){
	var tomorrow = new Date();
	tomorrow.setDate(tomorrow.getDate() + 1); // 내일의 날짜를 가져옴
	$('.date').datepicker({
		startDate: tomorrow, // 내일 이후의 날짜만 선택 가능하도록 설정
	});
	deptTrees();

	var tomorrow = new Date();
	tomorrow.setDate(tomorrow.getDate() + 1); // 내일의 날짜를 가져옴
	$('.date').datepicker({
		startDate: tomorrow, // 내일 이후의 날짜만 선택 가능하도록 설정
	});
}

function myClick(obj){
	$(obj).parent().children("div").click();
}

$("#codeList").treeview({collapsed: false});


// 게시판 그룹 변경시 입력 폼 설정
function changeCategory(obj){
	$('.formGroup').css('display','none');
	$('.boardTitle').text('제목');
	$('.'+obj.value+"Form").css("display",'block');
	
	if(obj.value=='duty'){
		$('.boardTitle').text('업무 제목');
	}
}

// 입력폼 수신자 삭제
function deleteElement(obj){
	console.log($('.'+$(obj).attr('class')));
	$('.'+$(obj).attr('data-class')).remove();
	$(obj).closest('div').remove();
}

//얍시로 숨겨놓기 시작
$("#addManager").click(function(){
	
	$("#largeModalLabel").html("수신자 추가");
	$("#myDutyList").html("수신자 목록");
	$("#managerModal").removeClass("receptionModal");
	$("#managerModal").addClass("managerModal");
	$(".noReceptionList").css("display","none");
	$(".noEmpList").css("display","");
	$(".myReceptioner").css("display","none");
	$(".myManager").css("display","");
	$(".fas fa-redo").css("display","none");
	
	
	if($(".myManager").length > 0){
		$(".noEmpList").css("display","none");
	}

});
$("#addReceptioner").click(function(){
	$("#largeModalLabel").html("참조자 추가");
	$("#myDutyList").html("참조자 목록");
	$("#managerModal").removeClass("managerModal");
	$("#managerModal").addClass("receptionModal");
	$(".noEmpList").css("display","none");
	$(".noReceptionList").css("display","");
	$(".myManager").css("display","none");
	$(".myReceptioner").css("display","");
	$(".fas fa-redo").css("display","");
	
	if($(".myReceptioner").length > 0){
		$(".noReceptionList").css("display","none");
	}

});

$("#addEmp").click(function(){
	if($(".managerModal").length > 0){//수신자 추가일 시
		$(".empEnforcerList").remove();
		
		var tempTag = "";
		for(var i = 0; i < $(".myManager").length; i++){
			tempTag += '<div style="border:1px solid #ced4da;border-radius: 0.25rem;padding:10px 15px;width:150px;display:inline-block;">'
					+'<span>'+$(".myManager").eq(i).find("td").eq(0).text()+'</span>'
					+'<div class="hiddenId manager" style="display:none;" value="'+$(".myManager").eq(i).attr("value")+'"></div>'
					+'<i class="fas fa-times" style="float:right;cursor:pointer;margin-top:5px;" onclick="deleteElement(this);"></i>'
					+'</div>';
		}
		
		$(".empFinish").html(tempTag);
		$("tbody").find(".myManager").remove();
	}else{//참조자 추가일 시
		$(".empReceptionDeptList").remove();
		$(".empReceptionList").remove();
		
		var tempTag = "";
		for(var i = 0; i < $(".myReceptioner").length; i++){
			if($(".myReceptioner").eq(i).hasClass("myReceptionDept")){
				tempTag += '<div class="l-seagreen" style="border:1px solid #ced4da;border-radius: 0.25rem;padding:10px 15px;width:150px;display:inline-block;">'
						+'<span>'+$(".myReceptioner").eq(i).find("td").eq(0).text()+'</span>'
						+'<div class="hiddenId receptionDept" style="display:none;" value="'+$(".myReceptioner").eq(i).attr("value")+'"></div>'
						+'<i class="fas fa-times" style="float:right;cursor:pointer;margin-top:5px;" onclick="deleteElement(this);"></i>'
						+'</div>';
				$(".empReception").html(tempTag);
			}else{
				tempTag += '<div style="border:1px solid #ced4da;border-radius: 0.25rem;padding:10px 15px;width:150px;display:inline-block;">'
						+'<span>'+$(".myReceptioner").eq(i).find("td").eq(0).text()+'</span>'
						+'<div class="hiddenId receptioner" style="display:none;" value="'+$(".myReceptioner").eq(i).attr("value")+'"></div>'
						+'<i class="fas fa-times" style="float:right;cursor:pointer;margin-top:5px;" onclick="deleteElement(this);"></i>'
						+'</div>';
			}
		}
		$(".empReception").html(tempTag);
		$("tbody").find(".myReceptioner").remove();
	}
	
	$("#closeModal").click();
	
});
////숨겨놓기끝

//조직도 출력
function deptTrees(){
	$.ajax({
		type:"GET",
		url:"<c:url value='/orgList' />",
		contentType:"application/json",
	// 	data:dataSet,
		processData:true,
		success: function(data) {
			data.forEach(function(e, i) {
				var deptId = e.deptId;
				var deptName = e.deptName;
			    var deptSupId = e.deptSupId;
			    var position = e.position;
			    var empState = e.empState;
			    var stName = e.empState;
			    var level = 5;
			    var deptSupName = $('li[id="'+deptSupId+'"] a').eq(0).text();
			    var li = "";
			    if(e.level){
					level = e.level;
			    }
			    if(position){
					li = '<li onclick="empChecked(this);" data-deptId="'+deptSupId+'" data-name="'+deptName+" "+position+'" data-dept="'+deptSupName+'" data-state="'+(empState==null ? '' : empState)+'" ondblclick="addEmpList();" id="'+ deptId +'" lvl="'+level +'" class="myChecked" style="cursor:pointer" ><img style ="width:20px; height:20px" src="<%=request.getContextPath() %>/js/treeview/images/emp.png" >'+" "+ deptName + " "+e.position+'</li>';
			    }else{
			    	li = '<li id="'+ deptId +'" lvl="'+level +'"><a class="file code" style="cursor: pointer;" onclick="myClick(this);" >'+ deptName +'&nbsp&nbsp<i data-id="'+deptId+'" data-name="'+deptName+'" style="color:#383d41; cursor:pointer;"></i></a></li>';
			    }
				
				// 1레벨은 그냥 추가
				// 다음 레벨부터는 상위 li의 클래스를 폴더로 바꾸고 자기 자신을 추가
			    if(level == 1) {
					$("#lvl0").append(li);
				} else {
					  var parentLi = $("li[id='"+ deptSupId +"']");
					  
					  parentLi.addClass("expandable lastExpandable");
				      var bUl = parentLi.children("ul");
			   		  
				      // 하위 그룹이 없으면 li로 추가
				      // 하위 그룹이 있으면 ul로 추가
				      if(bUl.length == 0) {
				    	  var div = "<div onclick='plusFromMinus(this);' class='hitarea expandable-hitarea lastExpandable-hitarea'></div>"
				          li = "<ul class='' style='display: none;'>" + li + "</ul>";
				          parentLi.append(div);
				          parentLi.append(li);
				          
				          return false;
				      } else {
				          if(position){
				        	  bUl.prepend(li);
				        	  return false;
				          }
				    	  bUl.append(li);
				      }
			     }
			});
		}
	});
}

//조직도 검색을 위한 함수입니다.
function searchOrg(obj){
	var keyword = $(obj).val();
	if(!keyword){//검색조건이 비어있으면 리턴
		$("#codeList")[0].scrollIntoView();
		$(".myChecked").css("background-color","");
		return false;
	}
	
	$("li:contains('"+keyword+"')").eq(2);
// 	console.log($("li:contains('"+keyword+"')"));
// 	console.log($("li:contains('"+keyword+"')").eq(2)[0]);
	
	var $plusIcon = $("li:contains('"+keyword+"')").eq(2).parent().parent().children("div");//한칸
	var $plusIcon2 = $("li:contains('"+keyword+"')").eq(3).parent().parent().children("div");//한칸이상
	
	if($("li:contains('"+keyword+"')").eq(2).attr("lvl") == 5){
		
		$($plusIcon).parent("li").removeClass("expandable lastExpandable");
		$($plusIcon).parent("li").addClass("collapsable lastCollapsable");
		$($plusIcon).removeClass("hitarea expandable-hitarea lastExpandable-hitarea");
		$($plusIcon).addClass("hitarea collapsable-hitarea lastCollapsable-hitarea");
		$($plusIcon).parent("li").children("ul").css("display","block");
		
		$("li:contains('"+keyword+"')").eq(2)[0].scrollIntoView();
		$("li:contains('"+keyword+"')").eq(2)[0].click();
	}else{
		if($("li:contains('"+keyword+"')").eq(3)[0]){
			$($plusIcon2).parent("li").removeClass("expandable lastExpandable");
			$($plusIcon2).parent("li").addClass("collapsable lastCollapsable");
			$($plusIcon2).removeClass("hitarea expandable-hitarea lastExpandable-hitarea");
			$($plusIcon2).addClass("hitarea collapsable-hitarea lastCollapsable-hitarea");
			$($plusIcon2).parent("li").children("ul").css("display","block");
			
			$("li:contains('"+keyword+"')").eq(3)[0].scrollIntoView();
			$("li:contains('"+keyword+"')").eq(3)[0].click();
		}
		
	}
	
}

//열고 닫는 함수입니다.
function plusFromMinus(obj){
	if($(obj).hasClass("expandable-hitarea")){
		$(obj).parent("li").removeClass("expandable lastExpandable");
		$(obj).parent("li").addClass("collapsable lastCollapsable");
		$(obj).removeClass("hitarea expandable-hitarea lastExpandable-hitarea");
		$(obj).addClass("hitarea collapsable-hitarea lastCollapsable-hitarea");
		$(obj).parent("li").children("ul").css("display","block");
	}else{
		$(obj).parent("li").removeClass("collapsable lastCollapsable");
		$(obj).parent("li").addClass("expandable lastExpandable");
		$(obj).removeClass("hitarea collapsable-hitarea lastCollapsable-hitarea");
		$(obj).addClass("hitarea expandable-hitarea lastExpandable-hitarea");
		$(obj).parent("li").children("ul").css("display","none");
	}
}

function empChecked(obj) {
	//기존 체크된 css 및 클래스 정보 삭제
	$(".myChecked").css("background-color","");
	$("li").removeClass("myChecked");
	
	//새로 체크된 css 및 클래스 정보 갱신
	$(obj).addClass("myChecked");
	$(".myChecked").css("background-color","#2980b9");
	
	$('#selectemp_Name').val($(obj).text().trim());
}

// 업무 수신자 목록으로 추가
function addEmpList(){
	if($('#selectemp_Name').val().trim()==""){
		alert("수신자를 선택하세요.");
		return;
	}
	
	var trTag = "";
	
	if($(".managerModal").length > 0){//수신자 추가시 조건
		for(var i = 0; i < $(".myManager").length ; i++){
			var emp_Id = $(".myManager").eq(i).attr("value");
			if($('.myChecked').attr('id') === emp_Id){
				alert("이미 추가된 수신자입니다.");
				return false;
			}
		}
	
		trTag += '<tr class="id_'+$('.myChecked').attr('id')+' myManager" value="'+$('.myChecked').attr('id')+'">'
				+"<td>"+$('.myChecked').attr('data-name')+"</td>"
				+"<td>"+$('.myChecked').attr('data-dept')+"</td>"
				+'<td style="text-align: center;">'+$('.myChecked').attr('data-state')+"</td>"
				+'<td style="text-align: center;cursor:pointer;" onclick="removeElement(this);"><i class="fas fa-times"></i></td>'
				+"</tr>";
	}else{//참조자 추가시 조건
		for(var i = 0; i < $(".myReceptioner").length ; i++){
			var emp_Id = $(".myReceptioner").eq(i).attr("value");
			if($('.myChecked').attr('id') === emp_Id){
				alert("이미 추가된 참조자입니다.");
				return false;
			}
		}
		
		trTag +=  '<tr class="id_'+$('.myChecked').attr('id')+' myReceptioner" value="'+$('.myChecked').attr('id')+'">'
				+"<td>"+$('.myChecked').attr('data-name')+"</td>"
				+"<td>"+$('.myChecked').attr('data-dept')+"</td>"
				+'<td style="text-align: center;">'+$('.myChecked').attr('data-state')+"</td>"
				+'<td style="text-align: center;cursor:pointer;" onclick="removeElement(this);"><i class="fas fa-times"></i></td>'
				+"</tr>";
	}
	$('.empListTable tbody').append(trTag);
	if($(".myManager").length > 0){
		$(".noEmpList").css("display","none");
	}
	
	if($(".myReceptioner").length > 0){
		$(".noReceptionList").css("display","none");
	}
}

// 업무 수신자 리스트에서 삭제
function removeElement(obj){
	$(obj).closest('tr').remove();
	
	if($('.empListTable tbody').children().length==1){
		$('.noEmpList').css('display','');
	}
}

// 업무 수신자 리스트 전체 삭제
function removeAllElement(){
	var check = confirm('수신자 목록을 비우시겠습니까?');
	if(!check){
		return;
	}
	$('form[name="temp"]').children().remove();
	$('.empListTable tbody').children().each(function(index,item){
		if(index==0){
			return true;
		}
		$(this).remove();
	})
	$('.noEmpList').css('display','');
}

// 글 등록
function submit_go(){
	var boardCategory = $('#selectBoard').val();
	var form = document.boardRegistForm;
	
	if(boardCategory=='default'){
		alert('업무를 선택하세요.');
		return;
	}
	if($.trim($('#boardTitle').val())==""){
		alert('제목을 입력하세요.');
		$('#boardTitle').focus();
		return;
	}

	// 업무 제안
	if(boardCategory=='duty'){	
		if($('.empFinish').children().length==0){
			alert('수신자를 한 명 이상 선택하세요.');
			return;
		}
		if($.trim($('.note-editable').text())==""){
			alert('업무 내용을 입력하세요.');
			$('.note-editable').focus();
			return;
		}
	
		if($.trim($('#boardEndDt').val())==""){
			alert('완료 기한을 선택하세요.');
			$('#boardEndDt').focus();
			return;
		}
		$('#duty_Board_Title').val($('#boardTitle').val());
		$('#duty_Board_Content').val($('.note-editable').html());
		$('#duty_Board_End_Dt').val($('#boardEndDt').val());
		$('#project_Id').val($('#selectProject').val());
		
		// 수신자 추가
		for(var i = 0; i < $(".manager").length; i++){
			var emp_Id = $(".manager").eq(i).attr('value');
			var inputTag1 = '<input class="empEnforcerList" type="hidden" name="dutyVO.empEnforcerList" value="'+emp_Id+'"/>'
			$(form).append(inputTag1);
		}
		
		// 참조자 추가
		if($('.receptioner').length > 0){
			for(var i = 0; i < $(".receptioner").length; i++){	
				var emp_Id = $(".receptioner").eq(i).attr('value');
				var inputTag3 = '<input class="empReceptionList" type="hidden" name="dutyVO.empReceptionList" value="'+emp_Id+'"/>'
				
				$(form).append(inputTag3);
			}
		}
		form.encoding = 'multipart/form-data';
		form.action = "<c:url value='/board/duty/regist'/>";
	}
	// 업무 이슈 게시판
	else if(boardCategory=='issue'){
		if($.trim($('#dutyBoardIdForIssue').val())==""){
			alert('업무 번호를 입력해주세요.');
			$('#dutyBoardIdForIssue').focus();
			return;
		}
		if($.trim($('#dutyBoardIdForIssue').val())!=""){
			var dutyBoardIdForIssue = $('#dutyBoardIdForIssue').val();
			// 숫자가 아닌 경우 얼럿 띄우기
			if (!$.isNumeric(dutyBoardIdForIssue)) {
				alert('업무 번호는 숫자만 입력가능합니다.');
				$('#dutyBoardIdForIssue').focus();
				return;
			}
		}
		
		if($.trim($('.note-editable').text())==""){
			alert('이슈 내용을 입력하세요.');
			$('.note-editable').focus();
			return;
		}
		
		$('input[name="issue_Board_Title"]').val($('#boardTitle').val());
		$('input[name="issue_Board_Content"]').val($('.note-editable').html());
		$('input[name="issue_Board_St"]').val($('#issueBoardStForIssue').val());
		
		if($.trim($('#dutyBoardIdForIssue').val())==""){
			$('input[name="duty_Board_Id"]').remove();
		}else{
			$('input[name="duty_Board_Id"]').val($('#dutyBoardIdForIssue').val());
		}
		
		form = document.issueRegistForm;
		form.action="<c:url value='/board/issue/regist'/>";
	}
	else{
		return;
	}
	
	// 글 등록
	var formData = new FormData(form);
	$.ajax({
		url:form.action,
		type:'post',
		data:formData,
		processData:false,
		contentType:false,
		dataType:"text",
		success:function(data){
			if(boardCategory=='issue'){
				alert("이슈가 등록되었습니다.");
				window.location.href='<c:url value="/board/issue/list" />';
				
			}else if(boardCategory=='duty'){
				alert("업무가 등록되었습니다.");
					window.location.href='<c:url value="/board/duty/dutyList" />';
			}
		},
		error:function(){
			alert("글 등록에 실패했습니다.");
			window.opener.location.reload(true);
		}
	});
}

</script>

<%--			파일 처리--%>
<script>

//파일 삭제용 고유 아이디
var uuid = ${empty boardFormVO.dutyVO.dutyAttachList ? 0 : boardFormVO.dutyVO.dutyAttachList.size()};

// 파일 업로드 버튼 클릭시
function myFileUpload() {
	// document.getElementById('fileInput').click();
	if($('#appendTbody').children().length == 5){
		alert('파일은 5개까지만 첨부할 수 있습니다.');
		return;
	}

	// 선택 안된 파일 지우기
	$('.attach_'+uuid).remove();

	var input = $('<input>').attr({"type":"file",'class':'attach_'+uuid,"name":"fileUploadCommand.uploadFile",'onchange':'myFileChange();'}).css('display','none');
	$("#fileUploadForm").append(input);

	// 파일 선택
	var inputFileTag = $("input[name='fileUploadCommand.uploadFile']");
	inputFileTag.eq(inputFileTag.length-1).click();

}
//파일 선택시
function myFileChange(){
	var inputFileTag = $("input[name='fileUploadCommand.uploadFile']");
	var filesLength = inputFileTag.length;

	var fileName = inputFileTag.eq(filesLength-1)[0].files[0].name;
	var extension = getExtensionOfFilename(fileName);
	var fileSize = (inputFileTag.eq(filesLength-1)[0].files[0].size / 1000) / 1000; // MB
	var fileType;

	if(fileSize > 50){
		alert("50MB 이하로 업로드해 주세요.");
		inputFileTag.eq(filesLength-1).remove();
		return;
	}

	if(!(extension == 'PNG' || extension == 'DOC' || extension == 'DOCX' || extension == 'GIF' || extension == 'JAVA' || extension == 'JPG' || extension == 'PDF'|| extension == 'PPT' || extension == 'PPTX'|| extension == 'TXT' || extension == 'XLSX'|| extension == 'ZIP')){
		alert("지원하지 않는 파일 형식입니다.");
		inputFileTag.eq(filesLength-1).remove();
		return;
	}
	if(extension == 'PNG' || extension == 'GIF' || extension == 'JPG'){
		fileType = '이미지';
	}else{
		fileType = '파일';
	}

	// 파일 업로드 창에 표시하기
	var fileTag = '<tr>'
			+'<td>'+fileType+'</td>'
			+'<td style="font-weight: normal;">'+fileName+'</td>'
			+'<td style="font-weight: normal;">'+extension+'</td>'
			+'<td><i class="fas fa-times" data-id="'+uuid+'" style="cursor: pointer;" onclick="removeEl(this)"></i></td>'
			+'</tr>';
	$('#appendTbody').append(fileTag);

	// 파일개수 수정
	$('#fileCount').text($('#appendTbody').children().length);

	$('#noFile').remove();

	uuid++;
}

//파일 확장자 추출 함수
function getExtensionOfFilename(filename) {

	var _fileLen = filename.length;

	var _lastDot = filename.lastIndexOf('.');

	var _fileExt = filename.substring(_lastDot+1, _fileLen).toUpperCase();

	return _fileExt;
}

//파일 전체 삭제
function removeAll(){
	if($('#appendTbody').children().length == 0) return;

	var check = confirm('파일을 전부 삭제하시겠습니까?');
	if(!check) return;

	$("input[name='fileUploadCommand.uploadFile']").remove();
	$('#appendTbody').children().each(function(){
		if($(this).find('i').attr('data-attach_id')){
			$('#deleteFile').append('<input type="hidden" name="fileUploadCommand.deleteFileIds" style="display:none;" value="'+$(this).find('i').attr('data-attach_id')+'"/>');
		}
		$(this).remove();
	});

	$('#attachInline').children().remove();
	$('#attachInline').append('<span id="noFile" style="font-weight: normal;">없음</span>');

	// 파일개수 수정
	$('#fileCount').text(0);
}

// 선택 파일 삭제
function removeEl(obj){
	var check = confirm('파일을 삭제하시겠습니까?');
	if(!check) return;

	if($(obj).attr('data-attach_id')){
		$('#deleteFile').append('<input type="hidden" name="fileUploadCommand.deleteFileIds" style="display:none;" value="'+$(obj).attr('data-attach_id')+'"/>');
	}

	$(obj).closest('tr').remove();
	$(".attach_"+$(obj).attr('data-id')).remove();

	// 파일개수 수정
	$('#fileCount').text($('#appendTbody').children().length);
}


</script>
</div>
</section>
</body>
