package com.WorkConGW.approval.controller;



import com.WorkConGW.YAMLConfig;
import com.WorkConGW.admin.controller.AdminCommonController;
import com.WorkConGW.approval.dto.ApprovalFormVO;
import com.WorkConGW.approval.dto.ApprovalVO;
import com.WorkConGW.approval.dto.FormVO;
import com.WorkConGW.approval.service.ApprovalService;
import com.WorkConGW.common.controller.BaseController;
import com.WorkConGW.common.controller.CommonController;
import com.WorkConGW.emp.dto.EmpVO;
import com.WorkConGW.emp.service.EmpService;
import com.google.api.Http;
import jakarta.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/approval/*")
public class ApprovalController extends CommonController {

    Logger logger = LoggerFactory.getLogger(ApprovalController.class);

    @Value("${uploadPath}")
    private String signPath;

    @Value("${approvalPath}")
    private String approvalPath;

    @Autowired
    private YAMLConfig Config;

    @Autowired
    private ApprovalService approvalService = null;


    @Autowired
    private EmpService empService = null;
    @GetMapping("/lists/waitList")
    public String waitList()
    {
        String url = "approval/lists/waitList";
        return url;
    }

    @GetMapping("/line")
    public String line()
    {
        return "approval/approvalLine";
    }


    @GetMapping("/lists/list")
    public String list()
    {
        String url = "approval/lists/list";
        return url;
    }

    @GetMapping("/lists/draftList")
    public String draftList(@ModelAttribute("approvalFormVO") ApprovalFormVO approvalFormVO, Model model)
    {

        String url = "approval/lists/draftList";
        return url;
    }

    @GetMapping("/lists/referList")
    public String referList()
    {
        String url = "approval/lists/referList";
        return url;
    }

    @RequestMapping(value = "/main")
    public ModelAndView approvalMain()
    {
        ModelAndView mnv = new ModelAndView();
        String url = "approval/main";
        mnv.setViewName(url);
        return mnv;
    }
    @RequestMapping(value = "/approvalInsert")
    public String approvalInsert()
    {
        String url = "approval/insert";
        return url;
    }

    @GetMapping("/registDocForm")
    public String registDocForm(Model model)
    {
        List<FormVO> formVOList = new ArrayList<>();
        formVOList = approvalService.registDocForm();
        logger.info(formVOList.toString());
        model.addAttribute("formVO", formVOList);
        String url = "/approval/registDocForm";

        return url;
    }

    @ResponseBody
    @PostMapping("/getForm")
    public ResponseEntity<Map<String,Object>> getForm(@RequestBody String formId)
    {
        ResponseEntity<Map<String,Object>> entity = null;
        Map<String,Object> pmap = approvalService.getForm(formId);
        if(pmap != null)
        {
           entity = new ResponseEntity<>(pmap, HttpStatus.OK);
        }
        else{
            entity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return entity;
    }

    @ResponseBody
    @PostMapping("/modifyApprovalTemp")
    public void modifyApprovalTemp(@RequestBody ApprovalVO approvalVO)
    {
        approvalService.modifyApprovalTemp(approvalVO);
    }
    @ResponseBody
    @PostMapping("/getSign")
    public ResponseEntity<byte[]> getSign(String sign, HttpServletRequest request)throws Exception
    {
        ResponseEntity<byte[]> entity = getPicture(signPath,sign);
        return entity;
    }

    @ResponseBody
    @PostMapping("/registApprovalLine")
    public void registApprovalLine(@RequestBody Map<String,Object>dataMap){
            logger.info(dataMap.toString());
            approvalService.registApprovalLine(dataMap);
    }

    @ResponseBody
    @PostMapping("/getApprovalLines")
    public Map<String,Object> getApprovalLines(){
        Map<String,Object> dataMap = approvalService.getApprovalLines();
        return dataMap;


    }

    @ResponseBody
    @PostMapping("/registApproval")
    public Object registApproval(@RequestBody Map<String,Object>dataObj){
            logger.info("dataObj : "+dataObj.toString());
            ApprovalVO approvalVO = approvalService.registApproval(dataObj);
            return approvalVO;
    }


    @ResponseBody
    @PostMapping("/registApprovalAttach")
    public void registApprovalAttach(@ModelAttribute ApprovalVO approval, @RequestParam String docId) throws IOException {
        logger.info(String.valueOf(docId));
        int docIdInt = Integer.parseInt(docId.replace(",", ""));
        logger.info(String.valueOf(docIdInt));
        approval.setDoc_Id(docIdInt);
        approval.getFileUploadCommand().setFileUploadPath(approvalPath);
        logger.info(approval.toString());
        approvalService.registApprovalAttach(approval);

    }

    @GetMapping("/docDetail")
    public String docDetail(String form_Id, Model model, HttpServletRequest request)
    {

        ApprovalVO approvalVO = null;
        logger.info(form_Id);
        approvalVO = approvalService.getApprovalByformId(form_Id);

        logger.info(approvalVO.toString());
        model.addAttribute("approval", approvalVO);

        return "/approval/docDetail";
    }

    @RequestMapping(value = "/approvalLine")
    public String approvalLine(Model model, String doc_Id, HttpServletRequest request)
    {
        EmpVO empVO = (EmpVO)request.getSession().getAttribute("loginUser");
        EmpVO emp = empService.getEmp(empVO.getEmp_Id());
        logger.info(emp.toString());
        model.addAttribute("emp",emp);
        model.addAttribute("docId",doc_Id);
        String url = "approval/approvalLine";
        return url;
    }

    @RequestMapping(value = "/detail")
    public String detail()
    {
        String url = "approval/detail";
        return url;
    }

    @GetMapping("lists/temporaryList")
    public String temporaryList()
    {
        String url = "approval/lists/temporaryList";

        return url;
    }

    @GetMapping("lists/completeList")
    public String completeList()
    {
        String url = "approval/lists/completeList";
        return url;
    }
	
}
