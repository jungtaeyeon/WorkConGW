package com.WorkConGW.board.issue.dao;


import com.WorkConGW.board.issue.dto.MilestoneVO;
import com.WorkConGW.emp.dto.EmpVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.SQLException;
import java.util.List;

@Repository
public class MilestoneDAO {

    Logger logger = LoggerFactory.getLogger(MilestoneDAO.class);
    final SqlSessionTemplate sqlSessionTemplate;

    @Autowired
    public MilestoneDAO(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate = sqlSessionTemplate;
    }

    public void insertMilestone(MilestoneVO milestoneVO) throws SQLException {
        sqlSessionTemplate.insert("insertMilestone", milestoneVO);
    }

    public void updateMilestone(MilestoneVO milestoneVO) throws SQLException {
        logger.info(String.valueOf(milestoneVO.getMilestone_End_Dt()));
        logger.info(milestoneVO.getMilestone_St());
        sqlSessionTemplate.update("updateMilestone", milestoneVO);

    }

    public void deleteMilestone(MilestoneVO milestoneVO) throws SQLException {
        sqlSessionTemplate.delete("deleteMilestone", milestoneVO);
    }

    public List<MilestoneVO> selectMilestoneList(MilestoneVO milestoneVO) throws SQLException {
        List<MilestoneVO> milestoneVOList = sqlSessionTemplate.selectList("selectMilestoneList", milestoneVO);
        return milestoneVOList;
    }

    public MilestoneVO selectMilestone(MilestoneVO milestoneVO) throws SQLException {
        MilestoneVO milestoneModify = sqlSessionTemplate.selectOne("selectMilestone", milestoneVO);
        return milestoneModify;
    }

    /* 이슈 디테일에서 사용 */
    public List<MilestoneVO> selectMilestoneListSimple(EmpVO empVO) throws SQLException {
        return sqlSessionTemplate.selectList("selectMilestoneListSimple", empVO);
    }
}
