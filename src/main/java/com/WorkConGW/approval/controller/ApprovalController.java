package com.WorkConGW.approval.controller;



import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.servlet.ModelAndView;


import com.WorkConGW.common.controller.BaseController;


@Controller
@RequestMapping("/approval")
public class ApprovalController extends BaseController{


    @RequestMapping(value = "/main")
    public ModelAndView approvalMain()
    {
        ModelAndView mnv = new ModelAndView();
        String url = "approval/main";
        mnv.setViewName(url);
        return mnv;
    }
	
}
