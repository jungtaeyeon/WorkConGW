package com.WorkConGW.approval.controller;



import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.servlet.ModelAndView;




@Controller
@RequestMapping("/approval")
public class ApprovalController {


    @RequestMapping(value = "/main")
    public ModelAndView approvalMain()
    {
        ModelAndView mnv = new ModelAndView();
        String url = "approval/main";
        mnv.setViewName(url);
        return mnv;
    }

    @RequestMapping(value = "/approvalInsert")
    public String approvalInsert()
    {
        String url = "approval/insert";
        return url;
    }
    @RequestMapping(value = "/approvalLine")
    public String approvalLine()
    {
        String url = "approval/approvalLine";
        return url;
    }

    @RequestMapping(value = "/detail")
    public String detail()
    {
        String url = "approval/detail";
        return url;
    }
	
}
