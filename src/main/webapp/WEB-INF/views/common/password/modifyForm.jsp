<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>



<head>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/js/treeview/jquery.treeview.css" />
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Font Awesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" integrity="sha512-" crossorigin="anonymous" />
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
    <!-- Summernote -->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>



</head>


<head>
    <title>:: 비밀번호 변경</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta name="description" content="Lucid Bootstrap 4x Admin Template">
    <meta name="author" content="WrapTheme, design by: ThemeMakker.com">

    <style>
        #hiddenFillBtn:hover{background-color: #f4f7f6;}
    </style>
</head>
<button type="button" class="btn btn-outline-light" id="hiddenFillBtn" onclick="presentationFill();" style="position:absolute;right:0;top:0;color:#f4f7f6; z-index: 100; border: 0px;">시연용버튼</button>
<body class="theme-blue" style="font-family: InfinitySans-RegularA1">


<div style="text-align: center; margin: 100px;">
    <div class="card"
         style="width: 550px; padding-top: 20px; right: 30px">
        <div class="body">
            <div class="row clearfix">
                <div class="col-lg-12 col-md-12">
                    <div style="margin-bottom: 40px;">
                        <h6 style="font-size: 20px;">비밀번호 변경</h6>
                        <p class="text-danger" style="font-size: 14px;">영문자, 숫자, 특수문자 최소 1개 포함 8 ~ 20 자리</p>
                    </div>
                    <div class="container-fluid">
                        <div class="row" style="padding-bottom: 23px;">
                            <div class="col-sm-3" >
                                <p style="margin-top: 7px;">기존 비밀번호</p>
                            </div>
                            <div class="col-sm-9">
                                <div class="form-group">
                                    <input type="password" id="oldPwd" class="form-control" placeholder="기존 비밀번호를 입력하세요">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="container-fluid">
                        <div class="row" style="padding-bottom: 23px;">

                            <div class="col-sm-3" >
                                <p style="margin-top: 7px;">새 비밀번호</p>
                            </div>
                            <div class="col-sm-9">
                                <div class="form-group">
                                    <input type="password" id="pwd1" class="form-control"  onclick="" placeholder="영문자,숫자,특수문자 최소 1개 포함 8 ~ 20 자리">
                                </div>
                                <div id="validatePwd" class="float-left">
                                    <span></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="container-fluid">
                        <div class="row" style="padding-bottom: 23px;">
                            <div class="col-sm-3" style="padding-right: 0px;">
                                <p style="margin-top: 7px;">새 비밀번호 확인</p>
                            </div>
                            <div class="col-sm-9">
                                <div class="form-group">
                                    <input type="password" id="pwd2" class="form-control" placeholder="새 비밀번호를 다시 한 번 입력해 주세요">
                                </div>
                                <div id="checkPwd1VsPwd2" class="float-left">
                                    <span></span>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-12 " >
                    <div class="float-right" style="padding-right: 15px;">
                        <button class="btn btn-primary" data-type="success" onclick="updatePwd_go();">확인</button>
                        <button class="btn btn-default" onclick="window.close();">취소</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="<%=request.getContextPath()%>/resources/js/jquery-3.6.0.min.js"></script>

<script>
let flag_vaildate = false;
let flag_compare = false;
// 2가지를 진행해야함
/*
* 1. 유효성 검사
* 2. 디비 값 비교
* */


</script>
<script> // 시연용
function presentationFill(){

    $("#oldPwd").val('123456');
    $("#pwd1").val('ddit406');
    $("#pwd2").val('ddit406!');

}
</script>
</body>
</html>