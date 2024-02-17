package com.WorkConGW.common.controller;


import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.WorkConGW.YAMLConfig;
import com.WorkConGW.common.dto.BaseVO;
import com.WorkConGW.common.dto.DashboardVO;
import com.WorkConGW.common.dto.HomeFormVO;
import com.WorkConGW.common.dto.MenuVO;
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
	private MenuService menuService;

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
        model.addAttribute("empVO", empVO);
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
    public String login(EmpVO empVO,HttpServletRequest request,Model model)throws SQLException
    {

        String url = null;
        HttpSession session = request.getSession();
        try{
            empVO = empService.login(empVO.getEmp_Id(),empVO.getEmp_Pwd(),session);
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
                url = "redirect:./home";
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
        String url ="redirect:/common/home";
		return url;
	}


    @GetMapping("/mypage/modifyform")
    public String modifyForm(HttpServletRequest request, Model model)
    {
        String url = "common/mypage/modifyform";
        EmpVO empVO = (EmpVO)request.getSession().getAttribute("loginUser");
        empVO = empService.getEmp(empVO.getEmp_Id());
        HttpSession session = request.getSession();
        session.setAttribute("loginUser", empVO);
        model.addAttribute("empVO", empVO);
        return url;
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

}
