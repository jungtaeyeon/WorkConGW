package com.WorkConGW.scheduler.dao;


import com.WorkConGW.scheduler.dto.ScheduleVO;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.annotations.Mapper;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

@Repository
@Slf4j
public class ScheduleDAO {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate= null;


    /**
     * 일정 조회를 위한 일정 리스트 조회
     */
    public List<ScheduleVO> selectScheduleListByDate(ScheduleVO scheduleVO) {
        log.info("scheduleDao연결");
        return sqlSessionTemplate.selectList("selectScheduleListByDate", scheduleVO);
    }

    /**
     * 부서장 일정 조회를 위한 리스트
     * @param scheduleVO
     * @return
     */
    public List<ScheduleVO> selectScheduleAllList(ScheduleVO scheduleVO) {
        log.info("부서장리스트dao연결");
        log.info(scheduleVO.getSearchKeyword());
        log.info(scheduleVO.getSearchType());
        log.info(scheduleVO.getSearchCondition());
        log.info(Integer.toString(scheduleVO.getSearchImportant()));
         List<ScheduleVO> schedule =  sqlSessionTemplate.selectList("selectScheduleAllList", scheduleVO);
        log.info(schedule.toString());
         return schedule;
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
        log.info(scheduleVO.getCode_Id());
        log.info(scheduleVO.getDept_Id());
//        log.info(scheduleVO.getTeam_Id());
        sqlSessionTemplate.insert("insertSchedule", scheduleVO);
        log.info("성공");
    }

    public void insertApprovalSchedule(Map<String, Object> dataMap) {
        log.info(dataMap.toString());
        log.info("여기타냐? 전결일정인서트");
        ScheduleVO scheduleVO = new ScheduleVO();
        String empId = (String)dataMap.get("empName");
        String startDt = (String)dataMap.get("startDt");

        String endDtString = (String)dataMap.get("endDt");
        LocalDate endDate = LocalDate.parse(endDtString);
        LocalDateTime endDt = endDate.atStartOfDay().plusHours(23);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        String modfiedEndDt = endDt.format(formatter);
        log.info(endDtString);
        log.info(modfiedEndDt);

        String deptId = "d099";
        String codeId = "S01";
        String title = "연차";
        scheduleVO.setSchedule_Writer_Id(empId);
        scheduleVO.setSchedule_Start_Dt(startDt);
        scheduleVO.setSchedule_End_Dt(modfiedEndDt);
        scheduleVO.setDept_Id(deptId);
        scheduleVO.setCode_Id(codeId);
        scheduleVO.setSchedule_Title(title);
        log.info(scheduleVO.toString());
        sqlSessionTemplate.insert("insertApprovalSchedule", scheduleVO);
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
