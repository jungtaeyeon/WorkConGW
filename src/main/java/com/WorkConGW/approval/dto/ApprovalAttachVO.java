package com.WorkConGW.approval.dto;

import com.WorkConGW.common.dto.AttachVO;
import lombok.ToString;


@ToString
public class ApprovalAttachVO extends AttachVO{


    private int doc_Id;
    public ApprovalAttachVO(int doc_Id) {
        this.doc_Id = doc_Id;
    }

    public int getDoc_Id() {
        return doc_Id;
    }

    public void setDoc_Id(int doc_Id) {
        this.doc_Id = doc_Id;
    }









}
