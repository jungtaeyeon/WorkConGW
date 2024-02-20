package com.WorkConGW.addbook.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.HashedMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.WorkConGW.addbook.dao.AddBookDAO;
import com.WorkConGW.addbook.dto.AddBookVO;

@Service
public class AddBookService {
  @Autowired
  private AddBookDAO AddBookDAO;
  Logger logger = LoggerFactory.getLogger(AddBookDAO.class);

  public List<AddBookVO> addBookList(Map<String, Object> pmap) {
    logger.info("addBookList");
    List<AddBookVO> list = new ArrayList<>();
    list = AddBookDAO.addBookList(pmap);
    return list;
  }

  public List<AddBookVO> addBookStarred(Map<String, Object> pmap) {
    logger.info("addBookList");
    List<AddBookVO> list = new ArrayList<>();
    list = AddBookDAO.addBookStarred(pmap);
    return list;
  }

  public List<AddBookVO> addBookShare(Map<String, Object> pmap) {
    logger.info("addBookShare");
    List<AddBookVO> list = new ArrayList<>();
    list = AddBookDAO.addBookShare(pmap);
    return list;
  }

  public List<AddBookVO> addBookSearch(Map<String, Object> pmap) {
    logger.info("addBookSearch");
    List<AddBookVO> list = new ArrayList<>();
    list = AddBookDAO.addBookSearch(pmap);
    return list;
  }

  public List<AddBookVO> addBookSearchStarred(Map<String, Object> pmap) {
    logger.info("addBookSearchStarred");
    List<AddBookVO> list = new ArrayList<>();
    list = AddBookDAO.addBookSearchStarred(pmap);
    return list;
  }

  public List<AddBookVO> addBookSearchShare(Map<String, Object> pmap) {
    logger.info("addBookSearchShare");
    List<AddBookVO> list = new ArrayList<>();
    list = AddBookDAO.addBookSearchShare(pmap);
    return list;
  }

  public int addBookInsert(Map<String, Object> pmap) {
    logger.info("addBookInsert");
    int result = 0;
    logger.info(pmap.toString());
    result = AddBookDAO.addBookInsert(pmap);
    return result;
  }

  public int addBookGroupInsert(Map<String, Object> pmap) {
    logger.info("addBookGroupInsert");
    int result = 0;
    logger.info(pmap.toString());
    result = AddBookDAO.addBookGroupInsert(pmap);
    return result;
  }

  public int addBookGroupUpdate(Map<String, Object> pmap) {
    logger.info("addBookGroupUpdate");
    int result = 0;
    logger.info(pmap.toString());
    result = AddBookDAO.addBookGroupUpdate(pmap);
    return result;
  }

  public List<Map<String, Object>> addBookListUpdate(Map<String, Object> pmap) {
    logger.info("addBookListUpdate");
    logger.info(pmap.toString());
    List<Map<String, Object>> list = AddBookDAO.addBookListUpdate(pmap);
    return list;
  }

  public List<AddBookVO> addBookGroupSelect(Map<String, Object> pmap) {
    logger.info("addBookGroupSelect");
    List<AddBookVO> list = new ArrayList<>();
    list = AddBookDAO.addBookGroupSelect(pmap);
    return list;
  }
  
  public List<AddBookVO> shareAddBookGroupSelect(Map<String, Object> pmap) {
    logger.info("shareAddBookGroupSelect");
    List<AddBookVO> list = new ArrayList<>();
    list = AddBookDAO.shareAddBookGroupSelect(pmap);
    return list;
  }

  public int addBookUpdate(Map<String, Object> pmap) {
    logger.info("addBookUpdate");
    int result = 0;
    logger.info(pmap.toString());
    result = AddBookDAO.addBookUpdate(pmap);
    return result;
  }

  public List<Map<String, Object>> addBookGroupDoubleCheck(Map<String, Object> pmap) {
    logger.info("addBookGroupDoubleCheck");
    logger.info(pmap.toString());
    List<Map<String, Object>> result = AddBookDAO.addBookGroupDoubleCheck(pmap);
    return result;
  }

  public int addBookStarredUpdate(Map<String, Object> pmap) {
    logger.info("addBookStarredUpdate");
    int result = 0;
    logger.info(pmap.toString());
    Object manage_starredObj = pmap.get("manage_starred");
    String manage_starred = manage_starredObj.toString();
    logger.info(manage_starred);
    
    if("1".equals(manage_starred)){
      AddBookDAO.addBookStarredInsert(pmap);
    }else{
      AddBookDAO.addBookStarredDelete(pmap);
    }
    result = AddBookDAO.addBookStarredUpdate(pmap);
    return result;
  }

  public int addBookGroupDelete(Map<String, Object> pmap) {
    logger.info("addBookGroupDelete");
    int result = 0;
    logger.info(pmap.toString());
    result = AddBookDAO.addBookGroupDelete(pmap);
    return result;
  }
  
  public int addBookDelete(List<Long> manage_id) {
    logger.info("addBookDelete");
    int result = 0;
    logger.info(manage_id.toString());
    result = AddBookDAO.addBookDelete(manage_id);
    return result;
  }

}
