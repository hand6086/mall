package com.hand.core.modules.export.exception;

public class NotSupportFileTypeException extends ExportException{

	private static final long serialVersionUID = -4604842828811512727L;

	public NotSupportFileTypeException() {
    	super();
    }

    public NotSupportFileTypeException(String message) {
    	super(message);
    }

    public NotSupportFileTypeException(String message, Throwable cause) {
        super(message, cause);
    }

    public NotSupportFileTypeException(Throwable cause) {
        super(cause);
    }
}