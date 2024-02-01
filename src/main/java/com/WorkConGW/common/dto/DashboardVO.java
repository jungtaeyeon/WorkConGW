package com.WorkConGW.common.dto;

import org.apache.ibatis.type.Alias;

@Alias("DashboardVO")
public class DashboardVO {

    private String emp_id;
    private int dashboard_duty;
    private int dashboard_issue;
    private int dashboard_project;
    private String dashboard_approval;
    private String dashboard_reservation;
    private String dashboard_board;


    public DashboardVO(){}

    public DashboardVO(String emp_id, int dashboard_duty, int dashboard_issue, int dashboard_project, String dashboard_approval,String dashboard_reservation,String dashboard_board)
    {
        this.emp_id =emp_id;
        this.dashboard_duty=dashboard_duty;
        this.dashboard_issue=dashboard_issue;
        this.dashboard_project=dashboard_project;
        this.dashboard_approval=dashboard_approval;
        this.dashboard_reservation=dashboard_reservation;
        this.dashboard_board=dashboard_board;
    }


    public String getEmp_id() {
        return this.emp_id;
    }

    public void setEmp_id(String emp_id) {
        this.emp_id = emp_id;
    }

    public int getDashboard_duty() {
        return this.dashboard_duty;
    }

    public void setDashboard_duty(int dashboard_duty) {
        this.dashboard_duty = dashboard_duty;
    }

    public int getDashboard_issue() {
        return this.dashboard_issue;
    }

    public void setDashboard_issue(int dashboard_issue) {
        this.dashboard_issue = dashboard_issue;
    }

    public int getDashboard_project() {
        return this.dashboard_project;
    }

    public void setDashboard_project(int dashboard_project) {
        this.dashboard_project = dashboard_project;
    }

    public String getDashboard_approval() {
        return this.dashboard_approval;
    }

    public void setDashboard_approval(String dashboard_approval) {
        this.dashboard_approval = dashboard_approval;
    }

    public String getDashboard_reservation() {
        return this.dashboard_reservation;
    }

    public void setDashboard_reservation(String dashboard_reservation) {
        this.dashboard_reservation = dashboard_reservation;
    }

    public String getDashboard_board() {
        return this.dashboard_board;
    }

    public void setDashboard_board(String dashboard_board) {
        this.dashboard_board = dashboard_board;
    }


    
	
}
