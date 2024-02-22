package com.WorkConGW.board.issue.service;

import com.WorkConGW.board.issue.dao.IssueDAO;
import com.WorkConGW.board.issue.dto.IssueReplyVO;
import com.WorkConGW.board.issue.dto.IssueVO;
import com.WorkConGW.board.issue.dto.ProjectVO;
import com.WorkConGW.emp.dto.EmpVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.List;

@Service
public class IssueService {

	private final IssueDAO issueDAO;

    @Autowired
    public IssueService(IssueDAO issueDAO) {
        this.issueDAO = issueDAO;
    }

    public void modify(IssueVO issueVO) throws SQLException{
        issueDAO.updateIssueVO(issueVO);
    }

    public IssueVO getIssue(IssueVO issueVO) throws SQLException{
        IssueVO resultVO = issueDAO.selectIssueVO(issueVO);

        // 댓글 목록 가져오기
        List<IssueReplyVO> issueReplyList = issueDAO.selectIssueReplyList(issueVO);
        resultVO.setIssueReplyList(issueReplyList);

        return resultVO;
    }

    public List<IssueVO> getMyIssueList(ProjectVO projectVO) throws SQLException{
        return issueDAO.selectMyIssueList(projectVO);
    }
}
