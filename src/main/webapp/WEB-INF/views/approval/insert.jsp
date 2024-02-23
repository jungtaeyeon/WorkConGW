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
</style>
<section class="subPageContain">

    <!-- 사이드바 -->
    <%@ include file="./sideBar.jsp"%>
    
    <!--컨텐츠 영역-->
    <div class="contentConteiner">
        <div class="subTitleText"> <!--컨텐츠 부분 타이틀 클래스(이건 부트스트랩 클래스 아니고 임의로 만든 클래스)--> 
            <h2><i class="fa-solid fa-angles-right"></i> <!--왼쪽 아이콘 폰트어썸-->기안하기</h2>
            <div class="btnGroup">
                <button type="button" class="btn btn-primary" onclick="OpenWindow('<%=request.getContextPath()%>/approval/line', 'WorkConGW', 1100,790)">결제라인</button>
                &nbsp
                <button type="button" class="btn btn-primary">결제요청</button>
                &nbsp
                <button type="button" class="btn btn-primary">임시저장</button>
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
                                        <div contenteditable="false" id="recommandDate">기안일</div>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 18px; text-align: center; color: rgb(0, 0, 0); font-size: 12px; font-weight: bold; vertical-align: middle;">

                                        신청자
                                    </td>
                                    <td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; text-align: left; color: rgb(0, 0, 0); font-size: 12px; font-weight: normal; vertical-align: middle;">
                                        <div contenteditable="false" id="empName">기안자</div>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 18px; text-align: center; color: rgb(0, 0, 0); font-size: 12px; font-weight: bold; vertical-align: middle;">

                                        부서
                                    </td>
                                    <td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; text-align: left; color: rgb(0, 0, 0); font-size: 12px; font-weight: normal; vertical-align: middle;">
                                        <div contenteditable="false" id="deptName">기안자 부서</div>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 18px; text-align: center; color: rgb(0, 0, 0); font-size: 12px; font-weight: bold; vertical-align: middle;">

                                        문서번호
                                    </td>
                                    <td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; text-align: left; color: rgb(0, 0, 0); font-size: 12px; font-weight: normal; vertical-align: middle;">
                                        <div contenteditable="false" id="docId">문서번호</div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>

                        </td>
                        <td id="approval-line" style="padding: 0px !important; border: currentColor; text-align: right; color: black; font-size: 12px; font-weight: normal; vertical-align: top;">
                            <!-- 에디터 &nbsp; 버그. 개행과 공백을 최소화 시키자. [결재선]-->

                        </td>
                    </tr>
                    </tbody>
                </table>

                <table style="border: 0px solid rgb(0, 0, 0); width: 800px; font-family: malgun gothic,dotum,arial,tahoma; margin-top: 10px; border-collapse: collapse;"><!-- Draft --><colgroup><col width="90"></colgroup>
                    <tbody>

                    <tr>
                        <td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 18px; text-align: center; color: rgb(0, 0, 0); font-size: 12px; font-weight: bold; vertical-align: middle;">

                            참조
                        </td>
                        <td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; text-align: left; color: rgb(0, 0, 0); font-size: 12px; font-weight: normal; vertical-align: middle;">
                            <div contenteditable="false" id="refer">참조자</div>
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
                        <td id="title" contenteditable="true" style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; text-align: left; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle;" colspan="3">
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

                            기간
                        </td>
                        <td style="text-align: center; background-color: rgb(255, 255, 255); padding: 5px; border: 1px solid black; height: 25px; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle; background-position: initial initial; background-repeat: initial initial;">
                            <span unselectable="on" contenteditable="false" class="comp_wrap" data-cid="6" data-dsl="{{period}}" data-wrapper="" style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;" data-value=""><input class="ipt_editor ipt_editor_date startDt" type="date" > ~ <input class="ipt_editor ipt_editor_date endDt" type="date"><span contenteditable="false" class="comp_active" style="display: none; font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"> <span class="Active_dot1" style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span class="Active_dot2" style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span> <span class="Active_dot3" style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span class="Active_dot4" style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span> </span> <span contenteditable="false" class="comp_hover" data-content-protect-cover="true" data-origin="6" style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"> <a contenteditable="false" class="ic_prototype ic_prototype_trash" data-content-protect-cover="true" data-component-delete-button="true"></a> </span> </span><br>
                        </td>
                    </tr>
                    <tr>
                        <td contenteditable="true" style="box-sizing: inherit; text-align: left; background-color: rgb(255, 255, 255); padding: 0.09%; border: 1px solid black; height: 100px; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle; background-position: initial initial; background-repeat: initial initial; border-top:none;" colspan="2" class="dext_table_border_t">
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
                                <div class="col-12 formGroup noticeForm">
                                    <input type="file" id="fileInput" style="display: none;" />
                                    <button type="button"  style="float:left;" onclick="myFileUpload();">파일 추가</button>
                                    <span class="float-right" style="margin:15px 10px 0 0;">파일 개수 <span id="fileCount"></span>/5</span>
                                    <br/>
                                    <br/>

                                    <div style="border:1px solid gray;height:200px;overflow-y: scroll;">
                                        <table class="table table-hover center-aligned-table" style="margin-bottom: 0;">
                                            <thead style="height:50px;">
                                            <tr>
                                                <th style="width:200px;">타입</th>
                                                <th style="width:300px;">파일명</th>
                                                <th style="width:200px;">확장자</th>
                                                <th style="width:200px;">용량</th>
                                                <th style="width:100px;"><i class="fas fa-trash-alt" style="cursor: pointer;" onclick="removeAll();"></i>
                                                </th>
                                            </tr>
                                            </thead>
                                            <tbody id="appendTbody">
                                            <!-- 파일 입력 -->
                                            <c:if test="${!empty boardFormVO.noticeVO.noticeAttachList }">
                                                <c:forEach items="${boardFormVO.noticeVO.noticeAttachList }" var="noticeAttach" varStatus="status">
                                                    <tr>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${noticeAttach.attach_type eq 'JPG' || noticeAttach.attach_type eq 'PNG' || noticeAttach.attach_type eq 'GIF'}">
                                                                    이미지
                                                                </c:when>
                                                                <c:otherwise>
                                                                    파일
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td style="font-weight: normal;">
                                                                ${noticeAttach.attach_name }
                                                        </td>
                                                        <td style="font-weight: normal;">
                                                                ${noticeAttach.attach_type }
                                                        </td>
                                                        <td style="font-weight: normal;">
                                                                ${noticeAttach.attach_size }
                                                        </td>
                                                        <td>
                                                            <i class="fas fa-times" data-id="${status.index }" data-attach_id="${noticeAttach.attach_id }" style="cursor: pointer;" onclick="removeEl(this)"></i>
                                                        </td>
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
    </div>
</section>

<!-- 푸터 인클루드 -->
<%@ include file="../include/footer.jsp"%>


<script>
    function OpenWindow(UrlStr, WinTitle, WinWidth, WinHeight){
        winleft = (screen.width - WinWidth) / 2;
        wintop = (screen.height - WinHeight) / 2;
        var winX      = window.screenX || window.screenLeft || 0;// 현재창의 x좌표
        var winY      = window.screenY || window.screenTop || 0; // 현재창의 y좌표

        winleft = winX + winleft;
        wintop = winY + wintop;

        var win = window.open(UrlStr, WinTitle, "scrollbars=yes,width="+ WinWidth +", "
            +"height="+WinHeight + ", top=" + wintop +", left="
            + winleft +", resizable=yes, status=yes");
        win.focus();
    }

    function  myFileUpload()
    {
        if($('#appendTbody').children().length == 5)
        {
            alert('파일은 5개까지만 저장할 수 있습니다.')
            return;
        }



    }

</script>