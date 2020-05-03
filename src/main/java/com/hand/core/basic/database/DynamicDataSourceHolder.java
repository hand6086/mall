package com.hand.core.basic.database;

/**
 * 利用ThreadLocal解决线程安全问题
 * @author qiqian.he
 *
 */
public class DynamicDataSourceHolder {
	public static final ThreadLocal<String> holder = new ThreadLocal<String>();

	public static void putDataSource(String name) {
		holder.set(name);
	}

	public static String getDataSouce() {
		return holder.get();
	}
	
	public static void clearDataSouce() {  
		holder.remove();  
    } 
}
