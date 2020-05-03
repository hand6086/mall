package com.hand.core.util;

import java.util.Map;
import java.util.Properties;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.config.YamlMapFactoryBean;
import org.springframework.beans.factory.config.YamlPropertiesFactoryBean;
import org.springframework.core.io.ClassPathResource;

public class YamlUtils {

	private static final Logger logger = LogManager.getLogger(YamlUtils.class);
	
	private static final String ymlName = "application.yml";
	
	public static Map<String, Object> yaml2Map(String yamlSource) {
        try {
            YamlMapFactoryBean yaml = new YamlMapFactoryBean();
            yaml.setResources(new ClassPathResource(yamlSource));
            return yaml.getObject();
        } catch (Exception e) {
            logger.error("Cannot read yaml/yml", e);
            return null;
        }
    }
	
	//根据属性层级路径名称得到值
	public static String getYmlValueByName(String name,String yamlSource){
		Map<String, Object> yamlMap = yaml2Map(yamlSource);
		Object result = new Object();
		String[] split = name.split("\\.");
		int len = split.length;
		if(len == 1){//如果长度为1则直接通过name去map中的值
			result = yamlMap.get(name);
		}else if(len >= 2){
			Object yamlMapTemp = yamlMap.get(split[0]);//先取到第二个元素
			for(int i=1;i<len-1;i++){//从第二个元素开始走你
				yamlMapTemp = ((Map<String,Object>)yamlMapTemp).get(split[i]);
			}
			result = ((Map<String,Object>)yamlMapTemp).get(split[len-1]);
		}
		//暂时统一返回String类型（为了搭配AppConstants）
		return result.toString();
	}
	
	//根据属性层级路径名称得到值
	public static String getByNameDefaultYml(String name){
			Map<String, Object> yamlMap = yaml2Map(ymlName);
			Object result = new Object();
			String[] split = name.split("\\.");
			int len = split.length;
			if(len == 1){//如果长度为1则直接通过name去map中的值
				result = yamlMap.get(name);
			}else if(len >= 2){
				Object yamlMapTemp = yamlMap.get(split[0]);//先取到第二个元素
				for(int i=1;i<len-1;i++){//从第二个元素开始走你
					yamlMapTemp = ((Map<String,Object>)yamlMapTemp).get(split[i]);
				}
				result = ((Map<String,Object>)yamlMapTemp).get(split[len-1]);
			}
			//暂时统一返回String类型（为了搭配AppConstants）
			return result.toString();
		}
	
	public static Properties yaml2Properties(String yamlSource) {
        try {
            YamlPropertiesFactoryBean yaml = new YamlPropertiesFactoryBean();
            yaml.setResources(new ClassPathResource(yamlSource));
            return yaml.getObject();
        } catch (Exception e) {
            logger.error("Cannot read yaml/yml", e);
            return null;
        }
    }
	
	public static void main(String[] args) {
		String a = getByNameDefaultYml("spring.redis.host");
		System.out.println(a);
	}

}
