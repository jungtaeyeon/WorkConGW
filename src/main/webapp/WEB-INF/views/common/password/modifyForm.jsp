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


$(document).on("input","#pwd1",function (){
    //비밀번호는 8자 이상, 20자 이하
    //적어도 한 개의 알파벳(대소문자 모두)이 포함
    //적어도 한 개의 숫자가 포함
    //적어도 한 개의 특수 문자가 포함
    let pwPattetn =  /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+])(?!.*[^a-zA-z0-9$`~!@$!%*#^?&\\(\\)\-_=+]).{8,20}$/;
    let vaildateStr = "";
    let pwd1 = $('#pwd1').val();
    let pwd2 = $('#pwd2').val();
    let str = "";

    if(pwd2)
    {
        if(pwd2 === pwd1 && pwd2 != null)
        {
            str = "<span></span>"
            flag_compare = true
        }
        if(pwd2 !== pwd1)
        {
            str = '<span style="color: red">입력한 비밀번호가 서로 일치하지 않습니다.</span>'
            flag_compare = true
        }
        $("#checkPwd1VsPwd2").html(str);
    }


    if(!pwPattetn.test(pwd1)&&pwd1!="")
    {
        vaildateStr = "<span style='color: red'>사용불가</span>"
        flag_vaildate = false;
    }
    else{
        vaildateStr = "<span style='color: blue'>안전</span>"
        flag_vaildate = true
        if(pwd1.length >= 12)
        {
            vaildateStr = "<span style='color: green'>매우안전</span>"
            flag_vaildate = true;
        }
    }


    if(pwd1=="")
    {
        vaildateStr = "<span></span>"
        flag_vaildate = false;
    }

    $("#validatePwd").html(vaildateStr);

})


$(document).on("input","#pwd2",function (){

    let pwd1 = $("#pwd1").val();
    let pwd2 = $("#pwd2").val();
    str = "";

    if(pwd2 === pwd1 && pwd2 != null)
    {
        str = "<span style='color: blue'>입력한 비밀번호가 서로 일치합니다.</span>"
        flag_compare = true;
    }

    if(pwd2 !== pwd1)
    {
        str = "<span style='color: red'>입력한 비밀번호가 서로 일치하지 않습니다.</span>"
        flag_compare = false;
    }

    $("#checkPwd1VsPwd2").html(str);

})


function updatePwd_go()
{
    let msg ="";
    let emp_Pwd = $("#oldPwd").val();
    let empVO = {"emp_Pwd":emp_Pwd}

    if(flag_vaildate && flag_compare)
    {
        // 둘 다 true 라면

        $.ajax({
            type : "post",
            url : '<%=request.getContextPath()%>/emp/compareEmpPwd',
            contentType : "application/json",
            async : false,
            data : JSON.stringify(empVO),
            success : function (data)
            {
                console.log(data)
                msg = data;
            },
            error: function (e){
                console.log(e)
            }
        });


        if(msg ==='fail')
        {
            alert('기존 비밀번호와 다릅니다. 다시 확인해주세요')
            return false;
        }


    }else{
        alert('새로운 비밀번호의 유효성을 확인해주세요.')
        return false
    }
    empVO.emp_Id = $("#emp_Id").val()
    empVO.emp_Pwd = $("#pwd2").val()
    $.ajax({
        type:"post",
        url: '<%=request.getContextPath()%>/emp/updateEmpPwd',
        contentType : "application/json",
        async : false,
        data:JSON.stringify(empVO),
        success:function (data)
        {
            console.log(data)
        },
        error : function (e)
        {
            console.log(e);
        }
    });

    opener.parent.flag_empUpdate = true;
    alert('비밀번호가 변경되었습니다.')
    window.close()




}


</script>

</body>
</html>