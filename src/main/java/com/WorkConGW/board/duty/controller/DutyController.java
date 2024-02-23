package com.WorkConGW.board.duty.controller;

import com.WorkConGW.board.BoardFormVO;
import com.WorkConGW.board.duty.dto.DutyVO;
import com.WorkConGW.board.duty.service.DutyService;
import com.WorkConGW.board.issue.dto.ProjectVO;
import com.WorkConGW.board.issue.service.ProjectService;
import com.WorkConGW.common.PaginationInfo;
import com.WorkConGW.common.controller.BaseController;
import com.WorkConGW.common.dto.AttachVO;
import com.WorkConGW.emp.dto.EmpVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import org.springframework.web.servlet.ModelAndView;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


@Controller
@RequestMapping("board/duty/*")
public class DutyController extends BaseController {
    Logger logger = LoggerFactory.getLogger(DutyController.class);
    private final DutyService dutyService;
    private final ProjectService projectService;

    @Value("${uploadPath}")
    private String fileUploadPath;

    @Autowired
    public DutyController(DutyService dutyService, ProjectService projectService) {
        this.dutyService = dutyService;
        this.projectService = projectService;
    }

    @RequestMapping(value="dutyList", method= {RequestMethod.GET, RequestMethod.POST})
    public String dutyList(@ModelAttribute("boardFormVO")BoardFormVO boardFormVO, Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{
        String url="board/duty/list";
        String dutyType = request.getParameter("dutyType");
        String emp_Id = ((EmpVO)request.getSession().getAttribute("loginUser")).getEmp_Id();

        logger.info(boardFormVO.getDutyVO().getDutyType());
        logger.info(boardFormVO.getSearchDutyVO().getDutyType());

        // 상세페이지 쿠키 삭제
        removeCookieByName(request,response,"duty_Board_Id");

        DutyVO searchDutyVO = boardFormVO.getSearchDutyVO();

        // 페이지네이션
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(searchDutyVO.getPageIndex());

        paginationInfo.setRecordCountPerPage(searchDutyVO.getPageUnit()); //한 페이지당 게시되는 게시물 수에 pageunit의 디폴트 값인 10 을 넣는다.
        paginationInfo.setPageSize(searchDutyVO.getPageSize());

        searchDutyVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        searchDutyVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        searchDutyVO.setEmp_Writer_Id(emp_Id);
        List<DutyVO> dutyList = new ArrayList<DutyVO>();
        int totCnt = 0;

        searchDutyVO.setDutyType(dutyType);
        if(searchDutyVO.getDutyType()!=null) {
            switch(searchDutyVO.getDutyType()) {
                case "receive":
                case "send":
                    logger.info("여기...!");
                    dutyList = dutyService.searchMyList(searchDutyVO);
                    totCnt = dutyService.searchMyListTotalCount(searchDutyVO);
                    break;
                case "reception":
                    dutyList = dutyService.searchReceptionList(searchDutyVO);
                    totCnt = dutyService.searchReceptionListTotalCount(searchDutyVO);
            }
        }else {
            dutyList = dutyService.searchList(searchDutyVO);
            totCnt = dutyService.searchListTotalCount(searchDutyVO);
        }

        paginationInfo.setTotalRecordCount(totCnt);
        searchDutyVO.setEndDate(paginationInfo.getLastPageNoOnPageList());
        searchDutyVO.setStartDate(paginationInfo.getFirstPageNoOnPageList());
        searchDutyVO.setPrev(paginationInfo.getXprev());
        searchDutyVO.setNext(paginationInfo.getXnext());

        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("totalPageCnt", (int)Math.ceil(totCnt/(double)searchDutyVO.getPageUnit()));
        model.addAttribute("today", new Date().getTime());
        model.addAttribute("myToday", new Date());
        model.addAttribute("dutyList", dutyList);

        return url;
    }

    @GetMapping("registForm")
    public String registForm(BoardFormVO boardFormVO, ProjectVO projectVO, Model model, HttpServletRequest request) throws Exception {
        String url="board/duty/registForm";
        boardFormVO.setProjectVO(projectService.getProjectList(projectVO));
        List<ProjectVO> projectList = boardFormVO.getProjectVO();

        model.addAttribute("projectList", projectList);

        return url;
    }

    @ResponseBody
    @PostMapping("regist")
    public String regist(BoardFormVO boardFormVO) throws Exception {

        if (boardFormVO.getFileUploadCommand() != null){
            // 파일 업로드 설정
            boardFormVO.getFileUploadCommand().setFileUploadPath(fileUploadPath);
            List<AttachVO> attachList = saveFile(boardFormVO.getFileUploadCommand());
            boardFormVO.getDutyVO().setAttachList(attachList);
        }

        try {
            dutyService.regist(boardFormVO.getDutyVO());
        }catch(SQLException e) {
            e.printStackTrace();
            throw e;
        }

        return String.valueOf(boardFormVO.getDutyVO().getDuty_Board_Id());
    }

    @GetMapping("detail")
    public String detail(@ModelAttribute("boardFormVO")BoardFormVO boardFormVO, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String url="board/duty/detail";
        boardFormVO.getDutyVO().setDuty_Board_Id(Integer.parseInt(request.getParameter("duty_Board_Id")));

        logger.info(String.valueOf(boardFormVO.getDutyVO().getDuty_Board_Id()));
        logger.info(String.valueOf(boardFormVO.getDuty_Board_Id()));

        DutyVO dutyVO = boardFormVO.getDutyVO();

        // 새로고침시 조회수 증가 방지
        if(!isCookieExist(request,response,"dutyBoardId",String.valueOf(dutyVO.getDuty_Board_Id()))) {
            dutyService.increaseDutyReadcnt(dutyVO);
        }

        PaginationInfo paginationInfo = new PaginationInfo();
        setUpPaginationInfo(paginationInfo, dutyVO);

        int totCnt = dutyService.replyListTotalCount(dutyVO);
        paginationInfo.setTotalRecordCount(totCnt);

        DutyVO detailVO = dutyService.getDutyForDetail(dutyVO, request.getSession());

        boardFormVO.setDutyVO(detailVO);

        model.addAttribute("duty", detailVO);
        model.addAttribute("paginationInfo", paginationInfo);

        return url;
    }

}
