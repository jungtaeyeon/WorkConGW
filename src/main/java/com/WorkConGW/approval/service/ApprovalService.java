package com.WorkConGW.approval.service;

import com.WorkConGW.approval.controller.ApprovalController;
import com.WorkConGW.approval.dao.ApprovalDAO;
import com.WorkConGW.approval.dto.ApprovalAttachVO;
import com.WorkConGW.approval.dto.ApprovalLineVO;
import com.WorkConGW.approval.dto.ApprovalVO;
import com.WorkConGW.approval.dto.FormVO;
import com.WorkConGW.common.command.FileUploadCommand;
import com.WorkConGW.emp.dao.EmpDAO;
import com.WorkConGW.emp.dto.EmpVO;
import com.google.api.Http;
import jakarta.servlet.http.HttpSession;
import org.eclipse.jdt.internal.compiler.problem.AbortType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.*;

@Service
public class ApprovalService{

    @Autowired
    private ApprovalDAO approvalDAO = null;

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
        line.setEmp_Id(emp_Id); // 사원번호 저장

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

        returnapprovalVO.setDoc_Id(Integer.parseInt((String)dataObj.get("docId")));
        logger.info(returnapprovalVO.toString());

        insertMap.put("emp_Id",(String)dataObj.get("apply")); //신청자 저장
        insertMap.put("doc_Id",Integer.parseInt((String)dataObj.get("docId")));
        insertMap.put("history_Turn", "N"); // 현재 결재 이력이 진행중
        insertMap.put("history_Step", "1"); // 기안 상태
        insertMap.put("approval_End_Dt",dataObj.get("endDt"));
        insertMap.put("approval_Start_Dt",dataObj.get("startDt"));

        logger.info(insertMap.toString());
        approvalDAO.insertApprovalHistory(insertMap);

        insertMap = new HashMap<>();
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


        List<String> list = (List)dataObj.get("approval");
        logger.info(list.toString());
        for(int i = 0; i < list.size(); i += 2) {
            insertMap.put("emp_Id", list.get(i));
            insertMap.put("doc_Id", Integer.parseInt((String) dataObj.get("docId")));
            insertMap.put("history_Turn", "N"); // 현재 결재 이력이 진행중
            insertMap.put("history_Step", "2");
            logger.info("for문 안쪽"+insertMap.toString());
            approvalDAO.insertApprovalHistory(insertMap);

            // i 값이 list 크기를 초과하지 않는지 확인하여 다음 값 처리
            if(i + 1 < list.size()) {
                insertMap = new HashMap<>();
                insertMap.put("emp_Id", list.get(i + 1));
                insertMap.put("doc_Id", Integer.parseInt((String) dataObj.get("docId")));
                insertMap.put("history_Turn", "N"); // 현재 결재 이력이 진행중
                insertMap.put("history_Step", "3");
                logger.info("if문 안쪽"+insertMap.toString());
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
            attachVO.setEmp_attacher_id(empId);
            attachVO.setDoc_Id(docId);


            approvalDAO.insertApprovalAttach(attachVO);
        }

    }
}
