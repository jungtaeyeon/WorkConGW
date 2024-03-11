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

	public List<MilestoneVO> getMilestoneList(MilestoneVO milestoneVO) throws SQLException{
		return milestoneDAO.selectMilestoneList(milestoneVO);
	}

	public void regist(MilestoneVO milestoneVO) throws SQLException {
		milestoneDAO.insertMilestone(milestoneVO);
	}

	public MilestoneVO getMilestone(MilestoneVO milestoneVO) throws SQLException{
		MilestoneVO milestone = milestoneDAO.selectMilestone(milestoneVO);

		milestone.setIsOpen(milestoneVO.getIsOpen());

		// 이슈리스트 가져오기
		List<IssueVO> issueList = issueDAO.selectIssueListByMilestoneId(milestoneVO);
		milestone.setIssueList(issueList);

		return milestone;
	}

	public void modify(MilestoneVO milestoneVO) throws SQLException {
		milestoneDAO.updateMilestone(milestoneVO);
	}

	public void remove(MilestoneVO milestoneVO, HttpSession session) throws SQLException{
		// 이슈 마일스톤 업데이트
//		issueDAO.updateIssueByDeleteMilestone(milestoneVO);

		// 마일스톤 삭제
		milestoneDAO.deleteMilestone(milestoneVO);
	}
}
