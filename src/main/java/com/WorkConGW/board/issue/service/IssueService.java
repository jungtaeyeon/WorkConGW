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

    public void regist(IssueVO issueVO) throws SQLException{
        issueDAO.insertIssue(issueVO);
    }

    /* 프로젝트에서 사용 */
    public List<IssueVO> getMyIssueList(ProjectVO projectVO) throws SQLException{
        return issueDAO.selectMyIssueList(projectVO);
    }

    public List<IssueVO> searchList(IssueVO searchIssueVO) throws SQLException{
        List<IssueVO> issueList = issueDAO.selectIssueList(searchIssueVO);
        return issueList;
    }

    public int searchIssueTotalCount(IssueVO issueVO) throws SQLException{
        return issueDAO.selectIssueTotalCount(issueVO);
    }

    /* 이슈 디테일 - 조회수 증가 */
    public void increaseIssueReadcnt(IssueVO issueVO) throws SQLException{
        issueDAO.increaseIssueReadcnt(issueVO);
    }

    /* 이슈 디테일 */
    public IssueVO getIssue(IssueVO issueVO) throws SQLException{
        IssueVO resultVO = issueDAO.selectIssueVO(issueVO);

        // 댓글 목록 가져오기
        List<IssueReplyVO> issueReplyList = issueDAO.selectIssueReplyList(issueVO);
        resultVO.setIssueReplyList(issueReplyList);

        return resultVO;
    }

    /* 이슈 수정 (프로젝트에서도 사용) */
    public void modify(IssueVO issueVO) throws SQLException{
        issueDAO.updateIssueVO(issueVO);
    }

    /* 이슈 삭제 */
    public void remove(IssueVO issueVO) throws SQLException{
        // 히스토리 삭제
        issueDAO.deleteIssueReplyAll(issueVO);

        // 이슈 삭제
        issueDAO.deleteIssueVO(issueVO);
    }

    /* 이슈 댓글 등록 */
    public void registReply(IssueReplyVO issueReplyVO) throws SQLException{
        issueDAO.insertIssueReply(issueReplyVO);
    }

    public void removeReply(IssueReplyVO issueReplyVO) throws SQLException{
        issueDAO.deleteIssueReply(issueReplyVO);
    }

    public void modifyReply(IssueReplyVO issueReplyVO) throws SQLException{
        issueDAO.updateIssueReply(issueReplyVO);
    }
}
