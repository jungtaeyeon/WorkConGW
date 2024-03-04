package com.WorkConGW.scheduler.controller;

import com.WorkConGW.common.controller.BaseController;
import com.WorkConGW.common.dto.DeptVO;
import com.WorkConGW.common.service.DeptService;
import com.WorkConGW.emp.dto.EmpVO;
import com.WorkConGW.emp.service.EmpService;
import com.WorkConGW.scheduler.command.ScheduleCommand;
import com.WorkConGW.scheduler.dto.ScheduleFormVO;
import com.WorkConGW.scheduler.dto.ScheduleVO;
import com.WorkConGW.scheduler.service.ScheduleService;
import com.google.gson.Gson;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cglib.core.Local;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.lang.model.type.IntersectionType;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.logging.SimpleFormatter;

@Controller
@RequestMapping("/schedule/*")
@Slf4j
public class ScheduleController extends BaseController {


    private final ScheduleService scheduleService;
    private final EmpService empService;
    private final DeptService deptService;


    @Autowired
    public ScheduleController(ScheduleService scheduleService, EmpService empService, DeptService deptService) throws SQLException {
        this.scheduleService = scheduleService;
        this.empService = empService;
        this.deptService = deptService;
    }

    /**
     * 메인 페이지
     *
     * @param model
     * @return View
     */
    @RequestMapping("/main")
    public String main(Model model) {
        model.addAttribute("scheduleFormVO", new ScheduleFormVO()); // 일정전체를 넘김

        //홈에서 ?

        LocalDate today = LocalDate.now(); //오늘날짜
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd"); //날짜형식
        String strToday = today.format(formatter); //오늘날짜를 날짜 형식에 맞게 문자열로 변환


        LocalDate tomorrow = today.plusDays(1); //내일날짜
        String strTomorrow = tomorrow.format(formatter); //내일날짜를 날짜 형식에 맞게 변환

        log.info("strToday={}", strToday);
        log.info("strTomorrow={}", strTomorrow);


        model.addAttribute("today", strToday);
        model.addAttribute("tomorrow", strTomorrow);
        return "schedule/main";
    }

    /**
     * 일정관리 등록 폼
     * Emp, Dept 테스트완성후  구현
     * @param model
     * @param
     * @param session
     * @return
     */
    @GetMapping("/registForm")
    public String registForm(Model model,  HttpSession session) throws Exception {
        log.info("등록 컨트롤러 호출");


        LocalDateTime nowTime = LocalDateTime.now(); //현재시간
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        String strNowTime = nowTime.format(formatter); //현재시간을 문자열로 변환
//        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
//        String strNowTime = nowTime.format(formatter);
        log.info("날짜형식" + strNowTime);


        LocalDateTime oneHourTime = nowTime.plusHours(1); //현재시간+1시간
        String strOneHourTime = oneHourTime.format(formatter); //현재시간+1시간 문자열 변환

        model.addAttribute("sendStart", strNowTime);
        model.addAttribute("sendEnd", strOneHourTime);


        List<DeptVO> deptList = new ArrayList<>();
        List<DeptVO> teamList = new ArrayList<>();
        List<DeptVO> selectDeptList = new ArrayList<>();
        List<DeptVO> selectTeamList = new ArrayList<>();

        // 부서장인지 아닌지 구분하는 코드 필요함
        EmpVO user = (EmpVO) session.getAttribute("loginUser");
        log.info(user.toString());
        log.info(user.getCode_Id());
//        List<DeptVO> selectDeptList = null;
//        List<DeptVO> selectTeamList = null;
        if (user.getCode_Id().equals("c01")) {
            log.info("부서장임");
            DeptVO list = new DeptVO();
            //부서만 조회
            selectTeamList = deptService.selectTeamList(list);
            //팀만 조회
            selectDeptList = deptService.selectDeptList(list);
            log.info(selectTeamList.toString());
            log.info(selectDeptList.toString());

        }

        try {
            log.info("일반사원임");
            DeptVO deptVO = new DeptVO();
            deptVO.setDept_Team_Yn(0); //0이면 부서
            deptList = deptService.selectDeptListByTeamYn(deptVO);
            log.info(deptList.toString());


            deptVO.setDept_Team_Yn(1); //1이면 팀
            teamList = deptService.selectDeptListByTeamYn(deptVO); //팀리스트 담음
            log.info(teamList.toString());

        } catch (Exception e) {
            e.printStackTrace();
        }


        ScheduleCommand scheduleCommand = new ScheduleCommand();
        log.info(selectDeptList.toString());
        log.info(selectTeamList.toString());

        model.addAttribute("scheduleCommand", scheduleCommand);
        model.addAttribute("deptList", deptList);
        model.addAttribute("teamList", teamList);
        model.addAttribute("selectDeptList", selectDeptList);
        model.addAttribute("selectTeamList", selectTeamList);


        return "schedule/regist";
    }

    /**
     * 등록
     * **/


