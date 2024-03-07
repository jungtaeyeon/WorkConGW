package com.WorkConGW.approval.service;

import com.WorkConGW.approval.controller.ApprovalController;
import com.WorkConGW.approval.dao.ApprovalDAO;
import com.WorkConGW.approval.dto.*;
import com.WorkConGW.common.command.FileUploadCommand;
import com.WorkConGW.emp.dao.EmpDAO;
import com.WorkConGW.attend.dao.AttendenceDAO;
import com.WorkConGW.emp.dto.EmpVO;
import com.beust.ah.A;
import com.google.api.Http;
import jakarta.servlet.http.HttpSession;
import org.eclipse.jdt.internal.compiler.problem.AbortType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.text.Normalizer;
import java.util.*;

@Service
public class ApprovalService{

    @Autowired
    private ApprovalDAO approvalDAO = null;
    
    @Autowired
    private AttendenceDAO attendenceDAO = null;

    @Autowired
    private EmpDAO empDAO = null;

    Logger logger = LoggerFactory.getLogger(ApprovalService.class);

    public List<FormVO> registDocForm() {


        return approvalDAO.registDocForm();
    }

    public Map<String, Object> getForm(String formId) {
        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession httpSession = servletRequestAttributes.getRequest().getSession();
        EmpVO emp = (EmpVO) httpSession.getAttribute("loginUser");
        String emp_Id = emp.getEmp_Id();

        Map<String,Object> dataMap = new HashMap<>();
        FormVO formVO = approvalDAO.selectFormById(formId);
        emp = empDAO.selectEmpById(emp_Id); // emp_Id(사번)를 넣고 + 그 사원에 대해 조회
        emp.setcode_Name(empDAO.selectOfficialById(emp_Id)); // emp에 대한 (직책 코드명을 조회해야함) ex: 부장/차장 이 부분을 조회해야함.
        emp.setDept_Name(empDAO.selectDeptNameById(emp_Id)); 
        
        // 두 개의 값을 담으려면 dataMap에 put해서 두개의 정보를 관리해야함
        dataMap.put("form",formVO);
        dataMap.put("emp",emp);
        return dataMap;
    }


    public ApprovalVO getApprovalByformId(String formId) {
        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = servletRequestAttributes.getRequest().getSession();
        Map<String,Object> dataMap = new HashMap<>();
        ApprovalVO approvalVO = new ApprovalVO();
        String myFormId = formId;

        EmpVO emp = (EmpVO) session.getAttribute("loginUser");
        String emp_Id = emp.getEmp_Id();
        logger.info(emp_Id);

        dataMap.put("formId",myFormId);
        dataMap.put("empId",emp_Id);

        FormVO formVO = approvalDAO.selectFormById(formId);
        logger.info("formVO : "+ formVO);
        int docId = approvalDAO.selectMaxDocId();
        approvalVO.setDoc_Id(docId);
        approvalVO.setEmp_Drafter_Id(emp_Id);
        approvalVO.setApproval_Content(formVO.getForm_Content());
        approvalVO.setForm_Id(formVO.getForm_Id());
        logger.info(approvalVO.toString());
        approvalDAO.insertApproval(approvalVO);

        return approvalVO;

    }

    public void modifyApprovalTemp(ApprovalVO approvalVO) {
        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = servletRequestAttributes.getRequest().getSession();
        EmpVO emp = (EmpVO) session.getAttribute("loginUser");
        String emp_Id = emp.getEmp_Id();
        approvalVO.setEmp_Drafter_Id(emp_Id);
        logger.info(approvalVO.toString());
        approvalDAO.updateApprovalTemp(approvalVO);
    }

