 package com.WorkConGW.emp.service;

import java.sql.SQLException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.WorkConGW.emp.dao.EmpDAO;
import com.WorkConGW.emp.dto.EmpVO;
import com.WorkConGW.exception.InvalidPasswordException;
import com.WorkConGW.exception.NotFoundIDException;
import jakarta.servlet.http.HttpSession;

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
	
}
