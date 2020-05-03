package com.hand.core.modules.export.exception;

public class ExportException extends Exception{

	private static final long serialVersionUID = 7911904150800542399L;

	public ExportException() {
    	super();
    }

    public ExportException(String message) {
    	super(message);
    }

    public ExportException(String message, Throwable cause) {
        super(message, cause);
    }

    public ExportException(Throwable cause) {
        super(cause);
    }
}