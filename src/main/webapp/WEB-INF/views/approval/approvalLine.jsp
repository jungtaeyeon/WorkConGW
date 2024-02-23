<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Popper.js CDN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha512-ldc1sPu1FZ8smgkgp+HwnYyVb1eRn2wEmKrDg1JqPEb02+Ei4kNzDIQ0Uwh0AJVLQFjJoWwG+764x70zy5Tv4A==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- Bootstrap CSS, js CDN -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- FontAwesome -->
<script src="https://kit.fontawesome.com/3a92c85ff9.js" crossorigin="anonymous"></script>
<!-- TreeView -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/js/treeview/jquery.treeview.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/js/treeview/screen.css" />
<script src="<%=request.getContextPath() %>/js/treeview/jquery.treeview.js"></script>
<!-- Summernote -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
<!-- Bootstrap Datepicker CSS, JS CDN -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/css/bootstrap-datepicker.min.css" integrity="sha512-34s5cpvaNG3BknEWSuOncX28vz97bRI59UnVtEEpFX536A7BtZSJHsDyFoCl8S7Dt2TPzcrCEoHBGeM4SUBDBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/js/bootstrap-datepicker.min.js" integrity="sha512-LsnSViqQyaXpD4mBBdRYeP6sRwJiJveh2ZIbW41EBrNmKxgr/LFZIiWT6yr+nycvhvauz8c2nYMhrP80YhG7Cw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- common.js -->
<script src="<%=request.getContextPath() %>/js/common.js"></script>


