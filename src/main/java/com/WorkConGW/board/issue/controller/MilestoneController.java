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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
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

	@RequestMapping(value = "list", method= {RequestMethod.GET, RequestMethod.POST})
	public String milestoneList(MilestoneVO milestoneVO, Model model, HttpSession session) throws Exception{
		String url = "board/milestone/list";
		EmpVO loginUser = (EmpVO) session.getAttribute("loginUser");
		milestoneVO.setEmp_Id(loginUser.getEmp_Id());
		List<MilestoneVO> milestoneList = milestoneService.getMilestoneList(milestoneVO);

		// 반대 탭 리스트 개수 가져오기
		MilestoneVO tempVO = new MilestoneVO();
		BeanUtils.copyProperties(milestoneVO, tempVO);
		tempVO.setIsOpen(milestoneVO.getIsOpen().equals("open") ? "closed" : "open");
		int oppListCount = milestoneService.getMilestoneList(tempVO).size();

		model.addAttribute("oppListCount",oppListCount);
		model.addAttribute("milestoneList", milestoneList);

		return url;
	}

	@GetMapping("registForm")
	public String registForm(MilestoneVO milestoneVO) throws Exception{
		return "board/milestone/registForm";
	}

	@ResponseBody
	@PostMapping("regist")
	public void regist(MilestoneVO milestoneVO) throws Exception{
		milestoneService.regist(milestoneVO);
	}

	@GetMapping("modifyForm")
	public String modifyForm(MilestoneVO milestoneVO) throws Exception{
		// 마일스톤 Id를 받아와서 받아온 Id로 마일스톤 조회 후 tempVO에 담는다.
		MilestoneVO tempVO = milestoneService.getMilestone(milestoneVO);
		// 조회된 값을 milestoneVO에 복사 -> 굳이 MilestoneVO 객체를 새로 만들지 않고 복사해서 원본을 사용
		BeanUtils.copyProperties(tempVO, milestoneVO);
		return "board/milestone/registForm";
	}

//	@ResponseBody
	@PostMapping("modify")
	public String modify(MilestoneVO milestoneVO) throws Exception{
		milestoneService.modify(milestoneVO);
		return "redirect:/board/milestone/list?isOpen="+milestoneVO.getIsOpen();
	}

	@PostMapping("remove")
	public String remove(MilestoneVO milestoneVO, HttpSession session) throws Exception{
		milestoneService.remove(milestoneVO, session);
		return "redirect:/board/milestone/list";
	}

	@RequestMapping(value = "detail", method= {RequestMethod.GET, RequestMethod.POST})
	public String detail(MilestoneVO milestoneVO, Model model) throws Exception{
		String url ="board/milestone/detail";

		MilestoneVO milestone = milestoneService.getMilestone(milestoneVO);

		model.addAttribute("milestone",milestone);

		return url;
	}
}
