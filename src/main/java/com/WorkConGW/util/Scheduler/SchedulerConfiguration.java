package com.WorkConGW.util.Scheduler;


import com.WorkConGW.common.dto.TimeVO;
import com.WorkConGW.common.service.TimeService;
import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.Date;

@Component
@RequiredArgsConstructor
public class SchedulerConfiguration {

    private final TimeService timeService;



//    @Scheduled(fixedRate = 1000)
//    public void updateBusinessHours()
//    {
//        TimeVO timeVO = timeService.getTime();
//        timeService.modifyTime(timeVO);
//        System.out.println(new Date());
//    }
}
