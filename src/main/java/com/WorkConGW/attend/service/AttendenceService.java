package com.WorkConGW.attend.service;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.WorkConGW.attend.dao.AttendenceDAO;
import com.WorkConGW.attend.dto.AttendenceVO;





@Service
public class AttendenceService{
  Logger logger = LoggerFactory.getLogger(AttendenceService.class);
  @Autowired
  private AttendenceDAO attendenceDAO;

  public List<AttendenceVO> attendenceList(Map<String, Object> pmap) {
    logger.info("attendenceList");
    logger.info(pmap.toString());
    List<AttendenceVO> attendenceList = null;
    attendenceList = attendenceDAO.attendenceList(pmap);
    return attendenceList;
  }

  public Map<String, Object> attendenceCountList(Map<String, Object> pmap) {
    logger.info("attendenceCountList");
    logger.info(pmap.toString());
    Map<String, Object> attendenceCountList = attendenceDAO.attendenceCountList(pmap);
    return attendenceCountList;
  }

  public Map<String, Object> attendStart(Map<String, Object> pmap) {
    logger.info("attendStart");
    logger.info(pmap.toString());
    pmap = attendenceDAO.attendStart(pmap);
    return pmap;
  }

  public Map<String, Object> attendEnd(Map<String, Object> pmap) {
    logger.info("attendEnd");
    logger.info(pmap.toString());
    pmap = attendenceDAO.attendEnd(pmap);
    return pmap;
  }

  public int historyReasonInsert(Map<String, Object> pmap) {
    logger.info("historyReasonInsert");
    int result = 0;
    logger.info(pmap.toString());
    result = attendenceDAO.historyReasonInsert(pmap);
    return result;
  }

  public List<Map<String, Object>> attendMainSelect(Map<String, Object> pmap) {
    logger.info("attendMainSelect");
    logger.info(pmap.toString());
    List<Map<String, Object>> result = attendenceDAO.attendMainSelect(pmap);
    return result;
  }

  public List<Map<String, Object>> attendSelect(Map<String, Object> pmap) {
    logger.info("attendSelect");
    logger.info(pmap.toString());
    List<Map<String, Object>> result = attendenceDAO.attendSelect(pmap);
    return result;
  }

}
