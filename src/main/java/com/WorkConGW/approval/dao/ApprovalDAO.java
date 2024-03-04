package com.WorkConGW.approval.dao;


import com.WorkConGW.approval.dto.*;
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

    public List<ApprovalVO> selectDraftDocsById(ApprovalVO searchApprovalVO) {
        return sqlSessionTemplate.selectList("selectDraftDocsById",searchApprovalVO);
    }

    public List<ApprovalVO> selectWaitDocsById(ApprovalVO searchApprovalVO) {
        return sqlSessionTemplate.selectList("selectWaitDocsById",searchApprovalVO);
    }

    public int selectDraftDocsCnt(ApprovalVO searchApprovalVO) {
        return sqlSessionTemplate.selectOne("selectDraftDocsCnt",searchApprovalVO);
    }

    public ApprovalVO getCompleteDocByDocId(String docId) {

        return sqlSessionTemplate.selectOne("getCompleteDocByDocId", docId);
    }

    public List<ApprovalAttachVO> selectAttachsByDocId(String docId) {

        return sqlSessionTemplate.selectList("selectAttachsByDocId", docId);
    }

    public ApprovalVO selectWaitDocByDocId(String docId) {
        return sqlSessionTemplate.selectOne("selectWaitDocByDocId", docId);
    }

    public List<FormVO> selectSaveFormsById(ApprovalVO searchApprovalVO) {
        return sqlSessionTemplate.selectList("selectSaveFormsById",searchApprovalVO);

    }

    public ApprovalHistoryVO selectHistoryById(String docId) {
        return sqlSessionTemplate.selectOne("selectHistoryById", docId);
    }

    public void updateDt(Map<String, Object> insertDt) {
        sqlSessionTemplate.update("updateDt",insertDt);
    }

    public List<ApprovalHistoryVO> getHistoryLine(int doc_Id) {
        return sqlSessionTemplate.selectList("getHistoryLine", doc_Id);
    }

    public void updateApprovalHistory(ApprovalHistoryVO history) {
        sqlSessionTemplate.update("updateApprovalHistory",history);
    }

    public ApprovalHistoryVO selectStepByEmpIdAndDocId(ApprovalHistoryVO history) {
        return sqlSessionTemplate.selectOne("selectStepByEmpIdAndDocId", history);

    }

    public void updateApprovalHistoryByDocIdAndStep(ApprovalHistoryVO history) {
        sqlSessionTemplate.update("updateApprovalHistoryByDocIdAndStep",history);
    }

    public ApprovalVO selectHistoryTurnYByDocId(ApprovalVO returnApproval) {

        return sqlSessionTemplate.selectOne("selectHistoryTurnYByDocId", returnApproval);

    }

    public void insertRefer(ApprovalHistoryVO history) {
        sqlSessionTemplate.insert("insertRefer",history);
    }

    public void approvalReturn(ApprovalVO approvalVO) {
        sqlSessionTemplate.update("approvalReturn", approvalVO);
    }

    public List<Map<String, Object>> selectEmpPicture(String docId) {
        return sqlSessionTemplate.selectList("selectEmpPicture",docId);
    }



    public List<ApprovalVO> selectCompleteDocsById(ApprovalVO searchApprovalVO) {

        return sqlSessionTemplate.selectList("selectCompleteDocsById", searchApprovalVO);
    }

    public int selectCheckStepByStep(String doc_Id) {
        return  sqlSessionTemplate.selectOne("selectCheckStepByStep", doc_Id);
    }

    public int selectCompleteDocCnt(ApprovalVO searchApprovalVO) {
        return sqlSessionTemplate.selectOne("selectCompleteDocCnt", searchApprovalVO);
    }

    public List<ApprovalVO> selectRejectList(ApprovalVO searchApprovalVO) {
        return sqlSessionTemplate.selectList("selectRejectList",searchApprovalVO);
    }

    public int selectRejectListCnt(ApprovalVO searchApprovalVO) {
        return sqlSessionTemplate.selectOne("selectRejectListCnt", searchApprovalVO);
    }


    public List<ApprovalVO> selectTemporaryList(ApprovalVO searchApprovalVO) {
        return sqlSessionTemplate.selectList("selectTemporaryList", searchApprovalVO);
    }

    public int selectTemporaryListCnt(ApprovalVO searchApprovalVO) {
        return sqlSessionTemplate.selectOne("selectTemporaryListCnt",searchApprovalVO);
    }

    public List<ApprovalVO> selectReferList(ApprovalVO searchApprovalVO) {
        return sqlSessionTemplate.selectList("selectReferList", searchApprovalVO);
    }

    public int selectReferListCnt(ApprovalVO searchApprovalVO) {
        return sqlSessionTemplate.selectOne("selectReferListCnt",searchApprovalVO);
    }

    public List<ApprovalVO> selectMainDraftDocsById(ApprovalVO searchApprovalVO) {
        return sqlSessionTemplate.selectList("selectMainDraftDocsById",searchApprovalVO);
    }

    public List<ApprovalVO> selectMainReferDocsById(ApprovalVO searchApprovalVO) {
        return sqlSessionTemplate.selectList("selectMainReferDocsById", searchApprovalVO);
    }
}

