package com.WorkConGW.common.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.WorkConGW.common.controller.CommonController;
import com.WorkConGW.common.dto.HomeFormVO;
import com.WorkConGW.emp.dto.EmpVO;

import java.util.List;
import java.util.Map;

@Repository
public class HomeDAO {

    Logger logger = LoggerFactory.getLogger(HomeDAO.class);
    @Autowired
    SqlSessionTemplate sqlSessionTemplate = null;
    public int updateProfile(EmpVO empVO) {
        logger.info("profile Repository updateProfile 들어오니?");

        return sqlSessionTemplate.update("updateProfile", empVO);
    }

    public List<HomeFormVO> getDashbodeList(String emp_Id) {
        logger.info("getDashbodeList");
        List<HomeFormVO> result = sqlSessionTemplate.selectList("getDashbodeList", emp_Id);
        logger.info(result.toString());
        return result;
    }

	public List<Map<String, Object>> homescheduleList(Map<String, Object> pmap) {
        logger.info("homescheduleList");
        logger.info(pmap.toString());
        List<Map<String, Object>> result = sqlSessionTemplate.selectList("homescheduleList", pmap);
        logger.info(result.toString());
        return result;
    }

    public List<Map<String, Object>> homeReservationList(Map<String, Object> pmap) {
        logger.info("homeReservationList");
        logger.info(pmap.toString());
        List<Map<String, Object>> result = sqlSessionTemplate.selectList("homeReservationList", pmap);
        logger.info(result.toString());
        return result;
    }

    public int dashbodeUpdate(Map<String, Object> pmap) {
        logger.info("dashbodeUpdate");
        int result = 0;
        result = sqlSessionTemplate.update("dashbodeUpdate", pmap);
        return result;
      }
}
