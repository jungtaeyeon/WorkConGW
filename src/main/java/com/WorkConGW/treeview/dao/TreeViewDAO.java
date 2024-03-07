package com.WorkConGW.treeview.dao;

import com.WorkConGW.approval.dto.FormVO;
import com.WorkConGW.treeview.command.OrganizationCommand;
import com.WorkConGW.treeview.command.ProjectOrgCommand;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class TreeViewDAO {
    @Autowired
    SqlSessionTemplate sqlSessionTemplate;

    public List<OrganizationCommand> selectSearchOrganization() {
        List<OrganizationCommand> joinList = sqlSessionTemplate.selectList("selectSearchOrganization");

        return joinList;
    }

    public List<OrganizationCommand> selectSearchEmp() {
        List<OrganizationCommand> joinList = sqlSessionTemplate.selectList("selectSearchEmp");

        return joinList;
    }


    public List<FormVO> selectSearchForm() {
        List<FormVO> joinList = sqlSessionTemplate.selectList("selectSearchForm");
        return joinList;
    }

    public List<ProjectOrgCommand> selectSearchProjectOrg() {
       return sqlSessionTemplate.selectList("selectSearchProjectOrg");
    }

    public List<ProjectOrgCommand> selectSearchDuty() {
        return sqlSessionTemplate.selectList("selectSearchDuty");
    }

    public List<ProjectOrgCommand> selectDutiesByProjectId(ProjectOrgCommand project) {
        return sqlSessionTemplate.selectList("selectDutiesByProjectId", project);
    }
}