package com.WorkConGW.board.notice.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.WorkConGW.board.notice.dto.NoticeVO;


@Repository
public class NoticeDAO {

    @Autowired
    public SqlSessionTemplate sqlSessionTemplate;
    Logger logger = LoggerFactory.getLogger(NoticeDAO.class);




//NoticeVO searchNoticeVO
    public List<NoticeVO> selectNoticeList(NoticeVO searchNoticeVO) {

        List<NoticeVO> noticeList  = sqlSessionTemplate.selectList("noticeList", searchNoticeVO);
        
        return noticeList;
    }



}
