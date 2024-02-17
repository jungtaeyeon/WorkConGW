package com.WorkConGW.common.dao;

import java.sql.SQLException;
import java.util.List;

import com.WorkConGW.common.dto.DeptVO;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.annotations.Mapper;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
@Slf4j
public class DeptDAO {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;


    public List<DeptVO> selectDeptListByTeamYn(DeptVO deptVO) {
        List<DeptVO> deptList = sqlSessionTemplate.selectList("selectDeptListByTeamYn", deptVO);
        log.info(deptList.toString());
        return deptList;
    }

    public void registDept(DeptVO deptVO) {
        sqlSessionTemplate.insert("insertDept", deptVO);
    }


    public int checkName(String deptName) {
        int result;
        result = sqlSessionTemplate.selectOne("checkName",deptName);
        return result;
    }

    public List<DeptVO> selectAllDeptName() {
        return sqlSessionTemplate.selectList("selectAllDeptName");
    }
}
