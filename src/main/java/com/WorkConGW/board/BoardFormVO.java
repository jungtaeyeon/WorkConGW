package com.WorkConGW.board;

import com.WorkConGW.board.anony.dto.AnonyReplyVO;
import com.WorkConGW.board.anony.dto.AnonyVO;
import com.WorkConGW.board.duty.dto.DutyProgressVO;
import com.WorkConGW.board.duty.dto.DutyReplyVO;
import com.WorkConGW.board.duty.dto.DutyVO;
import com.WorkConGW.board.issue.dto.IssueReplyVO;
import com.WorkConGW.board.issue.dto.IssueVO;
import com.WorkConGW.board.issue.dto.ProjectVO;
import com.WorkConGW.board.notice.dto.NoticeVO;
import com.WorkConGW.common.command.FileUploadCommand;
import com.WorkConGW.emp.dto.EmpVO;
import lombok.ToString;
import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;



@ToString
@Alias("boardFormVO")
public class BoardFormVO {

	private NoticeVO noticeVO;
	private NoticeVO searchNoticeVO;
	private EmpVO empVO;
	private EmpVO searchEmpVO;
	private FileUploadCommand fileUploadCommand;



	private AnonyVO anonyVO;
	private AnonyReplyVO anonyReplyVO;



	private AnonyReplyVO searchanonyReplyVO;
	private AnonyVO searchAnonyVO;

	private DutyVO dutyVO;
	private DutyVO searchDutyVO;
	private DutyReplyVO dutyReplyVO;

	private IssueVO issueVO;
	private IssueVO searchIssueVO;
	private IssueReplyVO issueReplyVO;

	private List<ProjectVO> projectVO;

	private DutyProgressVO dutyProgressVO;



	private String registParam;	// 등록창 기본값 세팅

	public BoardFormVO() {
		this.noticeVO = new NoticeVO();
		this.searchNoticeVO = new NoticeVO();
		this.empVO = new EmpVO();
		this.searchEmpVO = new EmpVO();
		this.anonyVO = new AnonyVO();
		this.searchAnonyVO = new AnonyVO();
		this.anonyReplyVO= new AnonyReplyVO();
		this.dutyVO = new DutyVO();
		this.searchDutyVO = new DutyVO();
		this.issueVO = new IssueVO();
		this.searchIssueVO = new IssueVO();
		this.issueReplyVO = new IssueReplyVO();
		this.searchanonyReplyVO = new AnonyReplyVO();
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

	/* ////////////////////////////////익명게시판//////////////////////////////// */
	public AnonyReplyVO getAnonyReplyVO() {
		return this.anonyReplyVO;
	}

	public void setAnonyReplyVO(AnonyReplyVO anonyReplyVO) {
		this.anonyReplyVO = anonyReplyVO;
	}

	public int getAnonyBoardId(){
		return this.anonyVO.getAnony_Board_Id();
	}
	public void setAnonyBoardId(int anony_Board_Id){
		this.anonyVO.setAnony_Board_Id(anony_Board_Id);

	}

	public AnonyVO getAnonyVO() {
		return this.anonyVO;
	}
	
	public void setAnonyVO(AnonyVO anonyVO) {
		this.anonyVO = anonyVO;
	}

	public AnonyVO getSearchAnonyVO()
	{
		return searchAnonyVO;
	}

	public void setSearchAnonyVO(AnonyVO searchAnonyVO)
	{
		this.searchAnonyVO=searchAnonyVO;
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
	public void setDuty_Board_Id(int duty_Board_Id) {
		this.dutyVO.setDuty_Board_Id(duty_Board_Id);
	}
	public AnonyReplyVO getSearchanonyReplyVO() {
		return searchanonyReplyVO;
	}

	public void setSearchanonyReplyVO(AnonyReplyVO searchanonyReplyVO) {
		this.searchanonyReplyVO = searchanonyReplyVO;
	}

	public List<ProjectVO> getProjectVO() {
		return projectVO;
	}

	public void setProjectVO(List<ProjectVO> projectVO) {
		this.projectVO = projectVO;
	}

	/* 업무 조회 구분을 위해 추가 */
	public String getDutyType() {
		return dutyVO.getDutyType();
	}
	public void setDutyType(String dutyType) {
		this.dutyVO.setDutyType(dutyType);
	}

	/* 이슈 디테일 조회를 위해 추가 */
	public int getIssue_Board_Id() {
		return issueVO.getIssue_Board_Id();
	}
	public void setIssue_Board_Id(int issue_board_id) {
		this.issueVO.setIssue_Board_Id(issue_board_id);
	}

	public DutyProgressVO getDutyProgressVO() {
		return dutyProgressVO;
	}

	public void setDutyProgressVO(DutyProgressVO dutyProgressVO) {
		this.dutyProgressVO = dutyProgressVO;
	}
}

