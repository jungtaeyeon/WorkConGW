package com.WorkConGW.addbook.dao;



import java.util.List;
import java.util.Map;

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
  public List<AddBookVO> addBookList(String empId) {
    logger.info("addBookList");
    AddBookVO addBookVO = new AddBookVO();
   
    logger.info(empId);
    List<AddBookVO> list = sqlSessionTemplate.selectList("addBookList", empId);
    logger.info(list.toString());
    return list;
  }

public List<AddBookVO> addBookSearch(Map<String, Object> pmap) {
    logger.info("addBookSearch");
    AddBookVO addBookVO = new AddBookVO();
    logger.info(pmap.toString());
    List<AddBookVO> list = sqlSessionTemplate.selectList("addBookSearch", pmap);
    logger.info(list.toString());
    return list;
}

}
