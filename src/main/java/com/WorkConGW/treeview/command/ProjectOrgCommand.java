package com.WorkConGW.treeview.command;

import lombok.ToString;
import org.apache.ibatis.type.Alias;

@ToString
@Alias("ProjectOrgCommand")
public class ProjectOrgCommand {
    private int project_Id;
    private String project_Title;
    private int duty_Board_Id;
    private String duty_Board_Title;

    public int getProject_Id() {
        return project_Id;
    }

    public void setProject_Id(int project_Id) {
        this.project_Id = project_Id;
    }

    public String getProject_Title() {
        return project_Title;
    }

    public void setProject_Title(String project_Title) {
        this.project_Title = project_Title;
    }

    public int getDuty_Board_Id() {
        return duty_Board_Id;
    }

    public void setDuty_Board_Id(int duty_Board_Id) {
        this.duty_Board_Id = duty_Board_Id;
    }

    public String getDuty_Board_Title() {
        return duty_Board_Title;
    }

    public void setDuty_Board_Title(String duty_Board_Title) {
        this.duty_Board_Title = duty_Board_Title;
    }

}
