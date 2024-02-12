package com.WorkConGW.board.duty.controller;

import com.WorkConGW.board.BoardFormVO;
import com.WorkConGW.board.duty.dto.DutyVO;
import com.WorkConGW.board.duty.service.DutyService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.servlet.ModelAndView;



@Controller
@RequestMapping("board/duty/*")
public class DutyController  {

    @Autowired
    DutyService dutyService;

    @RequestMapping(value ="dutyList", method = RequestMethod.GET)
    public ModelAndView dutyList()
    {
        ModelAndView mnv = new ModelAndView();
        String url = "/board/duty/list";
        mnv.setViewName(url);
        return mnv;
    }

    @RequestMapping("/registForm")
    public String registForm(BoardFormVO boardFormVO, HttpServletRequest request) throws Exception {
        String url="board/duty/registForm";

        if("issue".equals(boardFormVO.getRegistParam())) {

            int dutyBoardId = boardFormVO.getDutyVO().getDuty_Board_Id();
            DutyVO detailVO = dutyService.getDutyForDetail(boardFormVO.getDutyVO(), request.getSession());
            boardFormVO.setDutyVO(detailVO);
        }

        return url;
    }





	
}
