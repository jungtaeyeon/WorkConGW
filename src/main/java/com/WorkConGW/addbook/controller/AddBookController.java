package com.WorkConGW.addbook.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.WorkConGW.addbook.dto.AddBookVO;
import com.WorkConGW.addbook.service.AddBookService;
import com.WorkConGW.common.controller.BaseController;
import com.WorkConGW.common.dto.HomeFormVO;



@Controller
@RequestMapping("/addBook/*")
public class AddBookController extends BaseController{
	Logger logger = LoggerFactory.getLogger(AddBookController.class);
    @Autowired
    private AddBookService addBookService;

    @GetMapping("addBookList")
    public String addBookList(Model model, @RequestParam String empId)
    {
        logger.info("addBookList");
        List<AddBookVO> abList = null;
        abList = addBookService.addBookList(empId);
        logger.info(abList.toString());
        String url = "addbook/list";
        model.addAttribute("abList", abList);
        return url;
    }
}

