package com.WorkConGW.scheduler.dao;


import com.WorkConGW.scheduler.dto.ScheduleVO;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.annotations.Mapper;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Slf4j
public class ScheduleDAO {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate= null;


    /**
     * 일정 조회를 위한 일정 리스트 조회
     */
    public List<ScheduleVO> selectScheduleListByDate(ScheduleVO scheduleVO) {
        return sqlSessionTemplate.selectList("selectScheduleListByDate", scheduleVO);
    }

    /**
     * pk로 스케줄 상세정보 조회
     */
    public ScheduleVO selectScheduleById(int id) {
        log.info("DAO 연결");
        log.info(String.valueOf(id));
        List<ScheduleVO> selectScheduleById = sqlSessionTemplate.selectList("selectScheduleById", id);
        log.info("ggg");
        ScheduleVO scheduleVO = selectScheduleById.get(0);
        log.info(scheduleVO.toString());
        return scheduleVO;
    }

    /**
     * 일정 등록
     */
    public void insertSchedule(ScheduleVO scheduleVO) {
        log.info("insertDao");
        sqlSessionTemplate.insert("insertSchedule", scheduleVO);
        log.info("성공");
    }

    /**
     * 일정 수정
     */
    public void updateSchedule(ScheduleVO scheduleVO) {
        sqlSessionTemplate.update("updateSchedule", scheduleVO);
    }

    /**
     * 일정 삭제
     * 삭제는 delete가 아니라 update로 해서 schedule_st=0 (일정종료) 로 바꾼다
     * update -> delete로 ...?
     */
    public void deleteSchedule(ScheduleVO scheduleVO) {
        sqlSessionTemplate.delete("deleteSchedule", scheduleVO);
    }
}
