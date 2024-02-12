package com.WorkConGW.attend.controller;



import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.WorkConGW.common.controller.CommonController;

@Controller
@RequestMapping("/attend")
public class AttendenceController extends CommonController{

    @RequestMapping(value="/main",method = RequestMethod.GET)
	public String attendMain() {
		return "attend/main";
	}

	@RequestMapping(value="/attentMyList",method = RequestMethod.GET)
	public String attentMyList() {
		return "attend/myList";
	}

	@RequestMapping(value="/attentEmpList",method = RequestMethod.GET)
	public String attentEmpList() {
		return "attend/empList";
	}
	
	
}
