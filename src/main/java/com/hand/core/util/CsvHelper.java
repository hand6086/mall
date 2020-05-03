package com.hand.core.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;



public class CsvHelper {
	
	public static String[] impotrHead(File file, Map<String, String> tabelHead ) throws Exception{
		BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(file),"GB18030"));
		String line = reader.readLine();
		String row[] = line.split(",");
		String headName = "";
		boolean flag = true;
		for (int i = 0; i < row.length; i++) {
			if(flag){
				flag = false;
				for(Map.Entry<String, String> entry: tabelHead.entrySet()) {
					if(row[i].equals(entry.getKey())){
						if(headName.equals("")){
							headName = entry.getValue();
						}
						else{
							headName = headName +","+entry.getValue();
						}
						flag = true;
						break;
					}
				}
			}
			else{
				break;
			}	
		}
		reader.close();
		if(flag){
			String[] fieldNames = headName.split(",");
			return fieldNames;
		}
		return null;
		
	}

	public static <T> List<T> readExcel(Class<T> clazz, String[] fieldNames,File myfile) throws Exception {
		List<T> dataModels = new ArrayList<T>();

		BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(myfile),"GB18030"));
		reader.readLine();//第一行信息，为标题信息，不用,如果需要，注释掉 
		String line = null;
		while((line=reader.readLine())!=null){
			String row[] = line.split(",");//CSV格式文件为逗号分隔符文件，这里根据逗号切分

			// 生成实例并通过反射调用setter方法
			T target = clazz.newInstance();
			for (int j = 0; j < fieldNames.length; j++) {
				String fieldName = fieldNames[j];
				
				if (fieldName == null) {
					continue; // 过滤serialVersionUID属性
				}
				// 获取excel单元格的内容
				String cell = row[j];
				String content = "";
				if (cell != null) {
					content = cell;
				}
				
				Field field = clazz.getDeclaredField(fieldName);
				 ReflectUtil.invokeSetter(target, fieldName,
                         parseValueWithType(content, field.getType()));
			}
			dataModels.add(target);
		}
		reader.close();
		return dataModels;
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

}
