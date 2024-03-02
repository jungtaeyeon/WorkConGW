package com.WorkConGW.approval.controller;



import com.WorkConGW.YAMLConfig;
import com.WorkConGW.approval.dto.ApprovalFormVO;
import com.WorkConGW.approval.dto.ApprovalVO;
import com.WorkConGW.approval.dto.FormVO;
import com.WorkConGW.approval.service.ApprovalService;
import com.WorkConGW.common.PaginationInfo;
import com.WorkConGW.common.controller.CommonController;
import com.WorkConGW.emp.dto.EmpVO;
import com.WorkConGW.emp.service.EmpService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
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
import java.util.Date;
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
    @GetMapping("/awaitDocDetail")
    public String awaitDocDetail(String docId, Model model, HttpServletRequest request)
    {
        logger.info("awaitDocDetail");
        logger.info(docId);
        Map<String,Object> dataMap = approvalService.getWithDocById(docId);
        List<Map<String,Object>> approvalList = new ArrayList<>();
        List<Map<String,Object>> getApprovalList = (List)dataMap.get("pList");
        logger.info("getApprovalList : "+getApprovalList.toString());
        logger.info("approval" + dataMap.get("approval"));
        approvalList.add(dataMap);
        int getApprovalListCnt = getApprovalList.size();
        model.addAttribute("approvalList",approvalList);
        model.addAttribute("approval",dataMap.get("approval"));
        model.addAttribute("history", dataMap.get("approvalHistoryVO"));
        model.addAttribute("getApprovalList",getApprovalList);


        String url = "approval/awaitDocDetail";
        return url;
    }

    @GetMapping("/lists/waitList")
    public String waitList(ApprovalFormVO approvalFormVO, Model model)
    {
        logger.info("awaitDocDetail");
        String url = "approval/lists/waitList";
        ApprovalVO searchApprovalVO = approvalFormVO.getSearchApprovalVO();

        Map<String,Object> dataMap = approvalService.getWaitList(searchApprovalVO);
        List<Map<String,Object>> approvalList = (List)dataMap.get("waitDocs");

        logger.info(approvalList.toString());
        model.addAttribute("approvalList",approvalList);
        model.addAttribute("dataMap",dataMap);



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
        ApprovalVO searchApprovalVO = approvalFormVO.getSearchApprovalVO();
        logger.info("pageIndex:"+approvalFormVO.getSearchApprovalVO().getPageIndex());




        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(searchApprovalVO.getPageIndex());


        paginationInfo.setRecordCountPerPage(searchApprovalVO.getPageUnit()); //한 페이지당 게시되는 게시물 수에 pageunit의 디폴트 값인 10 을 넣는다.
        paginationInfo.setPageSize(searchApprovalVO.getPageSize());

        searchApprovalVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        searchApprovalVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        Map<String,Object> dataMap = approvalService.getDraftList(searchApprovalVO);
        int totCnt = (Integer)dataMap.get("totCnt");
        logger.info("totCnt :" + totCnt);
        List<ApprovalVO> approvalList = (List)dataMap.get("draftDocs");

        paginationInfo.setTotalRecordCount(totCnt);


        searchApprovalVO.setEndDate(paginationInfo.getLastPageNoOnPageList());
        searchApprovalVO.setStartDate(paginationInfo.getFirstPageNoOnPageList());
        searchApprovalVO.setPrev(paginationInfo.getXprev());
        searchApprovalVO.setNext(paginationInfo.getXnext());



        logger.info("pageInfo SearchApprovalVO :" + searchApprovalVO.toString());

        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("approvalList",approvalList);
        model.addAttribute("totCnt",totCnt);
        model.addAttribute("dataMap",dataMap);
        model.addAttribute("searchApprovalVO", searchApprovalVO);
        model.addAttribute("totalPageCnt", (int)Math.ceil(totCnt/(double)searchApprovalVO.getPageUnit()));

        return url;
    }
    @RequestMapping(value = "/referDetail")
    public String referDetail(String docId, Model model)
    {
        ApprovalVO approval = approvalService.getCompleteDocByDocId(docId);

        Map<String,Object> dataMap = approvalService.getWithDocById(docId);
        List<Map<String,Object>> approvalList = new ArrayList<>();
        List<Map<String,Object>> getApprovalList = (List)dataMap.get("pList");
        approvalList.add(dataMap);
        int getApprovalListCnt = getApprovalList.size();
        model.addAttribute("approvalList",approvalList);
        model.addAttribute("approval",dataMap.get("approval"));
        model.addAttribute("history", dataMap.get("approvalHistoryVO"));
        model.addAttribute("getApprovalList",getApprovalList);

        String url = "approval/detail/referDetail";
        return url;
    }




    @GetMapping("/lists/referList")
    public String referList(@ModelAttribute("approvalFormVO") ApprovalFormVO approvalFormVO, Model model)
    {
        String url = "approval/lists/referList";
        ApprovalVO searchApprovalVO = approvalFormVO.getSearchApprovalVO();
        logger.info("pageIndex:"+approvalFormVO.getSearchApprovalVO().getPageIndex());




        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(searchApprovalVO.getPageIndex());


        paginationInfo.setRecordCountPerPage(searchApprovalVO.getPageUnit()); //한 페이지당 게시되는 게시물 수에 pageunit의 디폴트 값인 10 을 넣는다.
        paginationInfo.setPageSize(searchApprovalVO.getPageSize());

        searchApprovalVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        searchApprovalVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        Map<String,Object> dataMap = approvalService.getReferList(searchApprovalVO);
        int totCnt = (Integer)dataMap.get("totCnt");
        List<ApprovalVO> approvalList = (List)dataMap.get("refer");

        paginationInfo.setTotalRecordCount(totCnt);


        searchApprovalVO.setEndDate(paginationInfo.getLastPageNoOnPageList());
        searchApprovalVO.setStartDate(paginationInfo.getFirstPageNoOnPageList());
        searchApprovalVO.setPrev(paginationInfo.getXprev());
        searchApprovalVO.setNext(paginationInfo.getXnext());



        logger.info("pageInfo SearchApprovalVO :" + searchApprovalVO.toString());

        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("approvalList",approvalList);
        model.addAttribute("totCnt",totCnt);
        model.addAttribute("dataMap",dataMap);
        model.addAttribute("searchApprovalVO", searchApprovalVO);
        model.addAttribute("totalPageCnt", (int)Math.ceil(totCnt/(double)searchApprovalVO.getPageUnit()));

        return url;
    }

    @RequestMapping(value = "/main")
    public ModelAndView approvalMain(@ModelAttribute("approvalFormVO") ApprovalFormVO approvalFormVO,Model model, HttpServletRequest request)
    {

        HttpSession session = request.getSession();
        EmpVO emp = (EmpVO) session.getAttribute("loginUser");
        String empId = "";
        if(emp != null ) empId = emp.getEmp_Id();
        ApprovalVO searchApprovalVO = approvalFormVO.getSearchApprovalVO();
        searchApprovalVO.setEmp_Id(empId);


        Map<String,Object> dataMap = approvalService.getSaveFormsById(searchApprovalVO);
        model.addAttribute("dataMap",dataMap);
        model.addAttribute("today",new Date());

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
    @PostMapping("/registApproval")
    public Object registApproval(@RequestBody Map<String,Object>dataObj){
            logger.info("dataObj : "+dataObj.toString());
            ApprovalVO approvalVO = approvalService.registApproval(dataObj);
            return approvalVO;
    }

    @PostMapping("/approvalReivew")
    @ResponseBody
    public Object approvalReview(@RequestBody Map<String,Object> obj)
    {
        ApprovalVO approvalVO = approvalService.modifyApprovalReview(obj);
        logger.info(approvalVO.toString());
        return  approvalVO;
    }

    @PostMapping("/approvalReturn")
    @ResponseBody
    public void approvalReturn(@RequestBody  Map<String,Object> dataMap)
    {
        ResponseEntity<String> entity = null;

        logger.info(dataMap.toString());
        approvalService.approvalReturn(dataMap);




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

    @RequestMapping(value = "/draftDetail")
    public String draftDetail(String docId, Model model)
    {
        ApprovalVO approval = approvalService.getCompleteDocByDocId(docId);

        Map<String,Object> dataMap = approvalService.getWithDocById(docId);
        List<Map<String,Object>> approvalList = new ArrayList<>();
        List<Map<String,Object>> getApprovalList = (List)dataMap.get("pList");
        approvalList.add(dataMap);
        int getApprovalListCnt = getApprovalList.size();
        model.addAttribute("approvalList",approvalList);
        model.addAttribute("approval",dataMap.get("approval"));
        model.addAttribute("history", dataMap.get("approvalHistoryVO"));
        model.addAttribute("getApprovalList",getApprovalList);

        String url = "approval/detail/draftDetail";
        return url;
    }

    @GetMapping("lists/temporaryList")
    public String temporaryList(@ModelAttribute("approvalFormVO")ApprovalFormVO approvalFormVO, Model model)
    {
        String url = "approval/lists/temporaryList";
        ApprovalVO searchApprovalVO = approvalFormVO.getSearchApprovalVO();
        logger.info("pageIndex:"+approvalFormVO.getSearchApprovalVO().getPageIndex());




        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(searchApprovalVO.getPageIndex());


        paginationInfo.setRecordCountPerPage(searchApprovalVO.getPageUnit()); //한 페이지당 게시되는 게시물 수에 pageunit의 디폴트 값인 10 을 넣는다.
        paginationInfo.setPageSize(searchApprovalVO.getPageSize());

        searchApprovalVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        searchApprovalVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        Map<String,Object> dataMap = approvalService.gettemporaryList(searchApprovalVO);
        int totCnt = (Integer)dataMap.get("totCnt");
        logger.info("totCnt :" + totCnt);
        List<ApprovalVO> approvalList = (List)dataMap.get("temporary");

        paginationInfo.setTotalRecordCount(totCnt);


        searchApprovalVO.setEndDate(paginationInfo.getLastPageNoOnPageList());
        searchApprovalVO.setStartDate(paginationInfo.getFirstPageNoOnPageList());
        searchApprovalVO.setPrev(paginationInfo.getXprev());
        searchApprovalVO.setNext(paginationInfo.getXnext());



        logger.info("pageInfo SearchApprovalVO :" + searchApprovalVO.toString());

        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("approvalList",approvalList);
        model.addAttribute("totCnt",totCnt);
        model.addAttribute("dataMap",dataMap);
        model.addAttribute("searchApprovalVO", searchApprovalVO);
        model.addAttribute("totalPageCnt", (int)Math.ceil(totCnt/(double)searchApprovalVO.getPageUnit()));

        return url;
    }
    @GetMapping("lists/rejectList")
    public String rejectList(@ModelAttribute("approvalFormVO")ApprovalFormVO approvalFormVO,Model model)
    {
        String url = "approval/lists/rejectList";
        ApprovalVO searchApprovalVO = approvalFormVO.getSearchApprovalVO();
        logger.info("pageIndex:"+approvalFormVO.getSearchApprovalVO().getPageIndex());




        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(searchApprovalVO.getPageIndex());


        paginationInfo.setRecordCountPerPage(searchApprovalVO.getPageUnit()); //한 페이지당 게시되는 게시물 수에 pageunit의 디폴트 값인 10 을 넣는다.
        paginationInfo.setPageSize(searchApprovalVO.getPageSize());

        searchApprovalVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        searchApprovalVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        Map<String,Object> dataMap = approvalService.getRejectList(searchApprovalVO);
        int totCnt = (Integer)dataMap.get("totCnt");
        logger.info("totCnt :" + totCnt);
        List<ApprovalVO> approvalList = (List)dataMap.get("reject");

        paginationInfo.setTotalRecordCount(totCnt);


        searchApprovalVO.setEndDate(paginationInfo.getLastPageNoOnPageList());
        searchApprovalVO.setStartDate(paginationInfo.getFirstPageNoOnPageList());
        searchApprovalVO.setPrev(paginationInfo.getXprev());
        searchApprovalVO.setNext(paginationInfo.getXnext());



        logger.info("pageInfo SearchApprovalVO :" + searchApprovalVO.toString());

        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("approvalList",approvalList);
        model.addAttribute("totCnt",totCnt);
        model.addAttribute("dataMap",dataMap);
        model.addAttribute("searchApprovalVO", searchApprovalVO);
        model.addAttribute("totalPageCnt", (int)Math.ceil(totCnt/(double)searchApprovalVO.getPageUnit()));

        return url;
    }

    @GetMapping("/rejectDetail")
    public String rejectDetail(String docId, Model model)
    {
        ApprovalVO approval = approvalService.getCompleteDocByDocId(docId);

        Map<String,Object> dataMap = approvalService.getWithDocById(docId);
        List<Map<String,Object>> approvalList = new ArrayList<>();
        List<Map<String,Object>> getApprovalList = (List)dataMap.get("pList");
        approvalList.add(dataMap);
        int getApprovalListCnt = getApprovalList.size();
        model.addAttribute("approvalList",approvalList);
        model.addAttribute("approval",dataMap.get("approval"));
        model.addAttribute("history", dataMap.get("approvalHistoryVO"));
        model.addAttribute("getApprovalList",getApprovalList);

        String url = "approval/detail/rejectDetail";
        return url;
    }



    @GetMapping("/completeDetail")
    public String completeDetail(String docId, Model model)
    {
        ApprovalVO approval = approvalService.getCompleteDocByDocId(docId);

        Map<String,Object> dataMap = approvalService.getWithDocById(docId);
        List<Map<String,Object>> approvalList = new ArrayList<>();
        List<Map<String,Object>> getApprovalList = (List)dataMap.get("pList");
        approvalList.add(dataMap);
        int getApprovalListCnt = getApprovalList.size();
        model.addAttribute("approvalList",approvalList);
        model.addAttribute("approval",dataMap.get("approval"));
        model.addAttribute("history", dataMap.get("approvalHistoryVO"));
        model.addAttribute("getApprovalList",getApprovalList);

        String url = "approval/detail/completeDetail";
        return url;
    }


    @GetMapping("lists/completeList")
    public String completeList(@ModelAttribute("approvalFormVO") ApprovalFormVO approvalFormVO, Model model) {
        ApprovalVO searchApprovalVO = approvalFormVO.getSearchApprovalVO();
        logger.info(searchApprovalVO.toString());
        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(searchApprovalVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(searchApprovalVO.getPageUnit());
        paginationInfo.setPageSize(searchApprovalVO.getPageSize());

        searchApprovalVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        searchApprovalVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        Map<String, Object> dataMap = approvalService.getCompleteList(searchApprovalVO);

        List<ApprovalVO> approvalList = (List<ApprovalVO>) dataMap.get("completeDocs"); // 데이터 맵에서 ApprovalVO 리스트를 가져옴
        int totCnt = (Integer)dataMap.get("totCnt");
        logger.info(approvalList.toString());

        paginationInfo.setTotalRecordCount(totCnt);


        searchApprovalVO.setEndDate(paginationInfo.getLastPageNoOnPageList());
        searchApprovalVO.setStartDate(paginationInfo.getFirstPageNoOnPageList());
        searchApprovalVO.setPrev(paginationInfo.getXprev());
        searchApprovalVO.setNext(paginationInfo.getXnext());

        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("approvalList", approvalList);
        model.addAttribute("totCnt",totCnt);
        model.addAttribute("searchApprovalVO", searchApprovalVO);
        model.addAttribute("totalPageCnt", (int)Math.ceil(totCnt/(double)searchApprovalVO.getPageUnit()));

        String url = "approval/lists/completeList";
        return url;
    }

    @ResponseBody
    @PostMapping("/getApprovalLines")
    public Map<String,Object> getApprovalLines(){
        Map<String,Object> dataMap = approvalService.getApprovalLines();
        return dataMap;


    }
	
}
