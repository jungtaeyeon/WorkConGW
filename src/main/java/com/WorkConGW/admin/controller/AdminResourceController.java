package com.WorkConGW.admin.controller;




import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/admin/resource/*")
public class AdminResourceController {


    @RequestMapping("/loginlog")
    public String loginLog() {
        return "/admin/resource/loginlog";
    }
	
	
}
