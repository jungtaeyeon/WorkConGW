package com.WorkConGW.addbook.controller;

import java.util.List;
import java.util.Map;
import java.util.Enumeration;
import java.util.HashMap;

import org.apache.commons.collections.map.HashedMap;
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
import com.WorkConGW.emp.dto.EmpVO;

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
        Map<String, Object> pmap = new HashMap<String, Object>();
        EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        String empId = null;
        if(empVO != null) {
            empId = empVO.getEmp_Id();
        }
        pmap.put("empId", empId);
        pmap.put("share_add_book", 0);
        List<AddBookVO> abList = null;
        abList = addBookService.addBookList(pmap);
        String url = "addbook/list";
        model.addAttribute("abList", abList);
        return url;
    }

    @GetMapping("addBookShare")
    public String addBookShare()
    {
        logger.info("addBookShare");
        String url = "addbook/shareList";
        return url;
    }

    @GetMapping("addBookStarred")
    public String addBookStarred()
    {
        logger.info("addBookStarred");
        String url = "addbook/starredList";
        return url;
    }
    
    @GetMapping("addBookInsertPage")
    public String addBookInsertPage(){
        logger.info("addBookInsertPage");
        String url = "addbook/insert";
        return url;
    }


    /* restcontroller로 전송 */
    

    @GetMapping("addBookSearch")
    public String addBookSearch(Model model, @RequestParam Map<String,Object> pmap, HttpSession session)
    {
        logger.info("addBookSearch");
        List<AddBookVO> abList = null;
        EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        String empId = null;
        if(empVO != null) {
            empId = empVO.getEmp_Id();
        }
        pmap.put("empId", empId);

        logger.info(pmap.toString());
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

