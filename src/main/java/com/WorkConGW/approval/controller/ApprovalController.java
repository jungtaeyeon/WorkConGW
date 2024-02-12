package com.WorkConGW.approval.controller;



import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.servlet.ModelAndView;




@Controller
@RequestMapping("/approval/*")
public class ApprovalController {

    @GetMapping("lists/waitList")
    public String waitList()
    {
        String url = "approval/lists/waitList";
        return url;
    }
    @GetMapping("lists/list")
    public String list()
    {
        String url = "approval/lists/list";
        return url;
    }

    @GetMapping("lists/draftList")
    public String draftList()
    {
        String url = "approval/lists/draftList";
        return url;
    }

    @GetMapping("lists/referList")
    public String referList()
    {
        String url = "approval/lists/referList";
        return url;
    }

    @RequestMapping(value = "/main")
    public ModelAndView approvalMain()
    {
        ModelAndView mnv = new ModelAndView();
        String url = "approval/main";
        mnv.setViewName(url);
        return mnv;
    }

    @GetMapping("lists/temporaryList")
    public String temporaryList()
    {
        String url = "approval/lists/temporaryList";

        return url;
    }

    @GetMapping("lists/completeList")
    public String completeList()
    {
        String url = "approval/lists/completeList";
        return url;
    }
	
}
