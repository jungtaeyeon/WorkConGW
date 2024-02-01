<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="root" value="<%=request.getContextPath() %>" scope="application"/>


<head>
    <!-- VENDOR CSS -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>

<style>

    .pagination{
        text-align: center;
    }

    #tr1{
        text-align: center;
        padding-left: -10px;

    }

    tbody{
        text-align: center;
    }

    .td2{
        /* 	text-align: left;  */
        /* 	padding-left: 80px; */
    }

    .num{
        width:80px;
    }


</style>

<body>

<!-- 메인 content -->
<div id="main-content">
    <div class="container-fluid">
        <div class="row clearfix" style="font-family: S-CoreDream-7ExtraBold ">
            <div class="col-12" style="margin-top: 2%;">
                <h2 style="font-family: S-CoreDream-6Bold"><i class="fa fa-comments-o"></i>&nbsp;익명 게시판</h2>
                <hr>
            </div>
        </div>
        <div class="row clearfix" style="font-family: S-CoreDream-7ExtraBold;">
            <div class="col-lg-12 col-md-12">
                <div class="card">
                    <div class="body project_report">
                        <form:form modelAttribute="boardFormVO" id="listForm"  method ="POST">
                        <!-- 리셋버튼 -->
                        <button id="resetBtn" type="reset" class="btn btn-default" title="Refresh" style="display: none;"></button>
                        <label onclick="conditionReset();"  style="cursor: pointer;">
                            <i class="fa fa-refresh"></i>&nbsp&nbsp검색 조건 초기화
                        </label>
                        <div style="display:inline-block;margin:5px 15px;font-size: 1.2em;color:gray;">
                            <span>총 게시물 ${totCnt} / 페이지(${searchAnonyVO.pageIndex} / ${totalPageCnt})</span>
                        </div>
                        <div>
                            <form:select path="searchAnonyVO.searchCondition" class="form-control selectSearch" style="width:130px;font-size: 1.2em;float:left;">
                                <form:option value="tc">전체</form:option>
                                <form:option value="t">제목</form:option>
                                <form:option value="c">내용</form:option>
                                <form:option value="r">댓글내용</form:option>
                            </form:select>

                            <div id="navbar-search" class="navbar-form search-form selectSearch" style="float:left;">
                                <form:input path="searchAnonyVO.searchKeyword" class="form-control" placeholder="검색어를 입력하세요" type="text" style="width: 218px;height:36px;padding-right: 40px;" onkeypress="checkEnter(searchList);"/>
                                <button type="button" class="btn btn-default" onclick="searchList();"><i class="icon-magnifier"></i></button>
                            </div>
                            <div class="form-group" style="float:right;">
                                <div style="display: inline-block;float:left;font-size: 1.2em;margin:6px 20px 0 0">
                                    <span>${paginationInfo.currentPageNo} </span>/<span> ${paginationInfo.totalRecordCount} 페이지 중</span>-
                                </div>
                                <form:select path="searchAnonyVO.pageUnit" class="form-control" style="width:130px;font-size: 1.2em;" onchange="searchList(1);">
                                    <form:options items="${boardFormVO.searchAnonyVO.pageUnitSelector}" itemValue="pageUnitValue" itemLabel="pageUnitLabel"/>
                                </form:select>
                            </div>
                        </div>
                        <!-- 게시판 목록 -->
                        <div class="body">
                            <div class="table-responsive">
                                <table class="table table-bordered" width="100%" cellspacing="0" style="text-align:center;">
                                    <thead class="shadow-none p-3 mb-5 bg-light rounded">
                                    <tr id="tr1">
                                        <th class="num" style="width: 105px; text-align: center;">번호</th>
                                        <th class="title" style="width: 300px;">제목</th>
                                        <th>작성일자</th>
                                        <th>조회수</th>
                                    </tr>
                                    </thead>
                                    <tbody class="listData">
                                    <c:set var="anony_Board_Id" value="${resultCnt - (searchVO.pageIndex -1) * paginationInfo.recordCountPerPage }" />

                                    <c:if test="${!empty resultList }">
                                        <c:forEach items="${resultList}" var="result">
                                            <tr class="memList"  role="row" onclick="OpenWindow('<%=request.getContextPath()%>/board/anony/detail?anonyBoardId=${anony.anony_Board_Id }', 'WorkConGW', 800, 700);">

                                                <td class="t_c" style="text-align:center;"><c:out value="${result.anony_Board_Id}"/></td>
                                                <td class="t_c" style="width: 60%;text-align: left; padding-left: 100px;"><c:out value = "${result.anony_Board_Title}"/>
                                                    <a href = "{root}/board/anony/read?anony_Board_Id=${anony_Board_Id}"></a>
                                                    <span style="width: 300px;"><c:out value = "${result.anony_Board_Title}"/></span>
                                                    <c:if test="${defferTime <= (1000*60*5) }">
                                                        &nbsp<span class="badge badge-danger">방금전</span>
                                                    </c:if>
                                                    <c:if test="${result.anonyReplyList.size() > 0 }">
                                                        <i class="icon-bubble text-info" style="margin-left:5px; font-size: 1.2em; font-weight: bold">
																		<span class="m-l-5" style="vertical-align: text-top; margin-left: 3px;">
																			<fmt:formatNumber value="${result.anonyReplyList.size() }" type="number"/>
																		</span>
                                                        </i>
                                                    </c:if>
                                                </td>
                                                <td class = "t_c">
                                                    <fmt:formatDate value="${result.anony_Board_Create_Dt }" pattern="yyyy.MM.dd"/>
                                                </td>
                                                <td class = "t_c" style="text-align:center;"><c:out value = "${result.anony_Board_ReadCnt}"/></td>
                                            </tr>
                                        </c:forEach>
                                    </c:if>

                                    <tr>
                                        <td style="text-align: center;"><strong>해당 내용이 없습니다.</strong></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>


                        <div class="board-list-paging fr">
                            <c:set var="pageIndex" value="1"/>
                            <ol class="pagination" id="pagination">
                                <c:if test="${searchVO.prev}">
                                    <li class="prev_end">
                                        <a href="javascript:void(0);" onclick="searchList(1); return false;"></a>
                                    </li>
                                    <li class="prev">
                                        <a href="javascript:void(0);"  onclick="searchList(${searchVO.startDate - 1}); return false;"></a>
                                    </li>
                                </c:if>
                                <c:forEach var="num" begin="${searchVO.startDate}" end="${searchVO.endDate}">
                                    <li>
                                        <a href="javascript:void(0);" onclick="searchList(${num}); return false;" class="num ${pageIndex eq num ? 'on':'' }" title="${num}">${num}</a>
                                    </li>
                                </c:forEach>
                                <c:if test="${searchVO.next}">
                                    <li class="next">
                                        <a href="javascript:void(0);"  onclick="searchList(${searchVO.endDate + 1}); return false;"></a>
                                    </li>
                                    <li class="next_end">
                                        <a href="javascript:void(0);" onclick="searchList(${searchVO.realEnd }); return false;"></a>
                                    </li>
                                </c:if>
                            </ol>
                        </div>

                        </form:form>


