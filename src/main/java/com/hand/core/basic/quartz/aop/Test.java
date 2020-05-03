package com.hand.core.basic.quartz.aop;

import java.lang.reflect.Proxy;

public class Test {
	
		
		public static void main(String[] args) {   
	        //业务对象  
	        HelloWorld obj = new HelloWorldImpl();   
	           
	        //拦截器对象  
	        HelloWorldHandler handler = new HelloWorldHandler(obj);   
	           
	        //返回业务对象的代理对象  
	        HelloWorld proxy = (HelloWorld)Proxy.newProxyInstance(   
	                obj.getClass().getClassLoader(),    
	                obj.getClass().getInterfaces(),    
	                handler);   
	           
	        //通过代理对象执行业务对象的方法  
	        proxy.sayHelloWorld();
	    }
		

}
