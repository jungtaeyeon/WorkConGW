package com.WorkConGW.board.anony.dao;


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

    public List<AnonyReplyVO> selectAnonyReplyList(int queString) {
        List<AnonyReplyVO> anonyReplyVO = sqlSessionTemplate.selectList("selectAnonyReplyList",queString);
        return anonyReplyVO;
    }

    public int selectAnonyListTotalCount(AnonyVO searchAnonyVO) {
        return sqlSessionTemplate.selectOne("selectAnonyListTotalCount", searchAnonyVO);
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

    public AnonyVO selectAnonyById(int queString) {
       AnonyVO anony = sqlSessionTemplate.selectOne("selectAnonyById",queString);
       return anony;
    }

    public void increaseAnonyReadcnt(AnonyVO anonyVO) {
        sqlSessionTemplate.update("increaseAnonyReadcnt", anonyVO);

    }

    public void updateAnonyReply(AnonyReplyVO anonyVO) {
        sqlSessionTemplate.update("updateAnonyReply",anonyVO); 

    }

    public List<Map<String,Object>> getJsonAnnoyList(AnonyVO searchVO) {
        List<Map<String,Object>> pmap =sqlSessionTemplate.selectList("getJsonAnnoyList",searchVO);
        logger.info(pmap.toString());
        return pmap;
    }

}