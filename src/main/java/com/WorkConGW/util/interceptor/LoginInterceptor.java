package com.WorkConGW.util.interceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;


public class LoginInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
        HttpSession session = request.getSession();
        
        Object obj = session.getAttribute("loginUser");
        
        StringBuffer currentURL = null;
        String currentURLStr = null;
        
    	
        currentURL = request.getRequestURL();
        currentURLStr = currentURL.toString();
        
        String teString = (String)session.getAttribute("myCurrentURL");
        
        if(!("/common/loginForm".equals(currentURLStr.split("WorkConGW")[1]) || "/".equals(currentURLStr.split("WorkConGW")[1])
        		|| "/common/home".equals(currentURLStr.split("WorkConGW")[1]))) {
        	session.setAttribute("myCurrentURL", currentURLStr);
        	session.setAttribute("myCurrentParameter", request.getParameter("docId"));
        }
        
        //session에 로그인 유저가 없을 시
        if ( obj == null ){
            response.sendRedirect(request.getContextPath()+"/common/loginForm");
            return false;
        }
        
        
        return true;
	}
}


