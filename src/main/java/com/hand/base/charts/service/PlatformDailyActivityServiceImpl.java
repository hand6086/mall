package com.hand.base.charts.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.charts.dao.mybatis.mapper.PlatformDailyActivityMapper;
import com.hand.base.charts.model.PlatformDailyActivity;

@Service
public class PlatformDailyActivityServiceImpl extends BasicServiceImpl<PlatformDailyActivity> implements PlatformDailyActivityService {
	
	@Resource
	private PlatformDailyActivityMapper	plDailyActivityMapper;
	
	@Override
	public BasicMapper<PlatformDailyActivity> getBasicMapper() {
		return plDailyActivityMapper;
	}
}
