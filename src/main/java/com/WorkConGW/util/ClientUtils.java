package com.WorkConGW.util;

import jakarta.servlet.http.HttpServletRequest;


public class ClientUtils {
	public static String getRemoteIP(HttpServletRequest request){
        String ip = request.getHeader("X-FORWARDED-FOR");  // 클라이언트의 IP 주소를 가져옴.
        
        //proxy 환경일 경우
        if (ip == null || ip.length() == 0) {
            /* 
             * "X-FORWARDED-FOR" 헤더로부터 IP 주소를 가져오지 못했을 경우 이 헤더를 확인하여 클라이언트의 IP 주소를 추출
             */
            ip = request.getHeader("Proxy-Client-IP");
        }

        //웹로직 서버일 경우
        if (ip == null || ip.length() == 0) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }

        if (ip == null || ip.length() == 0) {
            ip = request.getRemoteAddr() ;
        }
        
        return ip;
   }
}
