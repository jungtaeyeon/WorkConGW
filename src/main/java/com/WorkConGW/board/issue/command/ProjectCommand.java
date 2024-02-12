package com.WorkConGW.board.issue.command;


import com.WorkConGW.board.issue.dto.IssueVO;

import java.util.List;

public class ProjectCommand {
	List<IssueVO> projectList;

	public List<IssueVO> getProjectList() {
		return projectList;
	}

	public void setProjectList(List<IssueVO> projectList) {
		this.projectList = projectList;
	}

}
