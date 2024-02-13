package com.WorkConGW.common.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.WorkConGW.common.controller.CommonController;
import com.WorkConGW.emp.dto.EmpVO;



@Repository
public class HomeDAO {

    Logger logger = LoggerFactory.getLogger(HomeDAO.class);
    @Autowired
    SqlSessionTemplate sqlSessionTemplate = null;
    public int updateProfile(EmpVO empVO) {
        logger.info("profile Repository updateProfile 들어오니?");

        return sqlSessionTemplate.update("updateProfile", empVO);
    }
	
}