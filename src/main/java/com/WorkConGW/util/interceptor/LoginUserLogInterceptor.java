package com.WorkConGW.util.interceptor;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
// import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.WorkConGW.emp.dto.EmpVO;
import com.WorkConGW.exception.InvalidPasswordException;
import com.WorkConGW.exception.NotFoundIDException;
import com.WorkConGW.util.ClientUtils;

public class LoginUserLogInterceptor  implements HandlerInterceptor {
	
	@Resource(name="logFilePath")
	private String logFilePath;
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		EmpVO loginUser = (EmpVO) request.getSession().getAttribute("loginUser");
		
		String errorType = "성공";
		if(loginUser == null) {
			// 로그인 시도한 아이디 기록
			loginUser = new EmpVO();
			loginUser.setEmp_Id(String.valueOf(request.getSession().getAttribute("emp_Id")));
			
			Exception ex = (Exception) request.getSession().getAttribute("errorType");
			if(ex instanceof NotFoundIDException) {
				errorType = "아이디 오류";
			}else if(ex instanceof InvalidPasswordException) {
				errorType = "비밀번호 오류";
			}
		}
		
		// 로그인 시각
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String loginTime = sdf.format(new Date());
		
		// // 로그인 유저 IP 주소
		String loginUserIp = request.getHeader("X-Forwarded-For");
	    if (loginUserIp == null) loginUserIp = ClientUtils.getRemoteIP(request);
		
		String log = "[login:user],"
					+loginTime+","
					+loginUser.getEmp_Id()+","
					+loginUserIp+","
					+errorType;
		
		// 로그파일 생성
		File file = new File(logFilePath);
		if(!file.exists()) {
			file.mkdirs();
		}
		String filePath = logFilePath+File.separator+"$$login_user_log.txt";
		BufferedWriter out = new BufferedWriter(new FileWriter(filePath,true));
		
		// 로그 기록
		// out.write(log);
		out.newLine();
		
		out.close();
	}
}



