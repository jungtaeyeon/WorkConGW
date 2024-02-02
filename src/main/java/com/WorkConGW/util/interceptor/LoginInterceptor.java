package com.WorkConGW.util.interceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component("LoginInterceptor")
public class LoginInterceptor implements HandlerInterceptor {
	
    Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);


	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
        HttpSession session = request.getSession();
        
        logger.info("LoginInterceptor + 여기들어오니?");
        Object obj = session.getAttribute("loginUser");
        
        StringBuffer currentURL = null;
        String currentURLStr = null;
        
    	
        currentURL = request.getRequestURL();
        currentURLStr = currentURL.toString();

        logger.info("currentURLStr :"+currentURLStr);
        logger.info("currentURL : "+currentURL);
        
        String teString = (String)session.getAttribute("myCurrentURL");
        logger.info("teString:" + teString);
        
        if(!("/common/loginForm".equals(currentURLStr.split("WorkConGW")[1]) || "/".equals(currentURLStr.split("WorkConGW")[1])
        		|| "/common/home".equals(currentURLStr.split("WorkConGW")[1]))) {
        	session.setAttribute("myCurrentURL", currentURLStr);
        	session.setAttribute("myCurrentParameter", request.getParameter("docId"));
        }
        
        //session에 로그인 유저가 없을 시
        //로그인하지 않은 사용자일 경우 로그인 페이지로 이동
        if ( obj == null ){
            response.sendRedirect(request.getContextPath()+"/common/loginForm");
            return false;
        }   
        
        
        return true;
	}
}


