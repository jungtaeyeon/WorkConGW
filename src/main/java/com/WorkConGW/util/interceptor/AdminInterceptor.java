package com.WorkConGW.util.interceptor;



import java.io.IOException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
// import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.WorkConGW.emp.dto.EmpVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component("AdminInterceptor")
public class AdminInterceptor implements HandlerInterceptor {
	
    Logger logger = LoggerFactory.getLogger(AdminInterceptor.class);

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,Object handler) throws  IOException
    {
        HttpSession session = request.getSession();
        EmpVO empVO = (EmpVO)session.getAttribute("loginUser");

        if(! "a04".equals(empVO.getAuth_Id()) && "a07".equals(empVO.getAuth_Id()))
        {
           // response.sendRedirect(request.getContextPath()+"/admin/access_denied");
            return false;
        }
        
        String url = request.getRequestURI().split("/")[3];
        logger.info(url.toString());

        return true;
    }
}

