package com.WorkConGW.addbook.dao;



import java.util.List;
import java.util.Map;
import java.util.HashMap;
import org.apache.commons.collections.map.HashedMap;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.WorkConGW.addbook.dto.AddBookVO;



@Repository
public class AddBookDAO {
  private static final Integer Inteager = null;
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
    result = sqlSessionTemplate.delete("addBookGroupDelete", pmap);
    return result;
  }

  public int shareAddBookGroupDelete(Map<String, Object> pmap) {
    logger.info("shareAddBookGroupDelete");
    int result = 0;
    result = sqlSessionTemplate.delete("shareAddBookGroupDelete", pmap);
    logger.info(Integer.toString(result));
    return result;
  }

  public int addBookDelete(List<Long> manage_id) {
    logger.info("addBookDelete");
    int result = 0;
    logger.info(manage_id.toString());
    result = sqlSessionTemplate.delete("addBookDelete", manage_id);
    return result;
  }

  public int addBookShareInsert(Map<String, Object> pmap) {
    logger.info("addBookShareInsert");
    int result = 0;
    logger.info(pmap.toString());
    
    // emp_id_list에서 각각의 emp_id를 가져와서 처리합니다.
    List<String> empIdList = (List<String>) pmap.get("emp_id_list");
    String empId = (String) pmap.get("empId");
    String addBookId = (String) pmap.get("add_book_id");
    
    // 각각의 emp_id를 처리하는데 사용할 Map을 생성합니다
    Map<String, Object> paramMap = new HashMap<>();
    paramMap.put("add_book_id", addBookId);
    sqlSessionTemplate.update("addBookShareInsertUpdate", paramMap);
    // emp_id_list에 있는 각각의 emp_id를 처리합니다.
    for (String emp_id : empIdList) {
        paramMap.put("empId", empId);
        paramMap.put("emp_id", emp_id);
        // MyBatis의 insert 쿼리를 실행합니다.
        logger.info(paramMap.toString());
        result += sqlSessionTemplate.insert("addBookShareInsert", paramMap);
    }
    sqlSessionTemplate.insert("addBookShareManageUpdate", paramMap);
    logger.info(Integer.toString(result));
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
    result = sqlSessionTemplate.delete("addBookStarredDelete", pmap);
    logger.info(Integer.toString(result));
    return result;
  }

  public int messageInsert(Map<String, Object> pmap) {
    logger.info("messageInsert");
    int result = 0;
    logger.info(pmap.toString());

    
    List<String> manage_emp_id_list = (List<String>) pmap.get("manage_emp_id");
    String messageContent = (String) pmap.get("messageContent");

    // 각각의 emp_id를 처리하는데 사용할 Map을 생성합니다
    Map<String, Object> paramMap = new HashMap<>();
    paramMap.put("messageContent", messageContent);
    
    // emp_id_list에 있는 각각의 emp_id를 처리합니다.
    for (String manage_emp_id : manage_emp_id_list) {
        paramMap.put("manage_emp_id", manage_emp_id);
        // MyBatis의 insert 쿼리를 실행합니다.
        logger.info(paramMap.toString());
        result = sqlSessionTemplate.insert("messageInsert", pmap);
        Long sequenceKey = (Long)pmap.get("id");
        paramMap.put("sequenceKey", sequenceKey);
        sqlSessionTemplate.insert("receivermessageInsert", paramMap);
    }
    return result;
  }

  public List<AddBookVO> messageList(Map<String, Object> pmap) {
    logger.info("messageList");
    AddBookVO addBookVO = new AddBookVO();
    List<AddBookVO> list = sqlSessionTemplate.selectList("messageList", pmap);
    logger.info(list.toString());
    return list;
  }

  public List<AddBookVO> messageDetail(Map<String, Object> pmap) {
    logger.info("messageDetail");
    AddBookVO addBookVO = new AddBookVO();
    List<AddBookVO> list = sqlSessionTemplate.selectList("messageDetail", pmap);
    logger.info(list.toString());
    return list;
  }

  public int messageDelete(List<Long> manage_id) {
    logger.info("messageDelete");
    int result = 0;
    logger.info(manage_id.toString());
    result = sqlSessionTemplate.update("messageDelete", manage_id);
    sqlSessionTemplate.update("receivermessageDelete", manage_id);
    logger.info(Inteager.toString(result));
    return result;
  }

  public List<AddBookVO> receiverList(Map<String, Object> pmap) {
    logger.info("receiverList");
    AddBookVO addBookVO = new AddBookVO();
    List<AddBookVO> list = sqlSessionTemplate.selectList("receiverList", pmap);
    logger.info(list.toString());
    return list;
  }

  public List<AddBookVO> receiverDetail(Map<String, Object> pmap) {
    logger.info("receiverDetail");
    AddBookVO addBookVO = new AddBookVO();
    List<AddBookVO> list = sqlSessionTemplate.selectList("receiverDetail", pmap);
    sqlSessionTemplate.update("receiverRead", pmap);
    logger.info(list.toString());
    return list;
  }

  public int receiverDelete(List<Long> manage_id) {
    logger.info("receiverDelete");
    int result = 0;
    logger.info(manage_id.toString());
    result = sqlSessionTemplate.update("receivermessageDelete", manage_id);
    logger.info(Inteager.toString(result));
    return result;
  }
}
