package com.WorkConGW.emp.dto;

import com.WorkConGW.common.dto.BaseVO;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
public class EmpFormVO extends BaseVO{


    private EmpVO empVO;
    private EmpVO searchEmpVO;

    public EmpFormVO()
    {
        this.empVO = new EmpVO();
        this.searchEmpVO = new EmpVO();
    }


    public EmpVO getEmpVO() {
        return empVO;
    }

    public void setEmpVO(EmpVO empVO) {
        this.empVO = empVO;
    }

    public EmpVO getSearchEmpVO() {
        return searchEmpVO;
    }

    public void setSearchEmpVO(EmpVO searchEmpVO) {
        this.searchEmpVO = searchEmpVO;
    }
	
}
