package com.WorkConGW.attend.dto;


import java.util.Date;

import org.apache.ibatis.type.Alias;

import com.WorkConGW.common.dto.BaseVO;

import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author pc18
 *
 */
@Data
@NoArgsConstructor
@Alias("AttendenceVO")
public class AttendenceVO extends BaseVO{
  private Date history_attend_time;
  private Date history_leaving_time;
  private int attend_st_id;
  private String attend_st_name;
  private int history_id;
  private String emp_id;
  private String history_reason;

  private String attend_time;
  private String emp_manager_id;
  private String leaving_time;
  private String lunch_start_time;
  private String lunch_end_time;
}
