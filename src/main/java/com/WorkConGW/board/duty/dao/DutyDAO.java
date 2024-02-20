package com.WorkConGW.board.duty.dao;



import com.WorkConGW.board.duty.command.DutyEnforcerCommand;
import com.WorkConGW.board.duty.dto.DutyAttachVO;
import com.WorkConGW.board.duty.dto.DutyVO;
import com.WorkConGW.board.issue.dto.ProjectVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.SQLException;
import java.util.List;


@Repository
public class DutyDAO {

    private final SqlSessionTemplate sqlSessionTemplate;

    @Autowired
    public DutyDAO(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate = sqlSessionTemplate;
    }

    public DutyVO selectDutyVO(DutyVO dutyVO) throws SQLException {
        DutyVO duty = sqlSessionTemplate.selectOne("selectDutyVO", dutyVO);
        return duty;
    }

    public void updateDutyByDeleteProject(ProjectVO projectVO) {
        sqlSessionTemplate.update("updateDutyByDeleteProject", projectVO);
    }

    public List<DutyVO> selectDutyList(DutyVO searchDutyVO) {
        return sqlSessionTemplate.selectList("selectDutyList", searchDutyVO);
    }

    public List<DutyEnforcerCommand> selectDutyEnforcerList(DutyVO duty) {
        return sqlSessionTemplate.selectList("selectDutyEnforcerList", duty);
    }

    public int selectDutyListTotalCount(DutyVO searchDutyVO) {
        return sqlSessionTemplate.selectOne("selectDutyListTotalCount", searchDutyVO);
    }

    public void insertDuty(DutyVO dutyVO) {
        sqlSessionTemplate.insert("insertDuty", dutyVO);
    }

    public void insertDutyEnforcer(DutyEnforcerCommand dutyEnforcer) {
        sqlSessionTemplate.insert("insertDutyEnforcer", dutyEnforcer);
    }

    public void insertDutyReceptioner(DutyEnforcerCommand dutyEnforcer) {
        sqlSessionTemplate.insert("insertDutyReceptioner", dutyEnforcer);
    }

    public void insertDutyFile(DutyAttachVO dutyAttachVO) {
        sqlSessionTemplate.insert("insertDutyFile", dutyAttachVO);
    }

    public List<DutyVO> selectMyDutyList(DutyVO searchDutyVO) {

        return sqlSessionTemplate.selectList("selectMyDutyList", searchDutyVO);
    }

    public int selectMyDutyListTotalCount(DutyVO searchDutyVO) {
        return sqlSessionTemplate.selectOne("selectMyDutyListTotalCount", searchDutyVO);
    }

    public List<DutyVO> selectDutyReceptionList(DutyVO searchDutyVO) {
        return sqlSessionTemplate.selectList("selectDutyReceptionList", searchDutyVO);
    }

    public int selectDutyReceptionListTotalCount(DutyVO searchDutyVO) {
        return sqlSessionTemplate.selectOne("selectDutyReceptionListTotalCount", searchDutyVO);
    }
}
