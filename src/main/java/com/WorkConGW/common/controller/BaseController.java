package com.WorkConGW.common.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.print.attribute.standard.Media;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
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

/* 
 * 작성자 : 오지환
 * 날짜 : 2024/01/27
 * 목적 : 파일처리 관련 컨트롤러 --> 실질적 사용x
 */

public class BaseController { 
   Logger logger = LoggerFactory.getLogger(BaseController.class);

    @Autowired
    private YAMLConfig config;
    //-> http://localhost:8000/board/fileUpload
    @PostMapping("fileUpload")
    public String fileUpload(@RequestParam(value="b_file", required = false)MultipartFile b_file) throws IOException{
        File upImage = new File(config.getUploadPath(), b_file.getOriginalFilename());
        b_file.transferTo(upImage);
        return b_file.getOriginalFilename();//사용자가 선택한 이미지 이름을 반환한다 avartart21.png
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
   

    }
    