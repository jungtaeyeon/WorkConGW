package com.WorkConGW.approval.dto;


import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@NoArgsConstructor
@Alias("ApprovalLineVO")
public class ApprovalLineVO {
    private int line_Id;
    private String line_Name;
    private String emp_Id;
    private String line_Type;
    private String emp_Name;
    private String dept_Name;
    private String attend_St_Name;
    private String code_Name;

	
}
