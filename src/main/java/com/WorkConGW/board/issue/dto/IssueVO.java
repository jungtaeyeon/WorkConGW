package com.WorkConGW.board.issue.dto;


import com.WorkConGW.common.dto.BaseVO;
import org.apache.ibatis.type.Alias;

import java.util.List;

@Alias("IssueVO")
public class IssueVO extends BaseVO {

	private int issue_Board_Id;
	private String issue_Board_Title;
	private String issue_Board_Content;
	private int issue_Board_Readcnt;
	private String issue_Board_Create_Dt;
	private String issue_Board_Update_Dt;
	private String issue_Board_Updater_Id;
	private String emp_Id;
	private int duty_Board_Id;
	private int milestone_Id;
	private String issue_Board_St;
	private String issue_Project_St;	// 프로젝트 상태
	private String issue_Open_St = "Y";	// 이슈 공개 여부
	private String emp_Name;
	private String empPicture;
	private String officialName;
	private String dept_Name;
	private String teamName;
	private int reply_Count;	// 댓글수
	private String isOpen = "open";	// 탭 체크
	private int opp_Issue_Count;	// 열린/닫힌 이슈 개수
	private String duty_Board_Title;	// 관련 업무명
	private String milestone_Name;	// 마일스톤 이름
	private int open_Issue_Count;	// 진행중인 이슈개수
	private int closed_Issue_Count;	// 종료된 이슈개수

	private List<IssueReplyVO> issueReplyList; // 댓글 리스트

	public int getIssue_Board_Id() {
		return issue_Board_Id;
	}

	public void setIssue_Board_Id(int issue_Board_Id) {
		this.issue_Board_Id = issue_Board_Id;
	}

	public String getIssue_Board_Title() {
		return issue_Board_Title;
	}

	public void setIssue_Board_Title(String issue_Board_Title) {
		this.issue_Board_Title = issue_Board_Title;
	}

	public String getIssue_Board_Content() {
		return issue_Board_Content;
	}

	public void setIssue_Board_Content(String issue_Board_Content) {
		this.issue_Board_Content = issue_Board_Content;
	}

	public int getIssue_Board_Readcnt() {
		return issue_Board_Readcnt;
	}

	public void setIssue_Board_Readcnt(int issue_Board_Readcnt) {
		this.issue_Board_Readcnt = issue_Board_Readcnt;
	}

	public String getIssue_Board_Create_Dt() {
		return issue_Board_Create_Dt;
	}

	public void setIssue_Board_Create_Dt(String issue_Board_Create_Dt) {
		this.issue_Board_Create_Dt = issue_Board_Create_Dt;
	}

	public String getIssue_Board_Update_Dt() {
		return issue_Board_Update_Dt;
	}

	public void setIssue_Board_Update_Dt(String issue_Board_Update_Dt) {
		this.issue_Board_Update_Dt = issue_Board_Update_Dt;
	}

	public String getIssue_Board_Updater_Id() {
		return issue_Board_Updater_Id;
	}

	public void setIssue_Board_Updater_Id(String issue_Board_Updater_Id) {
		this.issue_Board_Updater_Id = issue_Board_Updater_Id;
	}

	public String getEmp_Id() {
		return emp_Id;
	}

	public void setEmp_Id(String emp_Id) {
		this.emp_Id = emp_Id;
	}

	public int getDuty_Board_Id() {
		return duty_Board_Id;
	}

	public void setDuty_Board_Id(int duty_Board_Id) {
		this.duty_Board_Id = duty_Board_Id;
	}

	public int getMilestone_Id() {
		return milestone_Id;
	}

	public void setMilestone_Id(int milestone_Id) {
		this.milestone_Id = milestone_Id;
	}

	public String getIssue_Board_St() {
		return issue_Board_St;
	}

	public void setIssue_Board_St(String issue_Board_St) {
		this.issue_Board_St = issue_Board_St;
	}

	public String getIssue_Project_St() {
		return issue_Project_St;
	}

	public void setIssue_Project_St(String issue_Project_St) {
		this.issue_Project_St = issue_Project_St;
	}

	public String getIssue_Open_St() {
		return issue_Open_St;
	}

	public void setIssue_Open_St(String issue_Open_St) {
		this.issue_Open_St = issue_Open_St;
	}

	public String getEmp_Name() {
		return emp_Name;
	}

	public void setEmp_Name(String emp_Name) {
		this.emp_Name = emp_Name;
	}

	public String getEmpPicture() {
		return empPicture;
	}

	public void setEmpPicture(String empPicture) {
		this.empPicture = empPicture;
	}

	public String getOfficialName() {
		return officialName;
	}

	public void setOfficialName(String officialName) {
		this.officialName = officialName;
	}

	public String getDept_Name() {
		return dept_Name;
	}

	public void setDept_Name(String dept_Name) {
		this.dept_Name = dept_Name;
	}

	public String getTeamName() {
		return teamName;
	}

	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}

	public int getReply_Count() {
		return reply_Count;
	}

	public void setReply_Count(int reply_Count) {
		this.reply_Count = reply_Count;
	}

	public String getIsOpen() {
		return isOpen;
	}

	public void setIsOpen(String isOpen) {
		this.isOpen = isOpen;
	}

	public int getOpp_Issue_Count() {
		return opp_Issue_Count;
	}

	public void setOpp_Issue_Count(int opp_Issue_Count) {
		this.opp_Issue_Count = opp_Issue_Count;
	}

	public String getDuty_Board_Title() {
		return duty_Board_Title;
	}

	public void setDuty_Board_Title(String duty_Board_Title) {
		this.duty_Board_Title = duty_Board_Title;
	}

	public String getMilestone_Name() {
		return milestone_Name;
	}

	public void setMilestone_Name(String milestone_Name) {
		this.milestone_Name = milestone_Name;
	}

	public int getOpen_Issue_Count() {
		return open_Issue_Count;
	}

	public void setOpen_Issue_Count(int open_Issue_Count) {
		this.open_Issue_Count = open_Issue_Count;
	}

	public int getClosed_Issue_Count() {
		return closed_Issue_Count;
	}

	public void setClosed_Issue_Count(int closed_Issue_Count) {
		this.closed_Issue_Count = closed_Issue_Count;
	}

	public List<IssueReplyVO> getIssueReplyList() {
		return issueReplyList;
	}

	public void setIssueReplyList(List<IssueReplyVO> issueReplyList) {
		this.issueReplyList = issueReplyList;
	}

}
