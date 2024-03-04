package com.WorkConGW.common.service;

import java.sql.SQLException;
import java.util.List;


import com.WorkConGW.common.dao.DeptDAO;
import com.WorkConGW.common.dto.DeptVO;
import com.WorkConGW.emp.dto.EmpVO;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;


@Service
@Slf4j
public class DeptService {


    private final DeptDAO deptDAO;

    @Autowired
    public DeptService(DeptDAO deptDAO) {
        this.deptDAO = deptDAO;
    }


    public List<DeptVO> selectDeptListByTeamYn(DeptVO deptVO) throws SQLException{
        ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        //Request 가지고 오기
        HttpSession session = servletRequestAttribute.getRequest().getSession(true);
        //Session 가지고 오기
        EmpVO emp = (EmpVO)session.getAttribute("loginUser");
        // loginUser로 사용자에대한 정보를 가져온다.(session 이용) 그렇게 되면 emp는 사용자에 대한 정보를 쥐고있다.

        String deptId = emp.getDept_Id(); //FK
        String empId = emp.getEmp_Id(); // PK
        String codeId = emp.getCode_Id();
        /* deptId : emp에 대한 DeptId를 넣는다. --> 사용자가 회원가입할때 넣은 값 */

        // 파라미터로 들어온 deptVO값에 deptId값을 넣는다. (로그인한 사용자에 대한 deptId값을 부서에 넣는다.)
        deptVO.setDept_Id(deptId); // FK넣는다.
        deptVO.setCode_Id(codeId);


        if(StringUtils.isEmpty(deptVO.getFlag()) && !"adminDept".equals(deptVO.getFlag())) deptVO.setEmp_Id(empId);


        log.info(deptVO.toString());
        List<DeptVO> DeptList = deptDAO.selectDeptListByTeamYn(deptVO);
        log.info(DeptList.toString());
        // 조회를 하게 되면
        return DeptList;
    }

    //관리자일때 부서 목록만 조회
    public List<DeptVO> selectDeptList(DeptVO deptVO) throws Exception {
        ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        //Request 가지고 오기
        HttpSession session = servletRequestAttribute.getRequest().getSession(true);
        //Session 가지고 오기
        EmpVO emp = (EmpVO)session.getAttribute("loginUser");
        String empId = emp.getEmp_Id();

        deptVO.setEmp_Id(empId);
        List<DeptVO> deptList = deptDAO.selectDeptList(deptVO);
        log.info(deptList.toString());
        return deptList;
    }

    //관리자일때 팀 목록만 조회
    public List<DeptVO> selectTeamList(DeptVO deptVO) throws Exception {
        ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        //Request 가지고 오기
        HttpSession session = servletRequestAttribute.getRequest().getSession(true);
        //Session 가지고 오기
        EmpVO emp = (EmpVO)session.getAttribute("loginUser");
        String empId = emp.getEmp_Id();

        deptVO.setEmp_Id(empId);
        List<DeptVO> teamList = deptDAO.selectTeamList(deptVO);
        log.info(teamList.toString());
        return teamList;
    }


    public void registDept(DeptVO deptVO) {
        deptDAO.registDept(deptVO);
    }


    public int checkName(String deptName) {
        int result = deptDAO.checkName(deptName);
        return result;
    }

    public List<DeptVO> selectAllDeptName() {
        return deptDAO.selectAllDeptName();
    }
}
