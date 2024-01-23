 package com.WorkConGW;


import javax.sql.DataSource;

 import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.logging.log4j.LogManager;
 import org.apache.logging.log4j.Logger;
 import org.mybatis.spring.SqlSessionFactoryBean;
 import org.mybatis.spring.SqlSessionTemplate;
 import org.springframework.beans.factory.annotation.Autowired;
 import org.springframework.boot.context.properties.ConfigurationProperties;
 import org.springframework.context.ApplicationContext;
 import org.springframework.context.annotation.Bean;
 import org.springframework.context.annotation.Configuration;
 import org.springframework.context.annotation.PropertySource;

import com.zaxxer.hikari.HikariConfig;
 import com.zaxxer.hikari.HikariDataSource;

 @Configuration //spring-data.xml
 @PropertySource("classpath:/application.yml") // 내려쓰기와 들여쓰기로 반복을 피한다.
 public class DatabaseConfiguration {
 	private static final Logger logger = LogManager.getLogger(DatabaseConfiguration.class);

 	@Bean
 	@ConfigurationProperties(prefix = "spring.datasource.hikari")
 	public HikariConfig hikariConfig() {
 		return new HikariConfig();
 	}

 	@Bean
 	public DataSource dataSource() {
 		DataSource dataSource = new HikariDataSource(hikariConfig());
 		logger.info("datasource : {}", dataSource);
 		return dataSource;
 	}

 	@Autowired //그물 엮는다 의미 - 의존성 주입관련 어노테이션
 	private ApplicationContext applicationContext;

 	@Bean
 	public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {
 		SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
 		sqlSessionFactoryBean.setDataSource(dataSource);
 		sqlSessionFactoryBean.setMapperLocations(applicationContext.getResources("classpath:/com/workcon/mybatis/mappers/**/*.xml"));
		sqlSessionFactoryBean.setTypeAliasesPackage("com.WorkConGW");
		org.apache.ibatis.session.Configuration configuration = new org.apache.ibatis.session.Configuration();
		configuration.setCallSettersOnNulls(true);
		sqlSessionFactoryBean.setConfiguration(configuration);

		return sqlSessionFactoryBean.getObject(); 
 	}

 	@Bean
 	public SqlSessionTemplate sqlSessionTemplate(SqlSessionFactory sqlSessionFactory) {
 		return new SqlSessionTemplate(sqlSessionFactory);
 	}
 }