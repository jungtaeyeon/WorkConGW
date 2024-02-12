package com.WorkConGW.board.duty.dao;



import com.WorkConGW.board.duty.dto.DutyVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.SQLException;


@Repository
public class DutyDAO {

    @Autowired
    SqlSessionTemplate sqlSessionTemplate;

    public DutyVO selectDutyVO(DutyVO dutyVO) throws SQLException {
        DutyVO duty = sqlSessionTemplate.selectOne("selectDutyVO", dutyVO);
        return duty;
    }
}
