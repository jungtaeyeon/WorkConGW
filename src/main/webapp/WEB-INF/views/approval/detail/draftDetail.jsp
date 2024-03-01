<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../../include/header.jsp"%>

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
    .thead{
        background-color: #e9ecef;
        height: 90px;
        width: 140px !important;
        line-height: 90px;
        text-align: center;
    }
    .theadText{text-align: center; line-height: 90px;}
    .formWriter {
        width: 100%;
        max-width: 900px; /* 원하는 너비로 조정 */
        height: auto; /* 필요에 따라 높이를 자동으로 조정하거나 고정할 수 있습니다. */
        border: 1px solid #000;
        margin: 0 auto; /* 좌우 마진을 자동으로 설정하여 요소를 가운데 정렬합니다. */
        padding: 10px; /* 박스 내부 여백을 조정합니다. */
        text-align: center; /* 내부 텍스트를 가운데 정렬합니다. */
    }


    /* 파일 첨부 관련 CSS */
    #fileInput {
        display: none;
    }

    .float-right {
        float: right;
    }

    .noticeForm {
        margin-top: 10px;
    }

    .noticeForm .table {
        margin-bottom: 0;
    }

    .noticeForm .table thead th,
    .noticeForm .table tbody td {
        vertical-align: middle;
    }

    .noticeForm .table tbody td i {
        cursor: pointer;
    }

    .noticeForm .table tbody td i:hover {
        color: red;
    }

    #approval-line {
        padding: 2% 0 1% !important;
        border: currentColor;
        text-align: left;
        color: black;
        font-size: 12px;
        font-weight: normal;
        vertical-align: top;
        width: 100%;
    }
