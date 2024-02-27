package com.WorkConGW.scheduler.command;

import com.WorkConGW.common.dto.BaseVO;
import com.WorkConGW.scheduler.dto.ScheduleVO;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.util.StringUtils;

import java.time.DateTimeException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeFormatterBuilder;
import java.time.format.DateTimeParseException;

@Data
public class ScheduleCommand extends BaseVO {

    /**
     * command - 입력받는 값을 담기 위한 VO -> ScheduleVO로 가공하는 작업 필요
     */

    private String id;
    private String title;
    private String content;
    private String start;
    private String end;
    private String imp; //중요도
    private String username;
    private String location;
    private String backgroundColor;
    private String type;
    private String color = "#ffffff";
    private String dept_Id;
    private String team_Id;

    //검색 조건
    private String searchImportant;
    private String searchType;




    /**
     * VO 변경
     */
    public ScheduleVO toScheduleVO() {
        ScheduleVO scheduleVO = new ScheduleVO();

        //중요도 변환
        int numImportant = 0;
        if (StringUtils.hasText(imp) && imp.equals("true")) {
            numImportant = 1;
            backgroundColor = "#D25565";
        }

        //String null, "" 공백 유효성 체크
        if(StringUtils.hasText(start) || StringUtils.hasText(end)) {
            DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

            LocalDate today = LocalDate.now();
            LocalDate endDay = null;

            //종료일시 유휴성 체크
            if (end != null && dateCheck(end, "yyyy-MM-dd")) {
                endDay = LocalDate.parse(end, formatter1);
            } else if (end != null && dateCheck(end, "yyyy-MM-dd HH:mm")) {
                endDay = LocalDate.parse(end, formatter2);
            }
        }

        if(StringUtils.hasText(type)) {
            switch (type) {
                case "S01":
                    backgroundColor = "#74c0fc";
                    break;
                case "S02":
                    backgroundColor = "#a9e34b";
                    break;
                case "S03":
                    backgroundColor = "#b070db";
                    break;
            }
        }

        // 중요도 검색할때 씀
        int setImportant = 0;
        if (StringUtils.hasText(searchImportant) && searchImportant.equals("true")) {
            setImportant = 1;
        } else if (StringUtils.hasText(searchImportant) && searchImportant.equals("false")) {
            setImportant = 0;
        }

        if(StringUtils.hasText(id)) {
            scheduleVO.setSchedule_Id(Integer.parseInt(id));
        }
        scheduleVO.setSchedule_Title(title);
        scheduleVO.setSchedule_Content(content);
        scheduleVO.setSchedule_Start_Dt(start);
        scheduleVO.setSchedule_End_Dt(end);
        scheduleVO.setCode_Id(type);
        scheduleVO.setSchedule_Writer_Id(username);
        scheduleVO.setSchedule_Imp(numImportant);
        scheduleVO.setSchedule_Location(location);
        scheduleVO.setSchedule_Background_Color(backgroundColor);
        scheduleVO.setSearchType(searchType);
        scheduleVO.setSearchImportant(setImportant);
        scheduleVO.setSearchCondition(super.getSearchCondition());
        scheduleVO.setSearchKeyword(super.getSearchKeyword());
        scheduleVO.setDept_Id(dept_Id);
        scheduleVO.setTeam_Id(team_Id);

        return scheduleVO;
    }



    public boolean dateCheck(String date, String format) {
        if(date == null) return false;

        try {
            LocalDate.from(LocalDate.parse(date, DateTimeFormatter.ofPattern(format)));
            return  true;
        } catch (DateTimeParseException e) {
            return false;
        }
    }
}
