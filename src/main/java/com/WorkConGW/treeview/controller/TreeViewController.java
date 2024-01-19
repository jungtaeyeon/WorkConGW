package com.WorkConGW.treeview.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class TreeViewController {
    @RequestMapping(value="/treeviewMain",method = RequestMethod.GET)
	public String treeviewMain() {
		return "common/loginForm";
	}

}
