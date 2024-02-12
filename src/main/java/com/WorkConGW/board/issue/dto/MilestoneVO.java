package com.WorkConGW.board.issue.dto;

import org.apache.ibatis.type.Alias;

import java.util.List;

@Alias("MilestoneVO")
public class MilestoneVO {

	private int milestone_Id;
	private String milestone_Name;
	private String milestone_Create_Dt;
	private String milestone_End_Dt;
	private String milestone_Update_Dt;
	private String milestone_St;
	private String emp_Id;
	private String emp_Name;
	private String isOpen = "open";	// 탭 체크
	private int openIssueCount;	// 진행중 이슈 개수
	private int closedIssueCount;	// 종료된 이슈 개수
	private int oppListCount;	// 진행/종료된 이슈 개수(반대)
	
	private List<IssueVO> issueList;	// 마일스톤의 이슈리스트

	public int getMilestone_Id() {
		return milestone_Id;
	}

	public void setMilestone_Id(int milestone_Id) {
		this.milestone_Id = milestone_Id;
	}

	public String getMilestone_Name() {
		return milestone_Name;
	}

	public void setMilestone_Name(String milestone_Name) {
		this.milestone_Name = milestone_Name;
	}

	public String getMilestone_Create_Dt() {
		return milestone_Create_Dt;
	}

	public void setMilestone_Create_Dt(String milestone_Create_Dt) {
		this.milestone_Create_Dt = milestone_Create_Dt;
	}

	public String getMilestone_End_Dt() {
		return milestone_End_Dt;
	}

	public void setMilestone_End_Dt(String milestone_End_Dt) {
		this.milestone_End_Dt = milestone_End_Dt;
	}

	public String getMilestone_Update_Dt() {
		return milestone_Update_Dt;
	}

	public void setMilestone_Update_Dt(String milestone_Update_Dt) {
		this.milestone_Update_Dt = milestone_Update_Dt;
	}

	public String getMilestone_St() {
		return milestone_St;
	}

	public void setMilestone_St(String milestone_St) {
		this.milestone_St = milestone_St;
	}

	public String getEmp_Id() {
		return emp_Id;
	}

	public void setEmp_Id(String emp_Id) {
		this.emp_Id = emp_Id;
	}

	public String getEmp_Name() {
		return emp_Name;
	}

	public void setEmp_Name(String emp_Name) {
		this.emp_Name = emp_Name;
	}

	public String getIsOpen() {
		return isOpen;
	}

	public void setIsOpen(String isOpen) {
		this.isOpen = isOpen;
	}

	public int getOpenIssueCount() {
		return openIssueCount;
	}

	public void setOpenIssueCount(int openIssueCount) {
		this.openIssueCount = openIssueCount;
	}

	public int getClosedIssueCount() {
		return closedIssueCount;
	}

	public void setClosedIssueCount(int closedIssueCount) {
		this.closedIssueCount = closedIssueCount;
	}

	public int getOppListCount() {
		return oppListCount;
	}

	public void setOppListCount(int oppListCount) {
		this.oppListCount = oppListCount;
	}

	public List<IssueVO> getIssueList() {
		return issueList;
	}

	public void setIssueList(List<IssueVO> issueList) {
		this.issueList = issueList;
	}

	
}