<style>
    .subTitleText{
        margin-bottom: 25px;
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
    .serchContain{
		display: flex; 
		align-items: flex-start;
	}
    .subContentConteiner{
        display: flex;
    }
    .approvalLineTreeviewGroup{
        width: 25%;
        margin-right: 2%;
    }
    .approvalLineEmpTableGroup{
        width: 100%;
    }
    .approvalLineTreeview{
        width: 100%;
        height: 600px;
        border: 1px solid #000;
        margin:3% 0 5%;
    }
    .tableCheckBox{text-align: center; vertical-align: middle !important;}
    .approvalLineResult{
        display: flex;
        justify-content: space-between;
        margin: 2% 0;
    }
    .approvalLineBox{
        width: 50%;
    }
    .approvalLineBoxTit{
        font-size: 18px;
    }
    .approvalLineBoxContent{
        width: 99%;
        height: 200px;
        border: 1px solid #000;
    }

    .appendli{
        width: 99%;
        height: 200px;
        border: 1px solid #000;
    }
</style>
<section class="subPageContain">

    <!-- 사이드바 -->

    <!--컨텐츠 영역-->
    <div class="contentConteiner">
        <div class="subTitleText"> <!--컨텐츠 부분 타이틀 클래스(이건 부트스트랩 클래스 아니고 임의로 만든 클래스)--> 
            <h2><i class="fa-solid fa-angles-right"></i> <!--왼쪽 아이콘 폰트어썸-->결재라인 설정</h2>
        </div>
        <div class="subContentConteiner">
            <div class="approvalLineTreeviewGroup">
                <select id="add_book_id" name="add_book_id" class="custom-select" aria-label="그룹">
                    <option value="0" selected>-직접선택-</option>
                </select>

                <div class="approvalLineTreeview">
                    <li> WorkConGW 조직도
                        <ul id="codeList" name = "child">
                            <ul id="lvl0"><!-- 자식 노드가 들어올 공간--></ul>
                        </ul>
                    </li>
                </div>
            </div>
            <div class="approvalLineEmpTableGroup">
                <div class="serchContain">
                        <div class="serchTextGroup">
                            <input type="search" oninput="searchOrg(this)"  name="searchText" class="form-control" placeholder="사원명을 입력해주세요" aria-label="입력해주세요">
                        </div>
                    <button type="button" class="btn btn-dark" onclick="addLine_go()" style="float:right">결재라인 저장</button> &nbsp&nbsp&nbsp&nbsp&nbsp
                    <button type="button" class="btn btn-dark" onclick="addLine_go()" style="float:right">현재결재라인 저장</button> &nbsp&nbsp&nbsp&nbsp&nbsp
                    <button type="button" onclick = "window.close();" class="btn btn-dark" style="float:right">취소</button>

                </div>

                <br/>
                <table class="table table-hover"> <!-- 부트스트랩 게시판 -->
                    <thead class="thead-light"> <!-- 게시판 맨위 색변경 클래스-->
                        <tr>
                            <th></th>
                            <th>타입</th>
                            <th>이름</th>
                            <th>부서</th>
                            <th></th>
                            <th>상태</th>
                            <th class="deleteAllEmp" style="cursor: pointer;">
                                <i class="fa fa-trash-o"></i>
                            </th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody id="appendTbody" style="overflow: scroll;">
                    <tr style="background-color: #f4f7f6;">
                        <td colspan="9">기안자</td>
                    </tr>
                    <tr style="color: #D8D8D8;">
                        <td style="width: 48px;background-color: #F2F2F2; text-align: center; color:black;">
                            <i class="fa fa-caret-right"></i>
                        </td>
                        <td></td>
                        <td>${emp.empName } ${emp.officialName }</td>
                        <td>${emp.deptName }</td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <%--//////////////////////////////////////결재자/////////////////////////////////////////////////--%>
                    <tr >
                        <td colspan="9" style="background-color: #f4f7f6;">결재/참조자</td>
                    </tr>
                    <tr id="appendTr">
                        <td onclick="moveRight();" rowspan="500" style="width: 48px;background-color: #F2F2F2; text-align: center; cursor: pointer;">
                            <i class="fa fa-caret-right"></i>
                        </td>
                        <!-- 첫 추가시 여기아래 붙음 -->
                    </tr>

                    <%--///////////////////////////////////참조자////////////////////////////////////////////////////--%>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>

<!-- 푸터 인클루드 -->

<script>

    function appendrefer()
    {
        if(!$("li").hasClass("myChecked")){
            alert("선택된 직원이 없습니다.");
            return false;
        }

        let str = "";
        let agencyStr = "";


        let empId = $(".myChecked").attr("id");
        let empName= $(".myChecked").text().trim();
        let deptName = $(".myChecked").parent().parent().children("a").text();
        let stName = $(".myChecked").attr("stName");

        if($("td").hasClass(empId)) // 같은 직원을 중복해서 쓸 때(td) 태그에서
        {
            alert('같은 직원은 선택할 수 없습니다.')
            return false;
        }

        if(empId === '${loginUser.empId}') // 자기 자신일 떄
        {
            alert('자기 자신을 추가할 수 없습니다.')
            return false;
        }

        if(stName === '휴가중')
        {
            alert(empName+"님은"+stName+"인 상태입니다. 결재가 불가능합니다.")
            return false;
        }

        empName= empName.split("휴가중")[0];



        if(!$("td").hasClass("firTd")){
            str +='<td class="firTd style="padding-right: 0;">';
            str +='<select style="width: 65px;">';
            str +='<option>결재</option>';
            str +='<option>참조</option>';
            str +='</select>';
            str +='</td>';
            str +='<td class="firTd myName">'+empName+'</td>';
            str +='<td class="firTd myDeptName">'+deptName+'</td>';
            str +='<td class="firTd empTd '+empId+'" style="display:none" value="'+empId+'"></td>';
            str +='<td class="firTd"></td>';

            if(stName=='정상출근')
            {
                str += '<td class="firTd st"><span class ="badge badge-primary">' + stName + '</span></td>';
            }
            else if(stName==='지각'||stName==='조퇴')
            {
                str += '<td class="firTd st"><span class = "badge badge-danger">'+stName+ '</span></td>';
            }
            else {
                str += '<td class="firTd st"><span class="badge badge-success">' + stName + '</span></td>';
            }

            str +='<td class="firTd deleteEmp" style="cursor: pointer;" ><i class="fa fa-trash-o"></i></td>';
            str +='<td class="firTd"></td>';

            $("#appendTr").append(str);


        }
        else{

            str += '<tr>';
            str +='<input value="'+empId+'" style="display:none;">';
            str +='<td class="myTd style="padding-right: 0;">';
            str += '<select style="width: 65px">';
            str += '<option>결재</option>'
            str += '<option>참조</option>'
            str += '</select>'
            str += '</td>'

            str += '<td class="myTd myName">'+empName+'</td>'
            str += '<td class="myTd myDeptName">'+deptName+'</td>'
            str += '<td class="myTd empTd '+empId+'" style="display:none" value="'+empId+'"></td>';
            str += '<td class ="myTd"></td>'

            if(stName=='정상출근')
            {
                str += '<td class="myTd st"><span class ="badge badge-primary">' + stName + '</span></td>';
            }
            else if(stName==='지각'||stName==='조퇴')
            {
                str += '<td class="myTd" st><span class = "badge badge-danger">'+stName+ '</span></td>';
            }

            else {
                str += '<td class="myTd st"><span class="badge badge-success">' + stName + '</span></td>';
            }


            str +='<td class="myTd deleteEmp" style="cursor: pointer;" ><i class="fa fa-trash-o"></i></td>';
            str +='<td class="myTd"></td>';
            str +='</tr>';


            $("#appendrefer").append(str);
        }

    }


    function addLine_go()
    {

        let tempArr = []
        let referArr = []
        let approvalArr = []
        let selectBoxCnt = $("select").length; // 드롭다운 메뉴의 개수
        let referObj = {}
        let approvalObj = {}
        let str1 = "";

        for(let i = 0; i< selectBoxCnt; i++)
        {
            let type = $("option:selected").eq(i).val(); // 선택된 메뉴의 타입을 가져온다. '결재' || '검토'
            tempArr.push(type); // 만약에 '결재'가 type 라면, tempArr = ['결재']
            console.log(type)

            if(type === '결재')
            {
                let approvalObj = {};
                approvalObj.name = $('option:selected').eq(i).parent().parent().parent().find(".firTd.myName").text().split(" ")[0]
                approvalObj.official = $('option:selected').eq(i).parent().parent().parent().find(".firTd").text().split(" ")[1]
                approvalObj.empId = $('option:selected').eq(i).parent().parent().parent().find(".firTd.empTd").attr("value")
                approvalObj.st = $('option:selected').eq(i).parent().parent().parent().find(".firTd.st").children().text()



                approvalObj.name = $('option:selected').eq(i).parent().parent().parent().find(".myName").text().split(" ")[0]
                approvalObj.official = $('option:selected').eq(i).parent().parent().parent().find(".myName").text().split(" ")[1] // 부장 << 이렇게 나옴
                approvalObj.empId = $('option:selected').eq(i).parent().parent().parent().find(".empTd").attr("value")
                approvalObj.st = $('option:selected').eq(i).parent().parent().parent().find(".st").children().text()

                approvalArr.push(approvalObj);


            }

            if(type === '참조')
            {
                referObj.name = $("option:selected").eq(i).parent().parent().parent().find(".myName").text().split(" ")[0] // 이름출력
                referObj.official = $("option:selected").eq(i).parent().parent().parent().find(".myName").text().split(" ")[1] // 직책출력
                referObj.empId = $('option:selected').eq(i).parent().parent().parent().find(".empId").attr("value") // 사번 출력
                referObj.st = $('option:selected').eq(i).parent().parent().parent().find(".st").children().text() // 상태 출력
                referArr.push(referObj);
                referObj = {}; // 여기서 초기화 시켜야함. 그래야 다음에 사용할 때 반영이 된다.
            }
        }

        let approvalCnt = tempArr.filter(element => '결재' === element).length
        if(approvalCnt == 0)
        {
            alert('적어도 결재자가 최소 한 명씩은 있어야 합니다.')
            return false;
        }

        if(approvalObj.st == '휴가중')
        {
            alert(approvalObj.name+"님이 휴가중입니다.")
            return false;
        }
        let approvalLineContent = $(".approvalLineBoxContent");

        let str = "";
        for(let i = 0; i<approvalArr.length; i++)
        {
            let empId = ""
            let name = ""
            let official = ""
            let supEmpId = ""
            let type = ""



            if(i == 0)
            {
                empId = approvalObj.empId;
                name = approvalObj.name;
                official = approvalObj.official;
                type = '결재'
            }

            if(i == 1)
            {
                empId = approvalObj.empId;
                name = approvalObj.name;
                official = approvalObj.official;
                type = '결재'
            }

            str +='<table border="1" style="display: inline-block; border-collapse: collapse; background: white;" class="lineTable">'
            str +='	<tbody >'
            str +='		<tr>'
            str +='			<td style="width: 40px; text-align: center;">직급</td>'
            str +='			<td style="width: 90px; text-align: center;">'+approvalArr[i].official+'</td>'
            str +='		</tr>'
            str +='		<tr>'
            str +='			<td style="width: 40px; text-align: center;">'+type+'</td>'
            str +='			<td style="width: 90px; height: 95px; text-align: center;">'


            str +='				<div id="d'+approvalArr[i].empId+'" style="width: 90px; height: 56px;"></div>'
            str +='			</td>'
            str +='		</tr>'
            str +='		<tr>'
            str +='			<td style="width: 40px; text-align: center;">성명</td>'

            str +='			<td id="'+tempArr[i].type+'" class="'+tempArr[i].type+'" contenteditable="false" style="width: 90px; text-align: center; cursor:pointer;" value="'+approvalArr[i].empId+'"><span class="badge badge-default">'+approvalArr[i].name+'</span></td>'
            str +='		</tr>'

            str +='	</tbody>'
            str +='</table>'


            let str2 = "";
            for(let i = 0; i<referArr.length; i++)
            {
                str2 +='<button class="btn btn-outline-secondary referBtn" style="padding:0;font-size:0; margin-right: 10px;">';
                str2 +='<span class="refer" style="font-size: 11px;" value="'+referArr[i].empId+'">'+referArr[i].name+" "+referArr[i].official+'</span>';
                str2 +='</button>';
                console.log(referArr)
                opener.document.querySelector("#refer").innerHTML = str2;
            }

        }
        opener.document.querySelector("#approval-line").innerHTML=str;


        ////////////////////////////작성일 뿌리기/////////////////////////////////////////////////////////////////////////

        let sysDate = new Date()
        let prettyDate = sysDate.getFullYear()+'-'+(sysDate.getMonth()+1)+'-'+sysDate.getDate()
        console.log(prettyDate)

        opener.document.querySelector("#recommandDate").innerHTML=prettyDate

    }


    function deptTrees() {
        $.ajax({
            type: "GET",
            url: "<c:url value='/orgList'/>",
            contentType: "application/json",
            processData: true,
            success: function (data) {
                console.log(data);
                data.forEach(function (e, i) {
                    let deptId = e.deptId;
                    let deptName = e.deptName;
                    let deptSupId = e.deptSupId;
                    let position = e.position
                    let stName = e.empState
                    let level = e.level || 5;
                    console.log(deptId)
                    console.log(deptName)
                    console.log(deptSupId)
                    console.log(position)
                    console.log(level)
                    console.log(stName)

                    let li = "";
                    if (position) {
                        li = '<li id="' + deptId + '" data-type="supervisor" lvl="' + level + '"><img src="<%=request.getContextPath() %>/js/treeview/images/file.gif"><a class="file code myHover" id="t1">' + " " + deptName + " " + e.position + '</a></li>';
                        if(stName == '휴가중') {
                            li = '<li onclick = "empChecked(this);" ondblclick="moveRight();" stName="' + stName + '" id="' + deptId + '" lvl="' + level + '" class ="" style="cursor: pointer"><img src="<%=request.getContextPath() %>/js/treeview/images/folder-closed.gif">'+" "+deptName +" "+'</a></li>'
                        }
                        else{
                            li = '<li onclick="empChecked(this);" ondblclick="moveRight();" stName="'+stName+'" id="'+ deptId +'" lvl="'+level +'" class="" style="cursor:pointer" ><img src = "<%=request.getContextPath()%>/js/treeview/images/emp2.png">'+" "+ deptName + " "+e.position+'</li>';
                        }
                    } else {
                        li = '<li id="' + deptId + '" data-type="dept" lvl="' + level + '"><img src="<%=request.getContextPath() %>/js/treeview/images/folder-closed.gif"><a class="file code" onclick="myClick(this)">' + " " + deptName + " " + '</a></li>';
                    }

                    // 1레벨은 그냥 추가
                    // 다음 레벨부터는 상위 li의 클래스를 폴더로 바꾸고 자기 자신을 추가
                    if (level == 1) {
                        $("#lvl0").append(li);
                    } else {
                        let parentLi = $("li[id='" + deptSupId + "']");
                        parentLi.addClass("expandable lastExpandable");
                        parentLi.find("a").removeClass("file");
                        parentLi.find("a").addClass("folder");
                        let bUl = parentLi.children("ul");

                        // 하위 그룹이 없으면 li로 추가
                        // 하위 그룹이 있으면 ul로 추가
                        if (bUl.length == 0) {
                            let div = "<div onclick='plusFromMinus(this);' class='hitarea expandable-hitarea lastExpandable-hitarea '></div>"
                            li = "<ul class='' style='display: none;'>" + li + "</ul>";
                            parentLi.append(div);
                            parentLi.append(li);
                        } else {
                            if (position) {
                                bUl.prepend(li);
                            } else {
                                bUl.append(li);
                            }
                        }////end of else

                    }///////////end of else

                }); ////////////end of for each




            } ///////////////////end of sucuess

        }); /////////////////////////end of ajax

    } /////////////////////////////////////deptTrees

    function myClick(obj){
        $(obj).parent().children("div").click();
    }

    function searchOrg(obj)
    {
        let keyword  = $(obj).val()
       // console.log(keyword)
        if(!keyword){ //검색 조건이 비어 있을 때, 예외처리
            $("#codeList")[0].scrollIntoView();
            $(".myChecked").css("background-color","")
            return false;
    }

        $("li:contains('"+keyword+"')").eq(2);
        //console.log( $("li:contains('"+keyword+"')")) // 0:li / 1:li#d002 / 2:li#00031 -> .mychecked로 나옴
        //console.log( $("li:contains('"+keyword+"')").eq(2).parent().parent().children("div"))
        console.log($("li:contains('"+keyword+"')").eq(3).parent().parent().children("div"))
        //keyword를 포함한 결과값에서 나온 keyword.eq(2)가 도출됨
        let $pluscon = $("li:contains('"+keyword+"')").eq(2).parent().parent().children("div") // (인사부/총무부)옆에 (+) 버튼임.
        //console.log($pluscon)
        let $pluscon2 = $("li:contains('"+keyword+"')").eq(3).parent().parent().children("div") // 한 칸 이상
        //console.log($pluscon2)

        if($("li:contains('"+keyword+"')").eq(2).attr("lvl") == 5)
        {
            $($pluscon).parent("li").removeClass("expandable lastCollapsable") // expandable 및 lastCollapsable 클래스를 제거
            $($pluscon).parent("li").addClass("collapsable lastCollapsable") // 클래스 추가 어떤 동작을 하는가?
            $($pluscon).removeClass("hitarea expandable-hitarea lastExpandable-hitarea")
            $($pluscon).addClass("hitarea collapsable-hitarea lastCollapsable-hitarea")
            $($pluscon).parent("li").children("ul").css("display","block")
            $("li:contains('"+keyword+"')").eq(2)[0].scrollIntoView()
            $("li:contains('"+keyword+"')").eq(2)[0].click();
        }
        else{
            if($("li:contains('"+keyword+"')").eq(3)[0])
            {
                $($pluscon2).parent("li").removeClass("expandable lastExpandable")
                $($pluscon2).parent("li").addClass("collapsable lastCollapsable")
                $($pluscon2).removeClass("hitarea expandable-hitarea lastExpandable-hitarea");
                $($pluscon2).addClass("hitarea collapsable-hitarea lastCollapsable-hitarea");
                $($pluscon2).parent("li").children("ul").css("disply","block");
                $("li:contains('"+keyword+"')").eq(3)[0].scrollIntoView()
                $("li:contains('"+keyword+"')").eq(3)[0].click();
            }
        }

    }




    function moveRight() {
        if(!$("li").hasClass("myChecked")){
            alert("선택된 직원이 없습니다.");
            return false;
        }

        let str = "";
        let agencyStr = "";


        let empId = $(".myChecked").attr("id");
        let empName= $(".myChecked").text().trim();
        let deptName = $(".myChecked").parent().parent().children("a").text();
        let stName = $(".myChecked").attr("stName");

        if($("td").hasClass(empId)) // 같은 직원을 중복해서 쓸 때(td) 태그에서
        {
            alert('같은 직원은 선택할 수 없습니다.')
            return false;
        }

        if(empId === '${loginUser.emp_Id}') // 자기 자신일 떄
        {
            alert('자기 자신을 추가할 수 없습니다.')
            return false;
        }

        if(stName === '휴가중')
        {
            alert(empName+"님은"+stName+"인 상태입니다. 결재가 불가능합니다.")
            return false;
        }

        empName= empName.split("휴가중")[0];



        if(!$("td").hasClass("firTd")){
            str +='<td class="firTd style="padding-right: 0;">';
            str +='<select style="width: 65px;">';
            str +='<option>결재</option>';
            str +='<option>참조</option>';
            str +='</select>';
            str +='</td>';
            str +='<td class="firTd myName">'+empName+'</td>';
            str +='<td class="firTd myDeptName">'+deptName+'</td>';
            str +='<td class="firTd empTd '+empId+'" style="display:none" value="'+empId+'"></td>';
            str +='<td class="firTd"></td>';

            if(stName=='정상출근')
            {
                str += '<td class="firTd st"><span class ="badge badge-primary">' + stName + '</span></td>';
            }
            else if(stName==='지각'||stName==='조퇴')
            {
                str += '<td class="firTd st"><span class = "badge badge-danger">'+stName+ '</span></td>';
            }
            else {
                str += '<td class="firTd st"><span class="badge badge-success">' + stName + '</span></td>';
            }

            str +='<td class="firTd deleteEmp" style="cursor: pointer;" ><i class="fa fa-trash-o"></i></td>';
            str +='<td class="firTd"></td>';

            $("#appendTr").append(str);


        }
        else{

            str += '<tr>';
            str +='<input value="'+empId+'" style="display:none;">';
            str +='<td class="myTd style="padding-right: 0;">';
            str += '<select style="width: 65px">';
            str += '<option>결재</option>'
            str += '<option>참조</option>'
            str += '</select>'
            str += '</td>'

            str += '<td class="myTd myName">'+empName+'</td>'
            str += '<td class="myTd myDeptName">'+deptName+'</td>'
            str += '<td class="myTd empTd '+empId+'" style="display:none" value="'+empId+'"></td>';
            str += '<td class ="myTd"></td>'

            if(stName=='정상출근')
            {
                str += '<td class="myTd st"><span class ="badge badge-primary">' + stName + '</span></td>';
            }
            else if(stName==='지각'||stName==='조퇴')
            {
                str += '<td class="myTd" st><span class = "badge badge-danger">'+stName+ '</span></td>';
            }

            else {
                str += '<td class="myTd st"><span class="badge badge-success">' + stName + '</span></td>';
            }


            str +='<td class="myTd deleteEmp" style="cursor: pointer;" ><i class="fa fa-trash-o"></i></td>';
            str +='<td class="myTd"></td>';
            str +='</tr>';


            $("#appendTbody").append(str);
        }

        }///////////////////////end of moveRight


    $(document).on("click",".deleteEmp",function (){
        console.log($(this).parent().attr('id'))
        if($(this).parent().attr('id')=="appendTr"){ //여기서 this는?
            $(".firTd").remove()
        }
        else{
            $(this).parent().remove()
        }
    })


    $(document).on("click",".deleteAllEmp", function (){
        console.log($('.firId'))

        $('.firTd').remove()

        $('.myTd').parent().remove()

    })



    function empChecked(obj) {
        //기존 체크된 css 및 클래스 정보 삭제
        $(".myChecked").css("background-color","");
        $("li").removeClass("myChecked");

        //새로 체크된 css 및 클래스 정보 갱신
        $(obj).addClass("myChecked");
        $(".myChecked").css("background-color","#E2E2E2");
    }

    //열고 닫는 함수
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

    $(document).ready(function(){
        deptTrees();
        $("#refresh").click(function() {
            $("#codeList").empty();
            deptTrees();
        });
        $("#codeList").treeview({
            collapsed: true
        });
    });



</script>

<script type="text/javascript">
    $(function() {
        $("#browser").treeview();
    });
</script>