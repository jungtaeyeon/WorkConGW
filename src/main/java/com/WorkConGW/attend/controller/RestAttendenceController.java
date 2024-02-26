package com.WorkConGW.attend.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.WorkConGW.addbook.dto.AddBookVO;
import com.WorkConGW.attend.service.AttendenceService;
import com.WorkConGW.emp.dto.EmpVO;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/attend/*")
public class RestAttendenceController {
  Logger logger = LoggerFactory.getLogger(RestAttendenceController.class);
  @Autowired
  private AttendenceService attendenceService;

  /* 출근버튼클릭시 */ 
  @GetMapping("attendStart")
    public int attendStart(@RequestParam Map<String, Object> pmap ,HttpSession session){
        logger.info("attendStart");
        EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        String attendStartTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        formatter.setTimeZone(TimeZone.getTimeZone("Asia/Seoul"));
        Date parsedDate = null;
        try {
            parsedDate = formatter.parse(attendStartTime);
            empVO.setHistory_Attend_Time(parsedDate);
        } catch (Exception e) {
            logger.error("Error parsing date: " + e.getMessage());
        }
        String empId = null;
        if(empVO != null) {
            empId = empVO.getEmp_Id();
        }
        pmap.put("empId", empId);
        pmap.put("history_attend_time",parsedDate);
        int result = attendenceService.attendStart(pmap);
        logger.info(empVO.toString());
        logger.info(pmap.toString());
        return result;
    }
}
