package com.WorkConGW.board;

import com.WorkConGW.board.notice.dto.NoticeVO;
import com.WorkConGW.emp.dto.EmpVO;

public class BoardFormVO {
	
	private NoticeVO noticeVO;
	private NoticeVO searchNoticeVO;
	private EmpVO empVO;
	private EmpVO searchEmpVO;
	
	
	public BoardFormVO() {

		
		this.noticeVO = new NoticeVO();
		this.searchNoticeVO = new NoticeVO();
		this.empVO = new EmpVO();
		
	}
	


	// 사내공지
	public NoticeVO getNoticeVO() {
		return noticeVO;
	}
	public void setNoticeVO(NoticeVO noticeVO) {
		this.noticeVO = noticeVO;
	}
	public NoticeVO getSearchNoticeVO() {
		return searchNoticeVO;
	}
	public void setSearchNoticeVO(NoticeVO searchNoticeVO) {
		this.searchNoticeVO = searchNoticeVO;
	}
	public int getNoticeId() {
		return noticeVO.getNotice_id();
	}
	public void setNoticeId(int noticeId) {
		this.noticeVO.setNotice_id(noticeId);
	}
	
	//회원(직원)내정보
	public EmpVO getEmpVO() {
		return empVO;
	}
	public void setEmpVO(EmpVO empVO) {
		this.empVO = empVO;
	}
	public EmpVO getSearchEmpVO() {
		return searchEmpVO;
	}
	public void setSearchEmpVO(EmpVO searchEmpVO) {
		this.searchEmpVO = searchEmpVO;
	}
	




}
