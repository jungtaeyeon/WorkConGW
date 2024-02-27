package com.WorkConGW.board.issue.dao;


import com.WorkConGW.board.issue.dto.IssueReplyVO;
import com.WorkConGW.board.issue.dto.IssueVO;
import com.WorkConGW.board.issue.dto.MilestoneVO;
import com.WorkConGW.board.issue.dto.ProjectVO;
import com.WorkConGW.emp.dto.EmpVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.SQLException;
import java.util.List;

@Repository
public class IssueDAO {
    Logger logger = LoggerFactory.getLogger(IssueDAO.class);
    public final SqlSessionTemplate sqlSessionTemplate;

    @Autowired
    public IssueDAO(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate = sqlSessionTemplate;
    }

    /* 프로젝트에서 사용 */
    public List<IssueVO> selectIssueListByProjectId(ProjectVO projectVO) {
        return sqlSessionTemplate.selectList("selectIssueListByProjectId", projectVO);
    }

    /* 프로젝트에서 사용 */
    public List<IssueVO> selectMyIssueList(ProjectVO projectVO) throws SQLException{
        List<IssueVO> myIssueList = sqlSessionTemplate.selectList("selectMyIssueList", projectVO);
        return myIssueList;
    }

    public List<IssueVO> selectIssueList(IssueVO searchIssueVO) throws SQLException{
        List<IssueVO> issueList = sqlSessionTemplate.selectList("selectIssueList", searchIssueVO);
        return issueList;
    }

    public int selectIssueTotalCount(IssueVO issueVO) {
        return sqlSessionTemplate.selectOne("selectIssueTotalCount", issueVO);
    }

    public void increaseIssueReadcnt(IssueVO issueVO) {
        sqlSessionTemplate.update("increaseIssueReadcnt", issueVO);
    }

    public IssueVO selectIssueVO(IssueVO issueVO) {
        logger.info(issueVO.toString());
        return sqlSessionTemplate.selectOne("selectIssueVO", issueVO);
    }

    public List<IssueReplyVO> selectIssueReplyList(IssueVO issueVO) {
        return sqlSessionTemplate.selectList("selectIssueReplyList", issueVO);
    }

    public void insertIssueReply(IssueReplyVO issueReplyVO) {
        sqlSessionTemplate.insert("insertIssueReply", issueReplyVO);
    }

    public void insertIssue(IssueVO issueVO) {
        sqlSessionTemplate.insert("insertIssue", issueVO);
    }

    /* 이슈 수정 (프로젝트에서도 사용) */
    public void updateIssueVO(IssueVO issueVO) throws SQLException{
        sqlSessionTemplate.update("updateIssueVO", issueVO);
    }

    public void deleteIssueReply(IssueReplyVO issueReplyVO) {
        sqlSessionTemplate.delete("deleteIssueReply", issueReplyVO);
    }

    public void updateIssueReply(IssueReplyVO issueReplyVO) {
        sqlSessionTemplate.update("updateIssueReply", issueReplyVO);
    }

    public void deleteIssueReplyAll(IssueVO issueVO) {
        sqlSessionTemplate.delete("deleteIssueReplyAll", issueVO);
    }

    public void deleteIssueVO(IssueVO issueVO) {
        sqlSessionTemplate.delete("deleteIssueVO", issueVO);
    }
}
