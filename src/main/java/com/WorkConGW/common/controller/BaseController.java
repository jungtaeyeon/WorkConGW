package com.WorkConGW.common.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.validator.GenericValidator;
import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import com.WorkConGW.common.dto.BaseVO;
import com.WorkConGW.common.service.CodeService;
import com.WorkConGW.emp.dto.EmpVO;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class BaseController {
	

        protected CodeService codeService;
        

        private static final String SAVE_TOKEN = "SAVE_TOKEN";
        // 로그인중인 유저
        protected static Map<String, HttpSession> users = new HashMap<>();
        
        
        public static void setSaveToken(HttpSession session, BaseVO baseVO){
            String saveToken = UUID.randomUUID().toString(); //무작위의 고유 식별자(UUID)를 생성
            baseVO.setSaveToken(saveToken); 
            
      
    
            @SuppressWarnings("unchecked")
            List<String> saveTokenList = (List<String>)session.getAttribute(SAVE_TOKEN);

            if(saveTokenList == null){
                saveTokenList = new ArrayList<String>();
                session.setAttribute(SAVE_TOKEN, saveTokenList);
            }
            saveTokenList.add(saveToken);    	

    
            
        }
        
        /** 중복등록 방지: token 유효성 검증 */

        //1. 전달된 BaseVO에서 saveToken 가져옴
        public static boolean isValidateSaveToken(HttpSession session, BaseVO baseVO){
            boolean isValid = false;
            String saveToken = baseVO.getSaveToken(); 

            //2. saveToken이 Null 또는 빈 문자열이 아닌 경우에만 검증을 수행
            if(!GenericValidator.isBlankOrNull(saveToken)){
                @SuppressWarnings("unchecked")
                List<String> saveTokenList = (List<String>)session.getAttribute(SAVE_TOKEN);
                if(saveTokenList.contains(saveToken)){
                    isValid = true;
                    saveTokenList.remove(saveToken);
                }
            }    	
            return isValid;
        }
        
        
        /**
         * 이미지 업로드 메서드
         * @param picturePath 이미지 저장 경로
         * @param multi 업로드할 파일객체
         * @param oldPicture 삭제예정인 파일객체(없을 시 "")
         * @param fileEmpId 이미지 소유 직원 id
         * @return ResponseEntity<String>
         * @throws Exception
         */
        public ResponseEntity<String> setPicture(String picturePath, MultipartFile multi, String oldPicture, String fileEmpId) throws Exception{
            ResponseEntity<String> entity = null;
            
            String result = "";
            HttpStatus status = null;
            
            /*파일저장 확인*/
            if((result = checkPicture(picturePath,oldPicture,multi,fileEmpId)) == null) {
                result = "업로드를 실패했습니다.";
                status = HttpStatus.BAD_REQUEST;
            } else {
                status = HttpStatus.OK;
            }
            
            entity = new ResponseEntity<String>(result, status);
            
            return entity;
        }
        
        /** 이미지 유무 확인 및 사진이름 생성 */
        public String checkPicture(String picturePath, String oldPicture, MultipartFile multi, String fileEmpId) throws Exception{
            String fileName = null;
            
            /*파일유무 확인*/
            if(!(multi == null || multi.isEmpty() || multi.getSize() > 1024 * 1024 * 1)) {
                String uploadPath = picturePath;
                String fileType = multi.getOriginalFilename().split("\\.")[1];
   
    
                fileName = fileEmpId + "." + fileType;
                File saveFile = new File(uploadPath, fileName);
                
                saveFile.mkdirs();
                
                multi.transferTo(saveFile);
                
                if(!oldPicture.isEmpty()) {
                    File oldFile = new File(uploadPath,oldPicture);
                    if(oldFile.exists()) { // 이전파일경로가 존재  -> 제거
                        oldFile.delete();
                    }
                }
            }
            
            return fileName;
        }
        
        /** 
         * 저장된 이미지 조회 메서드
         * @param picturePath 이미지 저장경로
         * @param picture 조회할 이미지 이름
         * @return ResponseEntity<byte[]>
         * @throws Exception
         */
        public ResponseEntity<byte[]> getPicture(String picturePath, String picture) throws Exception{
            // EmpCotroller.(baseController호출) -> BaseController 
            ResponseEntity<byte[]> entity = null;
            InputStream in = null;
            String imgPath = picturePath;
            try {
                in = new FileInputStream(new File(imgPath, picture));
                entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), HttpStatus.CREATED);
            } catch (IOException e) {
                e.printStackTrace();
                entity = new ResponseEntity<byte[]>(HttpStatus.INTERNAL_SERVER_ERROR);
            } finally {
                in.close();
            }
            return entity;
        }
        
        // 댓글 등록시 조회수 증가 막기
        public boolean isCookieExist(HttpServletRequest request, HttpServletResponse response, String cookieName, String cookieValue) throws Exception {
            boolean isExist = false;
            Cookie[] cookies = request.getCookies();
            Cookie checkCookie = null; 
            if(cookies != null && cookies.length > 0) {
                for(Cookie cookie : cookies) {
                    if(cookie.getName().equals(cookieName) && cookie.getValue().equals(cookieValue)) {	// 쿠키가 존재하면
                        checkCookie = cookie; 
                        /* 쿠키가 존재한다는 얘기 */
                        break; // breadk는 가까운 for문 탈출~ 다음 로직은 밑에 else isExist = true (존재하니깐)
                    }
                }
            }
            
            if(checkCookie == null) {	// 쿠키가 존재하지 않으면
                Cookie newCookie = new Cookie(cookieName, cookieValue);
                response.addCookie(newCookie); // 클라이언트에 쿠키값을 보낸다.
            }else {	// 쿠키가 존재하면
                isExist = true;
            }
            return isExist;
        }
        
        // 해당 이름의 쿠키 삭제
        public void removeCookieByName(HttpServletRequest request, HttpServletResponse response, String deleteCookieName) throws Exception{
            Cookie[] cookies = request.getCookies();
            for(Cookie cookie : cookies) {
                if(cookie.getName().equals(deleteCookieName)) {
                    cookie.setMaxAge(0);
                    response.addCookie(cookie); // 꼭 시간 설정을 0 으로하고 클라이언트에 내려줘야된다. 명심하자. 
                    break;
                }
            }
        }
        
        // 로그인 유저 정보 리스트로 가져오기
        public static List<EmpVO> getLoginUserList() throws Exception{
            List<EmpVO> loginUserList = new ArrayList<>();
            /* users : 전역변수로 static 으로 선언되어있음 */
            for(HttpSession session : users.values()) {
                EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
                loginUserList.add(empVO);
            }
            
            return loginUserList;
        }
    }
    
