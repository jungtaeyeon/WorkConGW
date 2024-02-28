<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            margin-bottom: 10px;
        }
        #serchForm{display: flex;}
        .serchTextGroup{display: flex;}
        .serchTextGroup span{
            font-size: 19px;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0px 10px;
        } 
        .tableCheckBox{text-align: center; vertical-align: middle !important;}
		.tardy{
			background: red;
			color: #fff;
			padding: 5px 10px;
			border-radius: 6px;
		}
		.goWork{
			color: #fff;
			padding: 5px 10px;
			border-radius: 6px;
		}
		.goWork0{background-color: #77af9c;}
		.goWork1{background: green;}
		.goWork2{background-color: #ce6d39;}
		.goWork3{background-color: #c82333;}
		.goWork4{background-color: #6aafe6;}
		.goWork5{background-color: #ff5f2e;}
		/* 모달 css */
		.show{background-color: rgba(0, 0, 0, 0.7);}
		.modalBtn{cursor: pointer;}
		.modal-body p{font-size: 16px;}
		.modal-body .modalSubTit{
			display: inline-block;
    		margin-right: 15px;
			vertical-align: top;
            width: 69px;
		}
        .treeviewGroup{width: 300px; height: 500px; border:1px solid #000; overflow-y: scroll;}
        .subContentContainer{display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 5%;}
        .serchContainer{margin-right: 2%;}
        .pagination{
            justify-content: center;
        }
    </style>
    <%@ include file="../include/header.jsp"%>

	<section class="subPageContain">

		<!-- 사이드바 -->
		<%@ include file="./sideBar.jsp"%>
		
		<!--컨텐츠 영역-->
		<div class="contentConteiner">
			<div class="subTitleText"> <!--컨텐츠 부분 타이틀 클래스(이건 부트스트랩 클래스 아니고 임의로 만든 클래스)--> 
				<h2><i class="fa-solid fa-angles-right"></i> <!--왼쪽 아이콘 폰트어썸-->부서 근태관리</h2>
			</div>
            <div class="subContentContainer">
                <div class="serchContainer">
                    <div class="treeviewGroup">
                        <div class="body">
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
                <div style="width: 100%;">
                    <div class="serchContain">
                        <div class="serchTextGroup">
                            <input type="date" name="startTime" class="form-control"> 
                            <span>~</span>
                            <input type="date" name="endTime" class="form-control"> 
                        </div>
                        <button class="btn btn-outline-secondary" style="width: 60px;" onclick="serchBtn()" name="serchBtn" type="button">검색</button>
                        <button class="btn btn-outline-secondary" style="width: 75px; margin-left: 6px;" onclick="initializeButton()" name="serchBtn" type="button">초기화</button>
                    </div>
                    <table class="table table-hover"> <!-- 부트스트랩 게시판 -->
                        <thead class="thead-light"> <!-- 게시판 맨위 색변경 클래스-->
                            <tr>
                                <th>날짜</th>
                                <th>이름</th>
                                <th>직급</th>
                                <th>출근시간</th>
                                <th>퇴근시간</th>
                                <th>상태</th>
                                <th>근태사유</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                    <ul class="pagination" id="pagination"></ul>
                </div>
            </div>
		</div>
	</section>
    <div class="modalContainer">

    </div>



	<!-- 푸터 인클루드 -->
	<%@ include file="../include/footer.jsp"%>

    <script>
        
        let startSeartTime;
        let endSeartTime;
        let itemsPerPage = 5;
        let currentPage = 1;
        let today = new Date();

        window.onload = function(){
            deptTrees();
        }

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
                            li = '<li onclick="empChecked(this);" data-deptId="'+deptSupId+'" data-empId="'+deptId+'" data-name="'+deptName+" "+position+'" data-dept="'+deptSupName+'" data-state="'+(empState==null ? '' : empState)+'" ondblclick="addEmpList();" id="'+ deptId +'" lvl="'+level +'" class="myChecked" style="cursor:pointer" ><img src="${pageContext.request.contextPath }/pds/emp.png" style="width:20px; height:20px;">'+" "+ deptName + " "+e.position+'</li>';
                        }else{
                            li = '<li id="'+ deptId +'" lvl="'+level +'"><a data-deptid="'+ deptId +'" class="file code" style="cursor: pointer; color: #000;" onclick="myClick(this);" >'+ deptName +'&nbsp&nbsp<i data-id="'+deptId+'" data-name="'+deptName+'" style="color:#383d41; cursor:pointer;"></i></a></li>';
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
        let data;
        function selectAjax(data, callback){
            $.ajax({
                type: "get",
                url: "/WorkConGW/attend/attendSelect",
                data: data,
                success: function(response) {
                    callback(response);
                },
                error: function(xhr, status, error) {
                // 오류 처리
                console.error(xhr.responseText);
                }
            });
        }

        // 페이지 업데이트 호출
        function empChecked(obj) {
            //기존 체크된 css 및 클래스 정보 삭제
            $(".myChecked").css("background-color","");
            $("li").removeClass("myChecked");
            //새로 체크된 css 및 클래스 정보 갱신
            $(obj).addClass("myChecked");
            $(".myChecked").css("background-color","#2980b9");
            data = {emp_id: $(obj).data('empid')}
            selectAjax(data, function(response){
                data = response
                updatePage(currentPage);
            });
        }

        function myClick(obj){
            data = {dept_id: $(obj).data('deptid')};
            selectAjax(data, function(response){
                data = response
                updatePage(currentPage);
            });
            
        }
        function addZero(num) {
            return (num < 10 ? '0' : '') + num;
        }
        function serchBtn(){
            updatePage(currentPage);
        }

        function initializeButton() {
            $('input[name="startTime"]').val('');
            $('input[name="endTime"]').val('');
            updatePage(currentPage);
        }

        // 페이지를 업데이트하는 함수
        function updatePage(page) {
            let startIndex = (page - 1) * itemsPerPage;
            let endIndex = startIndex + itemsPerPage;
            if($('input[name="startTime"]').val() == ''){
                startSeartTime = '1998-05-15';
                endSeartTime = today.getFullYear() + '-' + addZero(today.getMonth() + 1) + '-' + addZero(today.getDate());
            }else{
                startSeartTime = $('input[name="startTime"]').val();
                endSeartTime = $('input[name="endTime"]').val();
            }

            let searchDataFiltered = data.filter(function(e) {
                return (e.HISTORY_ATTEND_DAY >= startSeartTime && e.HISTORY_ATTEND_DAY <= endSeartTime);
            });

            let pageData = searchDataFiltered.slice(startIndex, endIndex);

            $('.table tbody').find('.modalBtn').remove();
            $('.modalContainer').find('.modal').remove();
            pageData.forEach(function(e, i) {
                e.HISTORY_ATTEND_DAY = e.HISTORY_ATTEND_DAY || '';
                e.EMP_NAME = e.EMP_NAME || '';
                e.CODE_NAME = e.CODE_NAME || '';
                e.HISTORY_ATTEND_TIME = e.HISTORY_ATTEND_TIME || '';
                e.HISTORY_LEAVING_TIME = e.HISTORY_LEAVING_TIME || '';
                e.ATTEND_ST_NAME = e.ATTEND_ST_NAME || '';
                e.HISTORY_REASON = e.HISTORY_REASON || '';

                let text = `
                    <tr class="modalBtn" data-toggle="modal" data-target="#staticBackdrop` + i + `">
                        <td>` + e.HISTORY_ATTEND_DAY + `</td>
                        <td>` + e.EMP_NAME + `</td>
                        <td>` + e.CODE_NAME + `</td>
                        <td>` + e.HISTORY_ATTEND_TIME + `</td>
                        <td>` + e.HISTORY_LEAVING_TIME + `</td>
                        <td><span class="goWork goWork` + e.ATTEND_ST_ID + `">` + e.ATTEND_ST_NAME + `</span></td>
                        <td>` + e.HISTORY_REASON + `</td>
                    </tr>
                `;
                $('tbody').append(text);
                let modal = `
                    <div class="modal fade" id="staticBackdrop` + i + `" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="staticBackdropLabel">` + e.EMP_NAME + `</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <p><span class="modalSubTit">날짜</span>` + e.HISTORY_ATTEND_DAY + `</p>
                                    <p><span class="modalSubTit">직급</span>` + e.CODE_NAME + `</p>
                                    <p><span class="modalSubTit">출근시간</span>` + e.HISTORY_ATTEND_TIME + `</p>
                                    <p><span class="modalSubTit">퇴근시간</span>` + e.HISTORY_LEAVING_TIME + `</p>
                                    <p><span class="modalSubTit">출근상태</span><span class="goWork goWork` + e.ATTEND_ST_ID + `">` + e.ATTEND_ST_NAME + `</span></p>
                                    <p><span class="modalSubTit">지각사유</span><span style="display: inline-block;">` + e.HISTORY_REASON + `</span></p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                `;
                $('.modalContainer').append(modal);
            });

            $('.pagination').find('li').remove();

            // 검색된 데이터에 따라 페이지 버튼을 생성
            for (var i = 1; i <= Math.ceil(searchDataFiltered.length / itemsPerPage); i++) {
                let button = `
                    <li class="paginate_button page-item">
                        <a href="javascript:void(0);" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">`+i+`</a>
                    </li>
                `;
                let buttonElement = $(button); // 문자열을 jQuery 객체로 변환
                console.log(buttonElement);
                buttonElement.click(function() {
                    currentPage = parseInt($(this).text());
                    updatePage(currentPage);
                });

                $('.pagination').append(buttonElement);
            }                                           
        }
    </script>