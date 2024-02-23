package com.WorkConGW.approval.service;

import com.WorkConGW.approval.dao.ApprovalDAO;
import com.WorkConGW.approval.dto.FormVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ApprovalService{

    @Autowired
    private ApprovalDAO approvalDAO = null;


}
