package com.WorkConGW.common.service;


import com.WorkConGW.common.dao.TimeDAO;
import com.WorkConGW.common.dto.TimeVO;
import com.WorkConGW.emp.service.EmpService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cglib.core.Local;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;


@Service
public class TimeService {
    Logger logger = LoggerFactory.getLogger(TimeService.class);

    @Autowired
    private TimeDAO timeDao;

    private LocalDateTime lastUpdateTime; // 마지막으로 업데이트된 시간을 기록

    public TimeVO getTime()
    {

        return timeDao.selectTime();
    }

    public void modifyTime(TimeVO timeVO) {
        TimerTask task = new TimerTask() {
            public void run()
            {
                System.out.println(new Date() + " : Executing the task from "
                        + Thread.currentThread().getName());
                timeDao.modifyTime(timeVO);
            }
        };

        Timer timer = new Timer("Timer");
        long currentMillis = System.currentTimeMillis();
        //long delay = (24 * 60 * 60 * 1000 - currentMillis % (24 * 60 * 60 * 1000)) + (8 * 60 * 60 * 1000);
        long delay = 1000L;
        timer.schedule(task,delay);



    }
}
