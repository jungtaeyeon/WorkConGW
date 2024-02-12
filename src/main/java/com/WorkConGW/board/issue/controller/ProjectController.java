package com.WorkConGW.board.issue.controller;

import com.WorkConGW.board.issue.command.ProjectCommand;
import com.WorkConGW.board.issue.dto.IssueVO;
import com.WorkConGW.board.issue.service.IssueService;
import com.WorkConGW.emp.dto.EmpVO;
import jakarta.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/board")
public class ProjectController {
	Logger logger = LoggerFactory.getLogger(ProjectController.class);

	@Autowired
	private IssueService issueService;
	
	@GetMapping("project")
	public ModelAndView main(ModelAndView mnv, HttpSession session) throws Exception {
		mnv.setViewName("board/project/main");
		
		return mnv;
	}

}
