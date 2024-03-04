package com.WorkConGW.board.issue.dto;

import org.apache.ibatis.type.Alias;

@Alias("IssueReplyVO")
public class IssueReplyVO {

	private String reply_Content;
	private String reply_Create_Dt;
	private String reply_Update_Dt;
	private int reply_Id;
	private int issue_Board_Id;
	private String emp_Id;
	private String reply_Group_Code;
	private String emp_Name;
	private String emp_Picture;

	public String getKoreanTime() {
		return koreanTime;
	}

	public void setKoreanTime(String koreanTime) {
		this.koreanTime = koreanTime;
	}

	private String koreanTime;
	private long issue_Hangle_Dt;

	public String getReply_Content() {
		return reply_Content;
	}

	public void setReply_Content(String reply_Content) {
		this.reply_Content = reply_Content;
	}

	public String getReply_Create_Dt() {
		return reply_Create_Dt;
	}

	public void setReply_Create_Dt(String reply_Create_Dt) {
		this.reply_Create_Dt = reply_Create_Dt;
	}

	public String getReply_Update_Dt() {
		return reply_Update_Dt;
	}

	public void setReply_Update_Dt(String reply_Update_Dt) {
		this.reply_Update_Dt = reply_Update_Dt;
	}

	public int getReply_Id() {
		return reply_Id;
	}

	public void setReply_Id(int reply_Id) {
		this.reply_Id = reply_Id;
	}

	public int getIssue_Board_Id() {
		return issue_Board_Id;
	}

	public void setIssue_Board_Id(int issue_Board_Id) {
		this.issue_Board_Id = issue_Board_Id;
	}

	public String getEmp_Id() {
		return emp_Id;
	}

	public void setEmp_Id(String emp_Id) {
		this.emp_Id = emp_Id;
	}

	public String getReply_Group_Code() {
		return reply_Group_Code;
	}

	public void setReply_Group_Code(String reply_Group_Code) {
		this.reply_Group_Code = reply_Group_Code;
	}

	public String getEmp_Name() {
		return emp_Name;
	}

	public void setEmp_Name(String emp_Name) {
		this.emp_Name = emp_Name;
	}

	public String getEmp_Picture() {
		return emp_Picture;
	}

	public void setEmp_Picture(String emp_Picture) {
		this.emp_Picture = emp_Picture;
	}


	public void setIssue_Hangle_Dt(long issue_Hangle_Dt) {
		this.issue_Hangle_Dt = issue_Hangle_Dt;
	}

	public long getIssue_Hangle_Dt() {
		return issue_Hangle_Dt;
	}
}
