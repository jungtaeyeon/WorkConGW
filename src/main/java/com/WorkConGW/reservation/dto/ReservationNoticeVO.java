package com.WorkConGW.reservation.dto;

import com.WorkConGW.common.dto.BaseVO;
import org.apache.ibatis.type.Alias;

@Alias("ReservationNoticeVO")
public class ReservationNoticeVO extends BaseVO {

    private int reservation_Notice_Id;
    private String emp_Id;
    private String reservation_Notice_Title;
    private String reservation_Notice_Content;
    private String reservation_Notice_Create_Date;
    private int reservation_Notice_St;
    private String isType;

    public String getIsType() {
        return isType;
    }

    public void setIsType(String isType) {
        this.isType = isType;
    }

    public int getReservation_Notice_Id() {
        return reservation_Notice_Id;
    }

    public void setReservation_Notice_Id(int reservation_Notice_Id) {
        this.reservation_Notice_Id = reservation_Notice_Id;
    }

    public String getEmp_Id() {
        return emp_Id;
    }

    public void setEmp_Id(String emp_Id) {
        this.emp_Id = emp_Id;
    }

    public String getReservation_Notice_Title() {
        return reservation_Notice_Title;
    }

    public void setReservation_Notice_Title(String reservation_Notice_Title) {
        this.reservation_Notice_Title = reservation_Notice_Title;
    }

    public String getReservation_Notice_Content() {
        return reservation_Notice_Content;
    }

    public void setReservation_Notice_Content(String reservation_Notice_Content) {
        this.reservation_Notice_Content = reservation_Notice_Content;
    }

    public String getReservation_Notice_Create_Date() {
        return reservation_Notice_Create_Date;
    }

    public void setReservation_Notice_Create_Date(String reservation_Notice_Create_Date) {
        this.reservation_Notice_Create_Date = reservation_Notice_Create_Date;
    }

    public int getReservation_Notice_St() {
        return reservation_Notice_St;
    }

    public void setReservation_Notice_St(int reservation_Notice_St) {
        this.reservation_Notice_St = reservation_Notice_St;
    }

}
