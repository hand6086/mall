package com.hand.base.basic.controller;

public class BasicControllerException extends RuntimeException{
	
	private static final long serialVersionUID = -4223886206319515926L;

	public BasicControllerException() {
    	super();
    }

    public BasicControllerException(String message) {
    	super(message);
    }

    public BasicControllerException(String message, Throwable cause) {
        super(message, cause);
    }

    public BasicControllerException(Throwable cause) {
        super(cause);
    }
}
