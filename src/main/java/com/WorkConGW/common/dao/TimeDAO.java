package com.WorkConGW.common.dao;


import com.WorkConGW.common.dto.TimeVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;



@Repository
public class TimeDAO {
    @Autowired
    private SqlSessionTemplate sqlSessionTemplate = null;

    public TimeVO selectTime() {
        TimeVO timeVO = sqlSessionTemplate.selectOne("selectTime");
        return timeVO;
    }


    public void modifyTime(TimeVO timeVO) {
        sqlSessionTemplate.update("modifyTime",timeVO);
    }
}