    public void registApprovalLine(Map<String, Object> dataMap) {

        ApprovalLineVO line = new ApprovalLineVO();
        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = servletRequestAttributes.getRequest().getSession();
        EmpVO emp = (EmpVO) session.getAttribute("loginUser");
        //{referArr=[], approvalObj={}, approvalArr=[{name=이지영, official=차장, empId=00003, st=정상출근}, {name=김차리, official=대리, empId=00014, st=정상출근}], lineName=asd}
        String emp_Id = emp.getEmp_Id();
        List<Map<String,Object>> pmap = (List)dataMap.get("approvalArr");
        List<Map<String,Object>> referList = (List)dataMap.get("referArr");
        String lineName = (String)dataMap.get("lineName");

        int lineId = approvalDAO.selectApprovalLineSeqNext();
        line.setLine_Id(lineId); // 결재선 코드
        line.setLine_Name(lineName); // 결재선 이름
        line.setEmp_Id(emp_Id); // 사원번호 저장l
        line.setLine_Type("신청");

        approvalDAO.insertApprovalLine(line);

        for(Map<String,Object> map : pmap)
        {
            String approvalEmpId = (String)map.get("empId");
            logger.info("apaprovalEmpId :"+approvalEmpId);
            line = new ApprovalLineVO();
            line.setEmp_Id(approvalEmpId);
            line.setLine_Id(lineId);
            line.setLine_Type("결재");
            logger.info("line:"+line.toString());
            approvalDAO.insertApprovalLineRegister(line);

        }

        for(Map<String,Object>map : referList)
        {
            line = new ApprovalLineVO();
            line.setLine_Id(lineId);
            String tempEmpId = (String)map.get("empId");
            line.setLine_Type("참조");
            line.setEmp_Id(tempEmpId);
            approvalDAO.insertApprovalLineRegister(line);
        }



    }

    public Map<String, Object> getApprovalLines() {
            List<ApprovalLineVO> lineList = new ArrayList<>(); // 결재선에 대한 이름을 가져옴
            List<ApprovalLineVO> lineRegistList = new ArrayList<>(); // 결재선에 대한 action 저장된 값을 가져옴
            Map<String,Object> dataMap = new HashMap<>();

            ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
            HttpSession session = servletRequestAttributes.getRequest().getSession();
            EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
            String empId = empVO.getEmp_Id();

            lineList = approvalDAO.selectApprovalLineByEmpId(empId);

            for(int i = 0; i < lineList.size(); i++)
            {

                //라인 아이디를 가져와야함 결재라인에 저장된 부분이 여러개 있을 수 있음 -> 그래서 그럼
                int lineId = lineList.get(i).getLine_Id(); // 그 결재라인에 매겨진 번호들을 가져와야함
                String lineName = lineList.get(i).getLine_Name();
                lineRegistList  = approvalDAO.selectApprovalLineRegistByLineId(lineId); // 여기서 결재선에대한 자세한 정보를 가져옴.
                dataMap.put(lineName,lineRegistList);
                logger.info(dataMap.toString());
            }

            return dataMap;

    }

