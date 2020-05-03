package com.hand.core.modules.imports.exception;

public class ImportsException extends Exception{

	/**
	 * 导入异常信息
	 */
	private static final long serialVersionUID = 8574307422120822836L;

	public ImportsException() {
    	super();
    }

    public ImportsException(String message) {
    	super(message);
    }

    public ImportsException(String message, Throwable cause) {
        super(message, cause);
    }

    public ImportsException(Throwable cause) {
        super(cause);
    }
}