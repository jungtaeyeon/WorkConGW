package com.WorkConGW;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.context.annotation.ComponentScan;

@ServletComponentScan
@SpringBootApplication
@ComponentScan(basePackages = "com.WorkConGW")
public class WorkConGwApplication {

	public static void main(String[] args) {
		SpringApplication.run(WorkConGwApplication.class, args);
	}

	

}
