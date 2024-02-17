package com.WorkConGW.common.service;


import com.WorkConGW.common.dao.TimeDAO;
import com.WorkConGW.common.dto.TimeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



@Service
public class TimeService {

    @Autowired
    private TimeDAO timeDao;

    public TimeVO getTime()
    {
        return timeDao.selectTime();
    }

    public void modifyTime(TimeVO timeVO) {
        timeDao.modifyTime(timeVO);

    }
}
