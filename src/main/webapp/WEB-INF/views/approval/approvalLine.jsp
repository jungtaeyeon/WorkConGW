<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
</style>
<%@ include file="../include/header.jsp"%>
<section class="subPageContain">

    <!-- 사이드바 -->
    <%@ include file="./sideBar.jsp"%>
    
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
                <div class="approvalLineTreeview"></div>
            </div>

            <div class="approvalLineEmpTableGroup">

                <div class="serchContain"> 
                    <form action="" id="serchForm">
                        <div class="serchTextGroup">
                            <input type="text" name="searchText" class="form-control" placeholder="사원명을 입력해주세요" aria-label="입력해주세요"> 
                        </div>
                    </form>
                    <button class="btn btn-outline-secondary" onclick="serchBtn()" name="serchBtn" type="button">검색</button>
                </div>

                <table class="table table-hover"> <!-- 부트스트랩 게시판 -->
                    <thead class="thead-light"> <!-- 게시판 맨위 색변경 클래스-->
                        <tr>
                            <th class="tableCheckBox"><input type="checkbox"/></th>
                            <th>부서</th>
                            <th>직급</th>
                            <th>사원명</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th class="tableCheckBox"><input type="checkbox"/></th>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                        </tr>
                        <tr>
                            <th class="tableCheckBox"><input type="checkbox"/></th>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                        </tr>
                        <tr>
                            <th class="tableCheckBox"><input type="checkbox"/></th>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                            <td>xxxxx</td>
                        </tr>
                    </tbody>
                </table>

                <div class="empBtnGroup">
                    <button type="button" class="btn btn-primary">결재</button>
                    <button type="button" class="btn btn-primary">수신참조</button>
                </div>

                <div class="approvalLineResult">
                    <div class="approvalLineBox">
                        <p class="approvalLineBoxTit">결재자</p>
                        <div class="approvalLineBoxContent">
                        </div>
                    </div>
                    
                    <div class="approvalLineBox">
                        <p class="approvalLineBoxTit">수신참조자</p>
                        <div class="approvalLineBoxContent">
                        </div>
                    </div>
                    
                </div>
                <button type="button" class="btn btn-primary btn-lg btn-block">결재라인 저장</button>
            </div>
        </div>
    </div>
</section>

<!-- 푸터 인클루드 -->
<%@ include file="../include/footer.jsp"%>