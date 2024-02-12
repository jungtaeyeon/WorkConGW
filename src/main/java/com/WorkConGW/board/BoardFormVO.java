package com.WorkConGW.board;

import com.WorkConGW.board.anony.dto.AnonyReplyVO;
import com.WorkConGW.board.anony.dto.AnonyVO;
import com.WorkConGW.board.duty.dto.DutyReplyVO;
import com.WorkConGW.board.duty.dto.DutyVO;
import com.WorkConGW.board.issue.dto.IssueReplyVO;
import com.WorkConGW.board.issue.dto.IssueVO;
import com.WorkConGW.board.notice.dto.NoticeVO;
import com.WorkConGW.common.command.FileUploadCommand;
import com.WorkConGW.emp.dto.EmpVO;
import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;

@Alias("boardFormVO")
public class BoardFormVO {

	private NoticeVO noticeVO;
	private NoticeVO searchNoticeVO;
	private EmpVO empVO;
	private EmpVO searchEmpVO;
	private FileUploadCommand fileUploadCommand;



	private AnonyVO annoyVO;
	private AnonyReplyVO annoyReplyVO;
	private AnonyVO searchAnonyVO;

	private DutyVO dutyVO;
	private DutyVO searchDutyVO;
	private DutyReplyVO dutyReplyVO;

	private IssueVO issueVO;
	private IssueVO searchIssueVO;
	private IssueReplyVO issueReplyVO;



	private String registParam;	// 등록창 기본값 세팅

	public BoardFormVO() {
		this.noticeVO = new NoticeVO();
		this.searchNoticeVO = new NoticeVO();
		this.empVO = new EmpVO();
		this.searchEmpVO = new EmpVO();
		this.annoyVO = new AnonyVO();
		this.searchAnonyVO = new AnonyVO();
		this.annoyReplyVO= new AnonyReplyVO();
		this.dutyVO = new DutyVO();
		this.searchDutyVO = new DutyVO();
		this.issueVO = new IssueVO();
		this.searchIssueVO = new IssueVO();
		this.issueReplyVO = new IssueReplyVO();
	}
	public FileUploadCommand getFileUploadCommand() {
		return fileUploadCommand;
	}

	public void setFileUploadCommand(FileUploadCommand fileUploadCommand) {
		this.fileUploadCommand = fileUploadCommand;
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
	public int getNotice_id() {
		return noticeVO.getNotice_id();
	}
	public void setNotice_id(int notice_id) {
		this.noticeVO.setNotice_id(notice_id);
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
	public AnonyVO getAnnoyVO() {
		return annoyVO;
	}

	public void setAnnoyVO(AnonyVO annoyVO) {
		this.annoyVO = annoyVO;
	}

	public AnonyReplyVO getAnnoyReplyVO() {
		return annoyReplyVO;
	}

	public void setAnnoyReplyVO(AnonyReplyVO annoyReplyVO) {
		this.annoyReplyVO = annoyReplyVO;
	}

	public AnonyVO getSearchAnonyVO() {
		return searchAnonyVO;
	}

	public void setSearchAnonyVO(AnonyVO searchAnonyVO) {
		this.searchAnonyVO = searchAnonyVO;
	}

	public DutyVO getDutyVO() {
		return dutyVO;
	}

	public void setDutyVO(DutyVO dutyVO) {
		this.dutyVO = dutyVO;
	}

	public DutyVO getSearchDutyVO() {
		return searchDutyVO;
	}

	public void setSearchDutyVO(DutyVO searchDutyVO) {
		this.searchDutyVO = searchDutyVO;
	}

	public DutyReplyVO getDutyReplyVO() {
		return dutyReplyVO;
	}

	public void setDutyReplyVO(DutyReplyVO dutyReplyVO) {
		this.dutyReplyVO = dutyReplyVO;
	}

	public IssueVO getIssueVO() {
		return issueVO;
	}

	public void setIssueVO(IssueVO issueVO) {
		this.issueVO = issueVO;
	}

	public IssueVO getSearchIssueVO() {
		return searchIssueVO;
	}

	public void setSearchIssueVO(IssueVO searchIssueVO) {
		this.searchIssueVO = searchIssueVO;
	}

	public IssueReplyVO getIssueReplyVO() {
		return issueReplyVO;
	}

	public void setIssueReplyVO(IssueReplyVO issueReplyVO) {
		this.issueReplyVO = issueReplyVO;
	}

	public String getRegistParam() {
		return registParam;
	}

	public void setRegistParam(String registParam) {
		this.registParam = registParam;
	}

	// detail 페이지용 id parameter 받기
	public int getDuty_Board_Id() {
		return this.dutyVO.getDuty_Board_Id();
	}
	public void set_DutyBoard_Id(int duty_Board_Id) {
		this.dutyVO.setDuty_Board_Id(duty_Board_Id);
	}
}

