 package com.WorkConGW.emp.service;

import java.sql.SQLException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.WorkConGW.emp.dao.EmpDAO;
import com.WorkConGW.emp.dto.EmpVO;
import com.WorkConGW.exception.InvalidPasswordException;
import com.WorkConGW.exception.NotFoundIDException;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

 @Service
public class EmpService {

    Logger logger = LoggerFactory.getLogger(EmpService.class);

    @Autowired
    private EmpDAO empDAO;

    public void login(String empId, String empPwd, HttpSession session)throws SQLException, NotFoundIDException,InvalidPasswordException {
        
        EmpVO emp = empDAO.selectEmpById(empId);

        if(emp == null) 
        {
            throw new NotFoundIDException();
        }
        if(!empPwd.equals(emp.getEmp_Pwd()))
        {
            throw new InvalidPasswordException();
        }

        session.setAttribute("loginUser", emp);
    
    }

    public List<EmpVO> selectEmpList() throws SQLException{
        logger.info("empList");
        List<EmpVO> empList = empDAO.selectEmpList();
        return empList;
    }

    public List<EmpVO> selectEmpIdListByDeptId(EmpVO empVO) throws SQLException{
        ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = servletRequestAttribute.getRequest().getSession(true);

        if("dept".equals(empVO.getFlag())) {
            EmpVO emp = (EmpVO)session.getAttribute("loginUser");
            String deptId = emp.getDept_Id();
            empVO.setDept_Id(deptId);
        }else if("team".equals(empVO.getFlag())) {
            EmpVO emp = (EmpVO)session.getAttribute("loginUser");
            String teamId = emp.getTeam_Id();
            empVO.setTeam_Id(teamId);

        }
        List<EmpVO> empList = empDAO.selectEmpIdListByDeptId(empVO);
        /* 조인을 걸 떄, deptId, teamId로함. */
        return empList;
    }
	
}
