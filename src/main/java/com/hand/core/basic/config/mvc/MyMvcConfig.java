package com.hand.core.basic.config.mvc;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScan.Filter;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.FilterType;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.http.converter.xml.MarshallingHttpMessageConverter;
import org.springframework.stereotype.Controller;
import org.springframework.web.accept.ContentNegotiationManager;
import org.springframework.web.accept.PathExtensionContentNegotiationStrategy;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.mvc.annotation.DefaultAnnotationHandlerMapping;
import org.springframework.web.servlet.view.BeanNameViewResolver;
import org.springframework.web.servlet.view.ContentNegotiatingViewResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;
import org.springframework.web.servlet.view.xml.MarshallingView;

import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hand.core.xstream.MyXStreamMarshaller;
import com.thoughtworks.xstream.io.naming.NoNameCoder;
import com.thoughtworks.xstream.io.xml.StaxDriver;
/**
 * @author Leon
 * 目前是按照原linkcrm工程里的spring mvc的配置来进行配置的
 */
@Configuration
@EnableWebMvc
@ComponentScan(basePackages={"com.hand.*.controller"},includeFilters={@Filter(type=FilterType.ANNOTATION,value=Controller.class)})
public class MyMvcConfig extends WebMvcConfigurerAdapter implements ApplicationContextAware {
	
	
	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/").setViewName("forward:/login.jsp");
	}

	//配置解析器
	@Bean
	public ContentNegotiatingViewResolver contentNegotiatingViewResolver(){
		ContentNegotiatingViewResolver contentNegotiatingViewResolver = new ContentNegotiatingViewResolver();
		contentNegotiatingViewResolver.setOrder(1);
		
		Map<String,MediaType> pecnsArgs = new HashMap<String,MediaType>();
		pecnsArgs.put("json", MediaType.APPLICATION_JSON);
		pecnsArgs.put("html", MediaType.TEXT_HTML);
		pecnsArgs.put("xml", MediaType.APPLICATION_XML);
		
		PathExtensionContentNegotiationStrategy pecns = new PathExtensionContentNegotiationStrategy(pecnsArgs);
		ContentNegotiationManager contentNegotiationManager = new ContentNegotiationManager(pecns);
		
		contentNegotiatingViewResolver.setContentNegotiationManager(contentNegotiationManager);
		
		List<ViewResolver> vrList = new ArrayList<ViewResolver>();
		vrList.add(new BeanNameViewResolver());
		vrList.add(viewResolvers());
		
		contentNegotiatingViewResolver.setViewResolvers(vrList);
		
		List<View> viewList = new ArrayList<View>();
		viewList.add(new MappingJackson2JsonView());
		MarshallingView marshallingView = new MarshallingView();
		marshallingView.setMarshaller(xStreamMarshaller());
		viewList.add(marshallingView);
		contentNegotiatingViewResolver.setDefaultViews(viewList);
		
		return contentNegotiatingViewResolver;
	}
	
	
//	@Bean
	public InternalResourceViewResolver viewResolvers(){//配置viewResolver
		InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
		viewResolver.setPrefix("/portal/");
		viewResolver.setSuffix(".jsp");
		viewResolver.setViewClass(JstlView.class);
		return viewResolver;
	}
	
	//配置自定义转换器 
	@Override
	public void extendMessageConverters(List<HttpMessageConverter<?>> converters){
		converters.clear();//清空转换器
		converters.add(jsonHttpMessageConverter());
		converters.add(marshallingHttpMessageConverter());
	}
	
	public MappingJackson2HttpMessageConverter jsonHttpMessageConverter(){
		MappingJackson2HttpMessageConverter jsonHttpMessageConverter = new MappingJackson2HttpMessageConverter();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.setDateFormat(simpleDateFormat);
		objectMapper.setSerializationInclusion(Include.NON_NULL);
		jsonHttpMessageConverter.setObjectMapper(objectMapper);
		List<MediaType> mediaTypeList = new ArrayList<MediaType>(); 
		mediaTypeList.add(MediaType.APPLICATION_JSON_UTF8);
		mediaTypeList.add(MediaType.TEXT_HTML);
		jsonHttpMessageConverter.setSupportedMediaTypes(mediaTypeList);
		return jsonHttpMessageConverter;
	}
	
	public MarshallingHttpMessageConverter marshallingHttpMessageConverter(){
		MarshallingHttpMessageConverter marshallingHttpMessageConverter = new MarshallingHttpMessageConverter();
		marshallingHttpMessageConverter.setMarshaller(xStreamMarshaller());
		marshallingHttpMessageConverter.setUnmarshaller(xStreamMarshaller());
		List<MediaType> mediaTypeList = new ArrayList<MediaType>(); 
		mediaTypeList.add(MediaType.APPLICATION_XML);
		marshallingHttpMessageConverter.setSupportedMediaTypes(mediaTypeList);
		return marshallingHttpMessageConverter;
	}
	
//	@Bean
	public MyXStreamMarshaller xStreamMarshaller(){
		MyXStreamMarshaller xStreamMarshaller = new MyXStreamMarshaller();
		xStreamMarshaller.setAutodetectAnnotations(true);
		
		StaxDriver staxDiver = new StaxDriver(new NoNameCoder());
		xStreamMarshaller.setStreamDriver(staxDiver);
		
		return xStreamMarshaller;
	}
	
	@Bean
	public DefaultAnnotationHandlerMapping defaultAnnotationHandlerMapping(){
		return new DefaultAnnotationHandlerMapping();
	}
	
	
	//显示声明CommonsMultipartResolver为mutipartResolver
	
//	@Bean
//	public ResourceHttpMessageConverter resourceHttpMessageConverter(){
//		ResourceHttpMessageConverter resourceHttpMessageConverter = new ResourceHttpMessageConverter();
//		List<MediaType> mediaTypeList = new ArrayList<MediaType>(); 
//		mediaTypeList.add(MediaType.csv);
//		mediaTypeList.add();
//		mediaTypeList.add();
//		mediaTypeList.add();
//		mediaTypeList.add();
//		mediaTypeList.add();
//		resourceHttpMessageConverter.setSupportedMediaTypes(mediaTypeList);
//		return resourceHttpMessageConverter;
//	}

	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {//配置静态资源路径
		registry.addResourceHandler("/webapp/static/**").addResourceLocations("classpath:/webapp/static");
	}
	
	
	@Override
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
        configurer.enable(); //配置静态文件处理
    }


	@Override
	public void setApplicationContext(ApplicationContext arg0) throws BeansException {
		// TODO Auto-generated method stub
		
	}
	
	//添加mvc拦截器
	public void addInterceptors(InterceptorRegistry registry) {
		//拦截规则：除了login，其他都拦截判断
       /*registry.addInterceptor(new LoginInterceptor()).addPathPatterns("/**").excludePathPatterns("/j_spring_security_check");
       super.addInterceptors(registry);*/
	}
}
