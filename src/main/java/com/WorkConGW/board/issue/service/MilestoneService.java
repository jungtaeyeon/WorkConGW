package com.WorkConGW.board.issue.service;

import com.WorkConGW.board.issue.dao.IssueDAO;
import com.WorkConGW.board.issue.dao.MilestoneDAO;
import com.WorkConGW.board.issue.dto.IssueReplyVO;
import com.WorkConGW.board.issue.dto.IssueVO;
import com.WorkConGW.board.issue.dto.MilestoneVO;
import com.WorkConGW.board.issue.dto.ProjectVO;
import com.WorkConGW.emp.dto.EmpVO;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.List;

@Service
public class MilestoneService {
	
	private final MilestoneDAO milestoneDAO;
	private final IssueDAO issueDAO;

	@Autowired
	public MilestoneService(MilestoneDAO milestoneDAO, IssueDAO issueDAO) {
		this.milestoneDAO = milestoneDAO;
		this.issueDAO = issueDAO;
	}

	/* 이슈 디테일에서 사용 */
	public List<MilestoneVO> getMilestoneListAll(EmpVO empVO) throws SQLException{
		return milestoneDAO.selectMilestoneListSimple(empVO);
	}
}
