package com.WorkConGW;

import lombok.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Configuration;

import lombok.Data;

@Configuration
@EnableConfigurationProperties
@Data
@ConfigurationProperties(prefix = "application")
public class YAMLConfig {

    private String uploadPath;




}
