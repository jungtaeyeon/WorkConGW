package com.WorkConGW.common.controller;


import java.io.*;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import java.util.*;

import com.WorkConGW.common.PaginationInfo;
import com.WorkConGW.common.command.FileUploadCommand;
import com.WorkConGW.common.dto.DashboardVO;
import com.WorkConGW.common.dto.HomeFormVO;
import com.WorkConGW.common.dto.MenuVO;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonObject;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.WorkConGW.YAMLConfig;
import com.WorkConGW.approval.dto.ApprovalVO;
import com.WorkConGW.approval.service.ApprovalService;
import com.WorkConGW.board.issue.dto.IssueVO;
import com.WorkConGW.board.issue.dto.ProjectVO;
import com.WorkConGW.board.issue.service.IssueService;
import com.WorkConGW.board.issue.service.ProjectService;
import com.WorkConGW.board.duty.dto.DutyVO;
import com.WorkConGW.board.duty.service.DutyService;
import com.WorkConGW.board.notice.dto.NoticeVO;
import com.WorkConGW.board.notice.service.NoticeService;
import com.WorkConGW.common.service.HomeService;
import com.WorkConGW.common.service.MenuService;
import com.WorkConGW.emp.dto.EmpVO;
import com.WorkConGW.emp.service.EmpService;
import com.WorkConGW.exception.InvalidPasswordException;
import com.WorkConGW.exception.NotFoundIDException;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.util.UriUtils;


/*
* @작성자 : 오지환
* @내용 : 마이페이지 및 홈 화면 공통코드 작성 
*/
@Controller
@RequestMapping("/common/*")
public class CommonController {
    Logger logger = LoggerFactory.getLogger(CommonController.class);

    @Autowired
    private YAMLConfig config;

	@Autowired
	private EmpService empService;

    @Autowired
    private HomeService homeService;

    @Autowired
    private ApprovalService approvalService;
	
	@Autowired
	private MenuService menuService;

    @Autowired
	private IssueService issueService;

    @Autowired
	private ProjectService projectService;

    @Autowired
	private DutyService dutyService;

    @Value("${uploadPath}")
    private String fileUploadPath;

    @Value("${summernotePath}")
    private String summernotePath;

    @Autowired
    private NoticeService noticeService;

    protected static Map<String, HttpSession> users = new HashMap<>();

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

    //로그인중인 users 가져오기

    /* 작성자 : 오지환
    
    @ 메소드 설명
     * 로그인(Service) 단에서 로그인 유효성 검사를 진행한 뒤 setAttribute를 한다.
     * 이 때 session.setAttribute("loginUser",emp)를 갖는다.
     * 그렇게 되면 로그인 시 loginUser로 계속 setAttribute를 한다.
     *
     * 이걸 받아올 떄, 그래서 EmpVO empVO = (EmpVO)session.getAttribute("loginUser)로 받아오면,
     * empVO는 축적 되어 있는 loginUser를 for문을 돌면서 받게 된다.
     * 그 값을 loginUserList에 add한다(empVO)

    @ 언제 사용하는가? : 관리자(지금 접속한 인원 체크할 때)
    - getLoginUserList를 받아온다. 이 때, getLoginUserList가 static이라는 것을 명심하자.
   
    @ searchLoginUser 여기서 사용

     * */
    public static List<EmpVO> getLoginUserList()
    {
        List<EmpVO> loginUserList = new ArrayList<>();
        /*
        * users value에 접근하기 위해서 HttpSession값에 접근해야 됐다.
        *
        * */
        for(HttpSession session : users.values())
        {
            EmpVO empVO = (EmpVO)session.getAttribute("loginUser");

            loginUserList.add(empVO);
        }
        return loginUserList;
    }



    @GetMapping("/home")
    public String home(HomeFormVO homeFormVO, Model model, HttpServletRequest request) throws SQLException {
        EmpVO empVO = (EmpVO)request.getSession().getAttribute("loginUser");
        empVO = empService.getEmp(empVO.getEmp_Id());
        String emp_Id = ((EmpVO)request.getSession().getAttribute("loginUser")).getEmp_Id();
        NoticeVO noticeVO = homeFormVO.getNoticeVO(); //noticeVO객체를 얻어옴
        ApprovalVO approvalVO = homeFormVO.getApprovalVO(); 
        IssueVO issueVO = homeFormVO.getIssueVO(); 
        DutyVO dutyVO = homeFormVO.getDutyVO(); 
        ProjectVO projectVO = homeFormVO.getProjectVO(); 

        noticeVO.setRecordCountPerPage(5); //5개 지정
        approvalVO.setRecordCountPerPage(3); 
        issueVO.setRecordCountPerPage(3); 
        dutyVO.setRecordCountPerPage(3); 
        dutyVO.setEmp_Writer_Id(emp_Id);

        List<HomeFormVO> dashbodeList = homeService.getDashbodeList(emp_Id);
        Map<String,Object> dataMap = noticeService.getNoticeList(noticeVO);
        Map<String,Object> approvalList = approvalService.getWaitList(approvalVO);
        List<IssueVO> issueList = issueService.searchList(issueVO);
        List<ProjectVO> projectList = projectService.getProjectList(projectVO);
        List<DutyVO> dutyList = dutyService.searchList(dutyVO);
        
        logger.info(projectList.toString());
        model.addAttribute("projectList", projectList);
        model.addAttribute("dashbodeList", dashbodeList);
        model.addAttribute("empVO", empVO);
        model.addAttribute("approvalList",approvalList.get("waitDocs"));
        model.addAttribute("dutyList",dutyList);
        model.addAttribute("issueList",issueList);
        model.addAttribute("noticeList",dataMap.get("importantNoticeList"));
        return "/home";
    }

