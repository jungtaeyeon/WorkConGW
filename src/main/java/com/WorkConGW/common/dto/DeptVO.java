package com.WorkConGW.common.dto;

import com.WorkConGW.common.dto.BaseVO;
import lombok.Data;
import org.apache.ibatis.type.Alias;


@Alias("DeptVO")
public class DeptVO extends BaseVO {
    private String dept_Id;
    private String dept_Sup_Id;
    private String dept_Name;
    private String dept_Create_Dt; // Date


    private String dept_Update_Dt; // Date
    private String dept_St;
    private String dept_Hp;
    private String dept_Leader_Id;
    private String dept_Team_Yn;

    private String dept_Leader_Name; // 담당자명
    private String dept_Sup_Name;
    private String emp_Email;

    private int dept_Emp_Count; // 소속 직원 수

    private String emp_Id; // 특정 직원의 부서 및 담당부서 조회를 위해 추가

    private String flag; // deptService 이용 시 제어하기 위해 추가





    public DeptVO(){}
    public DeptVO(String dept_Id, String dept_Sup_Id, String dept_Name, String dept_Create_Dt, String dept_Update_Dt, String dept_St, String dept_Hp, String dept_Leader_Id, String dept_Team_Yn, String dept_Leader_Name, String dept_Sup_Name, String emp_Email, int dept_Emp_Count, String emp_Id, String flag) {
        super();
        this.dept_Id = dept_Id;
        this.dept_Sup_Id = dept_Sup_Id;
        this.dept_Name = dept_Name;
        this.dept_Create_Dt = dept_Create_Dt;
        this.dept_Update_Dt = dept_Update_Dt;
        this.dept_St = dept_St;
        this.dept_Hp = dept_Hp;
        this.dept_Leader_Id = dept_Leader_Id;
        this.dept_Team_Yn = dept_Team_Yn;
        this.dept_Leader_Name = dept_Leader_Name;
        this.dept_Sup_Name = dept_Sup_Name;
        this.emp_Email = emp_Email;
        this.dept_Emp_Count = dept_Emp_Count;
        this.emp_Id = emp_Id;
        this.flag = flag;
    }


    public String getDept_Id() {
        return dept_Id;
    }

    public void setDept_Id(String dept_Id) {
        this.dept_Id = dept_Id;
    }

    public String getDept_Sup_Id() {
        return dept_Sup_Id;
    }

    public void setDept_Sup_Id(String dept_Sup_Id) {
        this.dept_Sup_Id = dept_Sup_Id;
    }

    public String getDept_Name() {
        return dept_Name;
    }

    public void setDept_Name(String dept_Name) {
        this.dept_Name = dept_Name;
    }

    public String getDept_Create_Dt() {
        return dept_Create_Dt;
    }

    public void setDept_Create_Dt(String dept_Create_Dt) {
        this.dept_Create_Dt = dept_Create_Dt;
    }

    public String getDept_Update_Dt() {
        return dept_Update_Dt;
    }

    public void setDept_Update_Dt(String dept_Update_Dt) {
        this.dept_Update_Dt = dept_Update_Dt;
    }

    public String getDept_St() {
        return dept_St;
    }

    public void setDept_St(String dept_St) {
        this.dept_St = dept_St;
    }

    public String getDept_Hp() {
        return dept_Hp;
    }

    public void setDept_Hp(String dept_Hp) {
        this.dept_Hp = dept_Hp;
    }

    public String getDept_Leader_Id() {
        return dept_Leader_Id;
    }

    public void setDept_Leader_Id(String dept_Leader_Id) {
        this.dept_Leader_Id = dept_Leader_Id;
    }

    public String getDept_Team_Yn() {
        return dept_Team_Yn;
    }

    public void setDept_Team_Yn(String dept_Team_Yn) {
        this.dept_Team_Yn = dept_Team_Yn;
    }

    public String getDept_Leader_Name() {
        return dept_Leader_Name;
    }

    public void setDept_Leader_Name(String dept_Leader_Name) {
        this.dept_Leader_Name = dept_Leader_Name;
    }

    public String getDept_Sup_Name() {
        return dept_Sup_Name;
    }

    public void setDept_Sup_Name(String dept_Sup_Name) {
        this.dept_Sup_Name = dept_Sup_Name;
    }

    public String getEmp_Email() {
        return emp_Email;
    }

    public void setEmp_Email(String emp_Email) {
        this.emp_Email = emp_Email;
    }

    public int getDept_Emp_Count() {
        return dept_Emp_Count;
    }

    public void setDept_Emp_Count(int dept_Emp_Count) {
        this.dept_Emp_Count = dept_Emp_Count;
    }

    public String getEmp_Id() {
        return emp_Id;
    }

    public void setEmp_Id(String emp_Id) {
        this.emp_Id = emp_Id;
    }

    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }
}
