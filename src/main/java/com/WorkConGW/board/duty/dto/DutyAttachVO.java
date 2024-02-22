package com.WorkConGW.board.duty.dto;

import com.WorkConGW.common.dto.AttachVO;
import com.google.api.client.util.Value;
import org.apache.ibatis.type.Alias;

@Alias("DutyAttachVO")
public class DutyAttachVO extends AttachVO {
    private int duty_Board_Id;

    public DutyAttachVO(AttachVO attachVO) {
        setAttach_path(attachVO.getAttach_path());
        setAttach_name(attachVO.getAttach_name());
        setAttach_type(attachVO.getAttach_type());
    }

    public int getDuty_Board_Id() {
        return duty_Board_Id;
    }
    public void setDuty_Board_Id(int dutyBoardId) {
        this.duty_Board_Id = duty_Board_Id;
    }

}