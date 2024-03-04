package com.WorkConGW.common.controller;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

import org.springframework.web.bind.annotation.RestController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.WorkConGW.common.dto.HomeFormVO;
import com.WorkConGW.common.service.HomeService;
import com.WorkConGW.emp.dto.EmpVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;

@RestController
@RequestMapping("/common/*")
public class RestCommonController {
    @Autowired
    private HomeService homeService;
    Logger logger = LoggerFactory.getLogger(RestCommonController.class);

    @GetMapping("/homescheduleList")
    public List<Map<String, Object>> homescheduleList(@RequestParam Map<String, Object> pmap, HttpSession session){
        logger.info("homescheduleList");
        EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        String empId = null;
        if(empVO != null) {
            empId = empVO.getEmp_Id();
        }
        pmap.put("empId", empId);
        logger.info(pmap.toString());
        List<Map<String, Object>> result = homeService.homescheduleList(pmap);
        logger.info(result.toString());
        return result;
    }
    
    @GetMapping("/homeReservationList")
    public List<Map<String, Object>> homeReservationList(@RequestParam Map<String, Object> pmap, HttpSession session){
        logger.info("homeReservationList");
        EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        String empId = null;
        if(empVO != null) {
            empId = empVO.getEmp_Id();
        }
        pmap.put("empId", empId);
        logger.info(pmap.toString());
        List<Map<String, Object>> result = homeService.homeReservationList(pmap);
        logger.info(result.toString());
        return result;
    }
}
