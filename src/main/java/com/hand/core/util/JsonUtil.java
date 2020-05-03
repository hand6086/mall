package com.hand.core.util;

import java.io.IOException;
import java.io.StringWriter;

import org.apache.log4j.Logger;
import org.json.JSONObject;

import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.databind.module.SimpleModule;


public class JsonUtil {
	
	
	private static ObjectMapper objectMapper;
	private static Logger logger= Logger.getLogger(JsonUtil.class);
	
	public static String toJsonString(Object obj){
		String resp = null;
		ObjectMapper mapper = new ObjectMapper();
		JSONObject jsonObject = null;
		try {
			resp = mapper.writeValueAsString(obj);
			
			jsonObject = new JSONObject(resp);  
			
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return jsonObject.toString();
	}
	/**
	 * 懒惰单例模式得到ObjectMapper实例
	 * 此对象为Jackson的核心
	 */
	private static ObjectMapper getMapper(){
		if (objectMapper== null){
			synchronized (ObjectMapper.class) {  
		        if (objectMapper == null) {  
		        
					objectMapper= new ObjectMapper();
					//当找不到对应的序列化器时 忽略此字段
					objectMapper.configure(SerializationFeature.FAIL_ON_EMPTY_BEANS, false);
					//objectMapper.configure(SerializationFeature.Feature.FAIL_ON_EMPTY_BEANS, false);
					//对应实体类没有找到与json对应的字段时忽略
					objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
				    //使Jackson JSON支持Unicode编码非ASCII字符  
				    SimpleModule module = new SimpleModule();  
				    module.addSerializer(String.class, new StringUnicodeSerializer());  
				    objectMapper.registerModule(module);  
				    //设置null值不参与序列化(字段不被显示)  
				    objectMapper.setSerializationInclusion(Include.NON_NULL);  
					// 处理NULL值问题
					/*objectMapper.getSerializerProvider().setNullValueSerializer(
		                    new JsonSerializer<Object>() {
		                        @Override
		                        public void serialize(Object value, JsonGenerator jgen,
		                                SerializerProvider provider) throws IOException,
		                                JsonProcessingException {
		                            jgen.writeString("");
		                        }
		                    });*/

			//支持结束
		        }
			}
		}
		return objectMapper;
	}
	
	/**
	 * 创建JSON处理器的静态方法
	 * @param content JSON字符串
	 * @return
	 */
	private static JsonParser getParser(String content){
		try {
			return getMapper().getFactory().createParser(content);
		} catch (IOException ioe) {
			return null;
		}
	}
	
	/**
	 * 创建JSON生成器的静态方法, 使用标准输出
	 * @return
	 */
	private static JsonGenerator getGenerator(StringWriter sw){
		try {
			return getMapper().getFactory().createGenerator(sw);
		} catch (IOException e) {
			return null;
		}
	}
	
	/**
	 * JSON对象序列化
	 */
	public static String toJSON(Object obj){
		StringWriter sw= new StringWriter();
		JsonGenerator jsonGen= getGenerator(sw);
		if (jsonGen== null){
			try {
				sw.close();
			} catch (IOException e) {
			}
			return null;
		}		
		try {
		
			//由于在getGenerator方法中指定了OutputStream为sw
			//因此调用writeObject会将数据输出到sw
			jsonGen.writeObject(obj == null ? "" : obj);
			//由于采用流式输出 在输出完毕后务必清空缓冲区并关闭输出流
			jsonGen.flush();
			jsonGen.close();
			String resp = sw.toString();
			logger.debug("json: " + resp);
			return resp;
		} catch (JsonGenerationException jge) {
			jge.printStackTrace();
			logger.error("JSON生成错误" + jge.getMessage());
		} catch (IOException ioe) {
			ioe.printStackTrace();
			logger.error("JSON输入输出错误" + ioe.getMessage());
		}
		return null;		
	}
	
	/**
	 * JSON对象反序列化
	 */
	public static <T> T fromJSON(String json, Class<T> clazz) {
		try {
			JsonParser jp= getParser(json);
			return jp.readValueAs(clazz);
			
			// return (T) objectMapper.readValue(json, TypeFactory.rawClass(clazz));

		} catch (JsonParseException jpe){
			System.out.print(String.format("反序列化失败, 错误原因:%s", jpe.getMessage()));
			logger.error(String.format("反序列化失败, 错误原因:%s", jpe.getMessage()));
		} catch (JsonMappingException jme){
			System.out.print(String.format("反序列化失败, 错误原因:%s", jme.getMessage()));
			logger.error(String.format("反序列化失败, 错误原因:%s", jme.getMessage()));	
		} catch (IOException ioe){
			System.out.print(String.format("反序列化失败, 错误原因:%s", ioe.getMessage()));
			logger.error(String.format("反序列化失败, 错误原因:%s", ioe.getMessage()));
		}
		return null;
	}
	
}
