package com.WorkConGW.addbook.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.WorkConGW.common.controller.BaseController;



@Controller
@RequestMapping("/addBook/*")
public class AddBookController extends BaseController{
	 
    @RequestMapping(value = "addBookList" , method = RequestMethod.GET)
    public String addBookList()
    {
        String url = "addbook/list";
        return url;
    }
	
}
