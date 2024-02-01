package com.WorkConGW.admin.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;



@Controller
@RequestMapping("/admin/*")
public class AdminCommonController{

 @RequestMapping(value = "/main")
 public String adminMain(){
    String url = "/admin/main";
    return url;
 }

	
}
