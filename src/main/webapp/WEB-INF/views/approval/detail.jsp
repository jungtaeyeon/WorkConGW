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
        <div class="subTitleText"> <!--컨텐츠 부분 타이틀 클래스(이건 부트스트랩 클래스 아니고 임의로 만든 클래스)--> 
            <h2><i class="fa-solid fa-angles-right"></i> <!--왼쪽 아이콘 폰트어썸-->결재 대기 문서</h2>
            <div class="btnGroup">
                <button type="button" class="btn btn-primary">결재</button>
                <button type="button" class="btn btn-primary">반려</button>
                <button type="button" class="btn btn-primary">수정</button>
            </div>
        </div>
        <form>
            <table class="table table-bordered">
                <tbody>
                    <tr>
                        <th class="theadS" scope="row">품의 번호</th>
                        <td colspan="2">xxxxxx</td>
                        <td class="theadS">품의 일자</td>
                        <td colspan="2">xxxxx</td>
                    </tr>
                    <tr>
                        <th class="theadS" scope="row">품의 부서</th>
                        <td colspan="2">xxxxxx</td>
                        <td class="theadS">품의자</td>
                        <td colspan="2">xxxxx</td>
                    </tr>
                    <tr>
                        <th class="theadS" scope="row">구분</th>
                        <td colspan="2">xxxxxx</td>
                        <td class="theadS">기간</td>
                        <td colspan="2">xxxxx</td>
                    </tr>

                    <tr>
                        <th class="thead" scope="row">결재</th>
                        <td class="theadText">기안자</td>
                        <td class="theadText">과장</td>
                        <td class="theadText">부장</td>
                        <td class="theadText"></td>
                        <td class="theadText"></td>
                    </tr>
                    <tr>
                        <th class="theadS" scope="row">수신참조자</th>
                        <td colspan="5">홍길동</td>
                    </tr>
                    <tr>
                        <th class="theadS" scope="row">제목</th>
                        <td colspan="5">xxxxx</td>
                    </tr>
                    <tr>
                        <th class="theadS" scope="row">파일업로드</th>
                        <td colspan="5">
                            <a href="#">xxxx.cell</a>
                        </td>
                    </tr>
                </tbody>
            </table> 
            <div class="formWriter">
                
            </div>
        </form>
    </div>    
</section>

<!-- 푸터 인클루드 -->
<%@ include file="../include/footer.jsp"%>