    public ApprovalVO registApproval(Map<String, Object> dataObj) {
        Map<String,Object> insertMap = new HashMap<>();
        ApprovalVO approvalVO = new ApprovalVO();
        ApprovalVO returnapprovalVO = new ApprovalVO();
        Map<String,Object> insertDt = new HashMap<>();


        insertDt.put("startDt", dataObj.get("startDt"));
        insertDt.put("endDt", dataObj.get("endDt"));
        insertDt.put("doc_Id", dataObj.get("docId"));
        approvalDAO.updateDt(insertDt);

        logger.info("dataObj : " + dataObj.toString());

        returnapprovalVO.setDoc_Id(Integer.parseInt((String)dataObj.get("docId")));
        logger.info(returnapprovalVO.toString());

        insertMap.put("emp_Id",(String)dataObj.get("apply")); //신청자 저장
        insertMap.put("doc_Id",Integer.parseInt((String)dataObj.get("docId")));
        insertMap.put("history_Turn", "N"); // 현재 결재 이력이 진행중
        insertMap.put("history_Step", "1"); // 기안 상태
        insertMap.put("history_st", "0");
        insertMap.put("approval_End_Dt",dataObj.get("endDt"));
        insertMap.put("approval_Start_Dt",dataObj.get("startDt"));
        insertMap.put("history_Type","신청");

        logger.info(insertMap.toString());
        approvalDAO.insertApprovalHistory(insertMap);


//
//        insertMap.put("emp_Id",(String)dataObj.get("approval"));
//        insertMap.put("doc_Id",Integer.parseInt((String)dataObj.get("docId")));
//        insertMap.put("history_Turn", "N"); // 현재 결재 이력이 진행중
//        insertMap.put("history_Step","2");
//        approvalDAO.insertApprovalHistory(insertMap);
//
//        insertMap.put("emp_Id",(String)dataObj.get("approval"));
//        insertMap.put("doc_Id",Integer.parseInt((String)dataObj.get("docId")));
//        insertMap.put("history_Turn", "N"); // 현재 결재 이력이 진행중
//        insertMap.put("history_Step","3");
//        approvalDAO.insertApprovalHistory(insertMap);

        int step = 2;
        List<String> list = (List)dataObj.get("approval");
        logger.info(list.toString());
        if(dataObj.containsKey("approval"))
        {
            logger.info("approval if문");
            for(int i = 0; i < list.size(); i++) {
                insertMap = new HashMap<>();
                insertMap.put("emp_Id", list.get(i));
                insertMap.put("history_st", "0");
                insertMap.put("doc_Id", Integer.parseInt((String) dataObj.get("docId")));

                // 현재 결재 이력이 진행중이고, 각 단계마다 순차적으로 단계를 증가시킴
                if (i == 0) {
                    insertMap.put("history_Turn", "Y"); // 현재 결재 이력이 진행중
                    insertMap.put("history_Step", "2"); // 두 번째 단계
                    insertMap.put("history_Type", "결재");
                } else {
                    insertMap.put("history_Turn", "N"); // 이전 결재 이력이 완료됨
                    insertMap.put("history_Step", String.valueOf(++step)); // 다음 단계
                    insertMap.put("history_Type", "결재");
                }

                logger.info("insertMap: " + insertMap.toString());
                approvalDAO.insertApprovalHistory(insertMap);
            }
        }

        if (dataObj.containsKey("refer")) {
            List<String> referList = (List<String>) dataObj.get("refer");
            for (String refer : referList) {
                insertMap = new HashMap<>();
                insertMap.put("emp_Id", refer);
                insertMap.put("history_st", "0");
                insertMap.put("doc_Id", Integer.parseInt((String) dataObj.get("docId")));
                insertMap.put("history_Turn", "N");
                insertMap.put("history_Step", "0");
                insertMap.put("history_Type", "참조");
                logger.info("insertMap: " + insertMap.toString());
                approvalDAO.insertApprovalHistory(insertMap);
            }
        }


        approvalVO.setApproval_Content((String)dataObj.get("content"));
        approvalVO.setApproval_Title((String)dataObj.get("title"));
        approvalVO.setApproval_St(1); // 기안만 한 상태 1
        approvalVO.setDoc_Id(Integer.parseInt((String)dataObj.get("docId")));
        logger.info("approvalVO :"+approvalVO.toString());

        approvalDAO.updateApproval(approvalVO);



        return returnapprovalVO;

    }

