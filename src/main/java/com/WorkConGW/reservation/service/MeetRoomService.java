package com.WorkConGW.reservation.service;

import com.WorkConGW.reservation.dao.MeetRoomDAO;
import com.WorkConGW.reservation.dto.MeetRoomReservationVO;
import com.WorkConGW.reservation.dto.MeetRoomVO;
import com.WorkConGW.reservation.dto.ReservationComplainVO;
import com.WorkConGW.reservation.dto.ReservationNoticeVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;


@Service
@Slf4j
public class MeetRoomService {

    @Autowired
    private MeetRoomDAO meetRoomDAO;
    public List<ReservationComplainVO> getAllComplainList(ReservationComplainVO reservationComplainVO) {
        return meetRoomDAO.getAllComplainList(reservationComplainVO);
    }

    public List<MeetRoomVO> getAllMeetRoomList()throws SQLException {
        List<MeetRoomVO> allRoomList = meetRoomDAO.getAllMeetRoomList();
        return allRoomList;
    }

    public List<MeetRoomVO> notUseRoomList(MeetRoomVO searchMeetRoomVO)throws SQLException{
        List<MeetRoomVO> meetRoomList = meetRoomDAO.notUseRoomList(searchMeetRoomVO);
        return meetRoomList;
    }

    public List<ReservationNoticeVO> getSearchReservationNotice(ReservationNoticeVO searchReservationNoticeVO)throws SQLException {
        List<ReservationNoticeVO> reservationNoticeList = meetRoomDAO.getReservationNoticeList(searchReservationNoticeVO);
        return reservationNoticeList;
    }


    public void registMeetRoom(MeetRoomVO meetRoomVO) throws Exception {
        meetRoomVO.setMeet_Room_St(1);
        meetRoomDAO.registMeetRoom(meetRoomVO);
    }

    public void modifyMeetRoom(MeetRoomVO meetRoomVO) throws SQLException{
        meetRoomDAO.modifyMeetRoom(meetRoomVO);
    }

    public List<MeetRoomVO> meetRoomList(MeetRoomVO searchMeetRoomVO)throws SQLException{
        List<MeetRoomVO> meetRoomList = meetRoomDAO.getMeetRoomList(searchMeetRoomVO);
        return meetRoomList;
    }

    public String getDept(String empId)throws SQLException {

        String deptId = meetRoomDAO.getDept(empId);
        return deptId;
    }

    public int selectMeetRoomListTotalCount(MeetRoomVO searchMeetRoomVO)throws SQLException {
        int cnt = meetRoomDAO.selectMeetRoomListTotalCount(searchMeetRoomVO);
        return cnt;
    }

    public List<MeetRoomReservationVO> getSearchReservation(MeetRoomReservationVO searchMeetRoomVO)throws SQLException {
        List<MeetRoomReservationVO> reservationList = meetRoomDAO.getSearchReservation(searchMeetRoomVO);
        return reservationList;
    }

    public List<MeetRoomReservationVO> getSearchReservationAll(MeetRoomReservationVO searchAllMeetRoomVO)throws SQLException {
        List<MeetRoomReservationVO> reservationAllList = meetRoomDAO.getSearchReservationAll(searchAllMeetRoomVO);
        return reservationAllList;
    }

    public MeetRoomVO getMeetRoomVOForDetail(int meetRoomId)throws SQLException {
        MeetRoomVO roomVO = meetRoomDAO.getMeetRoomVOForDetail(meetRoomId);
        return roomVO;
    }

    public void remove(int meetRoomId)throws SQLException {
        meetRoomDAO.remove(meetRoomId);
    }

    public List<MeetRoomVO> searchRoom(Map<String, Object> data) throws Exception {
        List<MeetRoomVO> roomList = meetRoomDAO.searchRoom(data);
        return roomList;

    }

    public MeetRoomVO searchRoomInfo(int roomId) throws SQLException{
        MeetRoomVO room = meetRoomDAO.searchRoomInfo(roomId);
        return room;
    }

    public void makeReservation(MeetRoomReservationVO meetRoomReservationVO)throws SQLException {
        log.info("예약시도");
        log.info(meetRoomReservationVO.toString());
        meetRoomDAO.makeReservation(meetRoomReservationVO);
        log.info(meetRoomReservationVO.toString());
    }


    public MeetRoomReservationVO getReservationVOForDetail(int reservationId)throws SQLException {
        MeetRoomReservationVO roomVO = meetRoomDAO.getMeetRoomReservationVOForDetail(reservationId);
        return roomVO;
    }

    public void reservationRemove(int meetRoomReservationId) throws SQLException{
        meetRoomDAO.reservationRemove(meetRoomReservationId);
    }

    public int selectreservationNoticeListTotalCount(ReservationNoticeVO searchReservationNoticeVO)throws SQLException {
        int cnt = meetRoomDAO.selectreservationNoticeListTotalCount(searchReservationNoticeVO);
        return cnt;
    }

    public List<ReservationComplainVO> getMyComplainList(ReservationComplainVO searchReservationComplainVO)throws SQLException {
        List<ReservationComplainVO> complainList = meetRoomDAO.getComplainList(searchReservationComplainVO);
        return complainList;
    }

    public int selectreservationComplainListTotalCount(ReservationComplainVO searchReservationComplainVO)throws SQLException {
        int cnt = meetRoomDAO.selectreservationComplainListTotalCount(searchReservationComplainVO);
        return cnt;
    }

    public void registComplain(ReservationComplainVO reservationComplainVO)throws SQLException {

        meetRoomDAO.registComplain(reservationComplainVO);

    }

    public void removeComplain(int removeId)throws SQLException {
        meetRoomDAO.removeComplain(removeId);
    }

    public ReservationComplainVO getComplainVOForDetail(ReservationComplainVO reservationComplainVO) throws SQLException{
        return meetRoomDAO.selectComplainForDetail(reservationComplainVO);
    }

    public void registNotice(ReservationNoticeVO reservationNoticeVO)throws SQLException {
        meetRoomDAO.registNotice(reservationNoticeVO);
        log.info(reservationNoticeVO.toString());
    }

    public ReservationNoticeVO getNoticeVOForDetail(ReservationNoticeVO reservationNoticeVO)throws SQLException {
        ReservationNoticeVO noticeVO =  meetRoomDAO.getNoticeVOForDetail(reservationNoticeVO);
        return noticeVO;
    }

    public void removeNotice(int reservationNoticeId) throws SQLException{
        meetRoomDAO.removeNotice(reservationNoticeId);

    }







}