package com.WorkConGW.reservation.dto;


import com.WorkConGW.common.dto.BaseVO;
import org.apache.ibatis.type.Alias;

@Alias("MeetRoomVO")
public class MeetRoomVO extends BaseVO {

    private int    meetRoom_Id;
    private String meetRoom_No;
    private int meetRoom_St;
    private String meetRoom_Admin_Id;
    private int    meetRoom_Capacity;
    private String meetRoom_Name;
    private String meetRoom_Attach_Name;
    private String meetRoom_Attach_Type;
    private String meetRoom_Attach_Origin;
    private String meetRoom_Create_Date;
    private String meetRoom_Attach_Path;


    /////////////////////
    private String isType ="user";	// 탭 체크
    private String emp_Id;
    private String emp_Name;
    private String dept_Id;
    private String dept_Name;
    private String team_Name;
    private String reservation_Start_Time;
    private String reservation_End_Time;
    private String reservation_Date;
    private int meetRoom_Reservation_Id;

    public String getIsType() {
        return isType;
    }

    public void setIsType(String isType) {
        this.isType = isType;
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

    public String getDept_Id() {
        return dept_Id;
    }

    public void setDept_Id(String dept_Id) {
        this.dept_Id = dept_Id;
    }

    public String getDept_Name() {
        return dept_Name;
    }

    public void setDept_Name(String dept_Name) {
        this.dept_Name = dept_Name;
    }

    public String getTeam_Name() {
        return team_Name;
    }

    public void setTeam_Name(String team_Name) {
        this.team_Name = team_Name;
    }

    public String getReservation_Start_Time() {
        return reservation_Start_Time;
    }

    public void setReservation_Start_Time(String reservation_Start_Time) {
        this.reservation_Start_Time = reservation_Start_Time;
    }

    public String getReservation_End_Time() {
        return reservation_End_Time;
    }

    public void setReservation_End_Time(String reservation_End_Time) {
        this.reservation_End_Time = reservation_End_Time;
    }

    public String getReservation_Date() {
        return reservation_Date;
    }

    public void setReservation_Date(String reservation_Date) {
        this.reservation_Date = reservation_Date;
    }

    public int getMeetRoom_Reservation_Id() {
        return meetRoom_Reservation_Id;
    }

    public void setMeetRoom_Reservation_Id(int meetRoom_Reservation_Id) {
        this.meetRoom_Reservation_Id = meetRoom_Reservation_Id;
    }

    public String getMeetRoom_Team_Id() {
        return meetRoom_Team_Id;
    }

    public void setMeetRoom_Team_Id(String meetRoom_Team_Id) {
        this.meetRoom_Team_Id = meetRoom_Team_Id;
    }

    public String getMeetRoom_Detail() {
        return meetRoom_Detail;
    }

    public void setMeetRoom_Detail(String meetRoom_Detail) {
        this.meetRoom_Detail = meetRoom_Detail;
    }

    public String getOfficial_Name() {
        return official_Name;
    }

    public void setOfficial_Name(String official_Name) {
        this.official_Name = official_Name;
    }

    public String getMeetRoom_Reservation_St() {
        return MeetRoom_Reservation_St;
    }

    public void setMeetRoom_Reservation_St(String meetRoom_Reservation_St) {
        MeetRoom_Reservation_St = meetRoom_Reservation_St;
    }

    private String meetRoom_Team_Id;
    private String meetRoom_Detail;
    private String official_Name;
    private String MeetRoom_Reservation_St;

    public int getMeetRoom_Id() {
        return meetRoom_Id;
    }

    public void setMeetRoom_Id(int meetRoom_Id) {
        this.meetRoom_Id = meetRoom_Id;
    }

    public String getMeetRoom_No() {
        return meetRoom_No;
    }

    public void setMeetRoom_No(String meetRoom_No) {
        this.meetRoom_No = meetRoom_No;
    }

    public int getMeetRoom_St() {
        return meetRoom_St;
    }

    public void setMeetRoom_St(int meetRoom_St) {
        this.meetRoom_St = meetRoom_St;
    }

    public String getMeetRoom_Admin_Id() {
        return meetRoom_Admin_Id;
    }

    public void setMeetRoom_Admin_Id(String meetRoom_Admin_Id) {
        this.meetRoom_Admin_Id = meetRoom_Admin_Id;
    }

    public int getMeetRoom_Capacity() {
        return meetRoom_Capacity;
    }

    public void setMeetRoom_Capacity(int meetRoom_Capacity) {
        this.meetRoom_Capacity = meetRoom_Capacity;
    }

    public String getMeetRoom_Name() {
        return meetRoom_Name;
    }

    public void setMeetRoom_Name(String meetRoom_Name) {
        this.meetRoom_Name = meetRoom_Name;
    }

    public String getMeetRoom_Attach_Name() {
        return meetRoom_Attach_Name;
    }

    public void setMeetRoom_Attach_Name(String meetRoom_Attach_Name) {
        this.meetRoom_Attach_Name = meetRoom_Attach_Name;
    }

    public String getMeetRoom_Attach_Type() {
        return meetRoom_Attach_Type;
    }

    public void setMeetRoom_Attach_Type(String meetRoom_Attach_Type) {
        this.meetRoom_Attach_Type = meetRoom_Attach_Type;
    }

    public String getMeetRoom_Attach_Origin() {
        return meetRoom_Attach_Origin;
    }

    public void setMeetRoom_Attach_Origin(String meetRoom_Attach_Origin) {
        this.meetRoom_Attach_Origin = meetRoom_Attach_Origin;
    }

    public String getMeetRoom_Create_Date() {
        return meetRoom_Create_Date;
    }

    public void setMeetRoom_Create_Date(String meetRoom_Create_Date) {
        this.meetRoom_Create_Date = meetRoom_Create_Date;
    }

    public String getMeetRoom_Attach_Path() {
        return meetRoom_Attach_Path;
    }

    public void setMeetRoom_Attach_Path(String meetRoom_Attach_Path) {
        this.meetRoom_Attach_Path = meetRoom_Attach_Path;
    }

    public String getMeetRoom_Content() {
        return meetRoom_Content;
    }

    public void setMeetRoom_Content(String meetRoom_Content) {
        this.meetRoom_Content = meetRoom_Content;
    }

    private String meetRoom_Content;
}
