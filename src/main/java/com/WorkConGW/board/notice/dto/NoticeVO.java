package com.WorkConGW.board.notice.dto;

import com.WorkConGW.common.dto.AttachVO;
import com.WorkConGW.common.dto.BaseVO;
import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

@Alias("NoticeVO")
public class NoticeVO extends BaseVO{

    private int notice_id;
    private String notice_title;
    private String notice_content;
    private int notice_readcnt;
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private Date notice_create_dt; // string이 아니라 Date로 바꾸면 문제가 되는지?..
    private Date notice_update_dt;
    private String notice_important_yn;
    private String emp_writer_id;
    private String notice_update_id;
    private String emp_Name;
    private String officialName;
    private List<AttachVO> noticeAttachList;
    private int attachCount;
    private String searchDt;

    public NoticeVO(){}

    public NoticeVO(int notice_id, String notice_title, String notice_content, int notice_readcnt, Date notice_create_dt, Date notice_update_dt, String notice_important_yn, String emp_writer_id, String notice_update_id, String emp_Name, String officialName, List<AttachVO> noticeAttachList, int attachCount, String searchDt) {
        this.notice_id = notice_id;
        this.notice_title = notice_title;
        this.notice_content = notice_content;
        this.notice_readcnt = notice_readcnt;
        this.notice_create_dt = notice_create_dt;
        this.notice_update_dt = notice_update_dt;
        this.notice_important_yn = notice_important_yn;
        this.emp_writer_id = emp_writer_id;
        this.notice_update_id = notice_update_id;
        this.emp_Name = emp_Name;
        this.officialName = officialName;
        this.noticeAttachList = noticeAttachList;
        this.attachCount = attachCount;
        this.searchDt = searchDt;
    }


    public int getNotice_id() {
        return this.notice_id;
    }

    public void setNotice_id(int notice_id) {
        this.notice_id = notice_id;
    }

    public String getNotice_title() {
        return this.notice_title;
    }

    public void setNotice_title(String notice_title) {
        this.notice_title = notice_title;
    }

    public String getNotice_content() {
        return this.notice_content;
    }

    public void setNotice_content(String notice_content) {
        this.notice_content = notice_content;
    }

    public int getNotice_readcnt() {
        return this.notice_readcnt;
    }

    public void setNotice_readcnt(int notice_readcnt) {
        this.notice_readcnt = notice_readcnt;
    }


    public Date getNotice_create_dt() {
        return this.notice_create_dt;
    }

    public void setNotice_create_dt(Date notice_create_dt) {
        this.notice_create_dt = notice_create_dt;
    }

    public Date getNotice_update_dt() {
        return this.notice_update_dt;
    }

    public void setNotice_update_dt(Date notice_update_dt) {
        this.notice_update_dt = notice_update_dt;
    }

    public String getNotice_important_yn() {
        return this.notice_important_yn;
    }

    public void setNotice_important_yn(String notice_important_yn) {
        this.notice_important_yn = notice_important_yn;
    }

    public String getEmp_writer_id() {
        return this.emp_writer_id;
    }

    public void setEmp_writer_id(String emp_writer_id) {
        this.emp_writer_id = emp_writer_id;
    }

    public String getNotice_update_id() {
        return this.notice_update_id;
    }

    public void setNotice_update_id(String notice_update_id) {
        this.notice_update_id = notice_update_id;
    }

    public String getEmp_Name() {
        return emp_Name;
    }

    public void setEmp_Name(String emp_Name) {
        this.emp_Name = emp_Name;
    }

    public String getOfficialName() {
        return officialName;
    }

    public void setOfficialName(String officialName) {
        this.officialName = officialName;
    }

    public List<AttachVO> getNoticeAttachList() {
        return this.noticeAttachList;
    }

    public void setNoticeAttachList(List<AttachVO> noticeAttachList) {
        this.noticeAttachList = noticeAttachList;
    }

    public int getAttachCount() {
        return this.attachCount;
    }

    public void setAttachCount(int attachCount) {
        this.attachCount = attachCount;
    }

    public String getSearchDt() {
        return this.searchDt;
    }

    public void setSearchDt(String searchDt) {
        this.searchDt = searchDt;
    }


    
 
	
}
