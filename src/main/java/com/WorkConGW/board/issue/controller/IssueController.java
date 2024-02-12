package com.WorkConGW.board.issue.controller;

import com.WorkConGW.board.BoardFormVO;
import com.WorkConGW.board.duty.dto.DutyVO;
import com.WorkConGW.board.issue.dto.IssueReplyVO;
import com.WorkConGW.board.issue.dto.IssueVO;
import com.WorkConGW.board.issue.dto.MilestoneVO;
import com.WorkConGW.board.issue.service.IssueService;
import com.WorkConGW.board.issue.service.MilestoneService;
import com.WorkConGW.common.PaginationInfo;
import com.WorkConGW.common.controller.BaseController;
import com.WorkConGW.emp.dto.EmpVO;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/board/issue/*")
public class IssueController extends BaseController {
	
	private final IssueService issueService;
	private final MilestoneService milestoneService;

	@Autowired
	public IssueController(IssueService issueService, MilestoneService milestoneService) {
		this.issueService = issueService;
		this.milestoneService = milestoneService;
	}


	@GetMapping("list")
	public ModelAndView issueList(BoardFormVO boardFormVO, ModelAndView mnv) throws Exception{
		mnv.setViewName("board/issue/list");
		
		return mnv;
	}

	@GetMapping("registForm")
	public String registForm(BoardFormVO boardFormVO) throws Exception {
		String url="board/issue/registForm";
		return url;
	}

	@GetMapping("detail")
	public ModelAndView detail(BoardFormVO boardFormVO, ModelAndView mnv) throws Exception{
		mnv.setViewName("board/issue/detail");
		
		return mnv;
	}
	
}
