package com.WorkConGW.board.duty.dto;

import com.WorkConGW.board.duty.command.DutyManagerCommand;
import com.WorkConGW.board.duty.command.DutyReceptionCommand;
import com.WorkConGW.board.duty.command.DutyReceptionDeptCommand;
import com.WorkConGW.common.dto.AttachVO;
import com.WorkConGW.common.dto.BaseVO;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.ibatis.type.Alias;

import java.util.Date;
import java.util.List;

@Alias("DutyVO")
public class DutyVO extends BaseVO {
    private int duty_Board_Id;
    private String duty_Board_Title;
    private String duty_Board_Content;
    private int duty_Board_Readcnt;
    private Date duty_Board_Create_Dt;
    private Date duty_Board_Update_Dt;
    private String duty_Updater_Id;
    @JsonFormat(pattern = "MM/dd/yyyy")
    private Date duty_Board_End_Dt;
    private String emp_Writer_Id;
    private int dept_Cnt;
    private int emp_Cnt;
    private int duty_Board_Security;


    private String[] empManagerList;	// 담당자 아이디 목록
    private String[] empReceptionList;	// 담당자 아이디 목록
    private String[] empReceptionDeptList;	// 담당자 아이디 목록
    private List<DutyManagerCommand> dutyManagerList;	// 담당자 목록
    private List<DutyReceptionCommand> receptionList; //참조자 목록
    private List<DutyReceptionDeptCommand> receptionDeptList; //참조자 목록


    private List<AttachVO> attachList;	// 첨부 파일 목록(저장용)
    private List<DutyAttachVO> dutyAttachList;	// 첨부파일 목록(불러오기용)
    private String emp_Name;		// 팀장 이름
    private String emp_Id;		// 팀장 이름
    private String emp_Picture;	// 팀장 사진
    private int attachCount;	// 첨부 파일 개수

    private List<DutyReplyVO> dutyReplyList;	// 댓글 목록
    private int reply_Count; // 댓글수

    // 검색조건
    private String searchDeadline = "";	// 완료 기한
    private String searchState = "";	// 진행 상태
    private String searchDept = "";	// 부서/팀

    private String dutyBoardCreateDtStr; // 문자형 작성일자

    private String dutyType;	// 업무게시판 분류
    private String modifiable = "Y";	// 수정가능여부

    public int getDuty_Board_Id() {
        return duty_Board_Id;
    }

    public void setDuty_Board_Id(int duty_Board_Id) {
        this.duty_Board_Id = duty_Board_Id;
    }

    public String getDuty_Board_Title() {
        return duty_Board_Title;
    }

    public void setDuty_Board_Title(String duty_Board_Title) {
        this.duty_Board_Title = duty_Board_Title;
    }

    public String getDuty_Board_Content() {
        return duty_Board_Content;
    }

    public void setDuty_Board_Content(String duty_Board_Content) {
        this.duty_Board_Content = duty_Board_Content;
    }

    public int getDuty_Board_Readcnt() {
        return duty_Board_Readcnt;
    }

    public void setDuty_Board_Readcnt(int duty_Board_Readcnt) {
        this.duty_Board_Readcnt = duty_Board_Readcnt;
    }

    public Date getDuty_Board_Create_Dt() {
        return duty_Board_Create_Dt;
    }

    public void setDuty_Board_Create_Dt(Date duty_Board_Create_Dt) {
        this.duty_Board_Create_Dt = duty_Board_Create_Dt;
    }

    public Date getDuty_Board_Update_Dt() {
        return duty_Board_Update_Dt;
    }

    public void setDuty_Board_Update_Dt(Date duty_Board_Update_Dt) {
        this.duty_Board_Update_Dt = duty_Board_Update_Dt;
    }

    public String getDuty_Updater_Id() {
        return duty_Updater_Id;
    }

    public void setDuty_Updater_Id(String duty_Updater_Id) {
        this.duty_Updater_Id = duty_Updater_Id;
    }

    public Date getDuty_Board_End_Dt() {
        return duty_Board_End_Dt;
    }

    public void setDuty_Board_End_Dt(Date duty_Board_End_Dt) {
        this.duty_Board_End_Dt = duty_Board_End_Dt;
    }

    public String getEmp_Writer_Id() {
        return emp_Writer_Id;
    }

    public void setEmp_Writer_Id(String emp_Writer_Id) {
        this.emp_Writer_Id = emp_Writer_Id;
    }

