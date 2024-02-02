package com.WorkConGW.treeview.controller;

import com.WorkConGW.approval.dto.FormVO;
import com.WorkConGW.treeview.command.OrganizationCommand;
import com.WorkConGW.treeview.service.TreeViewService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.sql.SQLException;
import java.util.List;

@Controller
public class TreeViewController {
    Logger logger = LoggerFactory.getLogger(TreeViewController.class);

    @Autowired
    TreeViewService tvService;


    @ResponseBody
    @RequestMapping(value="/orgList")
    public List<OrganizationCommand> testTree()throws Exception{

        List<OrganizationCommand> orgList = tvService.getOrganizationList();
        logger.info(orgList.toString());

        return orgList;

    }


    @RequestMapping(value="/organization")
    public String treeView() {

        String url = "treeview/Organization";
        return url;
    }

    // 전자결재 구현할 때 사용 예정 - 미완
    @ResponseBody
    @RequestMapping(value="/getFormTreeView")
    public List<FormVO>  getFormTreeView() throws SQLException {
        List<FormVO> forms = tvService.getFormList();
        return forms;
    }

}

