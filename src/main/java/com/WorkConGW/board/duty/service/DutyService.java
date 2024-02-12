package com.WorkConGW.board.duty.service;

import com.WorkConGW.board.duty.command.DutyManagerCommand;
import com.WorkConGW.board.duty.dao.DutyDAO;
import com.WorkConGW.board.duty.dto.DutyAttachVO;
import com.WorkConGW.board.duty.dto.DutyReplyVO;
import com.WorkConGW.board.duty.dto.DutyVO;
import com.WorkConGW.emp.dto.EmpVO;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.List;

@Service
public class DutyService {
    @Autowired
    DutyDAO dutyDAO;

    public DutyVO getDutyForDetail(DutyVO dutyVO, HttpSession session) throws SQLException {
        // 상세정보 가져오기
        DutyVO duty = dutyDAO.selectDutyVO(dutyVO);

        if(duty == null) {
            return null;
        }
        // 담당자 목록 가져오기
//        List<DutyManagerCommand> dutyManagerList = dutyDAO.selectDutyManagerList(dutyVO);
//        duty.setDutyManagerList(dutyManagerList);
//
//        for(DutyManagerCommand dutyManager : dutyManagerList) {
//            EmpVO loginUser = (EmpVO) session.getAttribute("loginUser");
//            if(dutyManager.getEmp_Id().equals(loginUser.getEmp_Id()) && "N".equals(dutyManager.getReadSt())) {
//                dutyDAO.updateDutyManager(dutyManager);
//            }
//        }
//
//        // 파일 가져오기
//        List<DutyAttachVO> dutyAttachList = dutyDAO.selectDutyAttachList(dutyVO);
//        duty.setDutyAttachList(dutyAttachList);
//
//        // 댓글 목록 가져오기
//        List<DutyReplyVO> dutyReplyList = dutyDAO.selectDutyReplyList(dutyVO);
//        duty.setDutyReplyList(dutyReplyList);
//
//        duty.setReceptionDeptList(dutyDAO.selectReceptionDeptList(dutyVO));
//        duty.setReceptionList(dutyDAO.selectReceptionList(dutyVO));

        return duty;
    }
	
}
