package com.WorkConGW.board.duty.service;

import com.WorkConGW.board.duty.command.DutyEnforcerCommand;
import com.WorkConGW.board.duty.dao.DutyDAO;
import com.WorkConGW.board.duty.dto.DutyAttachVO;
import com.WorkConGW.board.duty.dto.DutyReplyVO;
import com.WorkConGW.board.duty.dto.DutyVO;
import com.WorkConGW.emp.dto.EmpVO;
import jakarta.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.WorkConGW.common.dto.AttachVO;

import java.sql.SQLException;
import java.util.List;

@Service
public class DutyService {
    Logger logger = LoggerFactory.getLogger(DutyService.class);
    private final DutyDAO dutyDAO;

    @Autowired
    public DutyService(DutyDAO dutyDAO) {
        this.dutyDAO = dutyDAO;
    }

    /* 업무목록 가져오기 */
    public List<DutyVO> searchList(DutyVO searchDutyVO) throws SQLException{
        List<DutyVO> dutyList = dutyDAO.selectDutyList(searchDutyVO);
        for(DutyVO duty : dutyList) {
            duty.setDutyEnforcerList(dutyDAO.selectDutyEnforcerList(duty));
        }
        return dutyList;
    }

    /* 업무목록 글 총 개수 */
    public int searchListTotalCount(DutyVO searchDutyVO) throws SQLException{
        return dutyDAO.selectDutyListTotalCount(searchDutyVO);
    }

    /* 업무 등록 메서드 */
    public void regist(DutyVO dutyVO) throws SQLException {
        dutyDAO.insertDuty(dutyVO);

        logger.info(String.valueOf(dutyVO.getProject_Id()));

        dutyDAO.updateProjectDutyCount(dutyVO);

        // 담당자(수신자) 저장
        for(String emp_Id : dutyVO.getEmpEnforcerList()) {
            DutyEnforcerCommand dutyEnforcer = new DutyEnforcerCommand();
            dutyEnforcer.setDuty_Board_Id(dutyVO.getDuty_Board_Id());
            dutyEnforcer.setEmp_Id(emp_Id);
            dutyDAO.insertDutyEnforcer(dutyEnforcer);
        }

        // 참조자 저장
        if(dutyVO.getEmpReceptionList() != null) {
            for(String emp_Id : dutyVO.getEmpReceptionList()) {
                DutyEnforcerCommand dutyEnforcer = new DutyEnforcerCommand();
                dutyEnforcer.setDuty_Board_Id(dutyVO.getDuty_Board_Id());
                dutyEnforcer.setEmp_Id(emp_Id);
                dutyDAO.insertDutyReceptioner(dutyEnforcer);
            }
        }

        // 파일 업로드
        if(dutyVO.getAttachList() != null) {
            for(AttachVO attachVO : dutyVO.getAttachList()) {
                DutyAttachVO dutyAttachVO = new DutyAttachVO(attachVO);
                dutyAttachVO.setDuty_Board_Id(dutyVO.getDuty_Board_Id());
                dutyDAO.insertDutyFile(dutyAttachVO);
            }
        }


    }

    /* 받은,보낸 업무목록에 필요한 메서드 (받은,보낸 업무목록 담기) */
    public List<DutyVO> searchMyList(DutyVO searchDutyVO) throws SQLException{
        List<DutyVO> dutyList = dutyDAO.selectMyDutyList(searchDutyVO);
        for(DutyVO duty : dutyList) {
            duty.setDutyEnforcerList(dutyDAO.selectDutyEnforcerList(duty));
        }
        return dutyList;
    }

    /* 받은,보낸 업무목록에 필요한 메서드 (받은,보낸 업무 글 총 개수) */
    public int searchMyListTotalCount(DutyVO searchDutyVO) throws SQLException{
        return dutyDAO.selectMyDutyListTotalCount(searchDutyVO);
    }

    /* 참조 업무목록에 필요한 메서드 (참조 리스트 담기) */
    public List<DutyVO> searchReceptionList(DutyVO searchDutyVO) throws SQLException{
        List<DutyVO> dutyList = dutyDAO.selectDutyReceptionList(searchDutyVO);
        for(DutyVO duty : dutyList) {
            duty.setDutyEnforcerList(dutyDAO.selectDutyEnforcerList(duty));
        }
        return dutyList;
    }

    /* 참조 업무목록에 필요한 메서드 (참조 리스트 업무 글 총 개수) */
    public int searchReceptionListTotalCount(DutyVO searchDutyVO) throws SQLException{
        return dutyDAO.selectDutyReceptionListTotalCount(searchDutyVO);
    }

    /* 디테일에 필요한 메서드 (업무 조회수) */
    public void increaseDutyReadcnt(DutyVO dutyVO) throws SQLException{
        dutyDAO.increaseDutyReadcnt(dutyVO);
    }

    /* 디테일에 필요한 메서드 (댓글 총 개수) */
    public int replyListTotalCount(DutyVO dutyVO) throws SQLException{
        return dutyDAO.selectReplyListTotalCount(dutyVO);
    }

    /* 디테일에 필요한 메서드 (디테일 데이터 가져오기) */
    public DutyVO getDutyForDetail(DutyVO dutyVO, HttpSession session) throws SQLException{
        // 상세정보 가져오기
        DutyVO duty = dutyDAO.selectDutyVO(dutyVO);

        if(duty == null) {
            return null;
        }
        // 담당자 목록 가져오기
        List<DutyEnforcerCommand> dutyEnforcerList = dutyDAO.selectDutyEnforcerList(dutyVO);
        duty.setDutyEnforcerList(dutyEnforcerList);

        for(DutyEnforcerCommand dutyEnforcer : dutyEnforcerList) {
            EmpVO loginUser = (EmpVO) session.getAttribute("loginUser");
            if(dutyEnforcer.getEmp_Id().equals(loginUser.getEmp_Id()) && "N".equals(dutyEnforcer.getRead_St())) {
                dutyDAO.updateDutyEnforcer(dutyEnforcer);
            }
        }

        // 파일 가져오기
        List<DutyAttachVO> dutyAttachList = dutyDAO.selectDutyAttachList(dutyVO);
        duty.setDutyAttachList(dutyAttachList);

        // 댓글 목록 가져오기
        List<DutyReplyVO> dutyReplyList = dutyDAO.selectDutyReplyList(dutyVO);
        duty.setDutyReplyList(dutyReplyList);

        duty.setReceptionList(dutyDAO.selectReceptionList(dutyVO));

        return duty;
    }
}
