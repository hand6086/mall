package com.hand.base.smscode.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.hand.base.smscode.dao.mybatis.mapper.MessageTemplateMapper;
import com.hand.base.smscode.dao.mybatis.mapper.SmsMapper;
import com.hand.base.smscode.model.MessageTemplate;
import com.hand.base.smscode.model.SmsLog;

@Component
public class SmsService {
	private static final Logger LOGGER = Logger.getLogger(SmsService.class);
	public static String targetPhone = "targetPhone";
	public static String type = "type";
	@Autowired
	private SmsMapper smsMapper;

	@Autowired
	private MessageTemplateMapper tempMapper;

	public int update(SmsLog record) {
		return smsMapper.updateByPrimaryKeySelective(record);
	}

	public int insert(SmsLog record) {
		return smsMapper.insertSelective(record);
	}

	public SmsLog getPinByPhone(String phone) {
		Map<String, Object> reqMap = new HashMap<String, Object>();

		reqMap.put(targetPhone, phone);
		reqMap.put(type, "注册验证码");

		List<SmsLog> logList = smsMapper.select(reqMap);

		if (logList.size() == 0) {
			return null;
		} else if (logList.size() == 1) {
			return logList.get(0);
		} else {
			// remove other log except the first one
			for (int i = 1; i < logList.size(); i++) {
				smsMapper.deleteByPrimaryKey(logList.get(i).getRowId());
			}
			LOGGER.info("getgetPinByPhone" + logList.get(0));
			return logList.get(0);
		}

	}

	public List<MessageTemplate> findTempByType(String type) {
		return tempMapper.getByType(type);
	}
	
	
}
