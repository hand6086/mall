package com.hand.core.modules.export.writer;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.nio.charset.Charset;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.hand.core.basic.query.ExportColumn;
import com.hand.core.modules.export.exception.WriteExportFileException;
import com.hand.core.util.AppConstants;
import com.hand.core.util.StringUtils;

/**
 * CSV文件导出输出处理器
 */
public class CSVFileWriter extends AbstractFileWriter{
	private static final Logger logger = LogManager.getLogger(CSVFileWriter.class);

	private CsvWriter writer = null;
	
	private List<ExportColumn> exportColumns;
	
	public void startWrite(File file) throws WriteExportFileException{
		logger.debug("开始写文件...");
		
		 try {
			String csvFilePath = file.getAbsolutePath();
			 writer = new CsvWriter(csvFilePath, ',', Charset.forName("GBK"));;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
	}

	public void writeHeader(List<ExportColumn> list) throws WriteExportFileException{
		this.exportColumns = list;
		if(exportColumns == null || exportColumns.isEmpty()){
			throw new WriteExportFileException("没有设置需要导出的列信息");
		}
		//根据列的order属性进行排序
		Collections.sort(exportColumns);
		
		int colSize = exportColumns.size();
		String[] sb = new String[exportColumns.size()];
		for(int i = 0 ; i < colSize; i++){
			ExportColumn exportColumn = exportColumns.get(i);
			sb[i] = exportColumn.getTitle();
		}
		//将标题行写到文件中去
		try {
			 writer.writeRecord(sb);  
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void wirteContent(List<?> contentList) throws WriteExportFileException{
		for(int i = 0 ; contentList != null && i < contentList.size(); i++){
			Object exportData = contentList.get(i);
			//获取当前返回值对象对应的类
			Class<?> clazz = exportData.getClass();
			//根据列顺序把导出数据写到文件中
			int colSize = exportColumns.size();
			String[] sb = new String[colSize];
			for(int j = 0 ; j < colSize; j++){
				ExportColumn col = exportColumns.get(j);
				String field = col.getField();
				//获取当前返回值对象相关属性值
				Field propertyField;
				Class<?> propertyType = null;
				Object colData = null;
				try {
					try{
						propertyField = clazz.getDeclaredField(field);
						propertyType = propertyField.getType();
					}catch (NoSuchFieldException e) {
						propertyType = String.class;
					}
					colData = PropertyUtils.getSimpleProperty(exportData, field);
				} catch (SecurityException e) {
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				} catch (InvocationTargetException e) {
					e.printStackTrace();
				} catch (NoSuchMethodException e) {
					e.printStackTrace();
				}
				
				String renderedData = "";
				if(colData == null) renderedData = "";
				else{
					if(propertyType == Integer.class){
						renderedData = AppConstants.numberFormatter.format(colData);
					}else if(propertyType == Long.class){
						renderedData = AppConstants.numberFormatter.format(colData);
					}else if(propertyType == Float.class){
						renderedData = AppConstants.decimalFormatter.format(colData);
					}else if(propertyType == Double.class){
						renderedData =AppConstants.decimalFormatter.format(colData);
					}else if(propertyType == Date.class){
						renderedData = AppConstants.datetimeFormatter.format(colData);
					}else if(propertyType == String.class){
						renderedData = colData.toString();
					}else{
						logger.warn("不支持的数据类型");
						renderedData = colData.toString();
					}
				}
				if(StringUtils.isNotBlank(col.getLov())){
					sb[j] = col.getLovShowName(renderedData);//值列表转换
				}else{
					sb[j] = renderedData;
				}
				
			}
			try {
				writer.writeRecord(sb);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public void stopWrite() throws WriteExportFileException{
		logger.debug("结束写文件...");
		try{
			if(writer != null){
				writer.close();
			}
		}catch(Exception e){
			logger.error(e);
			throw new WriteExportFileException("写文件时发生一个错误:"+e.getMessage());
		}finally{
			if(writer != null){
				writer.close();
			}
		}
	}
}
