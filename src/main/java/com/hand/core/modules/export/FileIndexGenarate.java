package com.hand.core.modules.export;

import java.util.Date;
import java.util.Random;

public class FileIndexGenarate {
	
	public static Integer index = 0;
	
	public static Date lastDate;
	
	public static synchronized String getFileIndex(Date currentTime){
		if(lastDate != null && lastDate.getTime() == currentTime.getTime()){
			index++;
		}else{
			lastDate = currentTime;
			index = 0;
		}
		int length = index.toString().length();
		return index+getRandomNum().substring((length));
	}
	
	public static String  getRandomNum(){
		Random random = new Random();
		Integer temp = random.nextInt();
		String tempStr = temp.toString();
		if(tempStr.length() >= 6){
			return tempStr.substring(tempStr.length() - 6);
		}else if(tempStr.length() < 6){
			while(tempStr.length() < 6){
				tempStr = "0" + tempStr;
			}
		}
		return tempStr;
	}
	
	public static void main(String args[]){
		for(int i=0;i<10000;i++){
			Date date = new Date();
			System.out.println(getFileIndex(date));
		}
	}

}
