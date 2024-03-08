<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<style>
    .card{
        padding-bottom: 30px;
    }

    .body{
        padding-top: 15px;
        padding-left: 17px;
        padding-right: 17px;
    }
    .subTitleText h2 {
        display: flex;
        justify-content: flex-start;
        align-items: center;
        font-size: 27px;
        padding: 10px 0;
        font-family: "Noto Sans KR", sans-serif;
      }
      .subTitleText i {
        font-size: 24px;
        margin-right: 5px;
      }
</style>

<body>
<%@ include file="../../include/header.jsp"%>
<section class="subPageContain">
<%@ include file="../sideBar.jsp"%>
<!-- 메인 content -->
<div id="main-content" style="width: 100%;">
    <div class="container-fluid" style="font-family: S-CoreDream-4Regular" >
        <div class="row clearfix" >
            <div class="col-12"  >
                <div class="row">
                    <div class="col-sm-5">
                        <div class="subTitleText">
                            <h2>
                              <i class="fa-solid fa-angles-right"></i>회의실민원
                            </h2>
                        </div>
                    </div>
                    <div class="col-sm-7" style="display: flex; justify-content: flex-end; align-items: center;">
                        <div>
                            <button type="button" onclick="goBack();" class="btn btn-secondary" style="width:80px;">닫기</button>
                        </div>
                    </div>
                </div>
                <hr>
            </div>
        </div>
        <div class="div2">
            <div class="row clearfix">
                <div class="col-lg-12 col-md-12">
                    <div class="card" style="padding-bottom:0px;">
                        <div class="body project_report" style="width: 100%; padding: 15px 17px; font-size: 16px;">
                            <div>  
                                <strong>${complain.meet_Room_Id}</strong>
                                <span> | ${complain.emp_Name } ${complain.official_Name }</span>
                            </div>
                            <hr>

                            <!-- 내용 -->
                            <div style="margin-top: 20px;">${complain.complain_Content}</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>

<script>
    function goBack() {
        window.history.back();
    }
</script>