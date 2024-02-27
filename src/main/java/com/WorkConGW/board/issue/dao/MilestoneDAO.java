package com.WorkConGW.board.issue.dao;


import com.WorkConGW.board.issue.dto.MilestoneVO;
import com.WorkConGW.emp.dto.EmpVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.SQLException;
import java.util.List;

@Repository
public class MilestoneDAO {

    @Autowired
    SqlSessionTemplate sqlSessionTemplate;

    public void insertMilestone(MilestoneVO milestoneVO) throws SQLException {

    }

    public void updateMilestone(MilestoneVO milestoneVO) throws SQLException {

    }

    public void deleteMilestone(MilestoneVO milestoneVO) throws SQLException {

    }

    public List<MilestoneVO> selectMilestoneList(MilestoneVO milestoneVO) throws SQLException {
        List<MilestoneVO> milestoneVOList = sqlSessionTemplate.selectList("selectMilestoneList", milestoneVO);
        return milestoneVOList;
    }

    public MilestoneVO selectMilestone(MilestoneVO milestoneVO) throws SQLException {
        MilestoneVO milestoneDetail = sqlSessionTemplate.selectOne("selectMilestone", milestoneVO);
        return milestoneDetail;
    }

    /* 이슈 디테일에서 사용 */
    public List<MilestoneVO> selectMilestoneListSimple(EmpVO empVO) throws SQLException {
        return sqlSessionTemplate.selectList("selectMilestoneListSimple", empVO);
    }
}
