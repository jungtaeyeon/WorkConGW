package com.WorkConGW.board.issue.dao;


import com.WorkConGW.board.issue.dto.IssueReplyVO;
import com.WorkConGW.board.issue.dto.IssueVO;
import com.WorkConGW.board.issue.dto.MilestoneVO;
import com.WorkConGW.emp.dto.EmpVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.SQLException;
import java.util.List;

@Repository
public class IssueDAO {
    @Autowired
    public SqlSessionTemplate sqlSessionTemplate;
	
	public void insertIssue(IssueVO issueVO) throws SQLException{

	}
	
	public void updateIssueVO(IssueVO issueVO) throws SQLException{

	}
	
	public void updateIssueByDeleteMilestone(MilestoneVO milestoneVO) throws SQLException{

	}
	
	public void updateIssueByProject(IssueVO issueVO) throws SQLException{

	}
	
	public void deleteIssueVO(IssueVO issueVO) throws SQLException{

	}
	
	public void increaseIssueReadcnt(IssueVO issueVO) throws SQLException{

	}
	
	public List<IssueVO> selectIssueList(IssueVO searchIssueVO) throws SQLException{
        List<IssueVO> issueList = sqlSessionTemplate.selectList("selectIssueList", searchIssueVO);
        return issueList;
    }
	
	public int selectIssueTotalCount(IssueVO issueVO) throws SQLException{

        return 0;
    }
	
	public IssueVO selectIssueVO(IssueVO issueVO) throws SQLException{

        return issueVO;
    }
	
	public List<IssueVO> selectMyIssueList(EmpVO empVO) throws SQLException{
        List<IssueVO> myIssueList = sqlSessionTemplate.selectList("selectMyIssueList", empVO);
        return myIssueList;
    }
	
	public void insertIssueReply(IssueReplyVO issueReplyVO) throws SQLException{

	}
	
	public void updateIssueReply(IssueReplyVO issueReplyVO) throws SQLException{

	}

    public void deleteIssueReply(IssueReplyVO issueReplyVO) throws SQLException {

    }

    public void deleteIssueReplyAll(IssueVO issueVO) throws SQLException {

    }

    public List<IssueReplyVO> selectIssueReplyList(IssueVO issueVO) throws SQLException {
        return null;
    }

    public IssueReplyVO selectIssueReplyVO(IssueReplyVO issueReplyVO) throws SQLException {
        return null;
    }

    public List<IssueVO> selectIssueListByMilestoneId(MilestoneVO milestoneVO) throws SQLException {
        List<IssueVO> milestoneIssue = sqlSessionTemplate.selectList("selectIssueListByMilestoneId", milestoneVO);
        return milestoneIssue;
    }
}
