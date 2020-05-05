package com.hand.core.basic.security;

import com.hand.base.user.service.LoginService;
import com.hand.core.basic.filter.LoginAuthenticationFilter;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import javax.annotation.Resource;

/**
 * 通过@EnableWebMvcSecurity注解开启Spring Security的功能
 * 继承WebSecurityConfigurerAdapter，并重写它的方法来设置一些web安全的细节
 */
@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
	
	@Resource
    private LoginService loginService;

	@Resource
    private RestAuthenticationFailureHandler authenticationFailureHandler;
	@Resource
    private RestAuthenticationSuccessHandler successHandler;

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(loginService).passwordEncoder(new UserPasswordEncoder());
	}
	

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		
		LoginAuthenticationFilter loginAuthenticationFilter = new LoginAuthenticationFilter();
		
		http
		.csrf().disable()
		.authorizeRequests()
			.antMatchers("/static/**", 
					"/index.html", 
					"/action/portal/login/nonSession",
					"/portal/handler.jsp",
					"/action/portal/token/login",
					"/action/portal/homeManage/smsHomeLogo",
					"/action/portal/product/list",
					"/action/portal/productNav/queryAll"
					).permitAll()
			.and()
		.addFilterBefore(loginAuthenticationFilter, UsernamePasswordAuthenticationFilter.class)
		.formLogin()
			.loginPage("/action/portal/login/nonSession")
			.loginProcessingUrl("/j_spring_security_check")
			.failureUrl("/action/portal/login/loginfail")
			.defaultSuccessUrl("/action/portal/login/login", true)
			.permitAll()
			.and()
		.sessionManagement()
			.invalidSessionUrl("/action/portal/login/nonSession")
			.and()
		.headers()
			.frameOptions()
			.disable()
			.and()
		.logout()
			.logoutRequestMatcher(new AntPathRequestMatcher("/j_spring_security_logout"))
			.logoutSuccessUrl("/action/portal/login/init")
			.invalidateHttpSession(true);

	}
	
	
}