<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Popper.js CDN -->
<script
  src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
  integrity="sha512-ldc1sPu1FZ8smgkgp+HwnYyVb1eRn2wEmKrDg1JqPEb02+Ei4kNzDIQ0Uwh0AJVLQFjJoWwG+764x70zy5Tv4A=="
  crossorigin="anonymous"
  referrerpolicy="no-referrer"
></script>
<!-- Bootstrap CSS, js CDN -->
<link
  rel="stylesheet"
  href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
/>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- FontAwesome -->
<script
  src="https://kit.fontawesome.com/3a92c85ff9.js"
  crossorigin="anonymous"
></script>
<!-- TreeView -->
<link
  rel="stylesheet"
  href="<%=request.getContextPath() %>/js/treeview/jquery.treeview.css"
/>
<link
  rel="stylesheet"
  href="<%=request.getContextPath() %>/js/treeview/screen.css"
/>
<script src="<%=request.getContextPath() %>/js/treeview/jquery.treeview.js"></script>
<!-- Summernote -->
<link
  href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css"
  rel="stylesheet"
/>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
<!-- Bootstrap Datepicker CSS, JS CDN -->
<link
  rel="stylesheet"
  href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/css/bootstrap-datepicker.min.css"
  integrity="sha512-34s5cpvaNG3BknEWSuOncX28vz97bRI59UnVtEEpFX536A7BtZSJHsDyFoCl8S7Dt2TPzcrCEoHBGeM4SUBDBw=="
  crossorigin="anonymous"
  referrerpolicy="no-referrer"
/>
<script
  src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/js/bootstrap-datepicker.min.js"
  integrity="sha512-LsnSViqQyaXpD4mBBdRYeP6sRwJiJveh2ZIbW41EBrNmKxgr/LFZIiWT6yr+nycvhvauz8c2nYMhrP80YhG7Cw=="
  crossorigin="anonymous"
  referrerpolicy="no-referrer"
></script>
<!-- common.js -->
<script src="<%=request.getContextPath() %>/js/common.js"></script>

