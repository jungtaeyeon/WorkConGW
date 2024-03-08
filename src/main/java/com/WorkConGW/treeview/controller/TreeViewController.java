package com.WorkConGW.treeview.controller;

import com.WorkConGW.approval.dto.FormVO;
import com.WorkConGW.board.duty.dto.DutyVO;
import com.WorkConGW.emp.dto.EmpVO;
import com.WorkConGW.treeview.command.OrganizationCommand;
import com.WorkConGW.treeview.command.ProjectOrgCommand;
import com.WorkConGW.treeview.command.ProjectWithDuties;
import com.WorkConGW.treeview.service.TreeViewService;
import jakarta.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

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

    // 전자결재 구현할 때 사용 예정
    @ResponseBody
    @RequestMapping(value="/getFormTreeView")
    public List<FormVO>  getFormTreeView() throws SQLException {
        List<FormVO> forms = tvService.getFormList();
        return forms;
    }

//    @ResponseBody
//    @RequestMapping(value="/getProjectTreeView")
//    public List<ProjectOrgCommand>  getProjectTreeView() throws SQLException {
//        List<ProjectOrgCommand> projectOrgList = tvService.getProjectOrgList();
//        return projectOrgList;
//    }

    @ResponseBody
    @RequestMapping(value="/getProjectTreeView")
    public List<ProjectWithDuties> getProjectTreeView(HttpServletRequest request) throws SQLException {
        String emp_Id = ((EmpVO)request.getSession().getAttribute("loginUser")).getEmp_Id();

        List<ProjectWithDuties> projectTree = tvService.getProjectTree(emp_Id);
        return projectTree;
    }

}

