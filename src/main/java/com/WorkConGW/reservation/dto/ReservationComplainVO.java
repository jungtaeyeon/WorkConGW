package com.WorkConGW.reservation.dto;

import com.WorkConGW.common.dto.BaseVO;
import org.apache.ibatis.type.Alias;

@Alias("compainVO")
public class ReservationComplainVO extends BaseVO{


    private int complain_Id;



    private String emp_Id;



    private int meet_Room_Id;
    private String complain_Content;
    private String complain_Create_Date;
    private int complain_St;
    private String auth_Name;
    private String emp_Name;


    public int getComplain_Id() {
        return complain_Id;
    }

    public void setComplain_Id(int complain_Id) {
        this.complain_Id = complain_Id;
    }

    public String getEmp_Id() {
        return emp_Id;
    }

    public void setEmp_Id(String emp_Id) {
        this.emp_Id = emp_Id;
    }

    public int getMeet_Room_Id() {
        return meet_Room_Id;
    }

    public void setMeet_Room_Id(int meet_Room_Id) {
        this.meet_Room_Id = meet_Room_Id;
    }

    public String getComplain_Content() {
        return complain_Content;
    }

    public void setComplain_Content(String complain_Content) {
        this.complain_Content = complain_Content;
    }

    public String getComplain_Create_Date() {
        return complain_Create_Date;
    }

    public void setComplain_Create_Date(String complain_Create_Date) {
        this.complain_Create_Date = complain_Create_Date;
    }

    public int getComplain_St() {
        return complain_St;
    }

    public void setComplain_St(int complain_St) {
        this.complain_St = complain_St;
    }

    public String getAuth_Name() {
        return auth_Name;
    }

    public void setAuth_Name(String auth_Name) {
        this.auth_Name = auth_Name;
    }

    public String getEmp_Name() {
        return emp_Name;
    }

    public void setEmp_Name(String emp_Name) {
        this.emp_Name = emp_Name;
    }

    public ReservationComplainVO(){}

    public ReservationComplainVO(int complain_Id, String emp_Id, int meet_Room_Id, String complain_Content, String complain_Create_Date, int complain_St, String auth_Name, String emp_Name) {
        super();
        this.complain_Id = complain_Id;
        this.emp_Id = emp_Id;
        this.meet_Room_Id = meet_Room_Id;
        this.complain_Content = complain_Content;
        this.complain_Create_Date = complain_Create_Date;
        this.complain_St = complain_St;
        this.auth_Name = auth_Name;
        this.emp_Name = emp_Name;
    }


}