</style>
<a id="previewModal" href="#defaultModal" data-toggle="modal" data-target="#preModal" style="display: none;"></a>
<a id="return-reason" href="#smallModal" data-toggle="modal" data-target="#smallModal" style="display: none;"></a>
<section class="subPageContain">

    <!-- 사이드바 -->
    <%@ include file="../sideBar.jsp"%>

    <!--컨텐츠 영역-->
    <div class="contentConteiner">
        <div class="subTitleText"> <!--컨텐츠 부분 타이틀 클래스(이건 부트스트랩 클래스 아니고 임의로 만든 클래스)-->
            <h2><i class="fa-solid fa-angles-right"></i> <!--왼쪽 아이콘 폰트어썸-->결재대기문서</h2>
            <div class="btnGroup">
                &nbsp
                <button type="button" class="btn btn-dark myBtn" style="width: 100px; opacity: 0.3;" onClick="location.href='<%=request.getContextPath()%>/approval/lists/draftList'">목록으로</button>

            </div>
        </div>


        <div class="modal fade" id="smallModal" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="title" id="smallModalLabel">반려 이유</h4>
                    </div>
                    <div class="modal-body" >
                        <textarea id="reason-content" rows="10" cols="35" style="border: 0;"></textarea>
                    </div>
                    <div class="modal-footer">
                        <p>*반려이유는 기안자에게 전달됩니다.</p>
                        <button id="reason_y" type="button" class="btn btn-primary" onclick="reason_y();">확인</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="reason_n();">닫기</button>
                        <button id="modal-off" type="button" class="btn btn-danger" data-dismiss="modal" style="display: none;">닫기</button>
                    </div>
                </div>
            </div>
        </div>

        <form>


            <div class="formWriter">

                <table style="border: 0px solid rgb(0, 0, 0); width: 800px; font-family: malgun gothic,dotum,arial,tahoma; margin-top: 1px; border-collapse: collapse;"><!-- Header --><colgroup><col width="310"><col width="490"></colgroup>
                    <tbody>
                    <tr>
                        <td style="padding: 0px !important; border: 0px currentColor; height: 90px; text-align: center; color: black; font-size: 36px; font-weight: bold; vertical-align: middle;" colspan="2" class="dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">

                            휴가 신청서<br><br>
                        </td>
                    </tr>
                    <tr>
                        <td style=" padding: 0px !important; border: currentColor; text-align: left; color: black; font-size: 12px; font-weight: normal; vertical-align: top;">

                            <table style="border: 1px solid rgb(0, 0, 0); font-family: malgun gothic,dotum,arial,tahoma; margin-top: 1px; border-collapse: collapse;"><!-- User --><colgroup><col width="90"><col width="220"></colgroup>
                                <tbody>
                                <tr>
                                    <td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 18px; text-align: center; color: rgb(0, 0, 0); font-size: 12px; font-weight: bold; vertical-align: middle;">

                                        작성일
                                    </td>
                                    <td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; text-align: left; color: rgb(0, 0, 0); font-size: 12px; font-weight: normal; vertical-align: middle;">
                                        <div contenteditable="false" id="recommandDate">    <fmt:formatDate value="${approval.approval_Recommand_Dt}" pattern="yyyy-MM-dd"/>

                                    </td>
                                </tr>
                                <tr>
                                    <td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 18px; text-align: center; color: rgb(0, 0, 0); font-size: 12px; font-weight: bold; vertical-align: middle;">

                                        신청자
                                    </td>
                                    <td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; text-align: left; color: rgb(0, 0, 0); font-size: 12px; font-weight: normal; vertical-align: middle;">
                                        <div contenteditable="false" id="empName">${history.emp_Name}</div>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 18px; text-align: center; color: rgb(0, 0, 0); font-size: 12px; font-weight: bold; vertical-align: middle;">

                                        부서
                                    </td>
                                    <td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; text-align: left; color: rgb(0, 0, 0); font-size: 12px; font-weight: normal; vertical-align: middle;">
                                        <div contenteditable="false" id="deptName">${history.dept_name}</div>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 18px; text-align: center; color: rgb(0, 0, 0); font-size: 12px; font-weight: bold; vertical-align: middle;">

                                        문서번호
                                    </td>
                                    <td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; text-align: left; color: rgb(0, 0, 0); font-size: 12px; font-weight: normal; vertical-align: middle;">
                                        <div contenteditable="false" id="docId">${approval.doc_Id}</div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>

                            <table border="1" style="display: inline-block;border-collapse: collapse;background: white;float: right;margin-top: -120px;" class="lineTable">
                                <tbody>
                                <tr>
                                    <td style="width: 40px; text-align: center;" contenteditable="false">반려사유<td>
                                </tr>

                                <tr>
                                    <td style="width: 90px; height: 95px; text-align: center;" contenteditable="false">

                                        <c:if test="${list.history_Type eq '신청'}">
                                            <div id="d${list.emp_Id}" style="width: 90px; height: 56px;" contenteditable="false" ></div>
                                        </c:if>

                                        <c:if test="${list.history_Type eq '결재'}">
                                            <div id="d${list.emp_Id}" style="width: 90px; height: 56px;" contenteditable="false"></div>
                                        </c:if>

                                    </td>
                                </tr>


                                </tbody>
                            </table>

                        </td>
                    <tr>
                        <td id="approval-line" >
                            <!-- 에디터 &nbsp; 버그. 개행과 공백을 최소화 시키자. [결재선]-->

                            <c:forEach items="${getApprovalList}" varStatus="status" var = "list">
                                <c:if test="${list.history_Type ne '참조'}">
                                    <table border="1" style="display: inline-block; border-collapse: collapse; background: white;" class="lineTable">
                                        <tbody>
                                        <tr>
                                            <td style="width: 40px; text-align: center;" contenteditable="false">직급</td>
                                            <td style="width: 90px; text-align: center;" contenteditable="false">${list.code_Name}</td>
                                        </tr>

                                        <tr>
                                            <td style="width: 40px; text-align: center;" contenteditable="false">${list.history_Type}</td>
                                            <td style="width: 90px; height: 95px; text-align: center;" contenteditable="false">

                                                <c:if test="${list.history_Type eq '신청'}">
                                                    <div id="d${list.emp_Id}" style="width: 90px; height: 56px;" contenteditable="false" ></div>
                                                </c:if>

                                                <c:if test="${list.history_Type eq '결재'}">
                                                    <div id="d${list.emp_Id}" style="width: 90px; height: 56px;" contenteditable="false"></div>
                                                </c:if>

                                                <c:if test="${list.history_Type eq '반려'}">
                                                    <div id="d${list.emp_Id}" style="width: 90px; height: 56px;" contenteditable="false"></div>
                                                </c:if>


                                            </td>
                                        </tr>

                                        <tr>
                                            <td style="width: 40px; text-align: center;" contenteditable="false">성명</td>
                                            <td id="결재" class="결재" contenteditable="false" style="width: 90px; text-align: center; cursor:pointer;" value="${status.index}">
                                                <span class="badge badge-default">${list.emp_Name}</span>
                                            </td>
                                        </tr>

                                        </tbody>
                                    </table>
                                </c:if>
                            </c:forEach>

                        </td>
                    </tr>
                    </tr>
                    </tbody>
                </table>

                <table style="border: 0px solid rgb(0, 0, 0); width: 800px; font-family: malgun gothic,dotum,arial,tahoma; margin-top: 10px; border-collapse: collapse;">
                    <!-- Draft -->
                    <colgroup>
                        <col width="90">
                    </colgroup>
                    <tbody>
                    <tr>
                        <td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 18px; text-align: center; color: rgb(0, 0, 0); font-size: 12px; font-weight: bold; vertical-align: middle;">
                            참조
                        </td>
                        <td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; text-align: left; color: rgb(0, 0, 0); font-size: 12px; font-weight: normal; vertical-align: middle;">
                            <c:forEach items="${getApprovalList}" var="list" varStatus="status">
                                <c:if test="${list.history_Type eq '참조'}">
                                    <span contenteditable="false" id="refer" class="refer" value = ${list.emp_Id}>${list.emp_Name}</span>
                                </c:if>
                            </c:forEach>
                        </td>
                    </tr>
                    </tbody>
                </table>

                <table style="border: 0px solid rgb(0, 0, 0); width: 800px; font-family: malgun gothic,dotum,arial,tahoma; margin-top: 10px; border-collapse: collapse;"><!-- Draft --><colgroup><col width="160"><col width="300"><col width="140"><col width="200"></colgroup>
                    <tbody>
                    <tr>
                        <td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">

                            제목
                        </td>
                        <td id="title" contenteditable="true" style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; text-align: left; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle;" colspan="3">  ${approval.approval_Title}
                        </td>
                    </tr>
                    </tbody>
                </table>

                <table style="border: 0px solid rgb(0, 0, 0); width: 800px; font-family: malgun gothic,dotum,arial,tahoma; margin-top: 10px; border-collapse: collapse;"><!-- Data2 --><colgroup><col width="160"><col width="150"><col width="490"></colgroup>
                    <tbody>
                    <tr>
                        <td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;" rowspan="3">

                            신청내용
                        </td>
                        <td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">

                            휴가종류
                        </td>
                        <td style="text-align: left; background-color: rgb(255, 255, 255); padding: 5px; border: 1px solid black; height: 25px; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle; background-position: initial initial; background-repeat: initial initial;">
                            <select id="vacationType" onchange="selectOption();" contenteditable="true">
                                <option selected="selected">연차</option>
                                <option>반차</option>
                                <option>보건</option>
                                <option>경조</option>
                                <option>교육</option>
                                <option>훈련</option>
                                <option>외출</option>
                                <option>조퇴</option>
                                <option>기타</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">

                            <c:set var="startDt" value="${approval.approval_Start_Dt}" />
                            <c:set var="endDt" value="${approval.approval_End_Dt}" />
                            기간
                        </td>
                        <td style="text-align: center; background-color: rgb(255, 255, 255); padding: 5px; border: 1px solid black; height: 25px; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle; background-position: initial initial; background-repeat: initial initial;">
                            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

                            <span unselectable="on" contenteditable="false" class="comp_wrap" data-cid="6" data-dsl="{{period}}" data-wrapper="" style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;" data-value="">
                                            <input class="ipt_editor ipt_editor_date startDt" type="date" value="<fmt:formatDate value='${approval.approval_Start_Dt}' pattern='yyyy-MM-dd' />">
                                            ~
                                            <input class="ipt_editor ipt_editor_date endDt" type="date" value="<fmt:formatDate value='${approval.approval_End_Dt}' pattern='yyyy-MM-dd' />">
                                            <span contenteditable="false" class="comp_active" style="display: none; font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
                                                <span class="Active_dot1" style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
                                                <span class="Active_dot2" style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
                                                <span class="Active_dot3" style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
                                                <span class="Active_dot4" style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
                                            </span>
                                            <span contenteditable="false" class="comp_hover" data-content-protect-cover="true" data-origin="6" style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
                                                <a contenteditable="false" class="ic_prototype ic_prototype_trash" data-content-protect-cover="true" data-component-delete-button="true"></a>
                                            </span>
                                        </span>
                            <br>
                        </td>
                    </tr>
                    <tr>
                        <td id = "contents" contenteditable="true" style="box-sizing: inherit; text-align: left; background-color: rgb(255, 255, 255); padding: 0.09%; border: 1px solid black; height: 100px; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle; background-position: initial initial; background-repeat: initial initial; border-top:none;" colspan="2" class="dext_table_border_t">
                            ${approval.approval_Content}
                        </td>
                    </tr>
                    </tbody>
                </table>


                <table style="border: 0px solid rgb(0, 0, 0); width: 800px; font-family: malgun gothic,dotum,arial,tahoma; margin-top: 10px; border-collapse: collapse;">
                    <!-- Draft -->
                    <colgroup>
                        <col width="160">
                        <col width="300">
                        <col width="140">
                        <col width="200">
                    </colgroup>
                    <tbody>
                    <tr>
                        <td contenteditable="false" style="background: rgb(255, 255, 255); padding: 5px; height: 100px; border: 1px solid black; text-align: left; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle;" colspan="4">
                            해당 증빙을 첨부하세요.<br><br>종류 : 연차, 반차, 보건, 경조, 교육, 훈련, 외출, 조퇴, 기타<br>시간 : 연차/보건/경조 =&gt; "전일"<br>&nbsp; &nbsp; &nbsp; &nbsp; 반차 =&gt; "오전","오후"<br>&nbsp; &nbsp; &nbsp; &nbsp; 교육/훈련/외출/조퇴 =&gt; 구체적 시간 기재<br><br type="_moz">
                        </td>
                    </tr>
                    <!-- 파일 첨부 부분 추가 -->
                    <tr>
                        <td colspan="4">
                            <div class="row clearfix">
                                <!-- 파일 입력 -->
                                <div class="col-12 formGroup" id = "fileContent">
                                    <input type="file" id="fileInput" style="display: none;" />
                                    <br/>
                                    <br/>

                                    <div style="border:1px solid gray;height:200px;overflow-y: scroll;">
                                        <table class="table table-hover center-aligned-table" style="margin-bottom: 0;">
                                            <thead style="height:50px;">
                                            <tr>
                                                <th>파일명</th>
                                                <th>확장자</th>
                                            </tr>
                                            </thead>

                                            <tbody id="appendTbody" style="overflow: scroll;">
                                            <c:if test="${not empty approval.attachVOList }">
                                                <c:forEach items="${approval.attachVOList }" var="attach">
                                                    <tr class="myFileLabels" style="cursor: pointer;" onclick="fileDownload(this);" data-attachId="${attach.attach_id }" data-filePath="${attach.attach_path }">
                                                        <th><span style="padding-top: 10px;">${attach.attach_name}</span></th>
                                                        <th><span style="padding-top: 10px;">${attach.attach_type}</span></th>
                                                    </tr>
                                                </c:forEach>
                                            </c:if>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <table style="border: 0px solid rgb(0, 0, 0); width: 800px; font-family: malgun gothic,dotum,arial,tahoma; margin-top: 10px; border-collapse: collapse;"><!-- Draft --><colgroup><col width="160"><col width="300"><col width="140"><col width="200"></colgroup>
                    <tbody>
                    <tr>
                        <td contenteditable="false" style="text-align: center; background-color: rgb(255, 255, 255); padding: 5px; height: 30px; border: 1px solid black; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle; background-position: initial initial; background-repeat: initial initial;" colspan="4">

                            위와 같이 신청하오니 재가하여 주시기 바랍니다. <br>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <div style="text-align: right; font-family: &quot;맑은 고딕&quot;; font-size: 10pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;" align="right"><br></div></span>
                <p><br></p>

            </div>
        </form>
        <div id="docContent">
            ${approval.approval_Content }
        </div>


    </div>
