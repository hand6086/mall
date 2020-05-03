/*package com.hand.core.util;

import java.text.SimpleDateFormat;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.SerializationConfig;

import com.hand.core.mybatis.MyBatisRepository;

public class CustomObjectMapper extends ObjectMapper {

    public CustomObjectMapper() {
        configure(SerializationConfig.Feature.WRITE_DATES_AS_TIMESTAMPS, false);            
        this.setDateFormat(new SimpleDateFormat("yyyy-MM-dd"));
    }
    
    public CustomObjectMapper(String datePattern) {
        configure(SerializationConfig.Feature.WRITE_DATES_AS_TIMESTAMPS, false);            
        setDateFormat(new SimpleDateFormat(datePattern));
    }
}*/