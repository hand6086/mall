package com.hand.core.util;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class TimeTool {
	
	public static final int THIRTY_MINUTES = 30;
	public static final SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public static final SimpleDateFormat dateTimeHourFormat = new SimpleDateFormat("yyyy-MM-dd HH");
	public static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	private static final Object dataTimeLocker = new Object();
	
	public static Date getCurrentDate(){
		return Calendar.getInstance().getTime();
	}
	

	/**
	 * 得到本周一
	 * @return
	 */
	public static Date getMondayOfThisWeek(){
		Calendar c = Calendar.getInstance();
		int dayofweek = c.get(Calendar.DAY_OF_WEEK) - 1;
		if (dayofweek == 0)
			dayofweek = 7;
		c.add(Calendar.DATE, -dayofweek + 1);
		return c.getTime();
	}
	
	public static Date getSpecialDayTime(int day) {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DATE, day);
		return calendar.getTime();
	}
	/**
	 * 得到下周一
	 * @return
	 */
	public static Date getMondayOfNextWeek(){
		Calendar c = Calendar.getInstance();
		int dayofweek = c.get(Calendar.DAY_OF_WEEK) - 1;
		if (dayofweek == 0)
			dayofweek = 7;
		c.add(Calendar.DATE, 8 - dayofweek);
		return c.getTime();
	}
	
	public static Date getByDateAndTime(String date, String time) {
		synchronized (dataTimeLocker) {
			try {
				return dateTimeFormat.parse(date + "" + time);
			} catch(Exception e) {
				return null;
			}
		}
	}
	public static Date getDateByString(String time) {
		synchronized (dataTimeLocker) {
			try {
				return dateTimeFormat.parse(time);
			} catch(Exception e) {
				return null;
			}
		} 
	}
	
	public static String getTimeStr(Date date) {
		synchronized (dataTimeLocker) {
			try {
				return dateTimeFormat.format(date);
			} catch(Exception e) {
				return date.toString();
			}
		} 
	}
	/**
	 * 获取今天是周几？（0-周日，1-周一，。。。6-周六）
	 * @return
	 */
	public static int getDayOfWeek(){
		Calendar c = Calendar.getInstance();
		return c.get(Calendar.DAY_OF_WEEK)-1;
	}
	
	public static boolean isCacheExpired(Long cacheTime) {
		if (cacheTime == null) return true;
		
		return System.currentTimeMillis()  > cacheTime;
	}
	
	public static String getHourTime(Date date) {
		synchronized (dateTimeHourFormat) {
			return dateTimeHourFormat.format(date);
		}
	}

	public static Date getTime(String str) {
		synchronized (dateFormat) {
			try {
				return dateFormat.parse(str);
			} catch (ParseException e) {
				e.printStackTrace();
				return null;
			}
		}
	}
	
	public static Date getExpireTime(int expiredInMinute) {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.MINUTE, expiredInMinute);
		return calendar.getTime();
	}
	
	public static Date getExpireTime(Date date, int expiredInMinute) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.MINUTE, expiredInMinute);
		return calendar.getTime();
	}
	
	public static void main(String[] args) {
		System.out.println(getExpireTime(15));
	}
}
