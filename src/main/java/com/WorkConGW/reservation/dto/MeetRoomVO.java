package com.WorkConGW.reservation.dto;


import com.WorkConGW.common.dto.BaseVO;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.type.Alias;

import java.util.List;

@Alias("MeetRoomVO")
public class MeetRoomVO extends BaseVO {

    ///////////회의실 VO
    private int meet_Room_Id;
    private String meet_Room_Admin_Id;
    private String meet_Room_No;
    private String meet_Room_Content;
    private int meet_Room_St;
    private int meet_Room_Capacity;
    private String meet_Room_Name;
    private String meet_Room_Create_Date;
    private String meet_Room_Attach_Name;
    private String meet_Room_Attach_Origin;
    private String meet_Room_Attach_Date;
    private String meet_Room_Attach_Type;







    public int getMeet_Room_Id() {
        return meet_Room_Id;
    }

    public void setMeet_Room_Id(int meet_Room_Id) {
        this.meet_Room_Id = meet_Room_Id;
    }

    public String getMeet_Room_Admin_Id() {
        return meet_Room_Admin_Id;
    }

    public void setMeet_Room_Admin_Id(String meet_Room_Admin_Id) {
        this.meet_Room_Admin_Id = meet_Room_Admin_Id;
    }

    public String getMeet_Room_No() {
        return meet_Room_No;
    }

    public void setMeet_Room_No(String meet_Room_No) {
        this.meet_Room_No = meet_Room_No;
    }

    public String getMeet_Room_Content() {
        return meet_Room_Content;
    }

    public void setMeet_Room_Content(String meet_Room_Content) {
        this.meet_Room_Content = meet_Room_Content;
    }

    public int getMeet_Room_St() {
        return meet_Room_St;
    }

    public void setMeet_Room_St(int meet_Room_St) {
        this.meet_Room_St = meet_Room_St;
    }

    public int getMeet_Room_Capacity() {
        return meet_Room_Capacity;
    }

    public void setMeet_Room_Capacity(int meet_Room_Capacity) {
        this.meet_Room_Capacity = meet_Room_Capacity;
    }

    public String getMeet_Room_Name() {
        return meet_Room_Name;
    }

    public void setMeet_Room_Name(String meet_Room_Name) {
        this.meet_Room_Name = meet_Room_Name;
    }

    public String getMeet_Room_Create_Date() {
        return meet_Room_Create_Date;
    }

    public void setMeet_Room_Create_Date(String meet_Room_Create_Date) {
        this.meet_Room_Create_Date = meet_Room_Create_Date;
    }

    public String getMeet_Room_Attach_Name() {
        return meet_Room_Attach_Name;
    }

    public void setMeet_Room_Attach_Name(String meet_Room_Attach_Name) {
        this.meet_Room_Attach_Name = meet_Room_Attach_Name;
    }

    public String getMeet_Room_Attach_Origin() {
        return meet_Room_Attach_Origin;
    }

    public void setMeet_Room_Attach_Origin(String meet_Room_Attach_Origin) {
        this.meet_Room_Attach_Origin = meet_Room_Attach_Origin;
    }

    public String getMeet_Room_Attach_Date() {
        return meet_Room_Attach_Date;
    }

    public void setMeet_Room_Attach_Date(String meet_Room_Attach_Date) {
        this.meet_Room_Attach_Date = meet_Room_Attach_Date;
    }

    public String getMeet_Room_Attach_Type() {
        return meet_Room_Attach_Type;
    }

    public void setMeet_Room_Attach_Type(String meet_Room_Attach_Type) {
        this.meet_Room_Attach_Type = meet_Room_Attach_Type;
    }




    public List<MeetRoomVO> getAttachList() {
        return attachList;
    }

    public void setAttachList(List<MeetRoomVO> attachList) {
        this.attachList = attachList;
    }

    public List<MeetRoomVO> getMeetRoomAttachList() {
        return meetRoomAttachList;
    }

    public void setMeetRoomAttachList(List<MeetRoomVO> meetRoomAttachList) {
        this.meetRoomAttachList = meetRoomAttachList;
    }

    private String MeetRoomReservationSt;


    public MeetRoomVO() {}

    private List<MeetRoomVO> attachList;	// 첨부 파일 목록(저장용)
    private List<MeetRoomVO> meetRoomAttachList;	// 첨부파일 목록(불러오기용)
}
