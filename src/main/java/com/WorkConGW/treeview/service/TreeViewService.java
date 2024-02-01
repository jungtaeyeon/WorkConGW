package com.WorkConGW.treeview.service;


import com.WorkConGW.approval.dto.FormVO;
import com.WorkConGW.treeview.command.OrganizationCommand;
import com.WorkConGW.treeview.dao.TreeViewDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Service
public class TreeViewService {
    Logger logger = LoggerFactory.getLogger(TreeViewService.class);

    @Autowired
    private TreeViewDAO treeViewDAO;

    public List<OrganizationCommand> getOrganizationList() throws SQLException {

        List<OrganizationCommand> joinList = new ArrayList<>();

        List<OrganizationCommand> orgList = treeViewDAO.selectSearchOrganization();
        List<OrganizationCommand> empList = treeViewDAO.selectSearchEmp();

        logger.info(orgList.toString());
        logger.info(orgList.toString());

        joinList.addAll(orgList);
        joinList.addAll(empList);
        logger.info(joinList.toString());

        return joinList;
    }


    // 전자결재 구현할 때 사용 예정 - 미완
    public List<FormVO> getFormList() throws SQLException {
        List<FormVO> forms = treeViewDAO.selectSearchForm();
        return forms;
    }

}

