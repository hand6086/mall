package com.hand.core.modules.imports;

import java.io.File;
import java.io.InputStream;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.hand.core.basic.query.ImportColumn;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.modules.imports.exception.ImportsException;

public class ImportReader {
	
	private static final Logger logger = LogManager.getLogger(ImportReader.class);
	
	private File file;
	
	private InputStream inputStream;
	
	private QueryParams qps;
	
	private FileReader fileReader;
	
	//导入文件时，每批读取数据数(暂时无效)
	public static final Integer DEFAULT_BATCH_SIZE = 1000;
	
	/**
	 * 构造函数
	 * @param qps
	 */
	public ImportReader(QueryParams qps,File file,FileReader fileReader){
		this.qps = qps;
		this.qps.invokePreFilterAndSorter();
		this.file = file;
		this.fileReader = fileReader;
	}
	
	/**
	 * 构造函数
	 * @param qps
	 */
	public ImportReader(QueryParams qps,InputStream inputStream,FileReader fileReader){
		this.qps = qps;
		this.qps.invokePreFilterAndSorter();
		this.inputStream = inputStream;
		this.fileReader = fileReader;
	}
	
	public <T> List<T> readList(Class<T> clazz) throws ImportsException{
		logger.debug("开始读取文件信息");
		List<ImportColumn> headers = fileReader.readHeader(file);
		checkHeader(qps.getImportColumns(),headers);
		return fileReader.readContent(clazz,qps.getImportColumns(),headers);
	}
	
	public <T> List<T> readListFromInputStream(Class<T> clazz) throws ImportsException{
		logger.debug("开始读取文件信息");
		// List<ImportColumn> headers = fileReader.readHeaderFromInputStream(inputStream);
		// checkHeader(qps.getImportColumns(),headers);
		return fileReader.readContentFromInputStream(clazz, qps.getImportColumns(), inputStream);
	}

	private void checkHeader(List<ImportColumn> gridColumns, List<ImportColumn> csvColumns) throws ImportsException{
		if(gridColumns == null || csvColumns == null || gridColumns.size() == 0 || csvColumns.size() == 0){
			throw new ImportsException("导入的列数量不能为0！");
		}
		/*if(gridColumns.size() != csvColumns.size()){
			throw new ImportsException("导入列与要求的不符，请确定导入的列数为"+gridColumns.size()+"！");
		}
		for(int i=0;i<gridColumns.size();i++){
			ImportColumn gridColumn = gridColumns.get(i);
			ImportColumn csvColumn = csvColumns.get(i);
			if(!gridColumn.getTitle().equals(csvColumn.getTitle().trim())){
				throw new ImportsException("第"+(i+1)+"列名称不符合导入要求请确认后再进行导入操作！");
			}
		}*/
	}
	
}
