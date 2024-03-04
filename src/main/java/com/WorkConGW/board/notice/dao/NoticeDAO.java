package com.WorkConGW.board.notice.dao;

import com.WorkConGW.board.notice.dto.NoticeAttachVO;
import com.WorkConGW.board.notice.dto.NoticeVO;
import com.WorkConGW.common.dto.AttachVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;


@Repository
public class NoticeDAO {

    @Autowired
    public SqlSessionTemplate sqlSessionTemplate;
    Logger logger = LoggerFactory.getLogger(NoticeDAO.class);




//NoticeVO searchNoticeVO
    public List<NoticeVO> selectNoticeList(NoticeVO searchNoticeVO) {

        List<NoticeVO> noticeList = sqlSessionTemplate.selectList("noticeList", searchNoticeVO);
        
        return noticeList;
    }


    public NoticeVO selectNoticeById(NoticeVO noticeVO) {
        NoticeVO detailNoticeVO = sqlSessionTemplate.selectOne("selectNoticeById",noticeVO);
        logger.info(detailNoticeVO.toString());
        return detailNoticeVO;
    }

    // 첨부파일 목록 가져오기
    public List<AttachVO> selectNoticeAttachList(NoticeVO noticeVO) {
        List<AttachVO> attachList = sqlSessionTemplate.selectList("selectNoticeAttachList", noticeVO);
//        logger.info(attachList.get(0).getAttach_name());
        return attachList;
    }

    public void increaseNoticeReadCnt(NoticeVO noticeVO) {
        sqlSessionTemplate.update("increaseNoticeReadCnt", noticeVO);
    }

    public void deleteEmergency() {
        sqlSessionTemplate.delete("deleteEmergency");
    }

    public void insertNotice(NoticeVO notice) {
        sqlSessionTemplate.insert("insertNotice", notice);
    }

    public void insertNoticeFile(NoticeAttachVO noticeAttachVO) {
        sqlSessionTemplate.insert("insertNoticeFile", noticeAttachVO);
    }

    public void deleteNoticeFile(NoticeVO noticeVO) {
        sqlSessionTemplate.delete("deleteNoticeFile", noticeVO);
    }

    public void deleteNotice(NoticeVO noticeVO) {
        sqlSessionTemplate.delete("deleteNotice", noticeVO);
    }

    public void updateNotice(NoticeVO noticeVO) {
        sqlSessionTemplate.update("updateNotice", noticeVO);
    }

    public int selectNoticeListTotalCount(NoticeVO searchNoticeVO) {
        int result = 0;
        result = sqlSessionTemplate.selectOne("selectNoticeListTotalCount", searchNoticeVO);
        logger.info("selectNoticeListTotal : "+ result);
        return result;
    }

    public List<NoticeVO> selectImportantNoticeList() {
        List<NoticeVO> importantNoticeList = sqlSessionTemplate.selectList("selectImportantNoticeList");
        return importantNoticeList;
    }

    public NoticeAttachVO selectNoticeAttachById(NoticeAttachVO removeFile) {
        NoticeAttachVO noticeAttachVO = sqlSessionTemplate.selectOne("selectNoticeAttachById", removeFile);
        return noticeAttachVO;
    }

    public void deleteNoticeFileById(NoticeAttachVO noticeAttach) {
        sqlSessionTemplate.delete("deleteNoticeFileById", noticeAttach);
    }

}