</section>

<form name="fileForm" action="${pageContext.request.contextPath }/common/getFile" method="post">
    <input type="hidden" name="fileUploadPath"/>
    <input type="hidden" name="attach_id"/>
</form>

<%--<form:form model="approval" method="POST" id="fileUploadForm" name="registForm" enctype="multipart/form-data" style="display: none;">--%>
<%--    <form:input path="docId" type="text" id="fileDocId" style="display: none;" />--%>
<%--</form:form>--%>
<!-- 푸터 인클루드 -->
<%@ include file="../../include/footer.jsp"%>


<script>
    //파일 다운로드
    function fileDownload(obj){
        var fileForm = $('form[name="fileForm"]');
        $('input[name="attach_id"]').val($(obj).attr('data-attachId'));
        $('input[name="fileUploadPath"]').val($(obj).attr('data-filePath'));
        fileForm.submit();
    }




    function getReturnSign() {


        let imageURL = "<%=request.getContextPath()%>/pds/Sign/반려.png"
        console.log(imageURL)
        $('div#d${loginUser.emp_Id}').css({
            'background-image': 'url(' + imageURL + ')',
            'background-position': 'center',
            'background-size': 'contain',
            'background-repeat': 'no-repeat'
        }).trigger("create");


    }


    $(document).on("click", ".deleteFile", function () {
        let fileNumber = parseInt($(this).attr("value"));
        console.log(fileNumber);
        console.log($(".myFile[value=" + fileNumber + "]"));
        $(".myFile[value=" + fileNumber + "]").remove();
        $(this).parent().remove();

    });


    function OpenWindow(UrlStr, WinTitle, WinWidth, WinHeight) {
        winleft = (screen.width - WinWidth) / 2;
        wintop = (screen.height - WinHeight) / 2;
        var winX = window.screenX || window.screenLeft || 0;// 현재창의 x좌표
        var winY = window.screenY || window.screenTop || 0; // 현재창의 y좌표

        winleft = winX + winleft;
        wintop = winY + wintop;

        var win = window.open(UrlStr, WinTitle, "scrollbars=yes,width=" + WinWidth + ", "
            + "height=" + WinHeight + ", top=" + wintop + ", left="
            + winleft + ", resizable=yes, status=yes");
        win.focus();
    }

    $(".startDt").change(function () {
        var startDt = $(".startDt").val();
        $(".startDt").attr("value", startDt);
    });

    $(".endDt").change(function () {
        var startDt = $(".endDt").val();
        $(".endDt").attr("value", startDt);
    });


    window.onload = function () {
        getSign();

        $("td").attr("contenteditable",false)
        $("div").attr("contenteditable",false);
        $("#vacationType").attr("disabled",true);
        $(".startDt").attr("readonly",true);
        $(".endDt").attr("readonly",true);
        $("input").attr("readonly",true);
        $("textarea").attr("readonly",true);

    }


    /*
* @ 작성자 : 오지환
* @ 작성일자 : 2024.03.01
* @ 설명 : 조건문에 대한 해설
* 1. historyType이 신청인지 확인 --> 첫 조건이 신청이기 때문에 나머지 조건은 확인 x
* 2. historyType이 결재이기 때문에 --> historyType === '신청' 제외한 뒤 부분 실행
*       - historyTurn이 'N'인지 확인 "그리고"
*       - historyType이 '결재'인지 확인 --> 두 조건이 맞아야 뒷 부분 실행 (Y라면 내 차례이기 때문에 도장이 찍히면 안됨)
* 3. 1~2 조건이 맞으면 -> historyStep이 2 "또는" 3인지 확인 그리고 history_st가 1이면 결재완료 상태임 (만약에 세번쨰 사람이 도장을 찍으면 historySt가 1로 업데이트 된다.)  그렇기 떄문에 마지막 ===1로 마지막 사람인지 아닌지 구별해야함.
* 4. 즉, 결재자 두 사람은 마지막 조건을 통해서 로직을 나눠서 탄다.

*
*
* */


    function getSign() {
        let imageCon, emp_Id, imageURL;
        let historyType, historyTurn, historyStep, historySt;

        <c:forEach var="list" items="${getApprovalList}">
        imageCon = '${list.emp_Sign}';
        emp_Id = '${list.emp_Id}';
        historyType = '${list.history_Type}';
        historyTurn = '${list.history_Turn}';
        historyStep = '${list.history_Step}';
        historySt = '${list.history_st}';


        if (historyType === '신청' || (historyTurn === 'N' && historyType === '결재' && (historyStep === '2' || historyStep === '3') && historySt === '1')) {
            console.log(emp_Id);
            console.log(imageCon);
            imageURL = "<%=request.getContextPath()%>/pds/Sign/" + imageCon;
            $('div#d' + emp_Id).css({
                'background-image': 'url(' + imageURL + ')',
                'background-position': 'center',
                'background-size': 'contain',
                'background-repeat': 'no-repeat'
            }).trigger("create");
        }


        if (historySt === '3')
        {
            console.log("historyst3>>"+emp_Id);
            let imageURL = "<%=request.getContextPath()%>/pds/Sign/반려.png"
            console.log(imageURL)
            $('div#d' + emp_Id).css({
                'background-image': 'url(' + imageURL + ')',
                'background-position': 'center',
                'background-size': 'contain',
                'background-repeat': 'no-repeat'
            }).trigger("create");
        }


        </c:forEach>
    }

    function getSign_approval() {
        let imageCon, emp_Id, imageURL;
        <c:forEach var="list" items="${getApprovalList}">
        if ('${list.history_Type}' === '결재' && '${list.history_Turn}' === 'Y') {
            let imageCon = '${list.emp_Sign}';
            let emp_Id = '${list.emp_Id}';
            console.log(emp_Id);
            console.log(imageCon);
            let imageURL = "<%=request.getContextPath()%>/pds/Sign/" + imageCon;
            $('div#d' + emp_Id).css({
                'background-image': 'url(' + imageURL + ')',
                'background-position': 'center',
                'background-size': 'contain',
                'background-repeat': 'no-repeat'
            }).trigger("create");
        }
        </c:forEach>

    }



    let fileLength = 0;
    let fileValue = 0;

    function myFileUpload() {
        $("#fileContent").css("display", "block");
        //빈 파일 테그면 사쿠죠
        for (var i = 0; i < $("input[name='fileUploadCommand.uploadFile']").length; i++) {

            if (!$("input[name='fileUploadCommand.uploadFile']").eq(i)[0].files[0]) {
                $("input[name='fileUploadCommand.uploadFile']").eq(i).remove();
            }
        }

        let input = $('<input>').attr({
            "type": "file",
            "name": "fileUploadCommand.uploadFile",
            "class": "myFile",
            "value": fileValue + ""
        });
        $("#fileUploadForm").append(input);

        fileLength = $("input[name='fileUploadCommand.uploadFile']").length;

        $("input[name='fileUploadCommand.uploadFile']").eq(fileLength - 1).click();
    }

    $(document).on("change", ".myFile", function () {
        let _fileLen = $("input[name='fileUploadCommand.uploadFile']").eq(fileLength - 1)[0].files[0].name.length;
        let _lastDot = $("input[name='fileUploadCommand.uploadFile']").eq(fileLength - 1)[0].files[0].name.lastIndexOf('.');


        let name = $("input[name='fileUploadCommand.uploadFile']").eq(fileLength - 1)[0].files[0].name.substring(0, _lastDot);
        let extension = getExtensionOfFilename($("input[name='fileUploadCommand.uploadFile']").eq(fileLength - 1)[0].files[0].name);
        let size = ($("input[name='fileUploadCommand.uploadFile']").eq(fileLength - 1)[0].files[0].size) / 1000 + "KB";


        setTimeout(function () {
            if (!(extension == 'png' || extension == 'doc' || extension == 'exe' || extension == 'gif' || extension == 'java' || extension == 'jpg' || extension == 'pdf' || extension == 'ppt' || extension == 'txt' || extension == 'xlsx' || extension == 'zip')) {
                alert("지원하지 않는 파일 형식입니다.");
                $("input[name='fileUploadCommand.uploadFile']").eq(fileLength - 1).remove();
                return false;
            }

            let fileLabel = "";

            fileLabel += '<tr class="myFileLabels">';
            fileLabel += '    <td>' + name + '</td>';
            fileLabel += '    <td>' + extension + '</td>';
            fileLabel += '    <td class="deleteFile" value="' + fileValue + '" style="cursor: pointer;"><i class="fa fa-trash-o"></i></td>';
            fileLabel += '</tr>';
            fileValue++;
            $("#appendTbody").append(fileLabel);
            $("#appendTbody").trigger("create");

        }, 50);

    });

    //파일 확장자 추출 함수
    function getExtensionOfFilename(filename) {

        let _fileLen = filename.length;

        let _lastDot = filename.lastIndexOf('.');

        let _fileExt = filename.substring(_lastDot + 1, _fileLen).toLowerCase();

        return _fileExt;
    }

    $(".deleteAllFile").click(function () {
        $(".myFileLabels").remove();
        $(".myFile").remove();
    })

    $(document).on("click", ".deleteFile", function () {
        var fileNumber = parseInt($(this).attr("value"));
        console.log(fileNumber);
        console.log($(".myFile[value=" + fileNumber + "]"));
        $(".myFile[value=" + fileNumber + "]").remove();
        $(this).parent().remove();

    });


</script>

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