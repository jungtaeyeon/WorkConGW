package com.WorkConGW.reservation.dao;

import com.WorkConGW.reservation.dto.ReservationComplainVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MeetRoomDAO {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;
    public List<ReservationComplainVO> getAllComplainList(ReservationComplainVO reservationComplainVO) {
            return sqlSessionTemplate.selectList("getAllComplainList",reservationComplainVO);
    }
}



