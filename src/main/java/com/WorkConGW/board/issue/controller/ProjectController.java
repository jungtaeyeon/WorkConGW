package com.WorkConGW.board.issue.controller;

import com.WorkConGW.board.issue.dto.IssueVO;
import com.WorkConGW.board.issue.dto.MilestoneVO;
import com.WorkConGW.board.issue.dto.ProjectVO;
import com.WorkConGW.board.issue.service.IssueService;
import com.WorkConGW.board.issue.service.ProjectService;
import com.WorkConGW.emp.dto.EmpVO;
import jakarta.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/board/project/*")
public class ProjectController {
	Logger logger = LoggerFactory.getLogger(ProjectController.class);

	private final IssueService issueService;
	private final ProjectService projectService;

	@Autowired
	public ProjectController(IssueService issueService, ProjectService projectService) {
		this.issueService = issueService;
        this.projectService = projectService;
    }

	@RequestMapping(value = "list", method = {RequestMethod.GET, RequestMethod.POST})
	public String projectList(ProjectVO projectVO, Model model, HttpSession session) throws Exception{
		String url = "board/project/list";
//		EmpVO loginUser = (EmpVO) session.getAttribute("loginUser");
//		projectVO.setEmp_Id(loginUser.getEmp_Id());
		List<ProjectVO> projectList = projectService.getProjectList(projectVO);

		// 반대 탭 리스트 개수 가져오기
		ProjectVO tempVO = new ProjectVO();
		BeanUtils.copyProperties(projectVO, tempVO);
		tempVO.setIsOpen(projectVO.getIsOpen().equals("open") ? "closed" : "open");
		int oppListCount = projectService.getProjectList(tempVO).size();

		model.addAttribute("oopListCount", oppListCount);
		model.addAttribute("projectList", projectList);

		return url;
	}

	@GetMapping("registForm")
	public String registForm(ProjectVO projectVO) throws Exception{
		return "board/project/registForm";
	}

	@ResponseBody
	@PostMapping("regist")
	public void regist(ProjectVO projectVO) throws Exception{
		projectService.regist(projectVO);
	}

	@GetMapping("modifyForm")
	public String modifyForm(ProjectVO projectVO) throws Exception{
		ProjectVO tempVO = projectService.getProject(projectVO);
		BeanUtils.copyProperties(tempVO, projectVO);
		logger.info(projectVO.getProject_Title());

		return "board/project/registForm";
	}

	@PostMapping("modify")
	public String modify(ProjectVO projectVO) throws Exception{
		projectService.modify(projectVO);
		logger.info(String.valueOf(projectVO.getProject_St()));

		return "redirect:/board/project/list?isOpen="+projectVO.getIsOpen();
	}

	@PostMapping("remove")
	public String remove(ProjectVO projectVO) throws Exception{
		projectService.remove(projectVO);
		return "redirect:/board/project/list";
	}

	@PostMapping("detail")
	public String detail(ProjectVO projectVO, Model model) throws Exception {
		String url = "board/project/detail";
		ProjectVO project = projectService.getProject(projectVO);

		List<IssueVO> issueList =  issueService.getMyIssueList(projectVO);
		logger.info(issueList.toString());

		List<IssueVO> todoList = new ArrayList<IssueVO>();
		List<IssueVO> inprogressList = new ArrayList<IssueVO>();
		List<IssueVO> doneList = new ArrayList<IssueVO>();
//		List<IssueVO> noList = new ArrayList<IssueVO>();
		for(IssueVO issue : issueList){
			if("todo".equals(issue.getIssue_Project_St())) {
				todoList.add(issue);
			}else if("inprogress".equals(issue.getIssue_Project_St())) {
				inprogressList.add(issue);
			}else if("done".equals(issue.getIssue_Project_St())) {
				doneList.add(issue);
			}
//			else {
//				noList.add(issue);
//			}
		}
		logger.info(todoList.toString());
		logger.info(inprogressList.toString());
		logger.info(doneList.toString());

		model.addAttribute("todoList", todoList);
		model.addAttribute("inprogressList", inprogressList);
		model.addAttribute("doneList", doneList);
//		model.addAttribute("noList", noList);
		model.addAttribute("project", project);

		return url;
	}
}
