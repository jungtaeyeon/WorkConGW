package com.WorkConGW.board.issue.dao;


import com.WorkConGW.board.issue.dto.ProjectVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.SQLException;
import java.util.List;

@Repository
public class ProjectDAO {
    Logger logger = LoggerFactory.getLogger(ProjectDAO.class);
    final SqlSessionTemplate sqlSessionTemplate;

    @Autowired
    public ProjectDAO(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate = sqlSessionTemplate;
    }

    public List<ProjectVO> selectProjectList(ProjectVO projectVO) throws SQLException {
        return sqlSessionTemplate.selectList("selectProjectList", projectVO);
    }

    public void insertProject(ProjectVO projectVO) {
        sqlSessionTemplate.insert("insertProject", projectVO);
    }

    public void updateProject(ProjectVO projectVO) {
        logger.info(String.valueOf(projectVO.getProject_End_Dt()));
        sqlSessionTemplate.update("updateProject", projectVO);
    }

    public ProjectVO selectProject(ProjectVO projectVO) {
        return sqlSessionTemplate.selectOne("selectProject", projectVO);
    }

    public void deleteProject(ProjectVO projectVO) {
        sqlSessionTemplate.delete("deleteProject", projectVO);
    }

}
