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

import com.WorkConGW.addbook.dao.AddBookDAO;
import com.WorkConGW.addbook.dto.AddBookVO;
import com.WorkConGW.addbook.service.AddBookService;
import com.WorkConGW.common.controller.BaseController;
import com.WorkConGW.common.dto.HomeFormVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;



@Controller
@RequestMapping("/addBook/*")
public class AddBookController extends BaseController{
	Logger logger = LoggerFactory.getLogger(AddBookController.class);
    @Autowired
    private AddBookService addBookService;

    @GetMapping("addBookList")
    public String addBookList(Model model, HttpSession session)
    {
        logger.info("addBookList");
        session.setAttribute("empId", "rkdrhd98");
        String empId = (String) session.getAttribute("empId");
        List<AddBookVO> abList = null;
        abList = addBookService.addBookList(empId);
        String url = "addbook/list";
        model.addAttribute("abList", abList);
        return url;
    }
    
    @GetMapping("addBookInsertPage")
    public String addBookInsertPage(Model model, HttpSession session){
        logger.info("addBookInsertPage");
        String empId = (String) session.getAttribute("empId");
        List<AddBookVO> addBookGroupList = null;
        addBookGroupList = addBookService.addBookGroupSelect(empId);
        model.addAttribute("addBookGroupList", addBookGroupList);
        String url = "addbook/insert";
        return url;
    }

    @GetMapping("addBookSearch")
    public String addBookSearch(Model model, @RequestParam Map<String,Object> pmap)
    {
        logger.info("addBookSearch");
        List<AddBookVO> abList = null;
        abList = addBookService.addBookSearch(pmap);
        logger.info(abList.toString());
        String url = "addbook/list";
        model.addAttribute("abList", abList);
        return url;
    }

    @GetMapping("addBookInsert")
    public String addBookInsert(@RequestParam Map<String, Object> pmap) {
        logger.info("addBookInsert");
        int result = 0;
        String path = "";
        logger.info(pmap.toString());
        result = addBookService.addBookInsert(pmap);
        if (result == 1) {// 입력이 성공했을때
            path = "redirect:/addBook/addBookList";
        } else {// 입력이 실패 했을때
            path = "/error";
        }
        return path;
    }

}

