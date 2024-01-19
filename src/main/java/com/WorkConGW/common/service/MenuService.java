package com.WorkConGW.common.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.WorkConGW.common.dao.MenuDAO;
import com.WorkConGW.common.dto.MenuVO;

@Service
public class MenuService {

    @Autowired
    private MenuDAO menuDAO;

    public List<MenuVO> getMenuList() {
        List<MenuVO> menu = menuDAO.selectMenu();
        return menu;

    }


	
}
