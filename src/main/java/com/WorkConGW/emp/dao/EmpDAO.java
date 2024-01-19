package com.WorkConGW.emp.dao;

import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.WorkConGW.emp.dto.EmpVO;
import com.WorkConGW.emp.service.EmpService;

@Repository
public class EmpDAO {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;


    Logger logger = LoggerFactory.getLogger(EmpService.class);

    public EmpVO selectEmpById(String emp) {
        List<EmpVO> empvo = sqlSessionTemplate.selectList("selectEmpById", emp);
        EmpVO empvo2 = empvo.get(0);
        logger.info(empvo2.toString());
        
        return empvo2;

    }
	

}
