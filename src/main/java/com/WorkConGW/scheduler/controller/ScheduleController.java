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
     * @param from
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
    public String registForm(Model model,  HttpSession session) {
        log.info("등록 컨트롤러 호출");


            LocalDateTime nowTime = LocalDateTime.now(); //현재시간
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
            String strNowTime = nowTime.format(formatter); //현재시간을 문자열로 변환

            LocalDateTime oneHourTime = nowTime.plusHours(1); //현재시간+1시간
            String strOneHourTime = oneHourTime.format(formatter); //현재시간+1시간 문자열 변환

            model.addAttribute("sendStart", strNowTime);
            model.addAttribute("sendEnd", strOneHourTime);


        List<DeptVO> deptList = new ArrayList<>();
        List<DeptVO> teamList = new ArrayList<>();

        try {
            DeptVO deptVO = new DeptVO();
            deptVO.setDept_Team_Yn("N"); //N이면 부서
            deptList = deptService.selectDeptListByTeamYn(deptVO);
            log.info(deptList.toString());


            deptVO.setDept_Team_Yn("Y"); //Y이면 팀
            teamList = deptService.selectDeptListByTeamYn(deptVO); //팀리스트 담음
            log.info(teamList.toString());

        } catch (Exception e) {
            e.printStackTrace();
        }
        ScheduleCommand scheduleCommand = new ScheduleCommand();

        model.addAttribute("scheduleCommand", scheduleCommand);
        model.addAttribute("deptList", deptList);
        model.addAttribute("teamList", teamList);


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
        log.info(scheduleCommand.toString());


        try {
            ScheduleVO schedule = scheduleCommand.toScheduleVO();
            EmpVO empVO = new EmpVO();

                scheduleService.insertSchedule(schedule);
                int scheduleId = schedule.getSchedule_Id();
                dataMap.put("scheduleId", scheduleId);

            if ("S02".equals(schedule.getCode_Id())) {
                log.info("개인일정");
                List<EmpVO> empList = empService.selectEmpList();
                log.info(empList.toString());
                dataMap.put("empList", empList);
            } else if ("S03".equals(schedule.getCode_Id())) {
                log.info("부서일정");
                empVO.setFlag("dept");
                List<EmpVO> empList = empService.selectEmpIdListByDeptId(empVO);
                dataMap.put("empList", empList);
            } else if ("S04".equals(schedule.getCode_Id())) {
                log.info("팀일정");
                empVO.setFlag("team");
                List<EmpVO> empList = empService.selectEmpIdListByDeptId(empVO);
                dataMap.put("empList", empList);
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
    public List<ScheduleCommand> list(@RequestBody ScheduleCommand scheduleCommand) {
        log.info("List컨트롤러호출");
        ScheduleVO schedule = scheduleCommand.toScheduleVO();

        List<ScheduleCommand> scheduleList = new ArrayList<>();

        try {
            scheduleList = scheduleService.selectScheduleList(schedule);
            log.info(scheduleList.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return scheduleList;
    }
        /** get 방식 - 개발자가 쿼리스트링 start,end를 입력하지 않아도 풀캘린더 내부에서 자동으로 넘긴다
         * 풀캘린더는 내부적으로 현재 화면에 보이는 기간(start와 end)을 파악하고,
         * 이를 서버로 전송하여 해당 기간에 해당하는 이벤트를 요청합니다.
         * 이를 통해 개발자가 별도로 쿼리스트링을 생성하고 추가하지 않아도 풀캘린더는 필요한 정보를 서버에게 전달할 수 있습니다.
         * 이는 일반적으로 풀캘린더의 기본 동작입니다.
        log.info("리스트 컨트롤러 호출");
        log.info(start);
        log.info(end);
        ScheduleVO schedule = new ScheduleVO();
        schedule.setSchedule_Start_Dt(start);
        schedule.setSchedule_End_Dt(end);

        List<ScheduleCommand> scheduleList = new ArrayList<>();
            scheduleList = scheduleService.selectScheduleList(schedule);
            return scheduleList;
         **/

        /** 값 테스트(DB X)
        List<Map<String,Object>> mList = new ArrayList<>();
        Map<String, Object> rmap = new HashMap<>();

        rmap.put("title", "휴가");
        rmap.put("start", "2024-01-02");
        rmap.put("end", "2024-01-05");
        mList.add(rmap);

        rmap = new HashMap<>();
        rmap.put("title", "게시판구현");
        rmap.put("start", "2024-01-06");
        rmap.put("end", "2024-01-07");
        mList.add(rmap);

        rmap = new HashMap<>();
        rmap.put("title", "공지사항구현");
        rmap.put("start", "2024-01-08");
        rmap.put("end", "2024-01-11");
        mList.add(rmap);

        Gson gson = new Gson();
        String temp = gson.toJson(mList);
        return temp;
        **/





    /**
     * 일정 상세보기
     */
    @RequestMapping("/detail")
    public String detail(ScheduleVO scheduleVO,  Model model) {
        log.info("id={}",scheduleVO.getSchedule_Id() + "=" + Integer.toString(scheduleVO.getSchedule_St()));
        log.info(scheduleVO.getSchedule_Create_Dt());
        ScheduleCommand schedule = null;

            int schedule_Id = scheduleVO.getSchedule_Id();

            schedule = scheduleService.selectScheduleById(schedule_Id);


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

    /**
     * modify 미구현
     * emp, dept 필요
     */





}







