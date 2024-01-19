package com.WorkConGW.reservation.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.WorkConGW.common.controller.BaseController;

@Controller
@RequestMapping("/reservation")
public class MeetRoomController extends BaseController{

    @RequestMapping(value="/main",method = RequestMethod.GET)
	public String reservationMain() {
		return "reservation/main";
	}
	
}
