package com.WorkConGW.board.duty.controller;




import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.servlet.ModelAndView;



@Controller
@RequestMapping("board/duty/*")
public class DutyController  {

    @RequestMapping(value ="dutyList", method = RequestMethod.GET)
    public ModelAndView dutyList()
    {
        ModelAndView mnv = new ModelAndView();
        String url = "/board/duty/list";
        mnv.setViewName(url);
        return mnv;
    }





	
}
