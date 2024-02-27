package com.WorkConGW.board.duty.dto;


import org.apache.ibatis.type.Alias;

import java.util.Date;

@Alias("DutyReplyVO")
public class DutyReplyVO {
    private int reply_Id;
    private String reply_Content;
    private Date reply_Create_Dt;
    private Date reply_Update_Dt;
    private int duty_Board_Id;
    private String emp_Id;
    private String emp_Name;

    public int getReply_Id() {
        return reply_Id;
    }

    public void setReply_Id(int reply_Id) {
        this.reply_Id = reply_Id;
    }

    public String getReply_Content() {
        return reply_Content;
    }

    public void setReply_Content(String reply_Content) {
        this.reply_Content = reply_Content;
    }

    public Date getReply_Create_Dt() {
        return reply_Create_Dt;
    }

    public void setReply_Create_Dt(Date reply_Create_Dt) {
        this.reply_Create_Dt = reply_Create_Dt;
    }

    public Date getReply_Update_Dt() {
        return reply_Update_Dt;
    }

    public void setReply_Update_Dt(Date reply_Update_Dt) {
        this.reply_Update_Dt = reply_Update_Dt;
    }

    public int getDuty_Board_Id() {
        return duty_Board_Id;
    }

    public void setDuty_Board_Id(int duty_Board_Id) {
        this.duty_Board_Id = duty_Board_Id;
    }

    public String getEmp_Id() {
        return emp_Id;
    }

    public void setEmp_Id(String emp_Id) {
        this.emp_Id = emp_Id;
    }

    public String getEmp_Name() {
        return emp_Name;
    }

    public void setEmp_Name(String emp_Name) {
        this.emp_Name = emp_Name;
    }

}