</body>

<script type="text/javascript">
    function searchList(pageNo){
        //////////////////////////////////////////비동기 처리 Start////////////////////////////////////////
        let submitObj = new Object();
        submitObj.pageIndex = pageNo;
        submitObj.searchWrd = $("#searchAnonyVO.searchKeyword").val();

        console.log(submitObj.searchWrd);
        console.log(submitObj.pageIndex);

        $.ajax({
            url: "${root}/board/list/paging",  // 여기서 경로를 수정
            type:"POST",
            contentType : "application/json;charset=UTF-8",
            data : JSON.stringify(submitObj),
            dataType : "json",
            progress : true
        }).done(function(data){

            let result = new Array();
            result = data.resultList;
            let searchVO = data.searchVO;
            let realEnd = searchVO.realEnd;
            let startDate = searchVO.startDate;
            let startButtonDate  = startDate -1;
            let endDate = searchVO.endDate;
            let endButtonDate = endDate+1;
            let pageIndex = searchVO.pageIndex;
            let resultCnt = data.resultList;
            let totalPageCnt = data.totalPageCnt;
            let recordCountPerPage = searchVO.recordCountPerPage;

            let anony_Board_Id = (resultCnt - (pageIndex - 1) * recordCountPerPage);

            let content = '';
            let content2 = '';

            $.each(result, function(key, value) {
                content +=    '<tr class="memList">';
                content +=    '<td class="t_c">' + anony_Board_Id + '</td>';
                content +=    '<td class="t_c">' + value.anony_Board_Title + '</td>';
                content +=    '<td class="t_c">' + value.anony_Board_Create_Dt + '</td>';
                content +=    '<td class="t_c">' + value.anony_Board_ReadCnt + '</td>';
                content +=    '</tr>';
                anony_Board_Id--;
            })

            $(".listData").html(content);
            content2 = '<form:hidden path="pageIndex" />';  // 여기서 path 수정
            content2 += '<ol class="pagination" id="pagination">'

            if(searchVO.prev){
                content2 +=    '<li class="prev_end"><a href="javascript:void(0);" onclick="searchList(1); return false;" ></a></li>';
                content2 +=    '<li class="prev"><a href="javascript:void(0);"  onclick="searchList(' + startButtonDate + '); return false;" ></a></li>';
            }

            for (var num=startDate; num<=endDate; num++) {
                if (num == pageIndex) {
                    content2 +=    '<li><a href="javascript:void(0);" onclick="searchList(' + num + '); return false;" title="' + num + '"  class="num on">' + num + '</a></li>';
                } else {
                    content2 +=    '<li><a href="javascript:void(0);" onclick="searchList(' + num + '); return false;" title="' + num + '" class="num">' + num + '</a></li>';
                }
            }

            if(searchVO.next){
                content2 +=    '<li class="next"><a href="javascript:void(0);"  onclick="searchList(' + endButtonDate + '); return false;" ></a></li>';
                content2 +=    '<li class="next_end"><a href="javascript:void(0);" onclick="searchList(' + searchVO.realEnd +'); return false;"></a></li>';
            }

            content2 +=    '</ol>';
            content2 +=    '</div>';

            $(".board-list-paging").html(content2);

        }).fail(function(e){
            alert("검색에 실패했습니다.")
        }).always(function(){

        });
    }


</script>
