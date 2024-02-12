package com.WorkConGW.admin.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;



@Controller
@RequestMapping("/admin/emp")
public class AdminEmpController  {
    Logger logger = LoggerFactory.getLogger(AdminEmpController.class);

    @GetMapping("empList")
    public String empList()
    {
        logger.info("empList");
        String url = "admin/emp/list";
        return url;
    }

    @GetMapping("empDetail")
    public String empDetail()
    {
        logger.info("empDetail");
        String url = "admin/emp/detail";
        return url;
    }

    @GetMapping("empInsert")
    public String empInsert()
    {
        logger.info("empInsert");
        String url = "admin/emp/insert";
        return url;
    }

    @GetMapping("empUpdate")
    public String empUpdate()
    {
        logger.info("empUpdate");
        String url = "admin/emp/insert";
        return url;
    }
}
