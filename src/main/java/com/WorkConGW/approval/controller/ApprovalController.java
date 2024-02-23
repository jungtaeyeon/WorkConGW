package com.WorkConGW.approval.controller;



import com.WorkConGW.admin.controller.AdminCommonController;
import com.WorkConGW.approval.dto.FormVO;
import com.WorkConGW.approval.service.ApprovalService;
import com.WorkConGW.emp.dto.EmpVO;
import com.WorkConGW.emp.service.EmpService;
import jakarta.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;


@Controller
@RequestMapping("/approval/*")
public class ApprovalController {

    Logger logger = LoggerFactory.getLogger(ApprovalController.class);

    @Autowired
    private ApprovalService approvalService = null;


    @Autowired
    private EmpService empService = null;
    @GetMapping("/lists/waitList")
    public String waitList()
    {
        String url = "approval/lists/waitList";
        return url;
    }

    @GetMapping("/line")
    public String line()
    {
        return "approval/approvalLine";
    }


    @GetMapping("/lists/list")
    public String list()
    {
        String url = "approval/lists/list";
        return url;
    }

    @GetMapping("/lists/draftList")
    public String draftList()
    {
        String url = "approval/lists/draftList";
        return url;
    }

    @GetMapping("/lists/referList")
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
    @RequestMapping(value = "/approvalInsert")
    public String approvalInsert()
    {
        String url = "approval/insert";
        return url;
    }

    @GetMapping("/registDocForm")
    public String registDocForm(Model model)
    {
        List<FormVO> formVOList = new ArrayList<>();
        String url = "/approval/registDocForm";

        return url;
    }

    @RequestMapping(value = "/approvalLine")
    public String approvalLine(Model model, String docId, HttpServletRequest request)
    {
        EmpVO empVO = (EmpVO)request.getSession().getAttribute("loginUser");
        EmpVO emp = empService.getEmp(empVO.getEmp_Id());
        logger.info(emp.toString());
        model.addAttribute("emp",emp);
        model.addAttribute("docId",docId);
        String url = "approval/approvalLine";
        return url;
    }

    @RequestMapping(value = "/detail")
    public String detail()
    {
        String url = "approval/detail";
        return url;
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
