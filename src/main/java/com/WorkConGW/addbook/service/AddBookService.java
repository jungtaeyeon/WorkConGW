package com.WorkConGW.addbook.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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

  public List<AddBookVO> addBookList(String empId) {
    logger.info("addBookList");
    List<AddBookVO> list = new ArrayList<>();
    list = AddBookDAO.addBookList(empId);
    logger.info(list.toString());
    return list;
  }
}
