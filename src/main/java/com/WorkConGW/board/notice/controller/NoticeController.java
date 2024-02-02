package com.WorkConGW.board.notice.controller;

import com.WorkConGW.board.BoardFormVO;
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

    // 페이징
//    protected void setUpPaginationInfo(PaginationInfo paginationInfo, BaseVO baseVO) {
//
//
//        List<BaseVO> pageUnitSelector = new ArrayList<BaseVO>();
//        BaseVO pageUnitVO = null;
//        for(String unit : BaseVO.PAGE_UNITS) {
//            pageUnitVO = new BaseVO();
//            pageUnitVO.setPageUnitValue(unit);
//            pageUnitVO.setPageUnitLabel(unit+"개씩");
//            pageUnitSelector.add(pageUnitVO);
//        }
//        baseVO.setPageUnitSelector(pageUnitSelector);
//
//        paginationInfo.setCurrentPageNo(baseVO.getPageIndex());
//        paginationInfo.setRecordCountPerPage(baseVO.getPageUnit());
//        paginationInfo.setPageSize(baseVO.getPageSize());
//
//        baseVO.setFirstIndex(paginationInfo.getFirstRecordIndex()+1);
//        baseVO.setLastIndex(paginationInfo.getLastRecordIndex());
//        baseVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
//
//    }

//    새로고침 시 조회수 증가 방지를 위해 작성
    public boolean isCookieExist(HttpServletRequest request, HttpServletResponse response, String cookieName, String cookieValue) throws Exception {
        boolean isExist = false;
        Cookie[] cookies = request.getCookies();
        Cookie checkCookie = null;
        if(cookies != null && cookies.length > 0) {
            for(Cookie cookie : cookies) {
                if(cookie.getName().equals(cookieName) && cookie.getValue().equals(cookieValue)) {	// 쿠키가 존재하면
                    checkCookie = cookie;
                    /* 쿠키가 존재한다는 얘기 */
                    break; // breadk는 가까운 for문 탈출~ 다음 로직은 밑에 else isExist = true (존재하니깐)
                }
            }
        }

        if(checkCookie == null) {	// 쿠키가 존재하지 않으면
            Cookie newCookie = new Cookie(cookieName, cookieValue);
            response.addCookie(newCookie); // 클라이언트에 쿠키값을 보낸다.
        }else {	// 쿠키가 존재하면
            isExist = true;
        }
        return isExist;
    }

//    공지 전체조회
    @RequestMapping(value = "noticeList", method = {RequestMethod.GET, RequestMethod.POST})
    public String noticeList(@ModelAttribute("boardFormVO")BoardFormVO boardFormVO, Model model) throws SQLException {
        String url = "/board/notice/list";

        NoticeVO searchNoticeVO = boardFormVO.getSearchNoticeVO();
        PaginationInfo paginationInfo = new PaginationInfo();
//        setUpPaginationInfo(paginationInfo, searchNoticeVO);

        int totCnt = noticeService.searchListTotalCount(searchNoticeVO);
        paginationInfo.setTotalRecordCount(totCnt);

        Map<String,Object> dataMap = noticeService.getNoticeList(searchNoticeVO);
        model.addAttribute("noticeList", dataMap.get("noticeList"));
        model.addAttribute("importantNoticeList", dataMap.get("importantNoticeList"));
        model.addAttribute("paginationInfo", paginationInfo);//목록페이징
        model.addAttribute("today", new Date());
        return url;
    }

//      공지 상세
    @GetMapping("detail")
    public String detail(@ModelAttribute("boardFormVO")BoardFormVO boardFormVO, Model model, HttpServletRequest req, HttpServletResponse res) throws Exception {
        String url="/board/notice/detail";

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
        // 파일 업로드 설정
        boardFormVO.getFileUploadCommand().setFileUploadPath(fileUploadPath);
        List<AttachVO> attachList = saveFile(boardFormVO.getFileUploadCommand());
        boardFormVO.getNoticeVO().setNoticeAttachList(attachList);


        noticeService.regist(boardFormVO.getNoticeVO());
        logger.info(String.valueOf(boardFormVO.getNoticeVO().getNotice_id()));
        logger.info(String.valueOf(boardFormVO.getNoticeVO()));

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
            // 파일 업로드 설정
            boardFormVO.getFileUploadCommand().setFileUploadPath(fileUploadPath);
            List<AttachVO> attachList = saveFile(boardFormVO.getFileUploadCommand());
            boardFormVO.getNoticeVO().setNoticeAttachList(attachList);

        noticeService.modify(boardFormVO);
        logger.info(boardFormVO.getNoticeVO().getNotice_title());
        logger.info(boardFormVO.getNoticeVO().getNotice_content());
    }
}