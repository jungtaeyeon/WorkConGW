package com.WorkConGW.attend.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;
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
    public Map<String, Object> attendStart(@RequestParam Map<String, Object> pmap ,HttpSession session){
        logger.info("attendStart");
        EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        String attendStartTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        formatter.setTimeZone(TimeZone.getTimeZone("Asia/Seoul"));
        Date parsedDate = null;
        try {
            parsedDate = formatter.parse(attendStartTime);
            empVO.setHistory_Attend_Time(attendStartTime);
        } catch (Exception e) {
            logger.error("Error parsing date: " + e.getMessage());
        }
        String empId = null;
        if(empVO != null) {
            empId = empVO.getEmp_Id();
        }
        logger.info(attendStartTime);
        logger.info(parsedDate.toString());
        pmap.put("empId", empId);
        pmap.put("history_attend_time",parsedDate);
        pmap = attendenceService.attendStart(pmap);
        logger.info(pmap.toString());
        String attend_st_id_str = String.valueOf(pmap.get("attend_st_id"));
        String attend_st_name_str = (String) pmap.get("attend_st_name");
        empVO.setAttend_St_Id(attend_st_id_str);
        empVO.setAttend_St_Name(attend_st_name_str);
        logger.info(empVO.toString());
        return pmap;
    }

    @GetMapping("attendEnd")
    public Map<String, Object> attendEnd(@RequestParam Map<String, Object> pmap ,HttpSession session){
        logger.info("attendEnd");
        EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        String attendEndTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        formatter.setTimeZone(TimeZone.getTimeZone("Asia/Seoul"));
        Date parsedDate = null;
        try {
            parsedDate = formatter.parse(attendEndTime);
            empVO.setHistory_Leaving_Time(attendEndTime);
        } catch (Exception e) {
            logger.error("Error parsing date: " + e.getMessage());
        }
        String empId = null;
        if(empVO != null) {
            empId = empVO.getEmp_Id();
        }
        logger.info(attendEndTime);
        logger.info(parsedDate.toString());
        pmap.put("empId", empId);
        pmap.put("history_leaving_time",parsedDate);
        pmap = attendenceService.attendEnd(pmap);
        logger.info(pmap.toString());
        String attend_st_id_str = String.valueOf(pmap.get("attend_st_id"));
        String attend_st_name_str = (String) pmap.get("attend_st_name");
        empVO.setAttend_St_Id(attend_st_id_str);
        empVO.setAttend_St_Name(attend_st_name_str);
        logger.info(empVO.toString());
        return pmap;
    }

    @GetMapping("attendSelect")
    public List<Map<String, Object>> attendSelect(@RequestParam Map<String, Object> pmap){
        logger.info("attendSelect");
        logger.info(pmap.toString());
        List<Map<String, Object>> result = attendenceService.attendSelect(pmap);
        return result;
    }

    @GetMapping("attendMainSelect")
    public List<Map<String, Object>> attendMainSelect(@RequestParam Map<String, Object> pmap, HttpSession session){
        logger.info("attendMainSelect");
        EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        String empId = null;
        if(empVO != null) {
            empId = empVO.getEmp_Id();
        }
        pmap.put("empId", empId);
        logger.info(pmap.toString());
        List<Map<String, Object>> result = attendenceService.attendMainSelect(pmap);
        Map<String, Object> attendenceCountList = attendenceService.attendenceCountList(pmap);
        result.add(attendenceCountList);
        logger.info(result.toString());
        return result;
    }
}
