package com.hand;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.context.web.SpringBootServletInitializer;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.transaction.annotation.EnableTransactionManagement;


/*@EnableEurekaClient*/
@EnableAutoConfiguration
@SpringBootApplication
@EnableScheduling
@EnableTransactionManagement 
@ComponentScan(basePackages="com.hand.*")
@ServletComponentScan(basePackages="com.hand.*")
public class MicroserviceApplication extends SpringBootServletInitializer{
	
	public static void main(String[] args) {
		SpringApplication.run(MicroserviceApplication.class, args);
	}
	
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
		return builder.sources(MicroserviceApplication.class);
	}
	
	
}
