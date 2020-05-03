package com.hand.base.basic.service;

public class BasicServiceException extends RuntimeException{
	
	private static final long serialVersionUID = 5140504639287738495L;

	public BasicServiceException() {
    	super();
    }

    public BasicServiceException(String message) {
    	super(message);
    }

    public BasicServiceException(String message, Throwable cause) {
        super(message, cause);
    }

    public BasicServiceException(Throwable cause) {
        super(cause);
    }
}
