package com.WorkConGW.attend.controller;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.WorkConGW.attend.service.AttendenceService;
import com.WorkConGW.common.controller.CommonController;
import com.WorkConGW.emp.dto.EmpVO;
import com.WorkConGW.attend.dto.AttendenceVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/attend")
public class AttendenceController extends CommonController{
	Logger logger = LoggerFactory.getLogger(AttendenceController.class);
	@Autowired
	private AttendenceService attendenceService;

	@RequestMapping(value="/main",method = RequestMethod.GET)
	public String attendMain(HttpSession session, Model model) {
		logger.info("attendMain");
		List<AttendenceVO> attendenceList = null;
		EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        String empId = null;
        if(empVO != null) {
            empId = empVO.getEmp_Id();
        }
		Map<String, Object> pmap = new HashMap<>();
		String attendDay = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM"));
		pmap.put("empId", empId);
		pmap.put("attendDay", attendDay);
		attendenceList = attendenceService.attendenceList(pmap);
		Map<String, Object> attendenceCountList = attendenceService.attendenceCountList(pmap);
		logger.info(attendenceCountList.toString());
		model.addAttribute("attendenceCountList", attendenceCountList);
		model.addAttribute("attendenceList", attendenceList);
		return "attend/main";
	}

	@RequestMapping(value="/historyReasonInsert",method = RequestMethod.GET)
	public String historyReasonInsert(HttpSession session, @RequestParam Map<String, Object> pmap) {
		logger.info("addBookInsert");
		EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        String empId = null;
        if(empVO != null) {
            empId = empVO.getEmp_Id();
        }
        pmap.put("empId", empId);
		attendenceService.historyReasonInsert(pmap);
		return "redirect:/attend/main";
	}

	@RequestMapping(value="/attentMyList",method = RequestMethod.GET)
	public String attentMyList() {
		return "attend/myList";
	}

	@RequestMapping(value="/attentEmpList",method = RequestMethod.GET)
	public String attentEmpList() {
		return "attend/empList";
	}
	
	
}
