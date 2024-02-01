package com.WorkConGW.scheduler.dto;


import com.WorkConGW.common.dto.BaseVO;
import com.WorkConGW.scheduler.command.ScheduleCommand;
import org.apache.ibatis.type.Alias;


@Alias("ScheduleVO")

public class ScheduleVO extends BaseVO {

    private int schedule_Id;
    private String schedule_Title;
    private String schedule_Content;
    private String schedule_Create_Dt; //생성날짜
    private String schedule_Start_Dt; //시작날짜
    private String schedule_End_Dt; //종료날짜
    private int schedule_Imp;
    private int schedule_St; //상태
    private String schedule_Writer_Id;
    private String schedule_Location;
    private String code_Id;
    private String dept_Id;
    private String schedule_Background_Color;
    private String str_Code_ScheduleId; //분류코드를 문자로 변환하기 위함
    private String team_Id;

    public ScheduleVO(int schedule_Id, String schedule_Title, String schedule_Content, String schedule_Create_Dt, String schedule_Start_Dt, String schedule_End_Dt, int schedule_Imp, int schedule_St, String schedule_Writer_Id, String schedule_Location, String code_Id, String dept_Id, String schedule_Background_Color, String str_Code_ScheduleId, String team_Id, String search_Type, int search_Important) {
        this.schedule_Id = schedule_Id;
        this.schedule_Title = schedule_Title;
        this.schedule_Content = schedule_Content;
        this.schedule_Create_Dt = schedule_Create_Dt;
        this.schedule_Start_Dt = schedule_Start_Dt;
        this.schedule_End_Dt = schedule_End_Dt;
        this.schedule_Imp = schedule_Imp;
        this.schedule_St = schedule_St;
        this.schedule_Writer_Id = schedule_Writer_Id;
        this.schedule_Location = schedule_Location;
        this.code_Id = code_Id;
        this.dept_Id = dept_Id;
        this.schedule_Background_Color = schedule_Background_Color;
        this.str_Code_ScheduleId = str_Code_ScheduleId;
        this.team_Id = team_Id;
        this.search_Type = search_Type;
        this.search_Important = search_Important;
    }

    public ScheduleVO() {
    }

    public int getSchedule_Id() {
        return schedule_Id;
    }

    public void setSchedule_Id(int schedule_Id) {
        this.schedule_Id = schedule_Id;
    }

    public String getSchedule_Title() {
        return schedule_Title;
    }

    public void setSchedule_Title(String schedule_Title) {
        this.schedule_Title = schedule_Title;
    }

    public String getSchedule_Content() {
        return schedule_Content;
    }

    public void setSchedule_Content(String schedule_Content) {
        this.schedule_Content = schedule_Content;
    }

    public String getSchedule_Create_Dt() {
        return schedule_Create_Dt;
    }

    public void setSchedule_Create_Dt(String schedule_Create_Dt) {
        this.schedule_Create_Dt = schedule_Create_Dt;
    }

    public String getSchedule_Start_Dt() {
        return schedule_Start_Dt;
    }

    public void setSchedule_Start_Dt(String schedule_Start_Dt) {
        this.schedule_Start_Dt = schedule_Start_Dt;
    }

    public String getSchedule_End_Dt() {
        return schedule_End_Dt;
    }

    public void setSchedule_End_Dt(String schedule_End_Dt) {
        this.schedule_End_Dt = schedule_End_Dt;
    }

    public int getSchedule_Imp() {
        return schedule_Imp;
    }

    public void setSchedule_Imp(int schedule_Imp) {
        this.schedule_Imp = schedule_Imp;
    }

    public int getSchedule_St() {
        return schedule_St;
    }

    public void setSchedule_St(int schedule_St) {
        this.schedule_St = schedule_St;
    }

    public String getSchedule_Writer_Id() {
        return schedule_Writer_Id;
    }

    public void setSchedule_Writer_Id(String schedule_Writer_Id) {
        this.schedule_Writer_Id = schedule_Writer_Id;
    }

    public String getSchedule_Location() {
        return schedule_Location;
    }

    public void setSchedule_Location(String schedule_Location) {
        this.schedule_Location = schedule_Location;
    }

    public String getCode_Id() {
        return code_Id;
    }

    public void setCode_Id(String code_Id) {
        this.code_Id = code_Id;
    }

    public String getDept_Id() {
        return dept_Id;
    }

    public void setDept_Id(String dept_Id) {
        this.dept_Id = dept_Id;
    }

    public String getSchedule_Background_Color() {
        return schedule_Background_Color;
    }

    public void setSchedule_Background_Color(String schedule_Background_Color) {
        this.schedule_Background_Color = schedule_Background_Color;
    }

    public String getStr_Code_ScheduleId() {
        return str_Code_ScheduleId;
    }

    public void setStr_Code_ScheduleId(String str_Code_ScheduleId) {
        this.str_Code_ScheduleId = str_Code_ScheduleId;
    }

    public String getTeam_Id() {
        return team_Id;
    }

    public void setTeam_Id(String team_Id) {
        this.team_Id = team_Id;
    }

    public String getSearch_Type() {
        return search_Type;
    }

    public void setSearch_Type(String search_Type) {
        this.search_Type = search_Type;
    }

    public int getSearch_Important() {
        return search_Important;
    }

    public void setSearch_Important(int search_Important) {
        this.search_Important = search_Important;
    }

    /**
     * 검색조건
     */
    private String search_Type; //일정그룹별 검색을 위해
    private int search_Important; //중요일정


    //command변경 (입력 날짜-문자열 변환에 필요함)
    public ScheduleCommand toScheduleCommand() {
        ScheduleCommand command = new ScheduleCommand();


        String type = null;
        switch (code_Id) {
            case "S01" :
                type = "개인일정";
                schedule_Background_Color = "#74c0fc";
                break;
            case "S02" :
                type = "회사일정";
                schedule_Background_Color = "#a9e34b";
                break;
            case "S03" :
                type = "부서일정";
                schedule_Background_Color = "#b070db";
                break;
            case "S04":
                type = "팀일정";
                schedule_Background_Color = "#ffa94d";
                break;
        }

        //imp(중요도) int -> String 변환
        String important =  "false";
        if(schedule_Imp == 1) {
            important = "true";
            schedule_Background_Color = "#D25565";
        }

        command.setId(Integer.toString(schedule_Id));
        command.setTitle(schedule_Title);
        command.setContent(schedule_Content);
        command.setStart(schedule_Start_Dt);
        command.setEnd(schedule_End_Dt);
        command.setImp(important);
        command.setUsername(schedule_Writer_Id);
        command.setLocation(schedule_Location);
        command.setBackgroundColor(schedule_Background_Color);
        command.setType(type);
        command.setColor("fffffff");

        return command;
    }
}
