 package com.WorkConGW.emp.service;

import java.io.File;
import java.nio.charset.Charset;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.WorkConGW.common.command.FileUploadCommand;
import com.WorkConGW.mail.MailUtils;
import com.WorkConGW.mail.TempKey;
import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.text.SimpleDateFormat;
import com.WorkConGW.common.service.HomeService;
import com.WorkConGW.emp.dao.EmpDAO;
import com.WorkConGW.emp.dto.EmpVO;
import com.WorkConGW.exception.InvalidPasswordException;
import com.WorkConGW.exception.NotFoundIDException;

import jakarta.servlet.http.HttpSession;

 @Service
public class EmpService {

    Logger logger = LoggerFactory.getLogger(EmpService.class);
    @Autowired 
    private HomeService homeService;
    @Autowired
    private JavaMailSender mailSender;

     @Value("${SignPath}")
     private String SignPath;

    @Autowired
    private EmpDAO empDAO;
    public EmpVO login(String empId, String empPwd ,HttpSession session)throws SQLException, NotFoundIDException,InvalidPasswordException {
        
        EmpVO emp = empDAO.selectEmpById(empId);

        if(emp == null) 
        {
            throw new NotFoundIDException(); // 아이디 자체가 없다는 뜻
        }

        if(!BCrypt.checkpw(empPwd,emp.getEmp_Pwd())) // 조회된 emp.getEmp_Pwd()값과 empPwd가 같지 않다면,
        { 
            throw new InvalidPasswordException(); // 비밀번호가 다르다는 에러를 던져라
        }
        session.setAttribute("loginUser", emp);
        return emp;
    }





    public int findPwCheck(EmpVO empVO)
    {
        return empDAO.findPwCheck(empVO);
    }


	public EmpVO getEmp(String emp_Id) {
        EmpVO empVO = empDAO.selectEmpById(emp_Id);
        logger.info(empVO.toString());
        return empVO;
	}


    public EmpVO checkEmpUdateYn() throws SQLException {
        /* 여기서 세션을 받아서 구현하자.. -> Service 계층에서 Session을 사용하려면 */
        ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
        EmpVO empVO = (EmpVO)session.getAttribute("loginUser"); // 로그인 유저는 어디서 담기는가? 로그인 시 login Service에서 담긴다.
        String emp_Id = empVO.getEmp_Id(); // 세션으로부터 사용자로부터 id값을 가져온다.
        logger.info(emp_Id);
        empVO = empDAO.selectEmpById(emp_Id);
        return empVO;
    }


     public int updateSign(MultipartFile signImage,String SignPath ,EmpVO empVO) throws IOException, IllegalStateException{
         String temp = empVO.getEmp_Sign(); // 사인 값을 가져옴
         String rename = null; //  변경 시 이름을 담을 변수
         if(signImage.getSize()>0) //업로드 된 사인 이미지가 있을 경우
         {
             rename = fileRename(signImage.getOriginalFilename(), empVO);
             empVO.setEmp_Sign(rename);
         }
         else{ // 없는 경우
             empVO.setEmp_Sign(null); // null값을 주지 않으면 NullPointerException이 발생함.
         }
         int result = empDAO.updateSign(empVO); // temp나 rename을 넘기는 것이 아니라, VO자체를 넘긴다.

         if(result>0) // 성공했다는 의미
         {if(rename!=null)
         {
             if(empVO.getEmp_Sign()!=null)
             {
                 Path filePath = Paths.get(SignPath, rename);
                 // 파일 저장
                 signImage.transferTo(filePath.toFile());
             }
         }}
         else{ //실패함
             empVO.setEmp_Sign(temp); // 이전 이미지로 저장
         }
         return result;
     }

    private String fileRename(String originalFilename, EmpVO empVO) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
		String date = sdf.format(new java.util.Date(System.currentTimeMillis()));
		
