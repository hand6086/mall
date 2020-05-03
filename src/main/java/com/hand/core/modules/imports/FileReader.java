package com.hand.core.modules.imports;

import java.io.File;
import java.io.InputStream;
import java.util.List;

import com.hand.core.basic.query.ImportColumn;
import com.hand.core.modules.export.exception.WriteExportFileException;
import com.hand.core.modules.imports.exception.ImportsException;

public interface FileReader {
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
	
	/**
	 * 读取文件头信息
	 * @param file 
	 * @return
	 * @throws ImportsException
	 */
	public List<ImportColumn> readHeader(File file) throws ImportsException;
	
	/**
	 * 读取文件头信息
	 * @param file 
	 * @return
	 * @throws ImportsException
	 */
	public List<ImportColumn> readHeaderFromInputStream(InputStream inputStream) throws ImportsException;
	
	/**
	 * 读取文件内容信息
	 * @return
	 * @throws WriteExportFileException
	 */
	public <T> List<T> readContent(Class<T> clazz,List<ImportColumn> importColumns,List<ImportColumn> headers) throws ImportsException;
	
	/**
	 * 读取文件内容信息
	 * @return
	 * @throws WriteExportFileException
	 */
	public <T> List<T> readContentFromInputStream(Class<T> clazz,List<ImportColumn> importColumns, InputStream inputStream) throws ImportsException;
}
