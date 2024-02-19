package com.WorkConGW.addbook.controller;

import java.util.List;
import java.util.Map;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.ArrayList;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.util.MultiValueMap;
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
    public String addBookList(Model model, HttpSession session, @RequestParam Map<String,Object> pmap)
    {
        logger.info("addBookList");
        EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        String empId = null;
        if(empVO != null) {
            empId = empVO.getEmp_Id();
        }
        pmap.put("empId", empId);
        List<AddBookVO> abList = null;
        List<AddBookVO> addBookGroupList = null;
        logger.info(pmap.toString());
        addBookGroupList = addBookService.addBookGroupSelect(pmap);
        abList = addBookService.addBookList(pmap);
        Map<String, List<AddBookVO>> groupedByManageId = new HashMap<>();

        for (AddBookVO addBook : abList) {
            String manageId = String.valueOf(addBook.getManage_id()); // int를 String으로 변환
            if (!groupedByManageId.containsKey(manageId)) {
                groupedByManageId.put(manageId, new ArrayList<>());
            }
            groupedByManageId.get(manageId).add(addBook);
        }
        logger.info(groupedByManageId.toString());

        String url = "addbook/list";
        model.addAttribute("abList", abList);
        model.addAttribute("addBookGroupList", addBookGroupList);
        model.addAttribute("groupedByManageId", groupedByManageId);
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
    public String addBookStarred(Model model, HttpSession session, @RequestParam Map<String,Object> pmap)
    {
        logger.info("addBookStarred");
        EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        String empId = null;
        if(empVO != null) {
            empId = empVO.getEmp_Id();
        }
        pmap.put("empId", empId);
        List<AddBookVO> abList = null;
        List<AddBookVO> addBookGroupList = null;
        logger.info(pmap.toString());
        abList = addBookService.addBookStarred(pmap);
        addBookGroupList = addBookService.addBookGroupSelect(pmap);
        String url = "addbook/starredList";
        model.addAttribute("abList", abList);
        model.addAttribute("abList", abList);
        model.addAttribute("addBookGroupList", addBookGroupList);
        return url;
    }
    
    @GetMapping("addBookInsertPage")
    public String addBookInsertPage(Model model, HttpSession session, @RequestParam Map<String,Object> pmap){
        logger.info("addBookInsertPage");
        EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        String empId = null;
        if(empVO != null) {
            empId = empVO.getEmp_Id();
        }
        pmap.put("empId", empId);
        List<AddBookVO> addBookGroupList = null;
        addBookGroupList = addBookService.addBookGroupSelect(pmap);
        
        model.addAttribute("addBookGroupList", addBookGroupList);
        String url = "addbook/insert";
        return url;
    }

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
    public String addBookInsert(@RequestParam Map<String, Object> pmap, @RequestParam("add_book_id[]") String[] addBookIds, HttpSession session) {
        logger.info("addBookInsert");
        EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        String empId = null;
        if(empVO != null) {
            empId = empVO.getEmp_Id();
        }
        pmap.put("empId", empId);
        int result = 0;
        String path = "";
        
        StringBuilder addBookIdGroup = new StringBuilder();
        logger.info(addBookIds.toString());
        if (addBookIds != null) {
            for (int i = 0; i < addBookIds.length; i++) {
                addBookIdGroup.append(addBookIds[i]);
                if (i < addBookIds.length - 1) {
                    addBookIdGroup.append("#"); // 마지막 요소 뒤에는 반점을 추가하지 않음
                }
                logger.info(addBookIds[i]);
            }
        }
        String addBookIdGroupStr = addBookIdGroup.toString();
        pmap.remove("add_book_id[]");
        pmap.remove("manage_id");
        pmap.remove("add_book_id_check");
        pmap.put("manage_add_book_id", addBookIdGroupStr);
        logger.info(pmap.toString());
        result = addBookService.addBookInsert(pmap);
        
        if (result == 1) {// 입력이 성공했을때
            path = "redirect:/addBook/addBookList";
        } else {// 입력이 실패 했을때
            path = "/error";
        }
        return path;
    }

    @GetMapping("addBookGroupInsert")
    public String addBookGroupInsert(Model model, @RequestParam Map<String, Object> pmap, HttpSession session) {
        logger.info("addBookGroupInsert");
        EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        String empId = null;
        if(empVO != null) {
            empId = empVO.getEmp_Id();
        }
        pmap.put("empId", empId);
        int result = 0;
        String path = "";
        logger.info(pmap.toString());
        result = addBookService.addBookGroupInsert(pmap);
        if (result == 1) {// 입력이 성공했을때
            path = "redirect:/addBook/addBookList";
        } else {// 입력이 실패 했을때
            path = "/error";
        }
        return path;
    }

    @GetMapping("addBookGroupUpdate")
    public String addBookGroupUpdate(Model model, @RequestParam Map<String, Object> pmap, HttpSession session) {
        logger.info("addBookGroupUpdate");
        EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        String empId = null;
        if(empVO != null) {
            empId = empVO.getEmp_Id();
        }
        pmap.put("empId", empId);
        int result = 0;
        String path = "";
        logger.info(pmap.toString());
        result = addBookService.addBookGroupUpdate(pmap);
        if (result == 1) {// 입력이 성공했을때
            path = "redirect:/addBook/addBookList";
        } else {// 입력이 실패 했을때
            path = "/error";
        }
        return path;
    }

    @GetMapping("addBookListUpdate")
    public String addBookListUpdate(Model model, @RequestParam Map<String, Object> pmap, HttpSession session) {
        logger.info("addBookListUpdate");
        EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        String empId = null;
        if(empVO != null) {
            empId = empVO.getEmp_Id();
        }
        pmap.put("empId", empId);
        logger.info(pmap.toString());
        List<Map<String, Object>> addBookListUpdate = addBookService.addBookListUpdate(pmap);
        List<AddBookVO> addBookGroupList = null;
        addBookGroupList = addBookService.addBookGroupSelect(pmap);
        model.addAttribute("addBookGroupList", addBookGroupList);
        model.addAttribute("addBookListUpdate", addBookListUpdate);
        String url = "addbook/insert";
        return url;
    }

    @GetMapping("addBookUpdate")
    public String addBookUpdate(@RequestParam Map<String, Object> pmap, HttpSession session) {
        logger.info("addBookUpdate");
        EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        String empId = null;
        if(empVO != null) {
            empId = empVO.getEmp_Id();
        }
        pmap.put("empId", empId);
        int result = 0;
        String path = "";
        logger.info(pmap.toString());
        result = addBookService.addBookUpdate(pmap);
        if (result == 1) {// 입력이 성공했을때
            path = "redirect:/addBook/addBookList";
        } else {// 입력이 실패 했을때
            path = "/error";
        }
        return path;
    }

    
}

