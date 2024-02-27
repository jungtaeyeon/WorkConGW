package com.WorkConGW.board.issue.service;

import com.WorkConGW.board.duty.dao.DutyDAO;
import com.WorkConGW.board.issue.dao.IssueDAO;
import com.WorkConGW.board.issue.dao.ProjectDAO;
import com.WorkConGW.board.issue.dto.IssueVO;
import com.WorkConGW.board.issue.dto.ProjectVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.List;

@Service
public class ProjectService {
    private final ProjectDAO projectDAO;
    private final IssueDAO issueDAO;
    private final DutyDAO dutyDAO;

    @Autowired
    public ProjectService(ProjectDAO projectDAO, IssueDAO issueDAO, DutyDAO dutyDAO) {
        this.projectDAO = projectDAO;
        this.issueDAO = issueDAO;
        this.dutyDAO = dutyDAO;
    }

    public List<ProjectVO> getProjectList(ProjectVO projectVO) throws SQLException {
        return projectDAO.selectProjectList(projectVO);
    }

    public void regist(ProjectVO projectVO) throws SQLException{
        projectDAO.insertProject(projectVO);
    }

    public void modify(ProjectVO projectVO) throws SQLException{
            projectDAO.updateProject(projectVO);
    }

    public ProjectVO getProject(ProjectVO projectVO) throws SQLException{
        ProjectVO project = projectDAO.selectProject(projectVO);

        project.setIsOpen(projectVO.getIsOpen());

        // 이슈리스트 가져오기
        List<IssueVO> issueList = issueDAO.selectIssueListByProjectId(projectVO);
        project.setIssueList(issueList);

        return project;
    }

    public void remove(ProjectVO projectVO) throws SQLException{

        // 이슈 프로젝트 업데이트
//        dutyDAO.updateDutyByDeleteProject(projectVO);

        // 프로젝트 삭제
        projectDAO.deleteProject(projectVO);
    }

}
