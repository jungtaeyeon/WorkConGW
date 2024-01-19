package com.WorkConGW.common.controller;


import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.WorkConGW.common.dto.HomeFormVO;
import com.WorkConGW.common.dto.MenuVO;
import com.WorkConGW.common.service.MenuService;
import com.WorkConGW.emp.service.EmpService;
import com.WorkConGW.exception.InvalidPasswordException;
import com.WorkConGW.exception.NotFoundIDException;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/common/*")
public class CommonController extends BaseController {
    Logger logger = LoggerFactory.getLogger(CommonController.class);

	@Autowired
	private EmpService empService;

	
	@Autowired
	private MenuService menuService;

    
    @RequestMapping(value="/home")
    public String home(HomeFormVO homeFormVO, Model model) throws SQLException {

        return "home";
    }

	@RequestMapping(value="/loginForm",method = RequestMethod.GET)
	public String loginForm() {
		return "common/loginForm";
	}


    @RequestMapping(value="/login",method = RequestMethod.POST)
    public String login(String empId, String empPwd, HttpSession session, RedirectAttributes rttr)throws SQLException
    {
        logger.info(empId);
        logger.info(empPwd);
        String url = "redirect:./home";

        try{
            empService.login(empId,empPwd,session);
            users.put(empId,session);
        }catch(NotFoundIDException|InvalidPasswordException e){
            url = "/common/loginForm";
            rttr.addFlashAttribute("msg","아이디 또는 패스워드가 일치하지 않습니다.");
            session.setAttribute("errorType", e);
            session.setAttribute("empId", empId);
            
        }
        return url;
    }
    
    @ResponseBody
	@RequestMapping(value="/menu/list", method=RequestMethod.POST)
	public List<MenuVO> getMenuList() throws Exception{
		List<MenuVO> menuList = menuService.getMenuList();
		logger.info(menuList.toString());

		return menuList;
	}

    @RequestMapping(value = "/join", method = RequestMethod.GET)
    public String join(Map<String,Object>dataMap)throws SQLException
    {
        String url = "/common/join";

       
        return url;
    }



    

}
