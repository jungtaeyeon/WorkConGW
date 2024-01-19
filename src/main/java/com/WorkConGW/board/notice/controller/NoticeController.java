package com.WorkConGW.board.notice.controller;

import java.sql.SQLException;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.WorkConGW.board.BoardFormVO;
import com.WorkConGW.board.notice.dto.NoticeVO;
import com.WorkConGW.board.notice.service.NoticeService;
import com.WorkConGW.common.controller.BaseController;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("board/notice/*")
public class NoticeController extends BaseController{
    Logger logger = LoggerFactory.getLogger(NoticeController.class);
    @Autowired
    private NoticeService noticeService;

    // @GetMapping("/noticeList")
    // public String noticeList()throws Exception{
    //     List<Map<String, Object>> list = noticeService.getNoticeList();
    //     logger.info(list.toString());
    //     return "/board/notice/list";
    // }

    @RequestMapping(value = "/noticeList", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView noticeList(BoardFormVO boardFormVO, ModelAndView mnv, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws SQLException
    {
        String url = "board/notice/list";
        NoticeVO saerchNoticeVO = boardFormVO.getSearchNoticeVO();
        Map<String,Object> datMap = noticeService.getNoticeList(saerchNoticeVO);
        mnv.setViewName(url);
        mnv.addObject(datMap);
        return mnv;
    }
}