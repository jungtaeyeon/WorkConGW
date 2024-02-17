package com.WorkConGW.admin.controller;

import com.WorkConGW.common.PaginationInfo;
import com.WorkConGW.emp.dto.EmpFormVO;
import com.WorkConGW.emp.dto.EmpVO;
import com.WorkConGW.emp.service.EmpService;
import com.google.api.Page;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;


@Controller
@RequestMapping("/admin/emp/*")
public class AdminEmpController  {
    Logger logger = LoggerFactory.getLogger(AdminEmpController.class);


    @Autowired
    EmpService empService;


    @GetMapping("empList")
    public String empList(@ModelAttribute("empFormVO")EmpFormVO empFormVO, Model model)
    {
        String url = "admin/emp/list";


        if(empFormVO == null){
            empFormVO = new EmpFormVO();
        }

        List<EmpVO> empList = new ArrayList<>();
        PaginationInfo paginationInfo = new PaginationInfo();
        EmpVO searchEmpVO = empFormVO.getSearchEmpVO(); // searchEmpVO값을 가져옴.
        paginationInfo.setCurrentPageNo(searchEmpVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(searchEmpVO.getPageUnit());
        paginationInfo.setPageSize(searchEmpVO.getPageSize());
        searchEmpVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        searchEmpVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());


        List<EmpVO> empVOList = new ArrayList<>();
        empVOList = empService.selectEmpPagingList(searchEmpVO);
        logger.info(empVOList.toString());
        int totCnt = empService.selectEmpCount(searchEmpVO);
        logger.info(String.valueOf(totCnt));
        paginationInfo.setTotalRecordCount(totCnt);
        searchEmpVO.setEndDate(paginationInfo.getLastPageNoOnPageList());
        searchEmpVO.setStartDate(paginationInfo.getFirstPageNoOnPageList());
        searchEmpVO.setPrev(paginationInfo.getXprev());
        searchEmpVO.setNext(paginationInfo.getXnext());

        model.addAttribute("searchEmpVO",searchEmpVO);
        model.addAttribute("empVOList",empVOList);
        model.addAttribute("totCnt", totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("totalPageCnt", (int)Math.ceil(totCnt/(double)searchEmpVO.getPageUnit()));




        return url;
    }

    @GetMapping("empDetail")
    public String empDetail(EmpVO emp,Model model)
    {
        logger.info(emp.getEmp_Id());
        logger.info("empDetail");
        EmpVO empvo = empService.getEmp(emp.getEmp_Id());
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String formattedDate = simpleDateFormat.format(empvo.getEmp_Create_Dt());
        logger.info(formattedDate);

        logger.info(empvo.toString());
        model.addAttribute("formattedDate",formattedDate);
        model.addAttribute("empVO",empvo);
        String url = "admin/emp/detail";
        return url;
    }

    @GetMapping("empInsert")
    public String empInsert()
    {
        logger.info("empInsert");
        String url = "admin/emp/insert";
        return url;
    }

    @PostMapping("empUpdate")
    public String empUpdate(EmpVO empVO) throws SQLException
    {
        logger.info("empUpdate");
        empService.adminEmpUpdate(empVO);
        String url = "redirect:/admin/emp/empList";
        return url;
    }
}
