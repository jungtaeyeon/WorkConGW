package com.WorkConGW.board.notice.dto;

import com.WorkConGW.common.dto.AttachVO;

public class NoticeAttachVO extends AttachVO{
	private int noticeId;
	
	public NoticeAttachVO() {};
	public NoticeAttachVO(AttachVO attachVO) {
		setAttachPath(attachVO.getAttachPath());
		setAttachName(attachVO.getAttachName());
		setAttachType(attachVO.getAttachType());
		
	}
	public int getNoticeId() {
		return noticeId;
	}
	public void setNoticeId(int noticeId) {
		this.noticeId = noticeId;
	}
	
}
