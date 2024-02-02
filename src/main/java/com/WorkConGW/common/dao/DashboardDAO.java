package com.WorkConGW.common.dao;


import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.WorkConGW.common.dto.DashboardVO;



@Repository
public class DashboardDAO {

    Logger logger = LoggerFactory.getLogger(DashboardDAO.class);

    @Autowired
    SqlSessionTemplate sqlSessionTemplate = null;

    public void updateDashboard(DashboardVO dashboardVO) {

        sqlSessionTemplate.update("updateDashBoard",dashboardVO);
        logger.info("대시보드 업데이트 성공함");

    }

    public void insertDashboard(DashboardVO dashboardVO) {
        sqlSessionTemplate.insert("insertDashboard", dashboardVO);
    }
	
}
