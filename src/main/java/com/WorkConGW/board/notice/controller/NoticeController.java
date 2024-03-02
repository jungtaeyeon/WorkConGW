package com.WorkConGW.board.notice.controller;

import com.WorkConGW.board.BoardFormVO;
import com.WorkConGW.board.anony.dto.AnonyVO;
import com.WorkConGW.board.notice.dto.NoticeVO;
import com.WorkConGW.board.notice.service.NoticeService;
import com.WorkConGW.common.PaginationInfo;
import com.WorkConGW.common.controller.BaseController;
import com.WorkConGW.common.dto.AttachVO;
import com.WorkConGW.common.dto.BaseVO;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("board/notice/*")
public class NoticeController extends BaseController{
    Logger logger = LoggerFactory.getLogger(NoticeController.class);
    @Autowired
    private NoticeService noticeService;

//    파일 경로 yml에 설정
    @Value("${uploadPath}")
    private String fileUploadPath;


//    공지 전체조회
    @RequestMapping(value = "noticeList", method = {RequestMethod.GET, RequestMethod.POST})
    public String noticeList(@ModelAttribute("boardFormVO")BoardFormVO boardFormVO, Model model) throws SQLException {
        String url = "/board/notice/list";

        NoticeVO searchNoticeVO = boardFormVO.getSearchNoticeVO();
        // 페이지네이션
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(searchNoticeVO.getPageIndex());

        paginationInfo.setRecordCountPerPage(searchNoticeVO.getPageUnit()); //한 페이지당 게시되는 게시물 수에 pageunit의 디폴트 값인 10 을 넣는다.
        paginationInfo.setPageSize(searchNoticeVO.getPageSize());

        searchNoticeVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        searchNoticeVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        Map<String,Object> dataMap = noticeService.getNoticeList(searchNoticeVO);
        int totCnt = noticeService.searchListTotalCount(searchNoticeVO);
        paginationInfo.setTotalRecordCount(totCnt);
        logger.info(paginationInfo.toString());
        searchNoticeVO.setEndDate(paginationInfo.getLastPageNoOnPageList());
        searchNoticeVO.setStartDate(paginationInfo.getFirstPageNoOnPageList());
        searchNoticeVO.setPrev(paginationInfo.getXprev());
        searchNoticeVO.setNext(paginationInfo.getXnext());



        model.addAttribute("noticeList", dataMap.get("noticeList"));
        model.addAttribute("importantNoticeList", dataMap.get("importantNoticeList"));
        model.addAttribute("paginationInfo", paginationInfo);//목록페이징
        model.addAttribute("totCnt", totCnt);
        model.addAttribute("totalPageCnt", (int)Math.ceil(totCnt/(double)searchNoticeVO.getPageUnit()));
        model.addAttribute("today", new Date());
        return url;
    }

//      공지 상세
    @GetMapping("detail")
    public String detail(@ModelAttribute("boardFormVO")BoardFormVO boardFormVO, Model model, HttpServletRequest req, HttpServletResponse res) throws Exception {
        String url="/board/notice/detail";

        logger.info(String.valueOf(boardFormVO.getNotice_id()));
        logger.info(String.valueOf(boardFormVO.getNoticeVO().getNotice_id()));

        boardFormVO.setNoticeVO(noticeService.getNotice(boardFormVO.getNoticeVO()));
        NoticeVO noticeVO = boardFormVO.getNoticeVO();
        logger.info(noticeVO.getEmp_writer_id());

        // 새로고침시 조회수 증가 방지
        if(!isCookieExist(req,res,"notice_id",String.valueOf(noticeVO.getNotice_id()))) {
            noticeService.increaseNoticeReadCnt(noticeVO);
        }

        NoticeVO detailVO = noticeService.getNotice(noticeVO);
        boardFormVO.setNoticeVO(detailVO);

        model.addAttribute("notice", noticeVO);
        return url;
    }

//    공지 등록 공통 폼
    @RequestMapping("/registForm")
    public String registForm(@ModelAttribute("boardFormVO")BoardFormVO boardFormVO, Model model) {
//        model.addAttribute("boardFormVO", boardFormVO);
        String url="board/registForm";
        return url;
    }

//    공지 등록
    @ResponseBody
    @PostMapping("regist")
    public String regist(BoardFormVO boardFormVO)throws Exception {
        logger.info("관리자페이지 오류 : 여기들어오니?"+ boardFormVO.toString());

        if(boardFormVO.getFileUploadCommand() != null){
            // 파일 업로드 설정
            boardFormVO.getFileUploadCommand().setFileUploadPath(fileUploadPath);
            List<AttachVO> attachList = saveFile(boardFormVO.getFileUploadCommand());
            boardFormVO.getNoticeVO().setNoticeAttachList(attachList);
        }

        noticeService.regist(boardFormVO.getNoticeVO());
        logger.info(String.valueOf(boardFormVO.getNoticeVO().getNotice_id()));

        return String.valueOf(boardFormVO.getNoticeVO().getNotice_id());
    }

//    공지 삭제
    @ResponseBody
    @PostMapping("remove")
    public void remove(BoardFormVO boardFormVO) throws SQLException{
        noticeService.remove(boardFormVO.getNoticeVO());
    }

//    게시글 수정 공통 폼
    @RequestMapping("modifyForm")
    public String ModifyForm(@ModelAttribute("boardFormVO")BoardFormVO boardFormVO)throws Exception{
        String url ="board/notice/modifyForm";
        logger.info(boardFormVO.getNoticeVO().getNotice_title());
        logger.info(boardFormVO.getNoticeVO().getNotice_content());
        return url;

    }

//    공지사항 수정
    @ResponseBody
    @PostMapping("modify")
    public void modify(BoardFormVO boardFormVO)throws Exception{
        if (boardFormVO.getFileUploadCommand() != null){
            // 파일 업로드 설정
            boardFormVO.getFileUploadCommand().setFileUploadPath(fileUploadPath);
            List<AttachVO> attachList = saveFile(boardFormVO.getFileUploadCommand());
            boardFormVO.getNoticeVO().setNoticeAttachList(attachList);
        }
        noticeService.modify(boardFormVO);
    }
}