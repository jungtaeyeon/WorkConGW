package com.WorkConGW.reservation.service;

import com.WorkConGW.reservation.dao.MeetRoomDAO;
import com.WorkConGW.reservation.dto.ReservationComplainVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


@Service
public class MeetRoomService {

    @Autowired
    private MeetRoomDAO meetRoomDAO;
    public List<ReservationComplainVO> getAllComplainList(ReservationComplainVO reservationComplainVO) {
        return meetRoomDAO.getAllComplainList(reservationComplainVO);
    }
}