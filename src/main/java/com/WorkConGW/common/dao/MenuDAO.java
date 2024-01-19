package com.WorkConGW.common.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.WorkConGW.common.dto.MenuVO;

@Repository
public class MenuDAO {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    public List<MenuVO> selectMenu(){
        List<MenuVO> menu = sqlSessionTemplate.selectList("selectMenu");
        return menu;
    }
}
