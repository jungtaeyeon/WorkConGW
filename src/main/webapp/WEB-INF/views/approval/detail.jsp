<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp"%>

<style>
    .subTitleText{
        margin-bottom: 25px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .subTitleText h2{
        display: flex;
        justify-content: flex-start;
        align-items: center;
        font-size: 27px;
    }
    .subTitleText i{
        font-size: 24px;
        margin-right: 5px;
    }
    .table-bordered td, .table-bordered th{width:180px; font-size: 15px;}
    .theadS{background-color: #e9ecef; text-align: center;}
    .thead{
        background-color: #e9ecef;
        height: 90px;
        width: 140px !important;
        line-height: 90px;
        text-align: center;
    }
    .theadText{text-align: center; line-height: 90px;}
    .formWriter{
        width: 100%;
        height: 500px;
        border: 1px solid #000;
        margin-bottom: 5%;
    }
</style>
<section class="subPageContain">

    <!-- 사이드바 -->
    <%@ include file="./sideBar.jsp"%>

    <!--컨텐츠 영역-->
    <div class="contentConteiner">
        <a id="viewModal" href="#defaultModal" data-toggle="modal" data-target="#defaultModal" style="display: none;"></a>
        <!-- 메인 content -->
        <div id="main-content">
            <div class="container-fluid" style="margin-left: 20px;">
                <!-- 메인 content 넣는 곳 -->
                <div class="row clearfix">

                    <div class="col-12" style="margin-top: 2%; margin-bottom: 3%; " >
                        <div class="h2title" style="font-family: S-CoreDream-4Regular">
                            <h2>전자 결재 양식</h2>
                        </div>
                    </div>
                    <div class="col-12" style=" margin-left: 525px; " >
                            <div class="body xl-slategray" style="border: 1px solid; border-radius: 2%; width: 300px; margin-right: 12%; font-family: InfinitySans-RegularA1" >
                                <div>
                                    <div style="text-align: center;"><i class="fa fa-exclamation-triangle"></i> 반려 사유</div>
                                    <div style="border-top: 1px solid; padding-left: 8px; height: 100px;overflow: auto;width: 300px;white-space: normal;word-break: break-all;">${approval.approval_Cancel_Reason }</div>
                                </div>
                            </div>
                    </div>

                    <div class="btnWrapper col-12" style="margin-bottom: 10px;">
                        <span onclick="toggleFileContent();" style="cursor: pointer; margin-left: 10px;"><i class="fa fa-sort-down" style="font-size: 25px;"></i></span>
                    </div>
                    <div class="col-10" id="fileContent" style="display: none; padding-left: 0;">
                        <div class="card" style="margin-bottom: 10px; overflow-y: scroll; height: 300px; width: 840px; ">
                            <div class="body" style="padding: 0;">
                                <div class="table-responsive" style="box-sizing: content-box;">
                                    <table class="table table-hover center-aligned-table" style="margin-bottom: 0;">
                                        <thead>
                                        <tr>
                                            <th></th>
                                            <th>파일명</th>
                                            <th>확장자</th>
                                            <th>용량</th>
                                            <th></th>
                                            <th>다운로드 횟수</th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                        </thead>

                                        <tbody id="appendTbody" style="overflow: scroll;">
                                        <c:if test="${not empty approval.attachVOList }">
                                            <c:forEach items="${approval.attachVOList }" var="attach">
                                                <tr class="myFileLabels" style="cursor: pointer;" onclick="location.href='getFile?attachPath=${attach.attach_path }';">
                                                    <th></th>
                                                    <th><h5 style="padding-top: 10px;">${attach.attach_name}</h5></th>
                                                    <th><h5 style="padding-top: 10px;">${attach.attach_type}</h5></th>
                                                    <th></th>
                                                    <th></th>
                                                    <th></th>
                                                    <th></th>
                                                </tr>
                                            </c:forEach>
                                        </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>





                    <div class="inside-wrapper" style="border: 1px solid black; padding: 20px; border-radius: 1%;">
                        <!--모달창 -->
                        <div class="modal fade" id="defaultModal" tabindex="-1" role="dialog">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content" style="width:290px;">
                                    <div class="modal-header" style="display: block; text-align: center;">
                                        <h4 class="title" id="defaultModalLabel"></h4>
                                    </div>
                                    <div class="modal-body">
                                        <div class="body text-center">
                                            <div class="chart easy-pie-chart-1 user-photo" id="empPicture" style="width: 100px;height: 100px; border-radius: 50%;"></div>
                                            <h5 id="modalName"></h5>
                                            <h5 id="modalEmail"></h5>
                                            <h5 id="modalSt"></h5>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        ${approval.approval_Content }




                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- 푸터 인클루드 -->
<%@ include file="../include/footer.jsp"%>

<script>

    window.onload=function(){
// 	if($('#docContent > #docContent #d201006JW0203').children().length == 0){
// 		$('#d201006JW0203').css('background-image','url("getSign?sign=201006JW0203.png")');
// 	}else{
// 		$('#docContent > #docContent #d201006JW0203').css('background-image','url("getSign?sign=201006JW0203.png")');
// 	}
        $('#d201006JW0203').css('background-image','url("getSign?sign=201006JW0203.png")');
        $('#docContent > #docContent #d201006JW0203').css('background-image','url("getSign?sign=201006JW0203.png")');
    }

    $("#vacationType option").eq(3).attr("selected",true);
    $(".startDt").val("2021-05-11")
    $(".endDt").val("2021-05-12")
    function empDetailModal(obj) {
        var empId = $(obj).attr("value");
        $.ajax({
            type:"POST",
            url:"<c:url value='/emp/getEmp'/>",
            contentType:"application/json",
            data : empId,
            processData:true,
            success: function(data) {
                var attendStName = data.attendStName;
                var deptName = data.deptName;
                var empEmail = data.empEmail;
                var empHp = data.empHp;
                var officialName = data.officialName;
                var empName = data.empName;
                var empId = data.empId;

                $("#defaultModalLabel").html(deptName);
                $("#modalName").html(empName+' '+officialName);
                $("#modalEmail").html(empEmail);
                $("#modalSt").html(attendStName);
                getPicture(empId);

            },
            error: function(e) {
                console.log(e);
            }
        });
        $("#viewModal").click();
    }

    $(".referBtn").click(function(){
        console.log($(this).children("span"));
        empDetailModal($(this).children("span"));
    });

    function getPicture(empId){

        var imageURL = "/JoinWorkGW/emp/getPicture?picture="+empId+".jpg";
        $('div#empPicture').css({'background-image':'url('+imageURL+')',
            'background-position':'center',
            'background-size':'cover',
            'background-repeat':'no-repeat'
        }).trigger("create");

    }


</script>


<!-- 파일관련 -->
<script>
    function toggleFileContent() {
        if($("#fileContent").css("display") === "none"){
            $("#fileContent").css("display","block");
            return false;
        }
        if($("#fileContent").css("display") === "block"){
            $("#fileContent").css("display","none");
            return false;
        }
    }
</script>
