package com.WorkConGW.util.interceptor;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.WorkConGW.emp.dto.EmpVO;
import com.WorkConGW.exception.InvalidPasswordException;
import com.WorkConGW.exception.NotFoundIDException;
import com.WorkConGW.util.ClientUtils;


@Component("LoginUserLogInterceptor")
public class LoginUserLogInterceptor  implements HandlerInterceptor {
	
	//@Resource(name="logFilePath")
	private String logFilePath;

	Logger logger = LoggerFactory.getLogger(LoginUserLogInterceptor.class);
	
	/* 
	 * 
	 */
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
				logger.info("postHandle + 여기들어오니?");
		
		EmpVO loginUser = (EmpVO) request.getSession().getAttribute("loginUser");// empService에서 setAttribute("loginUser", user(Dao 다녀옴))
		
		String errorType = "성공";
		if(loginUser == null) { // 아이디와 비밀번호가 다르다는 얘기.
			// 로그인 시도한 아이디 기록
			loginUser = new EmpVO();
			loginUser.setEmp_Id(String.valueOf(request.getSession().getAttribute("emp_Id"))); // 아이디와 비밀번호가 다를 때 사용되는 로직 + 그 사용자의 emp_id값을 가져와야 txt 파일에 찍을 때 사용된다.
			
			Exception ex = (Exception) request.getSession().getAttribute("errorType"); // 아이디와 비밀번호가 다를 때 사용되는 로직 common/login 컨트롤러에서 에러처리 시 2가지 처리를 진행함 (에러타입+emp_id)
			if(ex instanceof NotFoundIDException) {
				errorType = "아이디 오류";
			}else if(ex instanceof InvalidPasswordException) {
				errorType = "비밀번호 오류";
			}
		}
		
		// // 로그인 시각
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String loginTime = sdf.format(new Date());
		logger.info(loginTime);

		logger.info(request.getRemoteAddr());
		
		// 로그인 유저 IP 주소
		String loginUserIp = request.getHeader("X-Forwarded-For");
		//"X-Forwarded-For" 헤더가 존재하지 않거나 값이 null 인 경우 실행함.
	    if (loginUserIp == null) loginUserIp = ClientUtils.getRemoteIP(request);

		//https://linked2ev.github.io/java/2019/05/22/JAVA-1.-java-get-clientIP/
		
		String log = "[login:user],"
					+loginTime+","
					+loginUser.getEmp_Id()+","
					+loginUserIp+","
					+errorType;
		
		logger.info(log);
		String logFilePath = "src/main/resources";
		// 로그파일 생성
		File file = new File(logFilePath);
		if(!file.exists()) {
			file.mkdirs();
		}
		String filePath = logFilePath+File.separator+"$$login_user_log.txt";
		BufferedWriter out = new BufferedWriter(new FileWriter(filePath,true));
		
		// 로그 기록
		out.write(log);
		out.newLine();
		
		out.close();
	}
}