    @GetMapping("/api/weather-app-key")
    public ResponseEntity<String> getWeather()
    {
        String weather = homeService.getWeather();
        return ResponseEntity.ok(weather);
    }



    @PostMapping("/profile")
    public String updateProfile(@RequestParam("profileImage") MultipartFile profileImage, @SessionAttribute("loginUser")EmpVO empVO, RedirectAttributes attr)  throws IOException, IllegalStateException
    {
            logger.info("config : "+ config);
            logger.info("profileImage :" + profileImage);
            logger.info("profile Controller 들어오니?");
            logger.info(config.getUploadPath());
            String webPath = config.getUploadPath();
            int result = homeService.updateProfile(profileImage, webPath,empVO);
            logger.info("result :" + result);
            String url = "common/mypage/modifyform";
            String message = null; 
            if(result > 0)
            {
                message = "프로필 이미지가 변경되었습니다.";
            }
            else{
                message = "프로필 변경 실패";
            }
            attr.addFlashAttribute("message",message);
            
            return url;
    }





    @GetMapping("/loginForm")
	public String loginForm() {
		return "common/loginForm";
	}

    @PostMapping("/login")
    public String login(EmpVO empVO,HttpServletRequest request,HttpServletResponse response,Model model)throws SQLException
    {

        String url = null;
        HttpSession session = request.getSession();
        try{
            empVO = empService.login(empVO.getEmp_Id(),empVO.getEmp_Pwd(),session);
            if(empVO.getEmp_Update_Yn()=="n")
            {
                url = "redirect:/common/firstChange";
            }
            logger.info(empVO.toString());
            users.put(empVO.getEmp_Id(),session); // users에서 관리하는 이유는 로그인 유저 정보를 조회하기 위해서
            if(empVO.getEmp_authkey() == 0)
            {
                logger.info("여기에 들어왔습니다.");
                model.addAttribute("Auth",empVO.getEmp_authkey());
                return "/common/registerReady";
            }
            if("u".equals(empVO.getAuth_Id()))
            {
                url = "redirect:/common/home";
            }
            else if("s".equals(empVO.getAuth_Id()))
            {
                url = "redirect:/admin/main";
            }



        }catch(NotFoundIDException|InvalidPasswordException e){
            url = "/common/loginForm";
            logger.info("여기서 지금 에러가 발생합니다."); // 이 부분은 postHandle에서 txt 파일로 에러관리 시 사용된다.
            session.setAttribute("errorType", e); //로그찍을 떄 사용
            session.setAttribute("empId", empVO.getEmp_Id());

        }
        
        
        return url;
    }



  	@ResponseBody
    @PostMapping("/saveDashboard")
	public void saveDashboard(DashboardVO dashboardVO) throws Exception {
		homeService.modifyDashboard(dashboardVO);
	}

    @ResponseBody
    @PostMapping("/insertDashboard")
    public void insertDashboard(DashboardVO dashboardVO){
        homeService.insertDashboard(dashboardVO);
    }

    @GetMapping("/logout")
	public String logout(HttpSession session) {
		String url="redirect:/common/loginForm";
		
		// 로그인 유저맵에서 삭제
        logger.info(users.toString());
		users.remove(((EmpVO)session.getAttribute("loginUser")).getEmp_Id());
		session.invalidate();
	
		return url;
	}


    @PostMapping("/mypage/modify")
	public String mypageModify(EmpVO empVO) throws SQLException {
		empService.modifyEmp(empVO);
        String url ="redirect:/common/mypage/modifyform";
		return url;
	}


    @GetMapping("/mypage/modifyform")
    public String modifyForm(HttpServletRequest request, Model model)
    {
        String url = "common/mypage/modifyform";
        EmpVO empVO = (EmpVO)request.getSession().getAttribute("loginUser");
        HttpSession session = request.getSession();
        session.setAttribute("loginUser", empVO);
        model.addAttribute("empVO", empVO);
        return url;
    }


