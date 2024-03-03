package com.WorkConGW.reservation.dto;

import com.WorkConGW.common.dto.BaseVO;
import org.apache.ibatis.type.Alias;

@Alias("MeetRoomReservationVO")
public class MeetRoomReservationVO extends BaseVO {

    private int meet_Room_Reservation_Id;
    private int meet_Room_Id;
    private String emp_Id;
    private String emp_Name;
    private String meet_Room_Name;
    private String meet_Room_No;



    private String dept_Name;
    private String team_Name;
    private String official_Name;

    public String getOfficial_Name() {
        return official_Name;
    }

    public void setOfficial_Name(String official_Name) {
        this.official_Name = official_Name;
    }

    private int reservation_Start_Time;
    private int reservation_End_Time;
    private String reservation_Date;
    private String meet_Room_Detail;
    private int meet_Room_reservation_St;
    private String meet_Room_Dept_Id;



    private String meet_Room_Capacity;
    private String meet_Room_Attach_Origin;



    private String isType ="user";

//    private String searchKeyword;
//    private String searchCondition;

//    public String getSearchCondition() {
//        return searchCondition;
//    }
//
//    public void setSearchCondition(String searchCondition) {
//        this.searchCondition = searchCondition;
//    }
//
//    public String getSearchKeyword() {
//        return searchKeyword;
//    }
//
//    public void setSearchKeyword(String searchKeyword) {
//        this.searchKeyword = searchKeyword;
//    }

    public int getMeet_Room_Reservation_Id() {
        return meet_Room_Reservation_Id;
    }

    public void setMeet_Room_Reservation_Id(int meet_Room_Reservation_Id) {
        this.meet_Room_Reservation_Id = meet_Room_Reservation_Id;
    }

    public int getMeet_Room_Id() {
        return meet_Room_Id;
    }

    public void setMeet_Room_Id(int meet_Room_Id) {
        this.meet_Room_Id = meet_Room_Id;
    }

    public String getEmp_Id() {
        return emp_Id;
    }

    public void setEmp_Id(String emp_Id) {
        this.emp_Id = emp_Id;
    }

    public int getReservation_Start_Time() {
        return reservation_Start_Time;
    }

    public void setReservation_Start_Time(int reservation_Start_Time) {
        this.reservation_Start_Time = reservation_Start_Time;
    }

    public int getReservation_End_Time() {
        return reservation_End_Time;
    }

    public void setReservation_End_Time(int reservation_End_Time) {
        this.reservation_End_Time = reservation_End_Time;
    }

    public String getReservation_Date() {
        return reservation_Date;
    }

    public void setReservation_Date(String reservation_Date) {
        this.reservation_Date = reservation_Date;
    }

    public String getMeet_Room_Detail() {
        return meet_Room_Detail;
    }

    public void setMeet_Room_Detail(String meet_Room_Detail) {
        this.meet_Room_Detail = meet_Room_Detail;
    }

    public int getMeet_Room_reservation_St() {
        return meet_Room_reservation_St;
    }

    public void setMeet_Room_reservation_St(int meet_Room_reservation_St) {
        this.meet_Room_reservation_St = meet_Room_reservation_St;
    }

    public String getMeet_Room_Dept_Id() {
        return meet_Room_Dept_Id;
    }

    public void setMeet_Room_Dept_Id(String meet_Room_Dept_Id) {
        this.meet_Room_Dept_Id = meet_Room_Dept_Id;
    }
    public String getIsType() {
        return isType;
    }

    public void setIsType(String isType) {
        this.isType = isType;
    }

    public String getEmp_Name() {
        return emp_Name;
    }

    public void setEmp_Name(String emp_Name) {
        this.emp_Name = emp_Name;
    }

    public String getDept_Name() {
        return dept_Name;
    }

    public void setDept_Name(String dept_Name) {
        this.dept_Name = dept_Name;
    }
    public String getMeet_Room_Name() {
        return meet_Room_Name;
    }

    public void setMeet_Room_Name(String meet_Room_Name) {
        this.meet_Room_Name = meet_Room_Name;
    }

    public String getMeet_Room_No() {
        return meet_Room_No;
    }

    public void setMeet_Room_No(String meet_Room_No) {
        this.meet_Room_No = meet_Room_No;
    }

    public String getTeam_Name() {
        return team_Name;
    }

    public void setTeam_Name(String team_Name) {
        this.team_Name = team_Name;
    }

    public String getMeet_Room_Capacity() {
        return meet_Room_Capacity;
    }

    public void setMeet_Room_Capacity(String meet_Room_Capacity) {
        this.meet_Room_Capacity = meet_Room_Capacity;
    }

    public String getMeet_Room_Attach_Origin() {
        return meet_Room_Attach_Origin;
    }

    public void setMeet_Room_Attach_Origin(String meet_Room_Attach_Origin) {
        this.meet_Room_Attach_Origin = meet_Room_Attach_Origin;
    }

}
