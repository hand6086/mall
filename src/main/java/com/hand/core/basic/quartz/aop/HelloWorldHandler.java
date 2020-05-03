package com.hand.core.basic.quartz.aop;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;

public class HelloWorldHandler implements InvocationHandler{
	
	private Object targetObject;   
    
    public HelloWorldHandler(Object targetObject){   
        this.targetObject = targetObject;   
    }   
       
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {   
        System.out.println("方法调用前。。。");   
  
        Object result = method.invoke(this.targetObject, args);   
  
        System.out.println("方法调用结束");   
           
        return result;   
    } 

}
