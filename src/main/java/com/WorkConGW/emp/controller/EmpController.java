package com.WorkConGW.emp.controller;

import com.google.api.Http;
import jakarta.servlet.http.HttpServletRequest;
import org.json.simple.JSONObject;
import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
import java.util.List;
import java.util.Map;

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

    @Value("${uploadPath}")
    private String fileUploadPath;

    @Value("${SignPath}")
    private String SignPath;



    @PostMapping("/checkEmpUpdateYn")
    @ResponseBody
    public ResponseEntity<String> checkEmpUpdateYn()throws SQLException{
        logger.info("checkEmpUpdateYn 여기들어오니?");
        ResponseEntity<String> entity = null;
        EmpVO empVO = empService.checkEmpUdateYn(); // 다오에 접근해서 사용자에 대한 정보를 불러옴
        String empUpdateYn = empVO.getEmp_Update_Yn();

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
    public String register(EmpVO empVO,Model model)
    {
        logger.info("register");
        logger.info(empVO.getEmp_Id());
        empService.registerDashBoard(empVO);
        String hashedPw = BCrypt.hashpw(empVO.getEmp_Pwd(), BCrypt.gensalt());
        empVO.setEmp_Pwd(hashedPw); // 암호화된 정보를 넣는다.

        empService.register(empVO);

        model.addAttribute("emp",empVO);


        
        return "redirect:/admin/emp/empInsert";
    }

    @PostMapping("/findPw")
    public String findPw(EmpVO empVO, Model model) throws Exception
    {
        logger.info("findPw : "+empVO.toString());

        logger.info("findPw");
        if(empService.findPwCheck(empVO) == 0) // 0이라는 것은 결과가 틀렸다는 것.
        {
         logger.info("empService.findPwCheck if문에 진입함");
         model.addAttribute("msg", "아이디와 비밀번호를 확인해주세요");
         return "/common/loginForm";
        }else{
            empService.findPw(empVO.getEmp_Email(),empVO.getEmp_Id());
            model.addAttribute("empVO", empVO);
            return "/common/findPw"; // 임시비멀번호 뿌리는 창
        }

    }

    @GetMapping("/findIdView")
    public String findIdView()
    {
        return "/common/findIdView";
    }



    @PostMapping("/findId")
    public ResponseEntity<String> findId(EmpVO empVO,Model model)
    {
        ResponseEntity<String> entity = null;
        String msg = "";
        logger.info("findId");
        if(empService.findIdCheck(empVO.getEmp_Email()) == 0)
        {
            logger.info("값이 없을 때");
            msg = "아이디와 이메일을 확인하세요";
            entity = new ResponseEntity<>(msg,HttpStatus.INTERNAL_SERVER_ERROR);
        }
        else
        {
            logger.info("여기니?");
            msg = "아이디를 찾았습니다.";
            entity = new ResponseEntity<>(msg,HttpStatus.OK);
        }

        return entity;


    }
    @GetMapping("/findList")
    public String findList(EmpVO empVO,Model model)
    {
        logger.info(empVO.toString());
        List<EmpVO> empVO1 = empService.findId(empVO);
        model.addAttribute("empVO", empVO1);
        return "/common/findList";
    }

    @GetMapping("/findPwView")
    public String findPwView()
    {
        return "/common/findPwView";
    }

    @GetMapping("/registerEmail")
    public String emailConfirm(String emp_Email,String authKey, Model model) throws  Exception{
        logger.info("emp_Email :" + emp_Email);
        empService.empAuth(emp_Email,authKey);
        model.addAttribute("emp_Email", emp_Email);
        return "/common/registerEmail";
    }


    @PostMapping("/compareEmpPwd")
    public ResponseEntity<String> compareEmpPwd(@RequestBody EmpVO empVO)
    {
        ResponseEntity<String> entity = null;
        int cnt = empService.compareEmpByPwd(empVO);


        if(cnt < 0)
        {
            entity = new ResponseEntity<>("fail", HttpStatus.OK);
        }

        else{
            entity = new ResponseEntity<>("success", HttpStatus.OK);
    }
        return entity;
    }





    @PostMapping("/firstCompareEmpPwd")
    public ResponseEntity<String> firstCompareEmpPwd(@RequestBody EmpVO empVO)
    {
        logger.info("firstCompareEmpPwd");
        logger.info(empVO.toString());
        ResponseEntity<String> entity = null;
        boolean type = empService.firstCompareEmpPwd(empVO);
        logger.info(String.valueOf(type));


        if(type==false)
        {
            entity = new ResponseEntity<>("false", HttpStatus.OK);
        }

        else{
            entity = new ResponseEntity<>("true", HttpStatus.OK);
        }
        return entity;
    }

    @PostMapping("/empId")
    @ResponseBody
    public ResponseEntity<Map<String,Object>> empId()
    {
        logger.info("empId들어오니?");
        JSONObject resMap = new JSONObject();
        String emp_Id = empService.empId();
        resMap.put("res","ok");
        resMap.put("emp_Id",emp_Id);
        return ResponseEntity.ok(resMap);

    }


    @GetMapping("/firstChange")
    public String firstChange()
    {
        return "/common/firstChange";
    }





    @ResponseBody
    @PostMapping("/firstChangeAction")
    public ResponseEntity<String> firstChangeAction(@RequestBody EmpVO empVO)
    {

        ResponseEntity<String> entity = null;
       int cnt = empService.firstChangeAction(empVO);

       if(cnt==0)
       {
           entity = new ResponseEntity<String>("fail",HttpStatus.INTERNAL_SERVER_ERROR);
       }
       else{
           entity = new ResponseEntity<String>("success", HttpStatus.OK);

       }
       return entity;

    }

    @PostMapping("/updateEmpPwd")
    public void updateEmpPwd(@RequestBody EmpVO empVO)
    {

        empService.modifyEmpPwd(empVO);
    }



    @PostMapping("/idCnt")
    @ResponseBody
    public String idCnt(@RequestBody String filterJSON, HttpServletResponse response, ModelMap model)throws IOException{
        JSONObject resMap = new JSONObject(); //JSON으로 변환하기 위해 사용
        ObjectMapper mapper = new ObjectMapper(); // JSON ->JAVA로 변환하기 위해 사용
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

//    @PostMapping("registSign")
//    public ResponseEntity<String> updateSign(@RequestParam(value = "myEmpSign" , required=false) MultipartFile SignImage, @SessionAttribute("loginUser")EmpVO empVO,RedirectAttributes attr) throws IOException,IllegalStateException
//    {
//
//        logger.info("registSign");
//        int result = empService.updateSign(SignImage,SignPath,empVO);
//        String msg = "";
//        ResponseEntity<String> entity = null;
//        if(result > 0)
//        {
//            msg = "서명 이미지가 등록 되었습니다.";
//            entity = new ResponseEntity<>(msg , HttpStatus.OK);
//
//        }
//        else{
//            msg = "서명 이미지가 없습니다.";
//            entity = new ResponseEntity<>(msg, HttpStatus.OK);
//
//        }
//
//        return entity;
//
//
//
//    }

    @PostMapping("registSign")
    public ResponseEntity<String> updateSign(@RequestParam(value = "myEmpSign" , required=false) MultipartFile SignImage, @SessionAttribute("loginUser")EmpVO empVO,RedirectAttributes attr) throws IOException,IllegalStateException
    {

        logger.info("registSign");
        int result = empService.updateSign(SignImage,SignPath,empVO);
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

   @GetMapping("/registerAuth")
    public String loginView(HttpServletRequest request, Model model, String emp_Email, String emp_Id){
        logger.info("loginView");
        logger.info("emp_Email:"+emp_Email+"emp_Id:"+emp_Id);

        model.addAttribute("emp_Email",emp_Email);
        model.addAttribute("emp_Id",emp_Id);

        return "/admin/emp/list";
    }


    @ResponseBody
    @PostMapping("/getEmp")
    public EmpVO getEmpFromId(@RequestBody String emp_Id) throws SQLException {
        EmpVO emp = empService.getEmp(emp_Id);
        return emp;
    }


	
}
