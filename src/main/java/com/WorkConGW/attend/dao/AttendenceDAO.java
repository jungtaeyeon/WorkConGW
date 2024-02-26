package com.WorkConGW.attend.dao;

import java.time.LocalDateTime;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.WorkConGW.attend.dto.AttendenceVO;
import com.WorkConGW.emp.dto.EmpVO;
import com.google.api.client.util.Data;






@Repository
public class AttendenceDAO {
	Logger logger = LoggerFactory.getLogger(AttendenceDAO.class);
  @Autowired
  private SqlSessionTemplate sqlSessionTemplate;

  public List<AttendenceVO> attendenceList(String empId) {
    logger.info("attendenceList");
    logger.info(empId);
    List<AttendenceVO> attendenceList = null;
    attendenceList = sqlSessionTemplate.selectList("attendenceList", empId);
    
    return attendenceList;
  }

  public Map<String, Object> attendenceCountList(Map<String, Object> pmap) {
    logger.info("attendenceList");
    logger.info(pmap.toString());
    Map<String,Object> result = new HashMap<>();
    int attendenceNormalCountList = sqlSessionTemplate.selectOne("attendenceNormalCountList", pmap);
    int attendenceTardyCountList = sqlSessionTemplate.selectOne("attendenceTardyCountList", pmap);
    result.put("attendenceNormalCountList", attendenceNormalCountList);
    result.put("attendenceTardyCountList", attendenceTardyCountList);
    return result;
  }

  public Map<String, Object> attendStart(Map<String, Object> pmap) {
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
    sqlSessionTemplate.update("attendEmpUpdate", pmap);
    sqlSessionTemplate.insert("attendStart", pmap); 
    Map<String, Object> resultMap = sqlSessionTemplate.selectOne("attendStSelect", pmap); 

    Map<String, Object> lowercaseResultMap = new HashMap<>();

    for (Map.Entry<String, Object> entry : resultMap.entrySet()) {
        lowercaseResultMap.put(entry.getKey().toLowerCase(), entry.getValue());
    }
    return lowercaseResultMap;
  }

  public Map<String, Object> attendEnd(Map<String, Object> pmap) {
    logger.info("attendEnd");
    AttendenceVO attendenceVO = new AttendenceVO();
    LocalTime currentTime = LocalTime.now();
    String attend_time_String = sqlSessionTemplate.selectOne("leavingTimeSerch", pmap);
    logger.info(attend_time_String.toString());
    LocalTime otherTime = LocalTime.of(Integer.parseInt(attend_time_String.substring(0, 2)), Integer.parseInt(attend_time_String.substring(3)), 0);
    logger.info(currentTime.toString());
    LocalTime otherEndTime = otherTime.plusHours(1);
    logger.info(otherTime.toString());
    
    String attendStartTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
    pmap.put("attendStartTime", attendStartTime);
    if (currentTime.isAfter(otherEndTime) && currentTime.isAfter(otherTime)) {
      logger.info("야근입니다.");
      pmap.put("attend_st_id", "4");
    } else if (currentTime.isBefore(otherTime)) {
      logger.info("조퇴입니다.");
      pmap.put("attend_st_id", "3");
    } else if (currentTime.isBefore(otherEndTime) && currentTime.isAfter(otherTime)) {
      logger.info("정시퇴근.");
      pmap.put("attend_st_id", "0");
    }
    logger.info(pmap.toString());
    
    sqlSessionTemplate.update("attendEmpUpdate", pmap); 
    sqlSessionTemplate.update("attendEnd", pmap); 
    Map<String, Object> resultMap = sqlSessionTemplate.selectOne("attendStSelect", pmap); 
    Map<String, Object> lowercaseResultMap = new HashMap<>();

    for (Map.Entry<String, Object> entry : resultMap.entrySet()) {
        lowercaseResultMap.put(entry.getKey().toLowerCase(), entry.getValue());
    }
    return lowercaseResultMap;
  }

  public int historyReasonInsert(Map<String, Object> pmap) {
    logger.info("historyReasonInsert");
    int result = 0;
    result = sqlSessionTemplate.update("historyReasonInsert", pmap);
    return result;
  }

  public List<Map<String, Object>> attendDeptSelect(Map<String, Object> pmap) {
    logger.info("attendDeptSelect");
    logger.info(pmap.toString());
    List<Map<String, Object>> result = sqlSessionTemplate.selectList("attendDeptHistorySelect", pmap);
    logger.info(result.toString());
    return result;
  }

  public List<Map<String, Object>> attendSelect(Map<String, Object> pmap) {
    logger.info("attendSelect");
    logger.info(pmap.toString());
    List<Map<String, Object>> result = sqlSessionTemplate.selectList("attendSelect", pmap);
    logger.info(result.toString());
    return result;
  }

}
