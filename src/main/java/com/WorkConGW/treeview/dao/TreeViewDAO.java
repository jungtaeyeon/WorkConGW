package com.WorkConGW.treeview.dao;

import com.WorkConGW.approval.dto.FormVO;
import com.WorkConGW.treeview.command.OrganizationCommand;
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
        return null;
    }
}