		int ranNum = (int) (Math.random() * 100000); // 5자리 랜덤 숫자 생성
		
		String str = "_" + String.format("%05d", ranNum);
		
		String ext = originalFilename.substring(originalFilename.lastIndexOf("."));
		return empVO.getEmp_Id()+ext;
    }



    public void modifyEmp(EmpVO empVO) throws SQLException {
        logger.info("modify여기들어옴?");
		empDAO.updateEmpMyPage(empVO);
	}

    public void adminEmpUpdate(EmpVO empVO) throws  SQLException{
        empDAO.adminEmpUpdate(empVO);
    }

    @Transactional
    public void register(EmpVO empVO)
    {
        logger.info(empVO.toString());
       try{
        empDAO.register(empVO);

        String key = new TempKey().getKey(50,false);
        empDAO.createAuthKey(empVO.getEmp_Email(), key);
        MailUtils sendMail = new MailUtils(mailSender);
        sendMail.setSubject("[WorkConGW 그룹웨어 이메일 인증메일입니다.]");
           sendMail.setText(
                   "<h1>메일인증</h1>" +
                           "<br/>WorkconGW에 회원가입해주셔서 감사합니다."+
                           "<br/>아래 [이메일 인증 확인]을 눌러주세요."+
                           "<a href='http://localhost:8000/WorkConGW/emp/registerEmail?emp_Email=" + empVO.getEmp_Email() +
                           "&key=" + key +
                           "' target='_blenk'>이메일 인증 확인</a>");
        sendMail.setFrom("ohjihwan170@gamil.com", "오지환");
        sendMail.setTo(empVO.getEmp_Email());
        sendMail.send();
       }catch(Exception e)
       {
        e.printStackTrace();
       }
    }

    public void empAuth(String email_Emp,String authKey) throws Exception{
		empDAO.empAuth(email_Emp,authKey);
	}

    public int idCnt(EmpVO empVO)
    {
        return empDAO.idCnt(empVO);
    }

     public String empId() {
        return empDAO.empId();
     }



    public List<EmpVO> selectEmpList() throws SQLException{
        logger.info("empList");
        List<EmpVO> empList = empDAO.selectEmpList();
        return empList;
    }

    public List<EmpVO> selectEmpIdListByDeptId(EmpVO empVO) throws SQLException{
        ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = servletRequestAttribute.getRequest().getSession(true);

        if("dept".equals(empVO.getFlag())) {
            logger.info("emp부서");
            EmpVO emp = (EmpVO)session.getAttribute("loginUser");
            String deptId = emp.getDept_Id();
            empVO.setDept_Id(deptId);
        }else if("team".equals(empVO.getFlag())) {
            logger.info("emp팀");
            EmpVO emp = (EmpVO)session.getAttribute("loginUser");
            String teamId = emp.getTeam_Id();
            logger.info(teamId);
            empVO.setTeam_Id(teamId);

        }
        List<EmpVO> empList = empDAO.selectEmpIdListByDeptId(empVO);
        /* 조인을 걸 떄, deptId, teamId로함. */
        return empList;
    }



     public List<EmpVO> selectEmpPagingList(EmpVO searchEmpVO) {

        List<EmpVO> empVOList = new ArrayList<>();
        empVOList = empDAO.selectEmpPagingList(searchEmpVO);
        return empVOList;
     }

     public int selectEmpCount(EmpVO searchEmpVO) {
         return empDAO.selectEmpCount(searchEmpVO);
     }

     public List<EmpVO> searchLoginUser(EmpVO empVO) {
        return empDAO.searchLoginUser(empVO);
     }

     public void findPw(String emp_Email, String emp_Id) throws Exception{
        String empKey = new TempKey().getKey(6,false);
        String empPw = BCrypt.hashpw(empKey,BCrypt.gensalt()); // 여가서 사용자의 비밀번호를 암호호한다.(물론 키값)
        empDAO.findPw(emp_Email,emp_Id,empPw); // 여기서 난수로 비번을 업데이트함
        MailUtils sendMail = new MailUtils(mailSender);
        sendMail.setSubject("[WorkConGW 임시비밀번호입니다.]");
        sendMail.setText(
                "<h1>임시비밀번호 발급</h1>" +
                        "<br/>"+emp_Id+"님" +
                        "<br/> 비밀번호 찾기를 통한 임시 비밀번호입니다."+
                        "<br/>임시비밀번호 : <h2>"+empKey+"</h2>" +
                        "<br/>로그인 후 비밀번호 변경을 해주세요."+
                        "<a href='http://localhost:8080/WorkConGW/common/loginForm"+
                        ">로그인 페이지</a>");

         sendMail.setFrom("ohjihwan170@gamil.com", "오지환");
         sendMail.setTo(emp_Email);
         sendMail.send();
     }

     public int findIdCheck(String emp_Email)
     {
         return empDAO.findIdCheck(emp_Email);
     }


     public List<EmpVO> findId(EmpVO empVO)
     {
         return empDAO.findId(empVO);
     }

     public void modifyEmpPwd(EmpVO empVO) {
        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes)RequestContextHolder.currentRequestAttributes();
        HttpSession session = servletRequestAttributes.getRequest().getSession();
        EmpVO emp = (EmpVO)session.getAttribute("loginUser");
        logger.info(emp.toString());
        String empId = emp.getEmp_Id();
        empVO.setEmp_Id(empId);
        String empPw = BCrypt.hashpw(empVO.getEmp_Pwd(),BCrypt.gensalt());
        logger.info(empPw);

        emp.setEmp_Pwd(empPw);
        empDAO.modifyEmpPwd(empVO);
     }

     public int firstChangeAction(EmpVO empVO) {
        String empPw = BCrypt.hashpw(empVO.getEmp_Pwd(),BCrypt.gensalt());
        empVO.setEmp_Pwd(empPw);
        logger.info(empVO.toString());
       int cnt =  empDAO.modifyEmpPwd(empVO);
       logger.info(String.valueOf(cnt));
       return cnt;
     }

     public int compareEmpByPwd(EmpVO empVO) {
        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = servletRequestAttributes.getRequest().getSession();
        EmpVO emp = (EmpVO) session.getAttribute("loginUser");
        String empId = emp.getEmp_Id();
        empVO.setEmp_Id(empId);
        int cnt = empDAO.selectByPwd(empVO);
        return cnt;
     }

     public boolean firstCompareEmpPwd(EmpVO empVO) {
         logger.info(empVO.toString());
         EmpVO emp = empDAO.selectEmpById(empVO.getEmp_Id());
         boolean check = BCrypt.checkpw(empVO.getEmp_Pwd(),emp.getEmp_Pwd());
         logger.info(String.valueOf(check));
         return check;
     }

     public void registSign(EmpVO empVO) throws IOException{
        logger.info("registSign");
         FileUploadCommand fileUploadCommand = empVO.getFileUploadCommand();
         String fileUploadPath = fileUploadCommand.getFileUploadPath();
         List<MultipartFile> files = (List<MultipartFile>)fileUploadCommand.getUploadFile();

         logger.info(files.toString());
         for(MultipartFile file : files)
         {
             File target  =  new File(fileUploadPath,empVO.getEmp_Id()+".png");
             if (!target.exists()) {
                 target.mkdirs();
                 // 상위디렉토리가 존재하지 않는경우 상위 디렉토리까지 생성
                 // https://froginpot.tistory.com/51
                 file.transferTo(target);
                 //디비에 정보 입력
                 empDAO.updateSign(empVO);
             }
         }

     }

     public void registerDashBoard(EmpVO empVO) {
         String emp_Id = empVO.getEmp_Id();
         logger.info(emp_Id);
         empDAO.registerDashBoard(emp_Id);
     }
 }
