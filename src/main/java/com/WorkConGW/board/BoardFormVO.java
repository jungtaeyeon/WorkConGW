package com.WorkConGW.board;

import com.WorkConGW.board.anony.dto.AnonyReplyVO;
import com.WorkConGW.board.anony.dto.AnonyVO;
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

	public BoardFormVO() {
		this.noticeVO = new NoticeVO();
		this.searchNoticeVO = new NoticeVO();
		this.empVO = new EmpVO();
		this.searchEmpVO = new EmpVO();
		this.annoyVO = new AnonyVO();
		this.searchAnonyVO = new AnonyVO();
		this.annoyReplyVO= new AnonyReplyVO();
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
	public AnonyReplyVO getAnnoyReplyVO() {
		return this.annoyReplyVO;
	}

	public void setAnnoyReplyVO(AnonyReplyVO annoyReplyVO) {
		this.annoyReplyVO = annoyReplyVO;
	}

	public int getAnonyBoardId(){
		return this.annoyVO.getAnony_Board_Id();
	}
	public void setAnonyBoardId(int anonyBoardId){
		this.annoyVO.setAnony_Board_Id(anonyBoardId);

	}

	public AnonyVO getannoyVO() {
		return annoyVO;
	}

	public void setannoyVO(AnonyVO annoyVO) {
		this.annoyVO = annoyVO;
	}

	public AnonyVO getSearchAnonyVO()
	{
		return searchAnonyVO;
	}

	public void setSearchAnonyVO(AnonyVO searchAnonyVO)
	{
		this.searchAnonyVO=searchAnonyVO;
	}

}

