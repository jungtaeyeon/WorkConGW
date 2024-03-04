package com.WorkConGW.board.notice.service;

import com.WorkConGW.board.BoardFormVO;
import com.WorkConGW.board.anony.dto.AnonyVO;
import com.WorkConGW.board.notice.dao.NoticeDAO;
import com.WorkConGW.board.notice.dto.NoticeAttachVO;
import com.WorkConGW.board.notice.dto.NoticeVO;
import com.WorkConGW.common.dto.AttachVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class NoticeService {
    @Autowired 
    private NoticeDAO noticeDAO;
    Logger logger = LoggerFactory.getLogger(NoticeService.class);

//    public Map<String, Object> getNoticeList(NoticeVO searchNoticeVO) throws SQLException {
//		Map<String, Object> datMap = new HashMap<>();
//		List<NoticeVO> noticeList =noticeDAO.selectNoticeList(searchNoticeVO);
//		/*  */
//		List<NoticeVO> importantNoticeList = noticeDAO.selectImportantNoticeList();
//
//		datMap.put("noticeList", noticeList);
//        logger.info(datMap.toString());
//		datMap.put("importantNoticeList", importantNoticeList);
//        logger.info(datMap.get("importantNoticeList").toString());
//        return datMap;
//	}

    public Map<String,Object> getNoticeList(NoticeVO searchNoticeVO) {
        Map<String,Object> dataMap = new HashMap<>();

        List<NoticeVO> noticeList = noticeDAO.selectNoticeList(searchNoticeVO);

        List<NoticeVO> importantNoticeList = noticeDAO.selectImportantNoticeList();

        dataMap.put("noticeList", noticeList);
        dataMap.put("importantNoticeList",importantNoticeList);
        logger.info(dataMap.toString());
        return dataMap;
    }

    public NoticeVO getNotice(NoticeVO noticeVO) {
        NoticeVO notice = noticeDAO.selectNoticeById(noticeVO);
        logger.info(notice.toString());

//         파일 가져오기
        List<AttachVO> noticeAttachList = noticeDAO.selectNoticeAttachList(noticeVO);
        notice.setNoticeAttachList(noticeAttachList);

        logger.info(notice.toString());
        return notice;
    }

//    조회수 증가
    public void increaseNoticeReadCnt(NoticeVO noticeVO) throws SQLException{
        noticeDAO.increaseNoticeReadCnt(noticeVO);
    }

    // 글등록 폼에서 등록
    public void regist(NoticeVO notice) throws SQLException {
        logger.info("시퀀스로 id 채번 전 => " + String.valueOf(notice.getNotice_id()));

        logger.info(notice.toString());
        noticeDAO.insertNotice(notice);
        logger.info("시퀀스로 id 채번 후 => " + String.valueOf(notice.getNotice_id()));

        if(notice.getNoticeAttachList() != null){
            // 파일 업로드
            for(AttachVO attachVO : notice.getNoticeAttachList()) {

                NoticeAttachVO noticeAttachVO = new NoticeAttachVO(attachVO);
                noticeAttachVO.setNotice_id(notice.getNotice_id());

                noticeDAO.insertNoticeFile(noticeAttachVO);
            }
        }
    }

//     글삭제 및 첨부파일 삭제
    public void remove(NoticeVO noticeVO) throws SQLException {
        // 첨부파일 삭제
        List<AttachVO> noticeAttachList = noticeVO.getNoticeAttachList();
//        logger.info(noticeAttachList.toString());
        if(noticeAttachList != null && noticeAttachList.size() > 0) {
            // file 삭제
            for(AttachVO attach : noticeAttachList) {
                File deleteFile = new File(attach.getAttach_path());

                if (deleteFile.exists()) {
                    deleteFile.delete();
                }
            }
            // DB 삭제
            noticeDAO.deleteNoticeFile(noticeVO);
        }
        // 게시글 삭제
        noticeDAO.deleteNotice(noticeVO);
    }

//    게시글 수정 및 첨부파일 삭제
    public void modify(BoardFormVO boardFormVO) throws SQLException {
        NoticeVO noticeVO = boardFormVO.getNoticeVO();
        noticeDAO.updateNotice(noticeVO);

        if (boardFormVO.getFileUploadCommand() != null) {
            // 파일 삭제
            int[] deleteFileIds = boardFormVO.getFileUploadCommand().getDeleteFileIds();
            if(deleteFileIds != null && deleteFileIds.length > 0) {
                for(int attachId : deleteFileIds) {
                    NoticeAttachVO removeFile = new NoticeAttachVO();
                    removeFile.setAttach_id(attachId);
                    removeFile.setNotice_id(noticeVO.getNotice_id());

                    NoticeAttachVO noticeAttach = noticeDAO.selectNoticeAttachById(removeFile);
                    File deleteFile = new File(noticeAttach.getAttach_path());

                    logger.info(String.valueOf(noticeAttach.getAttach_id())); // 29
                    logger.info(String.valueOf(noticeAttach.getNotice_id())); // 56
                    // DB 삭제
                    noticeDAO.deleteNoticeFileById(noticeAttach);

                    // file 삭제
                    if (deleteFile.exists()) {
                        deleteFile.delete();
                    }
                }
            }

            // 파일 DB 저장
            for(AttachVO attachVO : noticeVO.getNoticeAttachList()) {
                NoticeAttachVO noticeAttachVO = new NoticeAttachVO(attachVO);
                noticeAttachVO.setNotice_id(noticeVO.getNotice_id());
                noticeDAO.insertNoticeFile(noticeAttachVO);
            }
        }
    }

//    페이징 처리
    public int searchListTotalCount(NoticeVO searchNoticeVO) throws SQLException{
        return noticeDAO.selectNoticeListTotalCount(searchNoticeVO);
    }
}
