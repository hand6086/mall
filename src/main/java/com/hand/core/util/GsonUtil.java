package com.hand.core.util;
import com.google.gson.ExclusionStrategy;
import com.google.gson.FieldAttributes;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class GsonUtil {

	public static String stayFields2Json(final String[] stayFields, Object obj){
		
		Gson gson = new GsonBuilder().setExclusionStrategies(new ExclusionStrategy() {
			@Override
			public boolean shouldSkipField(FieldAttributes f) {
				for(int i=0; i<stayFields.length; i++){
					if(f.getName().equals(stayFields[i])){
						return false;
					}
				}
				return true;
			}

			@Override
			public boolean shouldSkipClass(Class<?> arg0) {
				// TODO Auto-generated method stub
				return false;
			}
		}).create();
		
		return gson.toJson(obj);
	}
	
	public static String stayFields2Json(String stayFieldsStr, Object obj){
		if(stayFieldsStr == null || "".equals(stayFieldsStr)){
			return null;
		}
		String[] stayFields = stayFieldsStr.trim().split(",");
		return stayFields2Json(stayFields, obj);
	}
}