    @ResponseBody
    @PostMapping(value = "/regist")
    public Map<String, Object> regist(@RequestBody ScheduleCommand scheduleCommand, HttpServletRequest request) {
        log.info("regist컨트롤러호출");
        Map<String, Object> dataMap = new HashMap<>();

        HttpSession session = request.getSession();
//        scheduleCommand = (ScheduleCommand)session.getAttribute("loginUser");



        try {
            ScheduleVO schedule = scheduleCommand.toScheduleVO();
            EmpVO empVO = new EmpVO();

            scheduleService.insertSchedule(schedule);
                int scheduleId = schedule.getSchedule_Id();
                dataMap.put("scheduleId", scheduleId);

            if ("S01".equals(schedule.getCode_Id())) {
                log.info("개인일정");
                List<EmpVO> empList = empService.selectEmpList();
                log.info(empList.toString());
                dataMap.put("empList", empList);
            } else if ("S02".equals(schedule.getCode_Id())) {
                log.info("부서일정");
                empVO.setFlag("dept");
                List<EmpVO> empList = empService.selectEmpIdListByDeptId(empVO);
                dataMap.put("empList", empList);
            } else if ("S03".equals(schedule.getCode_Id())) {
                log.info("팀일정");
                empVO.setFlag("team");
                log.info(schedule.getTeam_Id());
                List<EmpVO> empList = empService.selectEmpIdListByDeptId(empVO);
                dataMap.put("teamList", empList);
            }
        } catch (Exception e) {
            log.info("예외처리 발생");
            e.printStackTrace();
        }
        return dataMap;
    }


    /**
     * 일정 삭제
     * @param scheduleVO
     * @return
     */
    @PostMapping("/remove")
    @ResponseBody
    public ResponseEntity<String> remove(ScheduleVO scheduleVO) {
        log.info("삭제 컨트롤러 호출");
        log.info(Integer.toString(scheduleVO.getSchedule_St()));
        log.info(Integer.toString(scheduleVO.getSchedule_Id()));
        ResponseEntity<String> entity = null;

        try {
            scheduleService.deleteSchedule(scheduleVO);
            log.info("삭제DB연결시도");
            entity = new ResponseEntity<>("1", HttpStatus.OK);
        } catch (Exception e) {
            log.info("예외 발생 삭제DB 처리 못함");
            e.printStackTrace();
            entity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return entity;
    }

    /**
     * 일정 리스트
     */
    /**
     *
     * @return
     */
    @PostMapping(value="/list", produces="application/json;charset=utf-8")
    @ResponseBody
    public List<ScheduleCommand> list(@RequestBody ScheduleCommand scheduleCommand, HttpSession session) {
        log.info("List컨트롤러호출");
        log.info(scheduleCommand.toString());
        ScheduleVO schedule = scheduleCommand.toScheduleVO();
        log.info("schedule" + schedule);

        List<ScheduleCommand> scheduleList = new ArrayList<>();

        //부서장인지 확인 필요함(팀 일정을 전부 조회 가능해야함)
        EmpVO user = (EmpVO)session.getAttribute("loginUser");
        if(user.getCode_Id().equals("c01")) {
            log.info("부서장 일정조회");
            scheduleList = scheduleService.selectScheduleAllList(schedule);
            return scheduleList;
        } else {
            try {
                log.info("일반사원 일정조회");
                scheduleList = scheduleService.selectScheduleList(schedule);
                log.info(scheduleList.toString());
            } catch (Exception e) {
                log.info("리스트에러발생");
                e.printStackTrace();
            }
            return scheduleList;
        }
    }

    /**
     * 일정 상세보기
     */
    @RequestMapping("/detail")
    public String detail(ScheduleVO scheduleVO,  Model model) {
        log.info("id={}",scheduleVO.getSchedule_Id() + "=" + Integer.toString(scheduleVO.getSchedule_St()));
        log.info(scheduleVO.getCode_Id());
        ScheduleCommand schedule = null;

            int schedule_Id = scheduleVO.getSchedule_Id();

            schedule = scheduleService.selectScheduleById(schedule_Id);
            log.info(schedule.getType());


        model.addAttribute("schedule", schedule);
        return "schedule/detail";
    }


    @GetMapping("/modifyForm")
    public String modifyForm(Model model, @RequestParam("schedule_Id") int schedule_Id) {
        ScheduleCommand schedule = new ScheduleCommand();

        schedule = scheduleService.selectScheduleById(schedule_Id);

        model.addAttribute("schedule", schedule);
        return "schedule/modify";
    }

    @ResponseBody
    @PostMapping(value="/modify", produces="application/json;charset=utf-8")
    public Object modify(@RequestBody ScheduleCommand scheduleCommand, HttpServletRequest request) throws Exception{
        log.info("수정컨트롤러 호출");
        log.info(scheduleCommand.getId());
        Map<String, Object> dataMap = new HashMap<String,Object>();

        ScheduleVO schedule = scheduleCommand.toScheduleVO();
        EmpVO empVO = new EmpVO(); // 부서 또는 팀 이용 직원 조회를 위한 vo 생성. service에서 loginUser의 deptId 심어줄 예정
        schedule.setSchedule_St(1);
        scheduleService.updateSchedule(schedule);
        int scheduleId = schedule.getSchedule_Id();
        log.info(Integer.toString(scheduleId));
        dataMap.put("scheduleId", scheduleId);


        if("S01".equals(schedule.getCode_Id())) {
            List<EmpVO> empList = empService.selectEmpList();
            dataMap.put("empList", empList);
        }else if("S02".equals(schedule.getCode_Id())) {
            empVO.setFlag("dept");
            List<EmpVO> empList = empService.selectEmpIdListByDeptId(empVO);
            dataMap.put("empList", empList);
        }else if("S03".equals(schedule.getCode_Id())) {
            empVO.setFlag("team");
            List<EmpVO> empList = empService.selectEmpIdListByDeptId(empVO);
            dataMap.put("empList", empList);
        }


        return dataMap;
    }





}








