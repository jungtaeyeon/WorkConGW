package com.WorkConGW.approval.dto;


import com.WorkConGW.common.command.FileUploadCommand;
import com.WorkConGW.common.dto.BaseVO;
import lombok.*;
import org.apache.ibatis.type.Alias;

import java.util.Date;
import java.util.List;
@ToString
@Getter
@Setter
@Alias("ApprovalVO")
public class ApprovalVO extends BaseVO {


    private int doc_Id;

    private int form_Id;
    private String approval_Title;

    private String approval_Content;

    private Date approval_Recommand_Dt;

    private Date approval_Termination_Dt;

    private Date approval_End_Dt;

    private Date approval_Start_Dt;

    private int approval_St;


    private String emp_Drafter_Id;

    private String emp_Name;

    private String emp_Drafter_Official;


    private String form_Name;


    private String attachCnt;

    private List<String> docIdList;


    private FileUploadCommand fileUploadCommand;

    private List<ApprovalAttachVO> attachVOList;

    private String searchDt;


    private String searchState;


    public ApprovalVO() {
        this.fileUploadCommand = new FileUploadCommand();
    }






	
}
