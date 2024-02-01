package com.WorkConGW.scheduler.dto;

import com.WorkConGW.common.dto.BaseVO;
import com.WorkConGW.scheduler.command.ScheduleCommand;
import lombok.Data;

@Data
public class ScheduleFormVO extends BaseVO {

    private ScheduleVO scheduleVO;
    private ScheduleCommand scheduleCommand;
    private ScheduleVO searchScheduleVO;
    private String form;

    public ScheduleFormVO() {
        this.scheduleVO = new ScheduleVO();
        this.scheduleCommand = new ScheduleCommand();
        this.searchScheduleVO = new ScheduleVO();
    }
}