<body>
  <style>
    .subTitleText h2 {
      display: flex;
      justify-content: flex-start;
      align-items: center;
      font-size: 27px;
      font-family: "Noto Sans KR", sans-serif;
    }
    .subTitleText i {
      font-size: 24px;
      margin-right: 5px;
    }
  </style>
  <!-- 헤더인클루드 -->
  <%@ include file="../include/header.jsp"%>
  <section class="subPageContain">
    <!-- 사이드바 -->
    <%@ include file="./sideBar.jsp"%>
    <!--컨텐츠 영역-->
    <div class="contentConteiner">
      <div class="wrapper">
        <!-- 메인 content -->
        <div id="main-content">
          <div class="container-fluid" style="font-size: 16px; padding-left: 0">
            <div class="row clearfix" style="margin-bottom: 1%">
              <div class="col-12" style="padding: 0">
                <div class="subTitleText">
                  <!--컨텐츠 부분 타이틀 클래스(이건 부트스트랩 클래스 아니고 임의로 만든 클래스)-->
                  <h2>
                    <i class="fa-solid fa-angles-right"></i>
                    <!--왼쪽 아이콘 폰트어썸-->결재양식선택
                  </h2>
                </div>
              </div>
            </div>

            <div
              class="inside-wrapper"
              style="
                padding: 0 3% 3% 0;
                background-color: white;
                border-radius: 2%;
                box-shadow: 0 1px 2px 0 rgb(0 0 0 / 10%);
                font-family: S-CoreDream-4Regular;
              "
            >
              <div class="row clearfix">
                <div class="col-12"></div>
              </div>
              <!-- 메인 content 넣는 곳 -->
              <div class="row clearfix">
                <div class="col-6">
                  <div class="card">
                    <div class="body" style="overflow: auto; height: 300px">
                      <div>
                        <ul id="codeList">
                          <li>
                            결재양식
                            <ul id="lvl0"></ul>
                          </li>
                        </ul>
                      </div>
                    </div>
                  </div>
                </div>

                <div class="col-6">
                  <div class="card" style="height: 300px; padding: 5px 15px">
                    <div class="header">
                      <h5>상세정보</h5>
                    </div>
                    <div class="body">
                      <div style="margin-bottom: 20px">
                        <p style="margin-bottom: 0">양식제목</p>
                        <span id="formName"></span>
                      </div>

                      <div style="margin-bottom: 20px">
                        <p style="margin-bottom: 0">기안자</p>
                        <span id="empName"></span>
                      </div>
                      <div style="margin-bottom: 20px">
                        <p style="margin-bottom: 0">기안자 팀/부서</p>
                        <span id="deptName"></span>
                      </div>
                      <div style="display: none">
                        <p style="margin-bottom: 0">양식아이디</p>
                        <span id="myFormId"></span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="row clearfix">
                <div class="col-12">
                  <button
                    type="button"
                    class="btn btn-dark float-right"
                    style="width: 100px"
                    onclick="window.close();"
                  >
                    취소
                  </button>
                  <button
                    type="button"
                    class="btn btn-dark float-right"
                    style="width: 100px; margin-right: 10px"
                    onclick="getForm_go();"
                  >
                    확인
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- 푸터 인클루드 -->
  <%@ include file="../include/footer.jsp"%>

  <!-- 공통모듈 -->
  <script>
        function deptTrees() {
            $.ajax({
                type: "GET",
                url: "<%=request.getContextPath()%>/getFormTreeView",
                contentType: "application/json",
                processData: true,
                success: function(data) {
                    console.log(data);
                    data.forEach(function(e, i) {
                        let formId = e.form_Id;
                        let formName = e.form_Name;
                        let formSupId = e.form_sup_id;
                        let level = 5;
                        let li = "";

                        console.log(formId);
                        console.log(formName);
                        console.log(formSupId);

                        if(e.level){
                            level = e.level;
                        }
                        if(formSupId != 0){
                            li = '<li onclick="formDetail(this);" id="' + formId + '" data-type="supervisor" lvl="' + level + '"><img src="<%=request.getContextPath() %>/js/treeview/images/file.gif"><a class="file code myHover" id="t1">' + " " + formName +'</a></li>';}
                        else{
                        }
                        if (level === 1) {
                            $("#lvl0").append(li);
                        } else {
                            var parentLi = $("li[id='" + formSupId + "']");
                            console.log('여기를 타니?')

                            parentLi.addClass("expandable lastExpandable");
                            var bUl = parentLi.children("ul");

                            // 하위 그룹이 없으면 li로 추가
                            // 하위 그룹이 있으면 ul로 추가
                            if (bUl.length === 0) {
                                var div = "<div onclick='plusFromMinus(this);' class='hitarea expandable-hitarea lastExpandable-hitarea'></div>"
                                li = "<ul class='' style='display: none;'>" + li + "</ul>";
                                parentLi.append(div);
                                parentLi.append(li);
                            } else {
                                bUl.append(li);
                            }
                        }
                    });
                }
            });
        }


        function formDetail(obj)
        {
            let formId = $(obj).attr("id"); // id값을 가져옴

            $.ajax({
                 type:"post",
                 url : "<c:url value="getForm"/>",
                 contentType: "application/json",
                 data : formId,
                 success : function (data)
                 {
                     console.log(data)
                     let empName = data.emp.emp_Name+" "+data.emp.code_Name;
                     let deptName = data.emp.dept_Name;
                     let formName = data.form.form_Name;
                     let formId = data.form.form_Id;
                     console.log(formId)

                     $("#empName").html(empName);
                     $("#deptName").html(deptName);
                     $("#formName").html(formName);
                     $("#myFormId").html(formId);
                 }
            })
        }


    function getForm_go()
    {
        let formId = $("#myFormId").html();
        console.log(formId)

        if(!formId){
            alert('양식을 선택하세요.')
            return false;
        }else if(formId =='1'){
            alert('하위계획서를 클릭해주세요')
            return false;
        }else if(formId !=='2'){
            alert('준비중입니다.')
            return false;
        }

        location.href = "<%=request.getContextPath()%>/approval/docDetail?form_Id="+formId;

    }



        function plusFromMinus(obj){
            let parentLi = $(obj).parent("li");
            let deptId = parentLi.attr("id");
            if($(obj).hasClass("expandable-hitarea")){
                $(obj).parent("li").removeClass("expandable lastExpandable");
                $(obj).parent("li").addClass("collapsable lastCollapsable");
                $(obj).removeClass("hitarea expandable-hitarea lastExpandable-hitarea");
                $(obj).addClass("hitarea collapsable-hitarea lastCollapsable-hitarea"); // (-)
                $(obj).parent("li").children("ul").css("display","block");
            }else{
                $(obj).parent("li").removeClass("collapsable lastCollapsable");
                $(obj).parent("li").addClass("expandable lastExpandable"); // 총무1팀
                $(obj).removeClass("hitarea collapsable-hitarea lastCollapsable-hitarea");
                $(obj).addClass("hitarea expandable-hitarea lastExpandable-hitarea"); //(+) 총무부
                $(obj).parent("li").children("ul").css("display","none");
            }
        }

        window.onload = function(){
            deptTrees();
    // 	getOrgChart();
            //부서클릭시 부서에 속한 직원 상세조회
        }

        $("#codeList").treeview({collapsed: false});
  </script>
</body>
