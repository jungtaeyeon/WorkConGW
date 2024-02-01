package com.WorkConGW.emp.controller;

import org.json.simple.JSONObject;
import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.io.IOException;
import java.io.PrintWriter;

import com.WorkConGW.YAMLConfig;
import com.WorkConGW.emp.dto.EmpVO;
import com.WorkConGW.emp.service.EmpService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.sql.SQLException;

import jakarta.servlet.http.HttpServletResponse;


    /* @작성자 : 오지환
    *  @작성일자 : 2024-01-26
    *  @설계목적: 사원 공통코드작성
    */

@Controller
@RequestMapping("/emp/*")
public class EmpController {
    Logger logger = LoggerFactory.getLogger(EmpController.class);

    @Autowired
    EmpService empService;
    @Autowired
    private YAMLConfig Config;




    @PostMapping("/checkEmpUpdateYn")
    @ResponseBody
    public ResponseEntity<String> checkEmpUpdateYn()throws SQLException{
        logger.info("checkEmpUpdateYn 여기들어오니?");
        ResponseEntity<String> entity = null;
        EmpVO empVO = empService.checkEmpUdateYn(); // 다오에 접근해서 사용자에 대한 정보를 불러옴
        String empUpdateYn = empVO.getEmp_Update_Yn();
        logger.info(empUpdateYn);
        
        if(empUpdateYn == "" || empUpdateYn == "Y" || empUpdateYn == null)
        {
            logger.info("여기는?");
            entity = new ResponseEntity<>("fail",HttpStatus.OK);
        }
        else{
            entity = new ResponseEntity<>("success",HttpStatus.OK);
        }

        return entity; // 이 entity값으로 자바스크립트단에서 분기처리 진행 

    }


    @PostMapping("/register")
    public String register(EmpVO empVO, RedirectAttributes rttr,Model model)
    {
        logger.info("register");
        String hashedPw = BCrypt.hashpw(empVO.getEmp_Pwd(), BCrypt.gensalt());
        empVO.setEmp_Pwd(hashedPw); // 암호화된 정보를 넣는다.
        empService.register(empVO);
        model.addAttribute("emp",empVO);
        rttr.addFlashAttribute("msg", "가입이 완료되었습니다.");
        rttr.addFlashAttribute("emp_Email",empVO.getEmp_Email());
        rttr.addFlashAttribute("emp_Id", empVO.getEmp_Id());

        
        return "redirect:/common/loginForm";
    }



    @PostMapping("/idCnt")
    @ResponseBody
    public String idCnt(@RequestBody String filterJSON, HttpServletResponse response, ModelMap model)throws IOException{
        JSONObject resMap = new JSONObject(); //JSON으로 변환
            ObjectMapper mapper = new ObjectMapper();
            EmpVO searchVO = (EmpVO)mapper.readValue(filterJSON, new TypeReference<EmpVO>(){}); //JSON -> JAVA로 변환
            logger.info(searchVO.toString());
            int idCnt = empService.idCnt(searchVO);
            resMap.put("res","ok");
            resMap.put("idCnt",idCnt);
        
        logger.info("idCnt"+resMap);
        response.setContentType("text");
        PrintWriter out = response.getWriter();
        out.print(resMap);
        return null;

    }

    @GetMapping("/registerView")
    public String registerView(){
        return "/common/join";
    }

    @PostMapping("registSign")
    public ResponseEntity<String> updateSign(@RequestParam(value = "myEmpSign" , required=false) MultipartFile SignImage, @SessionAttribute("loginUser")EmpVO empVO,RedirectAttributes attr) throws IOException,IllegalStateException
    {
        String webPath = "C:/Users/Ohjihwan/Desktop/ProjectTest/마이페이지/WorkConGW/src/main/webapp/pds/sign";
        int result = empService.updateSign(SignImage,webPath,empVO);
        String msg = "";
        ResponseEntity<String> entity = null;
        if(result > 0)
        {
            msg = "서명 이미지가 등록 되었습니다.";
            entity = new ResponseEntity<>(msg , HttpStatus.OK);

        }
        else{
            msg = "서명 이미지가 없습니다.";
            entity = new ResponseEntity<>(msg, HttpStatus.OK);

        }

        return entity;



    }





	
}