    public int getDept_Cnt() {
        return dept_Cnt;
    }

    public void setDept_Cnt(int dept_Cnt) {
        this.dept_Cnt = dept_Cnt;
    }

    public int getEmp_Cnt() {
        return emp_Cnt;
    }

    public void setEmp_Cnt(int emp_Cnt) {
        this.emp_Cnt = emp_Cnt;
    }

    public int getDuty_Board_Security() {
        return duty_Board_Security;
    }

    public void setDuty_Board_Security(int duty_Board_Security) {
        this.duty_Board_Security = duty_Board_Security;
    }

    public String[] getEmpManagerList() {
        return empManagerList;
    }

    public void setEmpManagerList(String[] empManagerList) {
        this.empManagerList = empManagerList;
    }

    public String[] getEmpReceptionList() {
        return empReceptionList;
    }

    public void setEmpReceptionList(String[] empReceptionList) {
        this.empReceptionList = empReceptionList;
    }

    public String[] getEmpReceptionDeptList() {
        return empReceptionDeptList;
    }

    public void setEmpReceptionDeptList(String[] empReceptionDeptList) {
        this.empReceptionDeptList = empReceptionDeptList;
    }

    public List<DutyManagerCommand> getDutyManagerList() {
        return dutyManagerList;
    }

    public void setDutyManagerList(List<DutyManagerCommand> dutyManagerList) {
        this.dutyManagerList = dutyManagerList;
    }

    public List<DutyReceptionCommand> getReceptionList() {
        return receptionList;
    }

    public void setReceptionList(List<DutyReceptionCommand> receptionList) {
        this.receptionList = receptionList;
    }

    public List<DutyReceptionDeptCommand> getReceptionDeptList() {
        return receptionDeptList;
    }

    public void setReceptionDeptList(List<DutyReceptionDeptCommand> receptionDeptList) {
        this.receptionDeptList = receptionDeptList;
    }

    public List<AttachVO> getAttachList() {
        return attachList;
    }

    public void setAttachList(List<AttachVO> attachList) {
        this.attachList = attachList;
    }

    public List<DutyAttachVO> getDutyAttachList() {
        return dutyAttachList;
    }

    public void setDutyAttachList(List<DutyAttachVO> dutyAttachList) {
        this.dutyAttachList = dutyAttachList;
    }

    public String getEmp_Name() {
        return emp_Name;
    }

    public void setEmp_Name(String emp_Name) {
        this.emp_Name = emp_Name;
    }

    public String getEmp_Id() {
        return emp_Id;
    }

    public void setEmp_Id(String emp_Id) {
        this.emp_Id = emp_Id;
    }

    public String getEmp_Picture() {
        return emp_Picture;
    }

    public void setEmp_Picture(String emp_Picture) {
        this.emp_Picture = emp_Picture;
    }

    public int getAttachCount() {
        return attachCount;
    }

    public void setAttachCount(int attachCount) {
        this.attachCount = attachCount;
    }

    public List<DutyReplyVO> getDutyReplyList() {
        return dutyReplyList;
    }

    public void setDutyReplyList(List<DutyReplyVO> dutyReplyList) {
        this.dutyReplyList = dutyReplyList;
    }

    public int getReply_Count() {
        return reply_Count;
    }

    public void setReply_Count(int reply_Count) {
        this.reply_Count = reply_Count;
    }

    public String getSearchDeadline() {
        return searchDeadline;
    }

    public void setSearchDeadline(String searchDeadline) {
        this.searchDeadline = searchDeadline;
    }

    public String getSearchState() {
        return searchState;
    }

    public void setSearchState(String searchState) {
        this.searchState = searchState;
    }

    public String getSearchDept() {
        return searchDept;
    }

    public void setSearchDept(String searchDept) {
        this.searchDept = searchDept;
    }

    public String getDutyBoardCreateDtStr() {
        return dutyBoardCreateDtStr;
    }

    public void setDutyBoardCreateDtStr(String dutyBoardCreateDtStr) {
        this.dutyBoardCreateDtStr = dutyBoardCreateDtStr;
    }

    public String getDutyType() {
        return dutyType;
    }

    public void setDutyType(String dutyType) {
        this.dutyType = dutyType;
    }

    public String getModifiable() {
        return modifiable;
    }

    public void setModifiable(String modifiable) {
        this.modifiable = modifiable;
    }
}
