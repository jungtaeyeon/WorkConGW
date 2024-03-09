package com.WorkConGW.util.Config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.WorkConGW.util.interceptor.AdminInterceptor;
import com.WorkConGW.util.interceptor.LoginInterceptor;
import com.WorkConGW.util.interceptor.LoginUserLogInterceptor;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

//    @Override
//    public void addResourceHandlers(ResourceHandlerRegistry registry) {
//        registry.addResourceHandler("/pds/**")
//                .addResourceLocations("file:/Users/jeongtaeyeon/WorkConProject/WorkConFeature/WorkConGW/src/main/webapp/pds/");
//    }



    public void addInterceptors(InterceptorRegistry registry) {
         registry.addInterceptor(new LoginUserLogInterceptor())
                 .addPathPatterns("/common/login")
                 .excludePathPatterns("/resources/**", "/pds/**");

         registry.addInterceptor(new LoginInterceptor())
                 .addPathPatterns("/**")
                 .excludePathPatterns("/emp/firstCompareEmpPwd","/emp/firstChange","/emp/findList","/emp/findIdView","/emp/findId","/emp/findId","/emp/findIdView","/common/login","/emp/findPwView","/emp/findPw","/common/loginForm", "/resources/**","/attend/insertStartWorkQR", "/common/home","/m/home", "/common/join", "/common/saveDashboard");

         registry.addInterceptor(new AdminInterceptor())
                 .addPathPatterns("/admin/**")
                 .excludePathPatterns("/admin/access_denied");

     }



}
