package com.WorkConGW.common.dto;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@ToString
@Alias("timeVO")
public class TimeVO {
    private String attend_Time;
    private String emp_Manager_Id;
    private String leaving_Time;
    private String lunch_Start_Time;
    private String lunch_End_Time;


    public TimeVO(String attend_Time, String emp_Manager_Id, String leaving_Time, String lunch_End_Time, String lunch_Start_Time)
    {
        this.attend_Time = attend_Time;
        this.emp_Manager_Id = emp_Manager_Id;
        this.leaving_Time = leaving_Time;
        this.lunch_End_Time = lunch_End_Time;
        this.lunch_Start_Time = lunch_Start_Time;
    }
	
}
