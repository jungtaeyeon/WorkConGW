package com.WorkConGW.approval.dto;

import com.WorkConGW.common.dto.AttachVO;
import lombok.ToString;
import org.apache.ibatis.type.Alias;


@Alias("ApprovalAttach")
@ToString
public class ApprovalAttachVO extends AttachVO{


    private int doc_Id;

    public int getDoc_Id() {
        return doc_Id;
    }

    public void setDoc_Id(int doc_Id) {
        this.doc_Id = doc_Id;
    }









}
