package com.hand.core.modules.export.writer;

import java.io.File;
import java.util.List;

import com.hand.core.basic.query.ExportColumn;
import com.hand.core.modules.export.FileWriter;
import com.hand.core.modules.export.exception.WriteExportFileException;
import com.hand.core.util.AppConstants;

/**
 * 文件导出输出处理器基类
 * @author ashen
 */
public abstract class AbstractFileWriter implements FileWriter{
	
	private File file;
	
	private String encoding = AppConstants.APP_ENCODING;
	
	public void startWrite(File file) throws WriteExportFileException{
		
	}

	public void writeHeader(List<ExportColumn> list) throws WriteExportFileException{
		
	}
	
	public void wirteContent(List<?> contentList) throws WriteExportFileException{
		
	}
	
	public void stopWrite() throws WriteExportFileException{
		
	}
	
	public File getFile() {
		return file;
	}
	public void setFile(File file) {
		this.file = file;
	}
	public String getEncoding() {
		return encoding;
	}
	public void setEncoding(String encoding) {
		this.encoding = encoding;
	}
	
}