    public void registApprovalAttach(ApprovalVO approval)throws IOException {
        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = servletRequestAttributes.getRequest().getSession(true);
        EmpVO emp = (EmpVO)session.getAttribute("loginUser");
        String empId = emp.getEmp_Id();

        FileUploadCommand fileUploadCommand = approval.getFileUploadCommand();
        String fileUploadPath = fileUploadCommand.getFileUploadPath();
        int docId = approval.getDoc_Id();
        List<MultipartFile> files = (List<MultipartFile>)fileUploadCommand.getUploadFile();

        for(MultipartFile file : files)
        {
            String originalFileName = file.getOriginalFilename().substring(0, file.getOriginalFilename().lastIndexOf('.'));
            String fileName = UUID.randomUUID().toString().replace("-", "") + "$$" + file.getOriginalFilename();
            String fileType = fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase();
            String filePath = fileUploadPath + "/" + fileName;
            File target = new File(fileUploadPath, fileName);

            if(!target.exists())
            {
                target.mkdirs();
            }

            file.transferTo(target);


            ApprovalAttachVO attachVO = new ApprovalAttachVO();
            attachVO.setAttach_name(originalFileName);
            attachVO.setAttach_path(filePath);
            attachVO.setAttach_type(fileType);
            //attachVO.setEmp_attacher_id(empId);
            attachVO.setDoc_Id(docId);


            approvalDAO.insertApprovalAttach(attachVO);
        }

    }

    public Map<String, Object> getDraftList(ApprovalVO searchApprovalVO) {
        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = servletRequestAttributes.getRequest().getSession();
        EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        String empId = empVO.getEmp_Id();
        searchApprovalVO.setEmp_Drafter_Id(empId);

        Map<String,Object> dataMap = new HashMap<>();

        logger.info("getDraftList : pageIndex" + searchApprovalVO.getPageIndex());
        //기안문서 조회
        List<ApprovalVO> draftDocs = approvalDAO.selectDraftDocsById(searchApprovalVO);

        //결재대기문서 조회
        List<ApprovalVO> docs = approvalDAO.selectWaitDocsById(searchApprovalVO);

        //전체문서 count
        int totCnt = approvalDAO.selectDraftDocsCnt(searchApprovalVO);

        dataMap.put("docs",docs);
        dataMap.put("draftDocs",draftDocs);
        dataMap.put("totCnt",totCnt);


        return dataMap;
    }

    public ApprovalVO getCompleteDocByDocId(String docId) {
        ApprovalVO approvalVO = approvalDAO.getCompleteDocByDocId(docId);
        approvalVO.setAttachVOList(approvalDAO.selectAttachsByDocId(docId));
        logger.info(approvalVO.toString());
        return approvalVO;

    }

    public Map<String, Object> getWithDocById(String docId) {
        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes)RequestContextHolder.currentRequestAttributes();
        HttpSession session = servletRequestAttributes.getRequest().getSession();
        EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        String empId = empVO.getEmp_Id();
        Map<String,Object> dataMap = new HashMap<>();
        ApprovalHistoryVO historyVO = new ApprovalHistoryVO();
        historyVO.setEmp_Id(empId);
        int doc_Id = (Integer.parseInt(docId));
        historyVO.setDoc_Id(doc_Id); // 문서번호를 넣는다.


        List<ApprovalHistoryVO> pList = approvalDAO.getHistoryLine(doc_Id);
        ApprovalHistoryVO approvalHistoryVO = approvalDAO.selectHistoryById(docId);
        ApprovalVO approvalVO = approvalDAO.selectWaitDocByDocId(docId);
        approvalVO.setAttachVOList(approvalDAO.selectAttachsByDocId(docId));
        List<Map<String,Object>> pmap = approvalDAO.selectEmpPicture(docId);
        logger.info("pmap >>>>" + pmap.toString());

        dataMap.put("approval",approvalVO);
        dataMap.put("approvalHistoryVO",approvalHistoryVO);
        dataMap.put("pList", pList);

