package com.WorkConGW.addbook.controller;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;


import com.WorkConGW.addbook.dto.AddBookVO;
import com.WorkConGW.addbook.service.AddBookService;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/addBook/*")
public class RestAddBookController {
  Logger logger = LoggerFactory.getLogger(AddBookController.class);
    @Autowired
    private AddBookService addBookService;

    @GetMapping("addBookGroupSelect")
    public List<AddBookVO> addBookGroupSelect(@RequestParam Map<String, Object> pmap ,HttpSession session){
        logger.info("addBookGroupSelect");
        String empId = (String) session.getAttribute("empId");
        pmap.put("empId", empId);
        logger.info(pmap.toString());
        List<AddBookVO> addBookGroupList = null;
        addBookGroupList = addBookService.addBookGroupSelect(pmap);
        Gson gson = new Gson();
        String temp = gson.toJson(addBookGroupList);

        return addBookGroupList;
    }
}
