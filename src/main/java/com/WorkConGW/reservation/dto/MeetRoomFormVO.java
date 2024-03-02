package com.WorkConGW.reservation.dto;


import com.WorkConGW.common.command.FileUploadCommand;

public class MeetRoomFormVO {

    private MeetRoomVO meetRoomVO;
    private MeetRoomVO searchMeetRoomVO;
    private FileUploadCommand fileUploadCommand;

    private MeetRoomReservationVO meetRoomReservationVO;
    private MeetRoomReservationVO searchMeetRoomReservationVO;

    private ReservationNoticeVO reservationNoticeVO;
    private ReservationNoticeVO searchReservationNoticeVO;

    private ReservationComplainVO reservationComplainVO;
    private ReservationComplainVO searchReservationComplainVO;

    public MeetRoomFormVO() {
        this.meetRoomVO = new MeetRoomVO();
        this.searchMeetRoomVO = new MeetRoomVO();

        this.meetRoomReservationVO = new MeetRoomReservationVO();
        this.searchMeetRoomReservationVO = new MeetRoomReservationVO();

        this.reservationNoticeVO = new ReservationNoticeVO();
        this.searchReservationNoticeVO = new ReservationNoticeVO();

        this.reservationComplainVO = new ReservationComplainVO();
        this.searchReservationComplainVO = new ReservationComplainVO();

        this.fileUploadCommand = new FileUploadCommand();
    }

    public MeetRoomVO getMeetRoomVO() {
        return meetRoomVO;
    }

    public void setMeetRoomVO(MeetRoomVO meetRoomVO) {
        this.meetRoomVO = meetRoomVO;
    }

    public MeetRoomVO getSearchMeetRoomVO() {
        return searchMeetRoomVO;
    }

    public void setSearchMeetRoomVO(MeetRoomVO searchMeetRoomVO) {
        this.searchMeetRoomVO = searchMeetRoomVO;
    }

    public FileUploadCommand getFileUploadCommand() {
        return fileUploadCommand;
    }

    public void setFileUploadCommand(FileUploadCommand fileUploadCommand) {
        this.fileUploadCommand = fileUploadCommand;
    }

    public MeetRoomReservationVO getMeetRoomReservationVO() {
        return meetRoomReservationVO;
    }

    public void setMeetRoomReservationVO(MeetRoomReservationVO meetRoomReservationVO) {
        this.meetRoomReservationVO = meetRoomReservationVO;
    }

    public MeetRoomReservationVO getSearchMeetRoomReservationVO() {
        return searchMeetRoomReservationVO;
    }

    public void setSearchMeetRoomReservationVO(MeetRoomReservationVO searchMeetRoomReservationVO) {
        this.searchMeetRoomReservationVO = searchMeetRoomReservationVO;
    }

    public ReservationNoticeVO getReservationNoticeVO() {
        return reservationNoticeVO;
    }

    public void setReservationNoticeVO(ReservationNoticeVO reservationNoticeVO) {
        this.reservationNoticeVO = reservationNoticeVO;
    }

    public ReservationNoticeVO getSearchReservationNoticeVO() {
        return searchReservationNoticeVO;
    }

    public void setSearchReservationNoticeVO(ReservationNoticeVO searchReservationNoticeVO) {
        this.searchReservationNoticeVO = searchReservationNoticeVO;
    }

    public ReservationComplainVO getReservationComplainVO() {
        return reservationComplainVO;
    }

    public void setReservationComplainVO(ReservationComplainVO reservationComplainVO) {
        this.reservationComplainVO = reservationComplainVO;
    }

    public ReservationComplainVO getSearchReservationComplainVO() {
        return searchReservationComplainVO;
    }

    public void setSearchReservationComplainVO(ReservationComplainVO searchReservationComplainVO) {
        this.searchReservationComplainVO = searchReservationComplainVO;
    }


}
