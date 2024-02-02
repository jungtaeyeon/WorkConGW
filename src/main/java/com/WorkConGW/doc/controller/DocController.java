package com.WorkConGW.doc.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;



@Controller
@RequestMapping("/doc")
public class DocController {

    @RequestMapping(value="/main",method = RequestMethod.GET)
	public String docMain() {
		return "doc/main";
	}
	

}
