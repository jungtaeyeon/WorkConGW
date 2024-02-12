package com.WorkConGW.board.anony.dao;


import java.util.Date;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.WorkConGW.board.anony.dto.AnonyReplyVO;
import com.WorkConGW.board.anony.dto.AnonyVO;


@Repository
public class AnonyDAO {

    Logger logger = LoggerFactory.getLogger(AnonyDAO.class);
    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    public List<AnonyVO> selectAnonyList(AnonyVO searchAnonyVO) {
        List<AnonyVO> anonyList = sqlSessionTemplate.selectList("selectAnonyList",searchAnonyVO);
        logger.info("annoyList : " + searchAnonyVO.toString());
        return anonyList;
    }

    public List<AnonyReplyVO> selectAnonyReplyList(AnonyVO searchAnonyVO) {
        List<AnonyReplyVO> anonyReplyVO = sqlSessionTemplate.selectList("selectAnonyReplyList",searchAnonyVO);
        return anonyReplyVO;
    }

    public int selectAnonyListTotalCount(AnonyVO searchAnonyVO) {
        return sqlSessionTemplate.selectOne("selectAnonyListTotalCount", searchAnonyVO);
    }

    public int selectReplyCount(int queryString)
    {
        int result = sqlSessionTemplate.selectOne("selectReplyCount", queryString);
        return result;
    }

    public void insertAnony(AnonyVO anonyVO) {
        sqlSessionTemplate.insert("insertAnony",anonyVO);
    }

    public void updateAnony(AnonyVO anonyVO) {
        sqlSessionTemplate.update("updateAnony",anonyVO);
    }

    public void deleteAnony(AnonyVO anonyVO) {
        sqlSessionTemplate.delete("deleteAnony", anonyVO);
    }

    public AnonyVO selectAnonyById(AnonyVO anonyVO) {
        AnonyVO anony = sqlSessionTemplate.selectOne("selectAnonyById",anonyVO);
        return anony;
    }

    public void increaseAnonyReadcnt(AnonyVO anonyVO) {
        sqlSessionTemplate.update("increaseAnonyReadcnt", anonyVO);

    }

    public void updateAnonyReply(AnonyReplyVO anonyVO) {
        sqlSessionTemplate.update("updateAnonyReply",anonyVO);

    }

    public void deleteAnonyReply(AnonyReplyVO anonyReplyVO)
    {
        sqlSessionTemplate.delete("deleteAnonyReply",anonyReplyVO);
    }

    public List<Map<String,Object>> getJsonAnnoyList(AnonyVO searchVO) {
        List<Map<String,Object>> pmap =sqlSessionTemplate.selectList("getJsonAnnoyList",searchVO);
        logger.info(pmap.toString());
        return pmap;
    }

    public void insertAnonyReply(AnonyReplyVO anonyReplyVO) {
        sqlSessionTemplate.insert("insertAnonyReply", anonyReplyVO);
    }

    public List<AnonyReplyVO> selectReplyPaging(AnonyReplyVO anonyReplyVO) {
        return sqlSessionTemplate.selectList("selectReplyPaging", anonyReplyVO);
    }

    public Date getCreatePost(AnonyVO searchAnonyVO) {
        return sqlSessionTemplate.selectOne("getCreatePost", searchAnonyVO);
    }

    public Date getPostTime(int anonyBoardId) {
        return sqlSessionTemplate.selectOne("getPostTime",anonyBoardId);
    }
}