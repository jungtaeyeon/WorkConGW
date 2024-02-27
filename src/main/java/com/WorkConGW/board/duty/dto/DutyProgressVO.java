package com.WorkConGW.board.duty.dto;

import org.apache.ibatis.type.Alias;

import java.util.Date;

@Alias("DutyProgressVO")
public class DutyProgressVO {
    private int progress_Id;
    private int duty_Board_Id;
    private String issue_Project_Id;
    private Date progress_Update_Dt;


    private int total_issues;
    private int todo_issues;
    private int inprogress_issues;
    private int done_issues;
    private int progress_percentage;

    public int getProgress_Id() {
        return progress_Id;
    }

    public void setProgress_Id(int progress_Id) {
        this.progress_Id = progress_Id;
    }

    public int getDuty_Board_Id() {
        return duty_Board_Id;
    }

    public void setDuty_Board_Id(int duty_Board_Id) {
        this.duty_Board_Id = duty_Board_Id;
    }

    public String getIssue_Project_Id() {
        return issue_Project_Id;
    }

    public void setIssue_Project_Id(String issue_Project_Id) {
        this.issue_Project_Id = issue_Project_Id;
    }

    public Date getProgress_Update_Dt() {
        return progress_Update_Dt;
    }

    public void setProgress_Update_Dt(Date progress_Update_Dt) {
        this.progress_Update_Dt = progress_Update_Dt;
    }

    public int getTotal_issues() {
        return total_issues;
    }

    public void setTotal_issues(int total_issues) {
        this.total_issues = total_issues;
    }

    public int getTodo_issues() {
        return todo_issues;
    }

    public void setTodo_issues(int todo_issues) {
        this.todo_issues = todo_issues;
    }

    public int getInprogress_issues() {
        return inprogress_issues;
    }

    public void setInprogress_issues(int inprogress_issues) {
        this.inprogress_issues = inprogress_issues;
    }

    public int getDone_issues() {
        return done_issues;
    }

    public void setDone_issues(int done_issues) {
        this.done_issues = done_issues;
    }

    public int getProgress_percentage() {
        return progress_percentage;
    }

    public void setProgress_percentage(int progress_percentage) {
        this.progress_percentage = progress_percentage;
    }

}
