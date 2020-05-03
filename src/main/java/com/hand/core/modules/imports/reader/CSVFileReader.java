package com.hand.core.modules.imports.reader;

import java.beans.IntrospectionException;
import java.beans.PropertyDescriptor;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

import com.hand.core.basic.query.ImportColumn;
import com.hand.core.modules.imports.FileReader;
import com.hand.core.modules.imports.exception.ImportsException;
import com.hand.core.util.StringUtils;

public class CSVFileReader implements FileReader{
	
	private File file;
	
	private InputStream inputStream;
	
	@Override
	public String getEncoding() {
		return null;
	}

	@Override
	public void setEncoding(String encoding) {
		
	}

	@Override
	public <T> List<T> readContent(Class<T> clazz,List<ImportColumn> importColumns,List<ImportColumn> headers) throws ImportsException{
		List<T> result = new ArrayList<T>();
		List<String[]> list = new ArrayList<String[]>();
		 String filePath = file.getAbsolutePath();
		 try{
			 CsvReader reader = new CsvReader(filePath,',',Charset.forName("GBK"));
			 reader.readHeaders();
			 int rows = 0;
			 while(reader.readRecord()){//逐行读取数据
				T record = clazz.newInstance();
				list.add(reader.getValues());
				for(int i=0;headers != null && i<headers.size() && i<list.get(rows).length;i++){
					ImportColumn header = headers.get(i);
					for(int j=0;importColumns != null && j<importColumns.size();j++){
						ImportColumn importColumn = importColumns.get(j);
						if( header.getTitle().equals(importColumn.getTitle()) ){
							String content = list.get(rows)[i];
							if(content == null){
								content = "";
							}
							String fieldName = importColumn.getField();
							if("id".equalsIgnoreCase(fieldName)){
									continue;
							}
							Class<?> propertyType = null;
							try{
								Field propertyField = clazz.getDeclaredField(fieldName);
								propertyType = propertyField.getType();
							}catch(Exception e){
								propertyType = String.class;
							}
							try {
								PropertyDescriptor pd = new PropertyDescriptor(fieldName, clazz);
								Method wM = pd.getWriteMethod();//获得写方法
								wM.invoke(record,  parseValueWithType(content, propertyType));
							} catch (IntrospectionException e) {
								e.printStackTrace();
							}
						}
					}
				}
				
				rows++;
				result.add(record);
			 }
			 reader.close();
		 }
		 catch (FileNotFoundException e) {
				e.printStackTrace();
		 } catch (IOException e) {
				e.printStackTrace();
		 } catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@Override
	public <T> List<T> readContentFromInputStream(Class<T> clazz, List<ImportColumn> importColumns, InputStream inputStream) throws ImportsException{
		this.inputStream = inputStream;
		List<T> result = new ArrayList<T>();
		List<String[]> list = new ArrayList<String[]>();
		
		List<ImportColumn> headers = new ArrayList<ImportColumn>();
		try {
			InputStreamReader inputStreamReader = new InputStreamReader(inputStream,"GB18030"); 
			BufferedReader reader = new BufferedReader(inputStreamReader);
			String line = reader.readLine();
			if(StringUtils.isNull(line)) throw new ImportsException("导入的列数量不能为0！");
			// 读取头信息（标题）
			String row[] = line.split(",");
			for (int i = 0; i < row.length; i++) {
				ImportColumn importColumn = new ImportColumn();
				importColumn.setTitle(row[i]);
				headers.add(importColumn);
			}
			
			// 逐行读取数据（数据）
			String contents = null;
			int rows = 0;
			while ((contents = reader.readLine()) != null) {// 逐行读取数据
				T record = clazz.newInstance();
				list.add(contents.split(","));
				for (int i = 0; headers != null && i < headers.size() && i < list.get(rows).length; i++) {
					ImportColumn header = headers.get(i);
					for (int j = 0; importColumns != null && j < importColumns.size(); j++) {
						ImportColumn importColumn = importColumns.get(j);
						if (header.getTitle().equals(importColumn.getTitle())) {
							String content = list.get(rows)[i];
							if (content == null) {
								content = "";
							}
							String fieldName = importColumn.getField();
							if ("id".equalsIgnoreCase(fieldName)) {
								continue;
							}
							Class<?> propertyType = null;
							try {
								Field propertyField = clazz.getDeclaredField(fieldName);
								propertyType = propertyField.getType();
							} catch (Exception e) {
								propertyType = String.class;
							}
							try {
								PropertyDescriptor pd = new PropertyDescriptor(fieldName, clazz);
								Method wM = pd.getWriteMethod();// 获得写方法
								wM.invoke(record, parseValueWithType(content, propertyType));
							} catch (IntrospectionException e) {
								e.printStackTrace();
							}
						}
					}
				}
				rows++;
				result.add(record);
			}
			inputStream.close();
			inputStreamReader.close();
			reader.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@Override
	public List<ImportColumn> readHeader(File file) throws ImportsException{
		List<ImportColumn> list = new ArrayList<ImportColumn>();
		try {
			this.file = file;
			BufferedReader reader;
			reader = new BufferedReader(new InputStreamReader(new FileInputStream(file),"GB18030"));
			String line = reader.readLine();
			String row[] = line.split(",");
			for (int i = 0; i < row.length; i++) {
				ImportColumn importColumn = new ImportColumn();
				importColumn.setTitle(row[i]);
				list.add(importColumn);
			}
			reader.close();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return list;
	}

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	protected static <T> Object parseValueWithType(String value, Class<?> type) {
		 Object result = null;
	        try { // 根据属性的类型将内容转换成对应的类型
	            if (Boolean.TYPE == type) {
	                result = Boolean.parseBoolean(value);
	            } else if (Byte.TYPE == type) {
	                result = Byte.parseByte(value);
	            } else if (Short.TYPE == type) {
	                result = Short.parseShort(value);
	            } else if (Integer.TYPE == type) {
	                result = Integer.parseInt(value);
	            } else if (Long.TYPE == type) {
	                result = Long.parseLong(value);
	            } else if (Float.TYPE == type) {
	                result = Float.parseFloat(value);
	            } else if (Double.TYPE == type) {
	                result = Double.parseDouble(value);
	            } else if (Class.forName("java.lang.Double") == type){
	            	result = Double.parseDouble(value);
	            } else {
	                result = (Object) value;
	            }
	        } catch (Exception e) {
	            // 把异常吞掉直接返回null
	        }
	        return result;
   }

	@Override
	public List<ImportColumn> readHeaderFromInputStream(InputStream inputStream) throws ImportsException {
		List<ImportColumn> list = new ArrayList<ImportColumn>();
		try {
			this.inputStream = inputStream;
			BufferedReader reader;
			reader = new BufferedReader(new InputStreamReader(inputStream,"GB18030"));
			String line = reader.readLine();
			String row[] = line.split(",");
			for (int i = 0; i < row.length; i++) {
				ImportColumn importColumn = new ImportColumn();
				importColumn.setTitle(row[i]);
				list.add(importColumn);
			}
			
			
			
			
			String contents = null;
			 int rows = 0;
			 while((contents = reader.readLine()) != null){//逐行读取数据
				 rows ++;
				System.out.println(rows + ":" + contents);
			 }
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			reader.close();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return list;
	}
}
