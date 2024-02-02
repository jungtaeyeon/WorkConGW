package com.WorkConGW.scheduler.service;

import com.WorkConGW.emp.dto.EmpVO;
import com.WorkConGW.scheduler.command.ScheduleCommand;
import com.WorkConGW.scheduler.dao.ScheduleDAO;
import com.WorkConGW.scheduler.dto.ScheduleVO;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
public class ScheduleService {

    private ScheduleDAO scheduleDAO;

    @Autowired
    public ScheduleService(ScheduleDAO scheduleDAO) {
        this.scheduleDAO = scheduleDAO;
    }

    /**
     * 일정 리스트 조회
     * @param scheduleVO
     * @return
     */
    public List<ScheduleCommand> selectScheduleList(ScheduleVO scheduleVO) {
        List<ScheduleVO> scheduleList = scheduleDAO.selectScheduleListByDate(scheduleVO);
        List<ScheduleCommand> scheduleCommandList = new ArrayList<>();

        for(ScheduleVO schedule : scheduleList) {
            scheduleCommandList.add(schedule.toScheduleCommand());
        }
        return scheduleCommandList;
    }

    /**
     * 일정 상세조회
     */
    public ScheduleCommand selectScheduleById(int id) {
        log.info("서비스 연결");
        ScheduleVO scheduleVO = scheduleDAO.selectScheduleById(id);
        log.info(scheduleVO.toString());
        ScheduleCommand command = scheduleVO.toScheduleCommand();
        return command;
    }

    /**
     * 일정 등록
     * @param scheduleVO
     */
    public void insertSchedule(ScheduleVO scheduleVO) {
        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = servletRequestAttributes.getRequest().getSession(true);
        EmpVO emp = (EmpVO) session.getAttribute("loginUser");

        String empId = emp.getEmp_Id();
        log.info(empId);
        scheduleVO.setSchedule_Writer_Id(empId); //작성자 사원번호에 사원번호 입력
        log.info(scheduleVO.getSchedule_Writer_Id());

        scheduleDAO.insertSchedule(scheduleVO);
    }

    /**
     * 일정 삭제
     */
    public void deleteSchedule(ScheduleVO scheduleVO) {
        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = servletRequestAttributes.getRequest().getSession(true);
        EmpVO emp = (EmpVO) session.getAttribute("loginUser");
        log.info(emp.toString());

        String empId = "e001";
        scheduleVO.setSchedule_Writer_Id(empId);
        log.info(Integer.toString(scheduleVO.getSchedule_St()));
        scheduleDAO.deleteSchedule(scheduleVO);
    }

}
