package com.WorkConGW.approval.dao;


import com.WorkConGW.approval.dto.ApprovalAttachVO;
import com.WorkConGW.approval.dto.ApprovalLineVO;
import com.WorkConGW.approval.dto.ApprovalVO;
import com.WorkConGW.approval.dto.FormVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Repository
public class ApprovalDAO {

    @Autowired
    SqlSessionTemplate sqlSessionTemplate = null;
    public List<FormVO> registDocForm() {
        return sqlSessionTemplate.selectList("registDocForm");
    }

    public FormVO selectFormById(String formId) {
        return sqlSessionTemplate.selectOne("selectFormById",formId);
    }

    public void insertApproval(ApprovalVO approvalVO) {
        sqlSessionTemplate.insert("insertApproval", approvalVO);
    }

    public void updateApprovalTemp(ApprovalVO approvalVO) {
        sqlSessionTemplate.update("updateApprovalTemp", approvalVO);
    }

    public int selectMaxDocId() {
        return sqlSessionTemplate.selectOne("selectMaxDocId");
    }

    public int selectApprovalLineSeqNext() {
        return sqlSessionTemplate.selectOne("selectApprovalLineSeqNext");
    }

    public void insertApprovalLine(ApprovalLineVO line) {
        sqlSessionTemplate.insert("insertApprovalLine", line);
    }

    public void insertApprovalLineRegister(ApprovalLineVO line) {
        sqlSessionTemplate.insert("insertApprovalLineRegister",line);
    }

    public List<ApprovalLineVO> selectApprovalLineByEmpId(String empId) {
        return sqlSessionTemplate.selectList("selectApprovalLineByEmpId",empId);
    }

    public List<ApprovalLineVO> selectApprovalLineRegistByLineId(int lineId) {
        return sqlSessionTemplate.selectList("selectApprovalLineRegistByLineId", lineId);
    }

    public void insertApprovalHistory(Map<String, Object> insertMap) {
        sqlSessionTemplate.insert("insertApprovalHistory",insertMap);
    }

    public void updateApproval(ApprovalVO approvalVO) {
        sqlSessionTemplate.update("updateApproval",approvalVO);
    }

    public void insertApprovalAttach(ApprovalAttachVO attachVO) {
        sqlSessionTemplate.insert("insertApprovalAttach", attachVO);
    }
}

