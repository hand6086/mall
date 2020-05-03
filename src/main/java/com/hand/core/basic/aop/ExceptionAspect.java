package com.hand.core.basic.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.BadSqlGrammarException;

import com.hand.base.basic.service.BasicServiceException;

@Aspect
public class ExceptionAspect {

	/**
     * @within(org.springframework.stereotype.Service)，拦截带有 @Service 注解的类的所有方法
     * @annotation(org.springframework.web.bind.annotation.RequestMapping)，拦截带有@RquestMapping的注解方法
     */
    //@Pointcut("@within(org.springframework.stereotype.Service) && execution(public * *(..))")
    @Pointcut("(@within(org.springframework.stereotype.Service) && execution(public * *(..))) || within(com.hand.core.basic.service.BasicServiceImpl)")
    private void servicePointcut() {}

    /**
     * 拦截service层异常，记录异常日志，并设置对应的异常信息
     * 目前只拦截Exception，是否要拦截Error需再做考虑
     *
     * @param e 异常对象
     */
    @AfterThrowing(pointcut = "servicePointcut()", throwing = "e")
    public void handle(JoinPoint point, Exception e) {

        String signature = point.getSignature().toString();
        System.err.println(signature);
        String errorMsg = getMessage(e);
        e.printStackTrace();
        throw new BasicServiceException(errorMsg);
    }
    
    private String getMessage(Exception e){
    	String message = e.getMessage();
    	if(e instanceof NullPointerException){
    		message = "服务异常（null）";
    	}else if(e instanceof BadSqlGrammarException){
    		message = "语法错误";
    	}else if(e instanceof DuplicateKeyException){
    		message = "唯一性冲突";
    	}
    	return message;
    }
}
