package com.hand.base.basic.dao;


public class BasicDaoException extends RuntimeException{
	private static final long serialVersionUID = -3271614427008139684L;

	public BasicDaoException(String errMsg){
		 super(errMsg);
	}
	
	public BasicDaoException(){
		 super();
	}
	
	public BasicDaoException(String errMsg, Throwable throwable){
		 super(errMsg, throwable);
	}
}
