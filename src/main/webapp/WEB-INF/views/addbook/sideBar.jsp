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
    padding-bottom: 0; 
    font-family: S-CoreDream-4Regular
  }
  .subsubmenu{margin-bottom: 20px;}
  .tab-content a{color: #000;}
  .metismenuLI{
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 3px;
  }
  
  .metismenu:last-child{margin-bottom:0 !important;}
  .metismenu .fa-square{color:#2980b9; margin-right: 5px;}
  .addBookGroupLi:hover .fa-ellipsis{opacity: 1;}
  .fa-ellipsis{cursor: pointer; opacity: 0; transition: opacity 0.5s;}
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
    border-radius: 10px; 
    font-family: InfinitySans-RegularA1;
  }
  .metismenuLI a{
    font-family: S-CoreDream-4Regular; 
    font-size: 20px;
  }
  .metismenuLI .dropdown-item{font-size: 16px; transition: 0.3s; margin-bottom: 0; cursor: pointer;}
  .go_btn{margin-bottom: 15px;}
  .modal.show{background-color: rgba(0, 0, 0, 0.7);}
  .modalBtnGroup{
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  .modalBtnGroup:hover .modalBtn{opacity: 1;}
  .modalBtn{cursor: pointer; color:#000 ; opacity: 0; transition: opacity 0.5s;}
  .addBookGroupInput{
    display: flex;
    align-items: center;
  }
  .addBookGroupInput p{
    margin-bottom: 0;
    margin-right: 5%;
  }
  .addBookGroupInput input{width: auto;}
  .dropdown-item.active, .dropdown-item:active, .dropdown-item:focus, .dropdown-item:hover{
    color: #000;
    text-decoration: none;
    background-color: #eff4fc;
  }
  .treeview{font-size: 14px;}
  </style>
  <script>
    $('input[type="text"]').keydown(function() {
      if (event.keyCode === 13) {
        event.preventDefault();
      };
    });
    const addBookGroupInsert = () => {
      addBookGroupInsertDoubleCheck(1);
    }
    const addBookGroupInsertDoubleCheck = (num) =>{
      let add_book_title = $("input[name='insert_add_book_title']").val();

      console.log(add_book_title);
      
      let DoubleCheck = $("input[name='DoubleCheck']").val();
      if(add_book_title == ''){
        alert("그룹명을 적어주세요.");
      }else{
        $.ajax({
          type : 'get',              
          url : '/WorkConGW/addBook/addBookGroupDoubleCheck',  
          data : {
            add_book_title : add_book_title
          },
          success : function(result) {         
            console.log("result :" +result)
            console.log("num :" +num) 
            console.log("DoubleCheck :" +DoubleCheck)
            if(result == 0 && num == 0){
              alert("생성가능한 그룹명입니다.");
              $("input[name='DoubleCheck']").val(1);
              return;
            }else if(result == 1 && num == 0){
              alert("중복된 그룹명입니다.");
              $("input[name='DoubleCheck']").val(0);
              return;
            }else if(result == 1 && DoubleCheck == 1 && num == 1){
              alert("중복확인을 해주세요.");
              return;
            }else if(result == 0 && DoubleCheck == 1 && num == 1){
              alert("추가되었습니다.");
              document.querySelector("#addBookGroupInsert").submit();
            }else if(result == 1 && DoubleCheck == 0 && num == 1){
              alert("중복된 그룹명입니다.");
              return;
            }
            
          },    
          error : function(request, status, error) {        
            console.log(error)    
          }
        })
      }
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
            <i class="fa-solid fa-plus modalBtn" data-toggle="modal" data-target="#addBookGroupModal"></i>
            <!-- 그룹추가 Modal -->
            <div class="modal fade" id="addBookGroupModal" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
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
                      <div class="addBookGroupInput">
                        <p style="font-size: 18px;">그룹명</p>
                        <input type="hidden" name="DoubleCheck" value="0">
                        <input type="text" name="insert_add_book_title" class="form-control">
                        <button type="button" class="btn btn-primary" onclick="addBookGroupInsertDoubleCheck(0)">중복확인</button>
                      </div>
                    </form>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                    <button type="button" class="btn btn-primary" onclick="addBookGroupInsert()">저장</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
            <ul class="main-menu metismenu addBook">
                <c:forEach var="list" items="${addBookGroupSelect}" varStatus="status">
                    <li id="li_importantSchedule" class="metismenuLI addBookGroupLi">
                      <a href="addBookList?add_book_id=${list.add_book_id}" class="addBookGroupListLink"><i class="fa fa-square" id="importantSchedule"></i><span data-addbookid="${list.add_book_id}">${list.add_book_title}</span></a>
                      <i class="fa-solid fa-ellipsis" id="dropdownMenuButton" data-toggle="dropdown" aria-expanded="false"></i>
                      <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                        <p class="dropdown-item" data-toggle="modal" data-target="#addBookGroupUpdateModal${status.index}">수정</p>
                        <p class="dropdown-item addBookGroupDeleteBtn">삭제</p>
                        <p class="dropdown-item" data-toggle="modal" data-target="#managerModal" onclick="treeviewON('${list.add_book_id}')">공유</p>
                      </div>
                    </li>
                    <!-- 그룹수정 Modal -->
                    <div class="modal fade" id="addBookGroupUpdateModal${status.index}" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="addBookGroupUpdateModal" aria-hidden="true">
                      <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="staticBackdropLabel">그룹수정</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                              <span aria-hidden="true">&times;</span>
                            </button>
                          </div>
                          <div class="modal-body">
                            <form id="addBookGroupUpdate" action="addBookGroupUpdate" method="get">
                              <div class="addBookGroupInput">
                                <p style="font-size: 18px;">그룹명</p>
                                <input type="hidden" name="DoubleCheck" value="0">
                                <input type="hidden" name="add_book_id" value="${list.add_book_id}">
                                <input type="text" name="update_add_book_title" value="${list.add_book_title}" class="form-control">
                                <button type="button" class="btn btn-primary update_add_book_btn">중복확인</button>
                              </div>
                            </form>
                          </div>
                          <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                            <button type="button" class="btn btn-primary update_add_book_submit_btn">수정</button>
                          </div>
                        </div>
                      </div>
                    </div>
                </c:forEach>
            </ul>
        </div>
        <div class="tab-content p-l-0 p-r-0 subsubmenu">
            <div class="modalBtnGroup">
              <!--서브메뉴 타이틀--> 
              <a href="addBookShare">공유주소록</a>
            </div>
            <ul class="main-menu metismenu shareAddBook">
              <c:forEach var="list" items="${shareAddBookGroupSelect}" varStatus="status">
                  <c:if test="${list.share_add_book_yn eq '1'}">
                    <li id="li_importantSchedule" class="metismenuLI addBookGroupLi">
                      <a href="addBookShare?add_book_id=${list.add_book_id}" class="shareAddBookGroupListLink"><i class="fa fa-square" id="importantSchedule"></i><span data-addbookid="${list.add_book_id}">${list.add_book_title}</span></a>
                        <i class="fa-solid fa-ellipsis" id="dropdownMenuButton" data-toggle="dropdown" aria-expanded="false"></i>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                          <p class="dropdown-item shareAddBookGroupDeleteBtn">삭제</p>
                        </div>
                    </li>
                  </c:if>
                </c:forEach>
            </ul>
        </div>
        <div class="tab-content p-l-0 p-r-0 subsubmenu">
          <!--서브메뉴 타이틀-->
            <a href="messageList">메시지</a>
            <ul class="main-menu metismenu shareAddBook">
              <li id="li_importantSchedule" class="metismenuLI addBookGroupLi">
                <a href="messageList" class="shareAddBookGroupListLink"><i class="fa fa-square" id="importantSchedule"></i><span>보낸메세지함</span></a>
              </li>
              <li id="li_importantSchedule" class="metismenuLI addBookGroupLi">
                <a href="receiverList" class="shareAddBookGroupListLink"><i class="fa fa-square" id="importantSchedule"></i><span>받은메세지함</span></a>
              </li>
            </ul>
        </div>
    </div>
</div>
<!-- 공유 Modal -->
<div class="modal fade" id="managerModal" tabindex="-1" role="dialog" style="display: none;" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="title" id="largeModalLabel">조직도 리스트</h4>
      </div>
      <div class="modal-body" style="display: flex; justify-content: center; align-items: center; ">
        <!-- 모달 수신자 등록 폼 -->
        <div style="width: 300px; height: 493px; display: inline-block;">
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
        <div style="width: calc(100% - 305px); height: 440px; display: inline-block; top: 0px;">
          <div class="body" style="padding: 6px;">
            <h4 id="myDutyList">직원 목록</h4>
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
        <button type="button" class="btn btn-primary" id="addEmp">공유</button>
        <button type="button" class="btn btn-secondary"
          data-dismiss="modal" id="closeModal">닫기</button>
      </div>
    </div>
  </div>
</div>
<script>
  $(document).ready(function() {
    // 버튼에 클릭 이벤트 핸들러 추가
    const addBookGroupUpdateDoubleCheck = (num, update_add_book_title, DoubleCheck) =>{
      $.ajax({
          type : 'get',              
          url : '/WorkConGW/addBook/addBookGroupDoubleCheck',  
          data : {
            add_book_title : update_add_book_title
          },
          success : function(result) {         
            console.log("result :" +result)
            console.log("DoubleCheck :" +DoubleCheck)
            console.log("num :" +num)
            if(result == 0 && num == 0){
              alert("생성가능한 그룹명입니다.");
              $("input[name='DoubleCheck']").val(1);
              return;
              
            }else if(result == 1 && num == 0){
              alert("중복된 그룹명입니다");
              return;
            } 
          },    
          error : function(request, status, error) {        
            console.log(error)    
          }
        })
    }
    $('.update_add_book_btn').on('click', function() {
      let update_add_book_title = $(this).parent().find('input[name="update_add_book_title"]').val();
      let DoubleCheck = $(this).parent().find("input[name='DoubleCheck']").val();
      console.log(update_add_book_title);
      if(update_add_book_title == ''){
        alert("그룹명을 적어주세요.");
      }else{
        let submit = addBookGroupUpdateDoubleCheck(0 ,update_add_book_title, DoubleCheck);
      }
    });
    $('.update_add_book_submit_btn').on('click', function() {
      let update_add_book_title_submit = $(this).closest('.modal').find('.modal-body #addBookGroupUpdate .addBookGroupInput input[name="update_add_book_title"]').val();
      console.log(update_add_book_title_submit);
      let DoubleCheck = $(this).closest('.modal').find(".modal-body #addBookGroupUpdate .addBookGroupInput input[name='DoubleCheck']").val();
      
      if(update_add_book_title_submit == ''){
        alert("그룹명을 적어주세요.");
      }else if(DoubleCheck == 0){
        alert("중복확인을 해주세요.");
      }else{
        let modal = $(this).closest('.modal');
        alert("수정되었습니다.");
        // 모달 내부의 폼을 찾아 제출
        modal.find('#addBookGroupUpdate').submit();
      }
  });

    $('.addBookGroupDeleteBtn').on('click', function() {
      let addBookId = $(this).closest('li').find('a.addBookGroupListLink span').data('addbookid');
      let result = confirm('삭제하시겠습니까?');

        // 확인 버튼을 클릭한 경우
        if (result) {
          $.ajax({
            type : 'get',              
            url : '/WorkConGW/addBook/addBookGroupDelete',  
            data : {
              add_book_id : addBookId
            },
            success : function(result) { 
              if(result == 1){
                alert('삭제되었습니다');
                location.reload();
              }
            },    
            error : function(request, status, error) {        
              console.log(error)    
            }
          })
        } else {
            
        }
    });

  $('.shareAddBookGroupDeleteBtn').on('click', function() {
      let addBookId = $(this).closest('li').find('a.shareAddBookGroupListLink span').data('addbookid');
      let result = confirm('삭제하시겠습니까?');

        // 확인 버튼을 클릭한 경우
        if (result) {
          $.ajax({
            type : 'get',              
            url : '/WorkConGW/addBook/shareAddBookGroupDelete',  
            data : {
              add_book_id : addBookId
            },
            success : function(result) { 
              alert('삭제되었습니다');
              location.reload();
            },    
            error : function(request, status, error) {        
              console.log(error)    
            }
          })
        } else {
            
        }
    });
  });

const treeviewON = (status) =>{
  if($("input[name='share_add_book_id']").length !=null){
    $("#managerModal").find(".modal-footer input[name='share_add_book_id']").remove();
  }
  $("#managerModal").find(".modal-footer").append('<input type="hidden" name="share_add_book_id" value="'+status+'">');
}
window.onload = function(){
	deptTrees();
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

$("#addEmp").click(function(){
  let add_book_id = $(this).closest('.modal-footer').find('input[name="share_add_book_id"]').val();
  console.log(add_book_id);
  if(add_book_id == undefined){
    //내부 주소록 추가
    if($('.empListTable .myReceptioner').length == 1){
      let manage_emp_id = $('.myReceptioner').data('empid');
      let manage_name = $('.myChecked').attr('data-name');
      let manage_dept = $('.myChecked').attr('data-dept');
      let manage_official_name = $('.myChecked').attr('data-position');
      let manage_company_name = 'WorkCon';
      $('input[name="manage_emp_id"]').val(manage_emp_id);
      $('input[name="manage_display_name"]').val(manage_name);
      $('input[name="manage_company_name"]').val(manage_company_name);
      $('input[name="manage_dept_name"]').val(manage_dept);
      $('input[name="manage_official_name"]').val(manage_official_name);
      alert('추가되었습니다.');
      $('#managerModal').modal('hide');
    }else{
      alert('직원등록은 한명만 가능합니다.');
    }
  }else{
    //공유 주소록 공유
    let recordIds = [];
    $(this).closest('.modal-content').find('.myReceptioner').each(function() {
      recordIds.push($(this).data('empid'));
    });
    $.ajax({
      type: "get",
      url: "/WorkConGW/addBook/addBookShareInsert",
      data: { add_book_id: add_book_id,
              emp_id : recordIds},
      success: function(response) {
        // 성공적으로 처리된 후에 수행할 작업
        console.log(response);
        alert("공유성공하였습니다.");
        location.reload();
      },
      error: function(xhr, status, error) {
        // 오류 처리
        console.error(xhr.responseText);
      }
    }); 
  }
});
////숨겨놓기끝

//조직도 출력
function deptTrees(){
	$.ajax({
		type:"GET",
		url:"/WorkConGW/orgList",
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
					li = '<li onclick="empChecked(this);" data-deptId="'+deptSupId+'" data-name="'+deptName+" "+position+'" data-dept="'+deptSupName+'" data-state="'+(empState==null ? '' : empState)+'" ondblclick="addEmpList();" id="'+ deptId +'" lvl="'+level +'" class="myChecked" style="cursor:pointer" ><img src="<%=request.getContextPath() %>/js/treeview/images/emp2.png">'+" "+ deptName + " "+e.position+'</li>';
			    }else{
			    	li = '<li id="'+ deptId +'" lvl="'+level +'"><img src="<%=request.getContextPath() %>/js/treeview/images/dept2.png"><a class="file code" style="cursor: pointer;" onclick="myClick(this);" >'+ deptName +'&nbsp&nbsp<i data-id="'+deptId+'" data-name="'+deptName+'" style="color:#383d41; cursor:pointer;"></i></a></li>';
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
	
		for(var i = 0; i < $(".myReceptioner").length ; i++){
			var emp_Id = $(".myReceptioner").eq(i).attr("value");
			if($('.myChecked').attr('id') === emp_Id){
				alert("이미 추가된 참조자입니다.");
				return false;
			}
		}
		
		trTag +=  '<tr class="id_'+$('.myChecked').attr('id')+' myReceptioner" value="'+$('.myChecked').attr('id')+'" data-empid="'+$('.myChecked').attr('id')+'">'
				+"<td>"+$('.myChecked').attr('data-name')+ " " +$('.myChecked').attr('data-position')+"</td>"
				+"<td>"+$('.myChecked').attr('data-dept')+"</td>"
				+'<td style="text-align: center;">'+$('.myChecked').attr('data-state')+"</td>"
				+'<td style="text-align: center;cursor:pointer;" onclick="removeElement(this);"><i class="fas fa-times"></i></td>'
				+"</tr>";
	
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

</script>