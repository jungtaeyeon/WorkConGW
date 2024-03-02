package com.WorkConGW.common.dto;

import com.WorkConGW.board.notice.dto.NoticeVO;

public class HomeFormVO extends BaseVO{
    private NoticeVO noticeVO;
    
    public HomeFormVO(){
        this.noticeVO = new NoticeVO();
    }

    public void setNoticeVO(NoticeVO noticeVO) {
        this.noticeVO = noticeVO;
    }
    public NoticeVO getNoticeVO() {
        return noticeVO;
    }
}
