package com.WorkConGW.treeview.command;

import lombok.ToString;
import org.apache.ibatis.type.Alias;

import java.util.ArrayList;
import java.util.List;

/**
 * 조직도를 그리기 위한 커맨드
 */

@ToString
@Alias("OrganizationCommand")
public class OrganizationCommand {
    private String deptId;
    private String deptName;
    private String deptSupId;
    private int level;
    private String position;
    private String deptLeaderId;
    private String empState;
    private List<OrganizationCommand> children = new ArrayList<OrganizationCommand>();


    public String getDeptLeaderId() {
        return deptLeaderId;
    }
    public void setDeptLeaderId(String deptLeaderId) {
        this.deptLeaderId = deptLeaderId;
    }
    public List<OrganizationCommand> getChildren() {
        return children;
    }
    public void setChildren(List<OrganizationCommand> children) {
        this.children = children;
    }
    public String getPosition() {
        return position;
    }
    public void setPosition(String position) {
        this.position = position;
    }
    public String getDeptId() {
        return deptId;
    }
    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }
    public String getDeptName() {
        return deptName;
    }
    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }
    public String getDeptSupId() {
        return deptSupId;
    }
    public void setDeptSupId(String deptSupId) {
        this.deptSupId = deptSupId;
    }
    public int getLevel() {
        return level;
    }
    public void setLevel(int level) {
        this.level = level;
    }
    public String getEmpState() {
        return empState;
    }
    public void setEmpState(String empState) {
        this.empState = empState;
    }

}
