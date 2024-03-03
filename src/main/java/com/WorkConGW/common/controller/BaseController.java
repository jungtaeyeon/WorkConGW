package com.WorkConGW.common.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

import javax.print.attribute.standard.Media;

import com.WorkConGW.common.PaginationInfo;
import com.WorkConGW.common.command.FileUploadCommand;
import com.WorkConGW.common.dto.AttachVO;
import com.WorkConGW.common.dto.BaseVO;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpSession;
import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import com.WorkConGW.YAMLConfig;

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class BaseController {
    Logger logger = LoggerFactory.getLogger(BaseController.class);

    private static final String SAVE_TOKEN = "SAVE_TOKEN";
    // 로그인중인 유저
    protected static Map<String, HttpSession> users = new HashMap<>();

    @Autowired
    protected YAMLConfig config;
    //-> http://localhost:8000/board/fileUpload
    @PostMapping("fileUpload")
    public String fileUpload(@RequestParam(value="b_file", required = false)MultipartFile b_file) throws IOException{
        File upImage = new File(config.getUploadPath(), b_file.getOriginalFilename());
        b_file.transferTo(upImage);
        return b_file.getOriginalFilename();//사용자가 선택한 이미지 이름을 반환한다 avartart21.png
    }

    protected List<AttachVO> saveFile(FileUploadCommand fileUploadCommand) throws Exception {

        List<AttachVO> attachList = new ArrayList<AttachVO>();

        if(fileUploadCommand.getUploadFile() != null) {

            for(MultipartFile multi : fileUploadCommand.getUploadFile()) {
                if(multi.isEmpty()) continue;
                String attachName = UUID.randomUUID().toString().replace("-", "") +
                        "$$" + multi.getOriginalFilename();
                File target = new File(fileUploadCommand.getFileUploadPath(), attachName);

                if (!target.exists()) {
                    target.mkdirs();
    
                }

                multi.transferTo(target);

                AttachVO attach = new AttachVO();
                attach.setAttach_path(fileUploadCommand.getFileUploadPath() + File.separator + attachName);
                attach.setAttach_name(multi.getOriginalFilename());
                attach.setAttach_type(attachName.substring(attachName.lastIndexOf(".")+1).toUpperCase());

                File file = new File(attach.getAttach_path());
                String attachSize = file.length()/1000 + "KB";

                attachList.add(attach);
            }
        }

        return attachList;
    }



    //목록에서 첨부파일 이름을 클릭하면 호출되는 메소드 구현하기
    @GetMapping("fileDownLoad")
    public ResponseEntity<Resource> fileDownLoad(String filename){
        try {
            File file = new File(config.getUploadPath(), URLDecoder.decode(filename, "UTF-8"));
            HttpHeaders header = new HttpHeaders();
            header.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename="+filename);
            header.add("Cache-Control", "no-cache, no-store, must-relalidate");
            header.add("Pragma", "no-cache");
            header.add("Expires", "0");
            Path path = Paths.get(file.getAbsolutePath());
            ByteArrayResource resource = new ByteArrayResource(Files.readAllBytes(path));
            return ResponseEntity.ok()
                    .headers(header)
                    .contentLength(file.length())
                    .contentType(MediaType.parseMediaType("application/octet-stream"))
                    .body(resource);
        } catch (IOException e) {
            e.printStackTrace();//메소드를 print에 넣지 말것 - 라인번호, 에러이력까지도 출력
            return null;
        }
    }

    @GetMapping("imageGet")
    public String imageGet(HttpServletRequest req, HttpServletResponse res) {
        String b_file = req.getParameter("imageName");
        logger.info("imageGet 호출 성공===>"+b_file);
        String filePath =config.getUploadPath(); // 절대경로.
        //String filePath ="upload"; // 절대경로.
        String fname = b_file;
        logger.info("b_file: 8->euc"+b_file);
        File file = new File(filePath,b_file.trim());
        String mimeType = req.getServletContext().getMimeType(file.toString());
        if(mimeType == null){
            res.setContentType("application/octet-stream");
        }
        String downName = null;
        FileInputStream fis = null;
        ServletOutputStream sos = null;
        try{
            if(req.getHeader("user-agent").indexOf("MSIE")==-1){
                downName = new String(b_file.getBytes("UTF-8"),"8859_1");
            }else{
                downName = new String(b_file.getBytes("EUC-KR"),"8859_1");
            }
            res.setHeader("Content-Disposition", "attachment;filename="+downName);
            fis = new FileInputStream(file);
            sos = res.getOutputStream();
            byte b[] = new byte[1024*10];
            int data = 0;
            while((data=(fis.read(b,0,b.length)))!=-1){
                sos.write(b,0,data);
            }
            sos.flush();
        }catch(Exception e){
            logger.info(e.toString());
        }finally{
            try {
                if(sos != null) sos.close();
                if(fis != null) fis.close();
            } catch (Exception e2) {
                // TODO: handle exception
            }
        }

        //byte[] fileArray = boardLogic.imageDownload(imageName);
        //logger.info(fileArray.length);
        return null;
    }// end of imageGet


    public ResponseEntity<byte[]> getPicture(String picturePath, String picture) throws Exception{
        // EmpCotroller.(baseController호출) -> BaseController
        ResponseEntity<byte[]> entity = null;
        InputStream in = null;
        String imgPath = picturePath;
        try {
            in = new FileInputStream(new File(imgPath, picture));
            entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), HttpStatus.CREATED);
            /* IOUtils.toByteArray(in) : 바이트 배열로 변환
             * 200 OK: 성공적으로 처리했을 때 쓰인다. 가장 일반적으로 볼 수 있는 HTTP 상태
             * 201 Created: 요청이 성공적으로 처리되어서 리소스가 만들어졌음을 의미한다.
             * - POST 나 PUT 으로 게시물 작성이나 회원 가입 등의 새로운 데이터를 서버에 생성하는(쓰는, 넣는) 작업이 성공했을 때 반환한다.
             */
        } catch (IOException e) {
            e.printStackTrace();
            entity = new ResponseEntity<byte[]>(HttpStatus.INTERNAL_SERVER_ERROR);
        } finally {
            in.close();
        }
        return entity;
    }



    // 새로고침 조회수 증가 방지
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

    public void removeCookieByName(HttpServletRequest request, HttpServletResponse response, String deleteCookieName) throws Exception{
        Cookie[] cookies = request.getCookies();
        for(Cookie cookie : cookies) {
            if(cookie.getName().equals(deleteCookieName)) {
                cookie.setMaxAge(0);
                response.addCookie(cookie);
                break;
            }
        }
    }

    protected void setUpPaginationInfo(PaginationInfo paginationInfo, BaseVO baseVO) {


        List<BaseVO> pageUnitSelector = new ArrayList<BaseVO>();
        BaseVO pageUnitVO = null;
        for(String unit : BaseVO.PAGE_UNITS) {
            pageUnitVO = new BaseVO();
            pageUnitVO.setPageUnitValue(unit);
            pageUnitVO.setPageUnitLabel(unit+"개씩");
            pageUnitSelector.add(pageUnitVO);
        }
        baseVO.setPageUnitSelector(pageUnitSelector);

        paginationInfo.setCurrentPageNo(baseVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(baseVO.getPageUnit());
        paginationInfo.setPageSize(baseVO.getPageSize());

        baseVO.setFirstIndex(paginationInfo.getFirstRecordIndex()+1);
        baseVO.setLastIndex(paginationInfo.getLastRecordIndex());
        baseVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

    }

}
