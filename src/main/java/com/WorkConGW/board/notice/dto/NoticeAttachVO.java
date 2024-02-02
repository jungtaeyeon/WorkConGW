package com.WorkConGW.board.notice.dto;

import com.WorkConGW.common.dto.AttachVO;
import org.apache.ibatis.type.Alias;

@Alias("NoticeAttachVO")
public class NoticeAttachVO extends AttachVO{
	private int notice_id;
	
	public NoticeAttachVO() {};
	public NoticeAttachVO(AttachVO attachVO) {
		setAttach_path(attachVO.getAttach_path());
		setAttach_name(attachVO.getAttach_name());
		setAttach_type(attachVO.getAttach_type());
	}
	public int getNotice_id() {
		return notice_id;
	}
	public void setNotice_id(int notice_id) {
		this.notice_id = notice_id;
	}
	
}
