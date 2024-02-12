<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp"%>
<style>
    .contentConteiner{
		margin:0 2%;
	}
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
    .profileImage{width: 250px; height: 250px; border-radius: 50%; border: 1px solid #000; overflow: hidden;}
    .profileImage img{width:100%; height: 100%;}
    .profileBtnGroup{
        display: flex;
        flex-direction: column;
        align-items: center; 
        margin-top: 5%;
    }
    .empDetailContent{display: flex;}
    .profileBtnGroup button{margin: 2% 0;}
    .profileContainer{margin-right: 5%;}
    .input-group-text{justify-content: center; width: 150px;}
    .textGroup{background-color: transparent; width: 300px;} 
</style>
<div class="contentConteiner">
    <div class="subTitleText"> <!--컨텐츠 부분 타이틀 클래스(이건 부트스트랩 클래스 아니고 임의로 만든 클래스)--> 
        <h2><i class="fa-solid fa-angles-right"></i> <!--왼쪽 아이콘 폰트어썸-->사원상세보기</h2>
    </div>
    <div class="empDetailContent">
        <div class="profileContainer">
            <div class="profileImage">
                <img src="/WorkConGW/pds/empPicture/e001정태연2024-02-01-17-57-48_12090.png">
            </div>
            <div class="profileBtnGroup">
                <button type="button" class="btn btn-primary">수정</button>
                <button type="button" class="btn btn-primary">목록</button>
                <button type="button" class="btn btn-primary">삭제</button>
            </div>
        </div>
        <div class="empInformation">
            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="manage_display_name">사원번호</span>
                </div>
                <span class="input-group-text textGroup" id="manage_display_name">xxxxx</span>
            </div>
            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="manage_display_name">사원명</span>
                </div>
                <span class="input-group-text textGroup" id="manage_display_name">홍길동</span>
            </div>
            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="manage_display_name">입사날짜</span>
                </div>
                <span class="input-group-text textGroup" id="manage_display_name">2024년02월12일</span>
            </div>
            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="manage_display_name">부서</span>
                </div>
                <span class="input-group-text textGroup" id="manage_display_name">경영부</span>
            </div>
            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="manage_display_name">직급</span>
                </div>
                <span class="input-group-text textGroup" id="manage_display_name">대리</span>
            </div>
            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="manage_display_name">이메일</span>
                </div>
                <span class="input-group-text textGroup" id="manage_display_name">kiwi@hot.co.kr</span>
            </div>
            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="manage_display_name">전화번호</span>
                </div>
                <span class="input-group-text textGroup" id="manage_display_name">010-1234-5678</span>
            </div>
            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="manage_display_name">주소</span>
                </div>
                <span class="input-group-text textGroup" id="manage_display_name">주소주소주소주소</span>
            </div>
            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="manage_display_name">주민등록번호</span>
                </div>
                <span class="input-group-text textGroup" id="manage_display_name">123456-1xxxxxx</span>
            </div>
            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="manage_display_name">권한</span>
                </div>
                <span class="input-group-text textGroup" id="manage_display_name">일반</span>
            </div>
        </div>
    </div>
    
</div>


<%@ include file="../../include/footer.jsp"%>