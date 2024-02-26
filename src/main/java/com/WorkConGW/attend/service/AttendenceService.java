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

  public int attendStart(Map<String, Object> pmap) {
    logger.info("attendStart");
    logger.info(pmap.toString());
    int result = attendenceDAO.attendStart(pmap);
    return result;
  }
}
