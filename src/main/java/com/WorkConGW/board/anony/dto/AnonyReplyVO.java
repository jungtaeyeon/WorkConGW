package com.WorkConGW.board.anony.dto;

import java.util.Date;

import com.WorkConGW.common.dto.BaseVO;
import lombok.Builder;
import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.NoArgsConstructor;

@Alias("anonyReply")
@Data
@NoArgsConstructor
public class AnonyReplyVO extends BaseVO {

	
    private int reply_Id;
    private String reply_Content;
    private Date reply_Create_Dt;
    private Date reply_Update_Dt;
    private int anony_Board_Id;
    private String emp_Writer_Id;

    @Builder
    public AnonyReplyVO(int reply_Id, String reply_Content, Date reply_Create_Dt, Date reply_Update_Dt, int anony_Board_Id, String emp_Writer_Id)
    {
        super();
        this.reply_Id = reply_Id;
        this.reply_Content = reply_Content;
        this.reply_Create_Dt = reply_Create_Dt;
        this.reply_Update_Dt = reply_Update_Dt;
        this.anony_Board_Id = anony_Board_Id;
        this.emp_Writer_Id = emp_Writer_Id;
    }



}
