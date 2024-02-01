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
        logger.info(emp);
        List<EmpVO> empvo = sqlSessionTemplate.selectList("selectEmpById", emp);
        logger.info(empvo.toString());

        if(empvo != null && !empvo.isEmpty()) {
            EmpVO empvo2 = empvo.get(0);
            logger.info(empvo.toString());
            return empvo2;
        } else {
            return null;
        }

    }

    public List<EmpVO> selectEmpList() {
        List<EmpVO> empList = sqlSessionTemplate.selectList("selectEmpList");
        logger.info(empList.toString());
        return empList;
    }

    public List<EmpVO> selectEmpIdListByDeptId(EmpVO empVO ) {
        logger.info(empVO.toString());
        List<EmpVO> empLIst = sqlSessionTemplate.selectList("selectEmpIdListByDeptId", empVO);
        logger.info(empLIst.toString());
        return empLIst;
    }
	

}