    @ResponseBody
    @PostMapping("/getFile")
    public ResponseEntity<byte[]> getFile(FileUploadCommand fileUploadCommand) throws Exception{

        InputStream in = null;
        ResponseEntity<byte[]> entity = null;

        String fileUploadPath = fileUploadCommand.getFileUploadPath();

        try {
            in = new FileInputStream(fileUploadPath);

            String fileName = fileUploadPath.substring(fileUploadPath.indexOf("$$") + 2);
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
            headers.add("Content-Disposition", "attachment;filename=\"" + new String(fileName.getBytes("utf-8"), "ISO-8859-1") + "\"");

            entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
        }catch(IOException e) {
            e.printStackTrace();
            entity = new ResponseEntity<byte[]>(HttpStatus.INTERNAL_SERVER_ERROR);
        }finally {
            if(in!=null) in.close();
        }

        return entity;
    }




    @PostMapping("/password/pswmodifyForm")
    public String pswmodifyForm(){
        return "common/password/pswmodifyForm";
    }


    @ResponseBody
    @PostMapping("/menu/list")
	public List<MenuVO> getMenuList() throws Exception{
		List<MenuVO> menuList = menuService.getMenuList();
		logger.info(menuList.toString());

		return menuList;
	}

    @GetMapping("/join")
    public String join(Map<String,Object>dataMap)throws SQLException
    {
        String url = "/common/join";

       
        return url;
    }

    @GetMapping("/password/modifyForm")
    public String pwdModifyForm()
    {
        return "common/password/modifyForm";
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
    /* 쿠키가 존재하면 true / 없으면 */


    @PostMapping("/summernote/uploadImg")
    public ResponseEntity<String> uploadImage(@RequestParam("file") MultipartFile file) {
        // 여기에 이미지를 저장하고 저장된 이미지의 URL을 생성합니다.
        String imgUrl = saveImage(file);
        return ResponseEntity.ok(imgUrl);
    }

    private String saveImage(MultipartFile file) {
        try {
            // 저장할 디렉토리 경로를 지정합니다. 여기에서는 임시 디렉토리로 저장합니다.
            String uploadDir = summernotePath+"/";

            // 저장할 파일명을 생성합니다.
            String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();

            // 저장할 경로를 설정합니다.
            Path uploadPath = Paths.get(uploadDir);

            // 디렉토리가 없으면 생성합니다.
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            // 파일을 저장합니다.
            Path filePath = uploadPath.resolve(fileName);
            Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

            // 저장된 이미지의 URL을 생성하여 반환합니다.
            String imgUrl = "/WorkConGW/pds/summernoteImage/"+fileName;
            return imgUrl;
        } catch (IOException e) {
            // 예외 처리
            e.printStackTrace();
            return null;
        }
    }
    @PostMapping("/summernote/deleteImg")
    public ResponseEntity<Void> deleteImage(@RequestBody String fileName) {
        try {
            logger.info(fileName);
            // 파일 명을 변환기 위해 메서드 호출
            String extractFileName = extractFileName(fileName);
            logger.info(extractFileName);

            // 파일 삭제를 위해 deleteImageFile 메서드 호출
            deleteImageFile(extractFileName);

            return ResponseEntity.ok().build();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    // 사진 삭제를 위해 변환 메서드
    private String extractFileName(String fileName) {
        try {
            // URL 디코딩을 수행합니다.
            String decodedFileName = UriUtils.decode(fileName, StandardCharsets.UTF_8);

            // JSON 형식의 문자열을 Map으로 변환합니다.
            ObjectMapper objectMapper = new ObjectMapper();
            Map<String, String> jsonMap = objectMapper.readValue(decodedFileName, Map.class);

            // Map에서 fileName 키에 해당하는 값을 가져옵니다.
            String actualFileName = jsonMap.get("fileName");

            // 파일 이름 부분만 추출하여 반환합니다.
            return actualFileName.substring(actualFileName.lastIndexOf("/") + 1);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    private void deleteImageFile(String fileName) {
        try {
            // 삭제할 파일의 절대 경로를 생성합니다.
            String filePath = summernotePath+"/"+fileName;

            // 파일 객체를 생성합니다.
            File file = new File(filePath);

            // 파일이 존재하면 삭제합니다.
            if (file.exists()) {
                if (file.delete()) {
                    System.out.println("파일 삭제 성공: " + filePath);
                } else {
                    System.out.println("파일 삭제 실패: " + filePath);
                }
            } else {
                System.out.println("삭제할 파일이 존재하지 않습니다: " + filePath);
            }
        } catch (Exception e) {
            // 예외 처리
            e.printStackTrace();
        }
    }

    @GetMapping("dashbodeUpdate")
    public String dashbodeUpdate(Model model, @RequestParam Map<String, Object> pmap, HttpSession session) {
        logger.info("dashbodeUpdate");
        EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        String empId = null;
        if(empVO != null) {
            empId = empVO.getEmp_Id();
        }
        pmap.put("empId", empId);
        int result = 0;
        String path = "";
        logger.info(pmap.toString());
        result = homeService.dashbodeUpdate(pmap);
        if (result == 1) {// 입력이 성공했을때
            path = "redirect:/common/home";
        } else {// 입력이 실패 했을때
            path = "/error";
        }
        return path;
    }
}
