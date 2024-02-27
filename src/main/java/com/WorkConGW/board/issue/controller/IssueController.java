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
@RequestMapping("/board/issue/*")
public class IssueController extends BaseController {
	Logger logger = LoggerFactory.getLogger(IssueController.class);
	
	private final IssueService issueService;
	private final MilestoneService milestoneService;

	@Autowired
	public IssueController(IssueService issueService, MilestoneService milestoneService) {
		this.issueService = issueService;
		this.milestoneService = milestoneService;
	}

	@RequestMapping(value ="list" , method= {RequestMethod.GET, RequestMethod.POST})
	public String issueList(BoardFormVO boardFormVO, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception{
		String url = "board/issue/list";
		IssueVO searchIssueVO = boardFormVO.getSearchIssueVO();

		// 상세페이지 쿠키 삭제
		removeCookieByName(request,response,"issueBoardId");

		// 페이지네이션
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchIssueVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchIssueVO.getPageUnit()); //한 페이지당 게시되는 게시물 수에 pageunit의 디폴트 값인 10 을 넣는다.
		paginationInfo.setPageSize(searchIssueVO.getPageSize());
		searchIssueVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchIssueVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<IssueVO> issueList = issueService.searchList(searchIssueVO);

		// 리스트 총 개수 가져오기
		int totCnt = issueService.searchIssueTotalCount(searchIssueVO);
		paginationInfo.setTotalRecordCount(totCnt);
		searchIssueVO.setEndDate(paginationInfo.getLastPageNoOnPageList());
		searchIssueVO.setStartDate(paginationInfo.getFirstPageNoOnPageList());
		searchIssueVO.setPrev(paginationInfo.getXprev());
		searchIssueVO.setNext(paginationInfo.getXnext());

		// 반대 탭 리스트 개수 가져오기
		IssueVO tempVO = new IssueVO();
		BeanUtils.copyProperties(searchIssueVO, tempVO);
		tempVO.setIsOpen(boardFormVO.getSearchIssueVO().getIsOpen().equals("open") ? "closed" : "open");
		int oppListCount = issueService.searchIssueTotalCount(tempVO);

		model.addAttribute("oppListCount",oppListCount);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("issueList", issueList);
		model.addAttribute("board/issue/list.page");

		return url;
	}

	@ResponseBody
	@PostMapping("regist")
	public String regist(IssueVO issueVO) throws Exception{
		issueService.regist(issueVO);

		return String.valueOf(issueVO.getIssue_Board_Id());
	}

	@GetMapping("detail")
	public String detail(BoardFormVO boardFormVO, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		String url = "board/issue/detail";
		IssueVO issueVO = boardFormVO.getIssueVO();

		// 새로고침시 조회수 증가 방지
		if(!isCookieExist(request,response,"issueBoardId",String.valueOf(issueVO.getIssue_Board_Id()))) {
			issueService.increaseIssueReadcnt(issueVO);
		}

		logger.info(String.valueOf(issueVO.getIssue_Board_Id()));

		IssueVO issue = issueService.getIssue(issueVO);
		boardFormVO.setIssueVO(issue);

		// 마일스톤 전체 리스트
		EmpVO loginUser = (EmpVO) session.getAttribute("loginUser");
		List<MilestoneVO> milestoneList = milestoneService.getMilestoneListAll(loginUser);

		model.addAttribute("issue", issue);
		model.addAttribute("issueReplyList", issue.getIssueReplyList());
		model.addAttribute("milestoneList", milestoneList);

		return url;
	}

	/* 프로젝트에서도 사용 */
	@ResponseBody
	@PostMapping("modify")
	public String modify(BoardFormVO boardFormVO) throws Exception{
		IssueVO issueVO = boardFormVO.getIssueVO();
		issueService.modify(issueVO);

		IssueVO resultVO = issueService.getIssue(issueVO);
		return resultVO.getDuty_Board_Title();
	}

	@ResponseBody
	@PostMapping("remove")
	public void remove(BoardFormVO boardFormVO) throws Exception{
		issueService.remove(boardFormVO.getIssueVO());
	}

	@ResponseBody
	@PostMapping("reply/regist")
	public IssueReplyVO replyRegist(IssueReplyVO issueReplyVO) throws Exception {
		logger.info("여기??");
		issueService.registReply(issueReplyVO);

		return issueReplyVO;
	}

	@ResponseBody
	@PostMapping("reply/remove")
	public void replyRemove(IssueReplyVO issueReplyVO) throws Exception{
		logger.info(String.valueOf(issueReplyVO.getReply_Id()));
		issueService.removeReply(issueReplyVO);
	}

	@ResponseBody
	@PostMapping("reply/modify")
	public void replyModify(IssueReplyVO issueReplyVO) throws Exception {
		issueService.modifyReply(issueReplyVO);
	}
	
}
