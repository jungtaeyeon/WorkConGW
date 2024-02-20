package com.WorkConGW.board.duty.service;

import com.WorkConGW.board.duty.command.DutyEnforcerCommand;
import com.WorkConGW.board.duty.dao.DutyDAO;
import com.WorkConGW.board.duty.dto.DutyAttachVO;
import com.WorkConGW.board.duty.dto.DutyVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.WorkConGW.common.dto.AttachVO;

import java.sql.SQLException;
import java.util.List;

@Service
public class DutyService {
    private final DutyDAO dutyDAO;

    @Autowired
    public DutyService(DutyDAO dutyDAO) {
        this.dutyDAO = dutyDAO;
    }

    public List<DutyVO> searchList(DutyVO searchDutyVO) throws SQLException{
        List<DutyVO> dutyList = dutyDAO.selectDutyList(searchDutyVO);
        for(DutyVO duty : dutyList) {
            duty.setDutyEnforcerList(dutyDAO.selectDutyEnforcerList(duty));
        }
        return dutyList;
    }

    public int searchListTotalCount(DutyVO searchDutyVO) throws SQLException{
        return dutyDAO.selectDutyListTotalCount(searchDutyVO);
    }

    public void regist(DutyVO dutyVO) throws SQLException {
        dutyDAO.insertDuty(dutyVO);

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

    public List<DutyVO> searchMyList(DutyVO searchDutyVO) throws SQLException{
        List<DutyVO> dutyList = dutyDAO.selectMyDutyList(searchDutyVO);
        for(DutyVO duty : dutyList) {
            duty.setDutyEnforcerList(dutyDAO.selectDutyEnforcerList(duty));
        }
        return dutyList;
    }

    public int searchMyListTotalCount(DutyVO searchDutyVO) throws SQLException{
        return dutyDAO.selectMyDutyListTotalCount(searchDutyVO);
    }

    public List<DutyVO> searchReceptionList(DutyVO searchDutyVO) throws SQLException{
        List<DutyVO> dutyList = dutyDAO.selectDutyReceptionList(searchDutyVO);
        for(DutyVO duty : dutyList) {
            duty.setDutyEnforcerList(dutyDAO.selectDutyEnforcerList(duty));
        }
        return dutyList;
    }
    public int searchReceptionListTotalCount(DutyVO searchDutyVO) throws SQLException{
        return dutyDAO.selectDutyReceptionListTotalCount(searchDutyVO);
    }

}
