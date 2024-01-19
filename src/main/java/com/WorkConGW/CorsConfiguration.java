package com.WorkConGW;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
// Cors이슈 해결 방법으로 추가함
// Front-End와 Back-End의 포트번호가 다를 때 사용
@Configuration
public class CorsConfiguration implements WebMvcConfigurer {
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**") // 모든 요청에 대해서
        		.allowedOrigins("http://localhost:9000/"); // 허용할 오리진들
        		//.allowedOrigins("*");
    }
}