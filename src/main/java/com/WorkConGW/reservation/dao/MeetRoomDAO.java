package com.WorkConGW.reservation.dao;

import com.WorkConGW.reservation.dto.MeetRoomReservationVO;
import com.WorkConGW.reservation.dto.MeetRoomVO;
import com.WorkConGW.reservation.dto.ReservationComplainVO;
import com.WorkConGW.reservation.dto.ReservationNoticeVO;
import com.mchange.v2.log.MLogInitializationException;
import lombok.extern.slf4j.Slf4j;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Repository
@Slf4j
public class MeetRoomDAO {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    public List<MeetRoomVO> getAllMeetRoomList()throws SQLException {
        List<MeetRoomVO> allRoomList = sqlSessionTemplate.selectList("getAllMeetRoomList");
        return allRoomList;
    }


    public List<ReservationNoticeVO> getReservationNoticeList(ReservationNoticeVO searchReservationNoticeVO)throws SQLException {
        List<ReservationNoticeVO> reservationNoticeList = sqlSessionTemplate.selectList("getReservationNoticeList", searchReservationNoticeVO);
        return reservationNoticeList;
    }

    public List<MeetRoomVO> notUseRoomList(MeetRoomVO searchMeetRoomVO)throws SQLException {
        List<MeetRoomVO>  meetRoomList = sqlSessionTemplate.selectList("notUseRoomList", searchMeetRoomVO);
        return meetRoomList;
    }


    public void registMeetRoom(MeetRoomVO meetRoomVO) throws  Exception{
        sqlSessionTemplate.insert("registMeetRoom", meetRoomVO);
    }

    public void modifyMeetRoom(MeetRoomVO meetRoomVO)throws SQLException {
        log.info(meetRoomVO.toString());
        sqlSessionTemplate.update("modifyMeetRoom", meetRoomVO);
    }

    public List<MeetRoomVO> getMeetRoomList(MeetRoomVO searchMeetRoomVO)throws SQLException {
        List<MeetRoomVO> meetRoomList = sqlSessionTemplate.selectList("getMeetRoomList", searchMeetRoomVO);
        return meetRoomList;
    }


    public List<ReservationComplainVO> getAllComplainList(ReservationComplainVO reservationComplainVO) {
            return sqlSessionTemplate.selectList("getAllComplainList",reservationComplainVO);
    }

    public String getDept(String empId) {
       String deptId = sqlSessionTemplate.selectOne("getDept", empId);
       return deptId;
    }

    public int selectMeetRoomListTotalCount(MeetRoomVO searchMeetRoomVO)throws SQLException {
        int count = sqlSessionTemplate.selectOne("selectMeetRoomListTotalCount", searchMeetRoomVO);
        return count;
    }

    public List<MeetRoomReservationVO> getSearchReservation(MeetRoomReservationVO searchMeetRoomVO)throws SQLException {
        List<MeetRoomReservationVO> meetRoomReservationList = sqlSessionTemplate.selectList("getSearchReservation", searchMeetRoomVO);
        return meetRoomReservationList;
    }

    public List<MeetRoomReservationVO> getSearchReservationAll(MeetRoomReservationVO searchAllMeetRoomVO) throws SQLException {
        List<MeetRoomReservationVO> meetRoomReservationAllList = sqlSessionTemplate.selectList("getAllReservationList", searchAllMeetRoomVO);
        return meetRoomReservationAllList;
    }

    public MeetRoomVO getMeetRoomVOForDetail(int meetRoomId)throws SQLException {
        List<MeetRoomVO> meetRoomVObyId = sqlSessionTemplate.selectList("getMeetRoomVOForDetail", meetRoomId);
        MeetRoomVO meetRoomVO = meetRoomVObyId.get(0);
        return meetRoomVO;
    }

    public void remove(int meetRoomId)throws SQLException {
        sqlSessionTemplate.delete("remove", meetRoomId);
    }

    public List<MeetRoomVO> searchRoom(Map<String, Object> data) throws Exception {
        List<MeetRoomVO> room =  sqlSessionTemplate.selectList("searchRoom", data);
        return room;
    }

    public MeetRoomVO searchRoomInfo(int roomId) {
        List<MeetRoomVO> roomList = sqlSessionTemplate.selectList("searchRoomInfo", roomId);
        log.info(roomList.toString());
        MeetRoomVO room = roomList.get(0);
        return room;
    }

    public void makeReservation(MeetRoomReservationVO meetRoomReservationVO)throws SQLException {
        log.info("예약생성다오");
        sqlSessionTemplate.insert("makeReservation", meetRoomReservationVO);
    }

    public MeetRoomReservationVO getMeetRoomReservationVOForDetail(int reservationId)throws SQLException {
        log.info("디테일다오");
        List<MeetRoomReservationVO> meetRoomReservationById =  sqlSessionTemplate.selectList("getMeetRoomReservationVOForDetail", reservationId);
        log.info(meetRoomReservationById.toString());

        MeetRoomReservationVO meetRoomReservationVO = meetRoomReservationById.get(0);
        return meetRoomReservationVO;
    }

    public void reservationRemove(int meetRoomReservationId)throws SQLException {
        log.info(Integer.toString(meetRoomReservationId));
        sqlSessionTemplate.update("reservationRemove", meetRoomReservationId);
    }

    public int selectreservationNoticeListTotalCount(ReservationNoticeVO searchReservationNoticeVO)throws SQLException {
        int cnt = sqlSessionTemplate.selectOne("selectreservationNoticeListTotalCount", searchReservationNoticeVO);
        return cnt;
    }

    public List<ReservationComplainVO> getComplainList(ReservationComplainVO searchReservationComplainVO)throws SQLException {
        log.info(searchReservationComplainVO.toString());
        List<ReservationComplainVO> reservationComplainVOList = sqlSessionTemplate.selectList("getComplainList", searchReservationComplainVO);
        log.info(reservationComplainVOList.toString());
        return reservationComplainVOList;
    }

    public int selectreservationComplainListTotalCount(ReservationComplainVO searchReservationComplainVO)throws SQLException {
        int cnt = sqlSessionTemplate.selectOne("selectreservationComplainListTotalCount", searchReservationComplainVO);
        return cnt;
    }

    public void registComplain(ReservationComplainVO reservationComplainVO)throws SQLException {
        sqlSessionTemplate.insert("registComplain", reservationComplainVO);
    }

    public void removeComplain(int removeId)throws SQLException {
        sqlSessionTemplate.update("removeComplain", removeId);
    }

    public ReservationComplainVO selectComplainForDetail(ReservationComplainVO reservationComplainVO) throws SQLException {
        ReservationComplainVO complainVO = sqlSessionTemplate.selectOne("selectComplainForDetail", reservationComplainVO);
        return complainVO;
    }

    public void registNotice(ReservationNoticeVO reservationNoticeVO)throws SQLException {
        sqlSessionTemplate.insert("registNotice", reservationNoticeVO);
    }

    public ReservationNoticeVO getNoticeVOForDetail(ReservationNoticeVO reservationNoticeVO)throws SQLException {
        ReservationNoticeVO noticeVO =  sqlSessionTemplate.selectOne("getNoticeVOForDetail", reservationNoticeVO);
        log.info(noticeVO.toString());
        return noticeVO;
    }

    public void removeNotice(int reservationNoticeId)throws SQLException {
        sqlSessionTemplate.update("removeNotice", reservationNoticeId);
    }


}



