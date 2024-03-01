package com.WorkConGW.approval.dto;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.service.annotation.GetExchange;

import java.util.Date;

@ToString
@Getter
@Setter
@Alias("ApprovalHistoryVO")
public class ApprovalHistoryVO {

    private int doc_Id;
    private String emp_Id;
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private Date history_Allow_Dt;
    private String history_Turn;
    private String history_Step;
    private int history_st;
    private String emp_Name;
    private String dept_name;
    private String history_Type;
    private String code_Name;
    private String emp_Sign;




}
