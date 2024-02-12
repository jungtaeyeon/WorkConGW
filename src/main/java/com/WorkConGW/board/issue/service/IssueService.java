package com.WorkConGW.board.issue.service;

import com.WorkConGW.board.issue.dao.IssueDAO;
import com.WorkConGW.board.issue.dto.IssueReplyVO;
import com.WorkConGW.board.issue.dto.IssueVO;
import com.WorkConGW.emp.dto.EmpVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.List;

@Service
public class IssueService {

	@Autowired
	private IssueDAO issueDAO;


}
