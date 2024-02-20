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
import com.WorkConGW.emp.dto.EmpVO;
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
        EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        String empId = null;
        if(empVO != null) {
            empId = empVO.getEmp_Id();
        }
        pmap.put("empId", empId);
        logger.info(pmap.toString());
        List<AddBookVO> addBookGroupList = null;
        List<AddBookVO> shareAddBookGroupSelect = null;
        shareAddBookGroupSelect = addBookService.shareAddBookGroupSelect(pmap);
        addBookGroupList = addBookService.addBookGroupSelect(pmap);
        if (addBookGroupList != null && shareAddBookGroupSelect != null) {
            addBookGroupList.addAll(shareAddBookGroupSelect);
        }
        return addBookGroupList;
    }

    @GetMapping("addBookGroupDoubleCheck")
    public String addBookGroupDoubleCheck(@RequestParam Map<String, Object> pmap, HttpSession session) {
        logger.info("addBookGroupDoubleCheck");
        EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        String empId = null;
        if(empVO != null) {
            empId = empVO.getEmp_Id();
        }
        pmap.put("empId", empId);
        logger.info(pmap.toString());
        String countVal = null;
        List<Map<String, Object>> result = addBookService.addBookGroupDoubleCheck(pmap);
        for (Map<String, Object> map : result) {
            Object countValue = map.get("COUNT");
            countVal = countValue.toString();
        }
        logger.info(countVal);
        return countVal;
    }

    @GetMapping("addBookStarredUpdate")
    public int addBookStarredUpdate(@RequestParam Map<String, Object> pmap, HttpSession session) {
        logger.info("addBookStarredUpdate");
        EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        String empId = null;
        if(empVO != null) {
            empId = empVO.getEmp_Id();
        }
        pmap.put("empId", empId);
        logger.info(pmap.toString());
        int result = addBookService.addBookStarredUpdate(pmap);
        return result;
    }

    @GetMapping("addBookGroupDelete")
    public int addBookGroupDelete(@RequestParam Map<String, Object> pmap, HttpSession session) {
        logger.info("addBookGroupDelete");
        EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        String empId = null;
        if(empVO != null) {
            empId = empVO.getEmp_Id();
        }
        pmap.put("empId", empId);
        logger.info(pmap.toString());
        int result = addBookService.addBookGroupDelete(pmap);
        return result;
    }

    @GetMapping("addBookDelete")
    public int addBookDelete(@RequestParam(value = "manage_id[]", required = false) List<Long> manage_id) {
        int result = 0;
        logger.info(manage_id.toString());
        if (manage_id != null && !manage_id.isEmpty()) {
            result = addBookService.addBookDelete(manage_id);
        }
        // 삭제 후 리다이렉트 또는 다른 처리
        return result;
    }
}
