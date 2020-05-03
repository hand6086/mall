package com.hand.core.modules.export.exception;

public class WriteExportFileException extends ExportException{

	private static final long serialVersionUID = 8410119731117504706L;

	public WriteExportFileException() {
    	super();
    }

    public WriteExportFileException(String message) {
    	super(message);
    }

    public WriteExportFileException(String message, Throwable cause) {
        super(message, cause);
    }

    public WriteExportFileException(Throwable cause) {
        super(cause);
    }
}