package com.hand.base.basic.controller;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.multipart.MultipartException;

@ControllerAdvice
public class ExceptionProcess {
	
	@ExceptionHandler(MultipartException.class)
    public void handleAll(Throwable t){
		System.out.println("-----------------------------------------");
        throw new BasicControllerException("1111111111111111");
    }

}
