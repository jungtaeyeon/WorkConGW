package com.WorkConGW.board.anony.dto;

import java.util.Date;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.NoArgsConstructor;

@Alias("anonyReply")
@Data
@NoArgsConstructor
public class AnonyReplyVO {

	
    private int reply_Id;
    private String reply_Content;
    private Date reply_Create_Dt;
    private Date reply_Update_Dt;
    private int anony_Board_Id;
    private String emp_Writer_Id;



}
