package com.hand.core.modules.export;

import java.io.File;
import java.util.List;

import com.hand.core.basic.query.ExportColumn;
import com.hand.core.modules.export.exception.WriteExportFileException;

public interface FileWriter {
	/**
	 * 获取文件写入时的编码
	 * @return 文件写入时的编码
	 */
	public String getEncoding();
	
	/**
	 * 设置文件写入时的编码
	 * @param encoding 文件写入时的编码
	 */
	public void setEncoding(String encoding);
	
	public void startWrite(File file) throws WriteExportFileException;

	public void writeHeader(List<ExportColumn> list) throws WriteExportFileException;
	
	public void wirteContent(List<?> contentList) throws WriteExportFileException;
	
	public void stopWrite() throws WriteExportFileException;
}
