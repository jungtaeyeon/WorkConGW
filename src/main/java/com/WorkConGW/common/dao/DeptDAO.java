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

    /** 부서장일 경우 전체 조회 **/
    public List<DeptVO> selectTeamList(DeptVO deptVO) {
        List<DeptVO> selectTeamList = sqlSessionTemplate.selectList("selectTeamList", deptVO);
        log.info(selectTeamList.toString());
        return selectTeamList;
    }

    /** 부서장일 경우 전체 조회 **/
    public List<DeptVO> selectDeptList(DeptVO deptVO) {
        List<DeptVO> selectDeptList = sqlSessionTemplate.selectList("selectDeptList", deptVO);
        log.info(selectDeptList.toString());
        return selectDeptList;
    }


    /**페이징이 적용된 모든 부서 리스트 조회*/
    //public List<DeptVO> selectDeptPagingList(DeptVO searchDeptVO) throws SQLException;

    /**전체 부서 개수*/
//    public int selectDeptCount(DeptVO searchDeptVO) throws SQLException;

    /**부서 사용 직원 수*/
//    public int seletDeptEmpCount(DeptVO deptVO) throws SQLException;

    /**부서 등록*/
//    public void insertDept(DeptVO deptVO) throws SQLException;

    /**부서코드로 부서 조회*/
//    public DeptVO selectDeptByDeptId(DeptVO deptVO);

    /**부서장 아이디로 부서장 이름 조회*/
//    public String selectEmpNameByLeaderId(String deptLeaderId);

    /**부서명 중복확인*/
//    public int dupleCheckDeptName(String deptName);

    /**부서 삭제 (상태변경)*/
//    public void deleteDept(DeptVO deptVO);

    /**부서 수정*/
//    public void updateDept(DeptVO deptVO);

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
