package com.WorkConGW.attend.dao;


import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.WorkConGW.attend.dto.AttendenceVO;
import com.google.api.client.util.Data;






@Repository
public class AttendenceDAO {
	Logger logger = LoggerFactory.getLogger(AttendenceDAO.class);
  @Autowired
  private SqlSessionTemplate sqlSessionTemplate;

  public int attendStart(Map<String, Object> pmap) {
    logger.info("attendStart");
    AttendenceVO attendenceVO = new AttendenceVO();
    LocalTime currentTime = LocalTime.now();
    String attend_time_String = sqlSessionTemplate.selectOne("attendTimeSerch", pmap);
    LocalTime otherTime = LocalTime.of(Integer.parseInt(attend_time_String.substring(0, 2)), Integer.parseInt(attend_time_String.substring(3)), 0);
    logger.info(currentTime.toString());
    logger.info(otherTime.toString());
    if (currentTime.isAfter(otherTime)) {
      logger.info("지각입니다.");
      pmap.put("attend_st_id", "2");
    } else if (currentTime.isBefore(otherTime)) {
      logger.info("이전입니다.");
      pmap.put("attend_st_id", "1");
    } else {
      logger.info("같다.");
      pmap.put("attend_st_id", "1");
    }
    
    logger.info(pmap.toString());
    
    int result = sqlSessionTemplate.insert("attendStart", pmap); 
    //logger.info(list.toString());
    return result;
  }

}