        logger.info("approval : "+ approvalVO.toString());
        return dataMap;



    }

    public Map<String, Object> getWaitList(ApprovalVO searchApprovalVO) {

        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes)RequestContextHolder.currentRequestAttributes();
        HttpSession session = servletRequestAttributes.getRequest().getSession();
        EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        String empId = empVO.getEmp_Id();
        Map<String,Object> dataMap = new HashMap<>();

        searchApprovalVO.setEmp_Drafter_Id(empId);
        List<FormVO> forms = approvalDAO.selectSaveFormsById(searchApprovalVO);
        List<ApprovalVO> waitDocs = approvalDAO.selectWaitDocsById(searchApprovalVO);

        dataMap.put("forms", forms);
        dataMap.put("waitDocs", waitDocs);

        logger.info("dataMap : "+ dataMap.toString());



        return dataMap;





    }

    public ApprovalVO modifyApprovalReview(Map<String, Object> dataMap) {

        ApprovalVO returnApproval = new ApprovalVO();
        ApprovalHistoryVO history = new ApprovalHistoryVO();
        ApprovalVO approval = new ApprovalVO();
        logger.info(dataMap.toString());


        ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = servletRequestAttribute.getRequest().getSession(true);
        EmpVO emp = (EmpVO)session.getAttribute("loginUser");
        String empId = emp.getEmp_Id();

        history.setDoc_Id((Integer.parseInt((String)dataMap.get("docId"))));
        history.setEmp_Id(empId); // 두번쨰결재자 emp_Id
        history.setHistory_st(1); //결재완료 상태
        history.setHistory_Turn("N");
        logger.info(history.toString());

        returnApproval.setDoc_Id((Integer.parseInt((String)dataMap.get("docId"))));
        logger.info(returnApproval.toString());
        approvalDAO.updateApprovalHistory(history);




        history = approvalDAO.selectStepByEmpIdAndDocId(history); // 문서 번호에 맞는 사원에 대해 step를 가져온다.
        /*
         * 1. 문서 번호에 맞는 사원에 대해 step를 가져온다.
         * 2. history에는 setDoc_Id/setEmp_Id/set_History_St가 박혀있다. 즉, 결재자에 대한 정보가 꽂혀있음.
         * */

        int historyStep = (Integer.parseInt(history.getHistory_Step())+1);
        // 결재가 완료되면, Step를  하나 증가시킨다.
        // 그러면 다음 결재자가 있을 때 결재자를 하나 더 늘려야한다.  2->3

        if(historyStep < 4)
        {
            int result = approvalDAO.selectCheckStepByStep((String)dataMap.get("docId"));
            if(result == 1) // 1이면 3번째 결재자가 있다는 거
            {
                logger.info("2step 들어옴?");
                history = new ApprovalHistoryVO(); // 새로 인스턴스화함.
                history.setDoc_Id((Integer.parseInt((String)dataMap.get("docId"))));
                history.setHistory_Step((String.valueOf(historyStep))); // -> 3
                history.setHistory_Turn("Y"); // 이번엔 3번쨰가 결재할 차례 그러면 이 정보를 업데이트 시켜야함.
                approvalDAO.updateApprovalHistoryByDocIdAndStep(history);
                logger.info("before:"+returnApproval.toString());
                // returnApproval = approvalDAO.selectHistoryTurnYByDocId(returnApproval); // 문서에 대한 결재하는 사번의 이름을 찾아서 넣는다.
                // logger.info("after:"+returnApproval.toString());

                ////////////////////////////////////////리턴에 값을 넣는다////////////////////////////////////

                returnApproval.setDoc_Id((Integer.parseInt((String)dataMap.get("docId")))); // 문서 번호+기안자 사번이 set 되어 있다.

                approval.setApproval_Title((String)dataMap.get("approvalTitle"));
                approval.setApproval_Content((String)dataMap.get("approvalContent"));
                approval.setApproval_St(1); // 결재 진행중인 상태
                approval.setDoc_Id((Integer.parseInt((String) dataMap.get("docId"))));

                approvalDAO.updateApproval(approval);
            }
            else{ // 두번째에서 끝내야함
                returnApproval.setDoc_Id((Integer.parseInt((String)dataMap.get("docId")))); // 문서 번호+기안자 사번이 set 되어 있다.

                approval.setApproval_Title((String)dataMap.get("approvalTitle"));
                approval.setApproval_Content((String)dataMap.get("approvalContent"));
                approval.setApproval_St(2); // 결재 진행중인 상태
                approval.setDoc_Id((Integer.parseInt((String) dataMap.get("docId"))));
                if (historyStep == 2 && result == 0) {
                    attendenceDAO.attendinsertApproval(dataMap);
                }
                approvalDAO.updateApproval(approval);

            }




        }

        else{
            List<String> refers = (List<String>)dataMap.get("referArr"); // 사번을 가져옴
            logger.info("refers :" + refers);
            for(String refer : refers)
            {
                logger.info("refer : "+refer);
                history = new ApprovalHistoryVO();
                history.setDoc_Id((Integer.parseInt((String)dataMap.get("docId"))));
                history.setEmp_Id(refer); // 참조자의 사번을 넣는다.
                approvalDAO.insertRefer(history);
            }


            /*조정 하는 부분 step 먼저 +1 했기 떄문에 조정 처리가 필요함*/
            history = new ApprovalHistoryVO();
            history.setDoc_Id((Integer.parseInt((String)dataMap.get("docId"))));
            history.setHistory_Step(String.valueOf(historyStep-1));
            history.setHistory_Turn("N");
            approvalDAO.updateApprovalHistoryByDocIdAndStep(history);

            approval.setApproval_Title((String)dataMap.get("approvalTitle"));
            approval.setApproval_Content((String)dataMap.get("approvalContent"));
            approval.setApproval_St(2);
            approval.setDoc_Id((Integer.parseInt((String)dataMap.get("docId"))));
            logger.info("approval >>> 여기들어오니? : "+approval.toString());
            if (historyStep == 3) {
                attendenceDAO.attendinsertApproval(dataMap);
            }
            approvalDAO.updateApproval(approval);


        }






        return returnApproval;

    }

    public void approvalReturn(Map<String, Object> dataMap) {
        ApprovalHistoryVO approvalHistoryVO = new ApprovalHistoryVO();
        ApprovalVO approvalVO = new ApprovalVO();
        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = servletRequestAttributes.getRequest().getSession();
        EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        String emp_Id = empVO.getEmp_Id();
        String docIdStr = (String) dataMap.get("doc_Id");

        logger.info("docIdStr"+docIdStr);
/////////////////////////////반려 하는 사람의 emp_Id / doc_Id값을 넣는다./////////////////////////////
        approvalHistoryVO.setDoc_Id((Integer.parseInt((String)dataMap.get("doc_Id"))));
        approvalHistoryVO.setEmp_Id(emp_Id);
        approvalHistoryVO.setHistory_st(3); // 반려도 결재가 완료된 상태이니 (1)로 바꿔줘야함.
        approvalHistoryVO.setHistory_Turn("N"); //결재차례가 아니니  업데이트 처리
        approvalHistoryVO.setHistory_Type("반려");
        approvalDAO.updateApprovalHistory(approvalHistoryVO);

/////////////////////////////반려 하는 사람의 emp_Id / 상태값을 업데이트한다./////////////////////////////

        approvalVO.setApproval_Cancel_Reason((String)dataMap.get("approval_Cancel_Reason"));
        approvalVO.setApproval_Content((String)dataMap.get("approval_Content"));
        approvalVO.setApproval_St(3); //3번은 반려상태
        approvalVO.setDoc_Id((Integer.parseInt((String)dataMap.get("doc_Id"))));
        approvalDAO.approvalReturn(approvalVO);

    }

    public Map<String, Object> getCompleteList(ApprovalVO searchApprovalVO) {
// 사용자 정보 가져옴
        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = servletRequestAttributes.getRequest().getSession();
        EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        Map<String,Object> dataMap = new HashMap<>();
        String emp_Id = empVO.getEmp_Id();
// 사용자 정보 가져옴
        searchApprovalVO.setEmp_Drafter_Id(emp_Id);

        logger.info(searchApprovalVO.toString());

        List<ApprovalVO> completeList = new ArrayList<>();

        completeList = approvalDAO.selectCompleteDocsById(searchApprovalVO);

        logger.info(completeList.toString());

        int totCnt = approvalDAO.selectCompleteDocCnt(searchApprovalVO);
        dataMap.put("totCnt",totCnt);
        dataMap.put("completeDocs",completeList);

        logger.info(dataMap.toString());

        return dataMap;


    }

    public Map<String, Object> getRejectList(ApprovalVO searchApprovalVO) {

        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = servletRequestAttributes.getRequest().getSession();
        EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        Map<String,Object> dataMap = new HashMap<>();
        String emp_Id = empVO.getEmp_Id();
// 사용자 정보 가져옴
        searchApprovalVO.setEmp_Drafter_Id(emp_Id);

        logger.info(searchApprovalVO.toString());

        List<ApprovalVO> rejectList = new ArrayList<>();

        rejectList = approvalDAO.selectRejectList(searchApprovalVO);

        logger.info(rejectList.toString());

        int totCnt = approvalDAO.selectRejectListCnt(searchApprovalVO);
        dataMap.put("totCnt",totCnt);
        dataMap.put("reject",rejectList);

        logger.info(dataMap.toString());

        return dataMap;

    }

    public Map<String, Object> gettemporaryList(ApprovalVO searchApprovalVO) {

        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = servletRequestAttributes.getRequest().getSession();
        EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        Map<String,Object> dataMap = new HashMap<>();
        String emp_Id = empVO.getEmp_Id();
// 사용자 정보 가져옴
        searchApprovalVO.setEmp_Drafter_Id(emp_Id);

        logger.info(searchApprovalVO.toString());

        List<ApprovalVO> temporaryList = new ArrayList<>();

        temporaryList = approvalDAO.selectTemporaryList(searchApprovalVO);

        logger.info(temporaryList.toString());

        int totCnt = approvalDAO.selectTemporaryListCnt(searchApprovalVO);
        dataMap.put("totCnt",totCnt);
        dataMap.put("temporary",temporaryList);

        logger.info(dataMap.toString());

        return dataMap;

    }


    public Map<String, Object> getReferList(ApprovalVO searchApprovalVO) {
        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = servletRequestAttributes.getRequest().getSession();
        EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        Map<String,Object> dataMap = new HashMap<>();
        String emp_Id = empVO.getEmp_Id();
// 사용자 정보 가져옴
        searchApprovalVO.setEmp_Drafter_Id(emp_Id);

        logger.info(searchApprovalVO.toString());

        List<ApprovalVO> referList = new ArrayList<>();

        referList = approvalDAO.selectReferList(searchApprovalVO);

        logger.info(referList.toString());

        int totCnt = approvalDAO.selectReferListCnt(searchApprovalVO);
        dataMap.put("totCnt",totCnt);
        dataMap.put("refer",referList);

        logger.info(dataMap.toString());

        return dataMap;
    }

    public Map<String, Object> getSaveFormsById(ApprovalVO searchApprovalVO) {


        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = servletRequestAttributes.getRequest().getSession();
        EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        String emp_Id = empVO.getEmp_Id();
// 사용자 정보 가져옴
        searchApprovalVO.setEmp_Drafter_Id(emp_Id);



        Map<String,Object> dataMap = new HashMap<>();
        List<ApprovalVO> docs = approvalDAO.selectWaitDocsById(searchApprovalVO);
        List<ApprovalVO> draftDocs = approvalDAO.selectMainDraftDocsById(searchApprovalVO);
        List<ApprovalVO> referDocs = approvalDAO.selectMainReferDocsById(searchApprovalVO);
        List<ApprovalVO> completeDocs = null;
        completeDocs = approvalDAO.selectCompleteDocsById(searchApprovalVO);



        dataMap.put("docs", docs);
        dataMap.put("completeDocs", completeDocs);
        dataMap.put("draftDocs", draftDocs);
        dataMap.put("referDocs", referDocs);


        logger.info("Main  :   " + dataMap);
        logger.info("draftDocs >> " + draftDocs.toString());
        return dataMap;


    }
}
