package com.WorkConGW.board.issue.controller;

import com.WorkConGW.board.issue.dto.MilestoneVO;
import com.WorkConGW.board.issue.service.MilestoneService;
import com.WorkConGW.board.notice.controller.NoticeController;
import com.WorkConGW.emp.dto.EmpVO;
import jakarta.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/board/milestone/*")
public class MilestoneController {
	Logger logger = LoggerFactory.getLogger(MilestoneController.class);

	private final MilestoneService milestoneService;

	@Autowired
	public MilestoneController(MilestoneService milestoneService) {
		this.milestoneService = milestoneService;
	}

	@GetMapping("list")
	public ModelAndView milestoneList(MilestoneVO milestoneVO, ModelAndView mnv) throws Exception{
		mnv.setViewName("board/milestone/list");
		
		return mnv;
	}
	
	@GetMapping("registForm")
	public String registForm(MilestoneVO milestoneVO) throws Exception{
		return "board/milestone/registForm";
	}
	
	@GetMapping("modifyForm")
	public String modifyForm(MilestoneVO milestoneVO) throws Exception{

		return "board/milestone/registForm";
	}

	
	@GetMapping("detail")
	public ModelAndView detail(MilestoneVO milestoneVO, ModelAndView mnv) throws Exception{
		mnv.setViewName("board/milestone/detail");

		return mnv;
	}
}
