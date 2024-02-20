package com.WorkConGW.addbook.dao;



import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.HashedMap;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.WorkConGW.addbook.dto.AddBookVO;



@Repository
public class AddBookDAO {
  @Autowired
  private SqlSessionTemplate sqlSessionTemplate;
  Logger logger = LoggerFactory.getLogger(AddBookDAO.class);

  /* 주소록리스트 */
  public List<AddBookVO> addBookList(Map<String, Object> pmap) {
    logger.info("addBookList");
    AddBookVO addBookVO = new AddBookVO();
    logger.info(pmap.toString());
    List<AddBookVO> manageAddBookIdList = sqlSessionTemplate.selectList("manageAddBookIdList", pmap);
    logger.info(manageAddBookIdList.toString());
    List<AddBookVO> list = sqlSessionTemplate.selectList("addBookList", pmap);
    
    logger.info(list.toString());
    return list;
  }

  public List<AddBookVO> addBookStarred(Map<String, Object> pmap) {
    logger.info("addBookStarred");
    AddBookVO addBookVO = new AddBookVO();
    logger.info(pmap.toString());
    List<AddBookVO> list = sqlSessionTemplate.selectList("addBookStarred", pmap); 
    logger.info(list.toString());
    return list;
  }

  public List<AddBookVO> addBookShare(Map<String, Object> pmap) {
    logger.info("addBookShare");
    AddBookVO addBookVO = new AddBookVO();
    logger.info(pmap.toString());
    List<AddBookVO> list = sqlSessionTemplate.selectList("addBookShare", pmap); 
    logger.info(list.toString());
    return list;
  }

  public List<AddBookVO> addBookSearch(Map<String, Object> pmap) {
      logger.info("addBookSearch");
      AddBookVO addBookVO = new AddBookVO();
      List<AddBookVO> list = sqlSessionTemplate.selectList("addBookSearch", pmap);
      return list;
  }

  public List<AddBookVO> addBookSearchStarred(Map<String, Object> pmap) {
    logger.info("addBookSearchStarred");
    AddBookVO addBookVO = new AddBookVO();
    List<AddBookVO> list = sqlSessionTemplate.selectList("addBookSearchStarred", pmap);
    return list;
  }

  public List<AddBookVO> addBookSearchShare(Map<String, Object> pmap) {
    logger.info("addBookSearchShare");
    AddBookVO addBookVO = new AddBookVO();
    List<AddBookVO> list = sqlSessionTemplate.selectList("addBookSearchShare", pmap);
    return list;
  }

  public List<AddBookVO> addBookGroupSelect(Map<String, Object> pmap) {
    logger.info("addBookGroupSelect");
    AddBookVO addBookVO = new AddBookVO();
    List<AddBookVO> list = sqlSessionTemplate.selectList("addBookGroupSelect", pmap);
    logger.info(list.toString());
    return list;
  }

  public List<AddBookVO> shareAddBookGroupSelect(Map<String, Object> pmap) {
    logger.info("shareAddBookGroupSelect");
    AddBookVO addBookVO = new AddBookVO();
    List<AddBookVO> list = sqlSessionTemplate.selectList("shareAddBookGroupSelect", pmap);
    logger.info(list.toString());
    return list;
  }

  public List<Map<String, Object>> addBookListUpdate(Map<String, Object> pmap) {
    logger.info("addBookListUpdate");
    List<Map<String, Object>> list = sqlSessionTemplate.selectList("addBookListUpdate", pmap);
    logger.info(list.toString());
    return list;
  }

  public int addBookInsert(Map<String, Object> pmap) {
    logger.info("addBookInsert");
    int result = 0;
    result = sqlSessionTemplate.insert("addBookInsert", pmap);
    return result;
  }

  public int addBookGroupInsert(Map<String, Object> pmap) {
    logger.info("addBookGroupInsert");
    int result = 0;
    result = sqlSessionTemplate.insert("addBookGroupInsert", pmap);
    return result;
  }

  public int addBookGroupUpdate(Map<String, Object> pmap) {
    logger.info("addBookGroupUpdate");
    int result = 0;
    result = sqlSessionTemplate.update("addBookGroupUpdate", pmap);
    return result;
  }

  public int addBookUpdate(Map<String, Object> pmap) {
    logger.info("addBookUpdate");
    int result = 0;
    result = sqlSessionTemplate.update("addBookUpdate", pmap);
    return result;
  }

  public int addBookGroupDelete(Map<String, Object> pmap) {
    logger.info("addBookGroupDelete");
    int result = 0;
    result = sqlSessionTemplate.update("addBookGroupDelete", pmap);
    return result;
  }

  public int addBookDelete(List<Long> manage_id) {
    logger.info("addBookDelete");
    int result = 0;
    logger.info(manage_id.toString());
    result = sqlSessionTemplate.update("addBookDelete", manage_id);
    return result;
  }

  public List<Map<String, Object>> addBookGroupDoubleCheck(Map<String, Object> pmap) {
    logger.info("addBookGroupDoubleCheck");
    List<Map<String, Object>> list = null;
    list = sqlSessionTemplate.selectList("addBookGroupDoubleCheck", pmap);
    logger.info(list.toString());
    return list;
  }

  public int addBookStarredUpdate(Map<String, Object> pmap) {
    logger.info("addBookStarredUpdate");
    int result = 0;
    result = sqlSessionTemplate.update("addBookStarredUpdate", pmap);
    logger.info(Integer.toString(result));
    return result;
  }

  public int addBookStarredInsert(Map<String, Object> pmap) {
    logger.info("addBookStarredInsert");
    int result = 0;
    result = sqlSessionTemplate.update("addBookStarredInsert", pmap);
    logger.info(Integer.toString(result));
    return result;
  }

  public int addBookStarredDelete(Map<String, Object> pmap) {
    logger.info("addBookStarredDelete");
    int result = 0;
    result = sqlSessionTemplate.update("addBookStarredDelete", pmap);
    logger.info(Integer.toString(result));
    return result;
  }
}
