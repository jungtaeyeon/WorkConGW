package com.WorkConGW.board.notice.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.WorkConGW.board.notice.dao.NoticeDAO;
import com.WorkConGW.board.notice.dto.NoticeVO;

@Service
public class NoticeService {
    @Autowired 
    private NoticeDAO noticeDAO;
    Logger logger = LoggerFactory.getLogger(NoticeService.class);
//NoticeVO searchNoticeVO
    // public List<Map<String, Object>> getNoticeList() throws SQLException{
    //     Map<String,Object> dataMap = new HashMap<>();
    //     List<Map<String, Object>> noticeList = noticeDAO.selectNoticeList();
    //     //List<NoticeVO> importantNoticeList = noticeDAO.selectImportantNoticeList();
    //    // dataMap.put("importantNoticeList", importantNoticeList);
    //     logger.info(dataMap.toString());

    //     return noticeList;
    // }

    public Map<String, Object> getNoticeList(NoticeVO searchNoticeVO) throws SQLException {
		Map<String, Object> datMap = new HashMap<>();
		List<NoticeVO> noticeList =noticeDAO.selectNoticeList(searchNoticeVO);
		/*  */
		//List<NoticeVO> importantNoticeList = noticeDAO.selectImportantNoticeList();
		
		datMap.put("noticeList", noticeList);
        logger.info(datMap.toString());
		//datMap.put("importantNoticeList", importantNoticeList);
		return datMap;
	}
}
