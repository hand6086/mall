package com.hand.base.charts.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.charts.dao.mybatis.mapper.PlatformRepeatPurchaseMapper;
import com.hand.base.charts.model.ChartsBrowsingAnalysis;
import com.hand.base.charts.model.PlatformRepeatPurchase;

@Service
public class PlatformRepeatPurchaseServiceImpl extends BasicServiceImpl<PlatformRepeatPurchase> implements PlatformRepeatPurchaseService {
	
	@Resource
	private PlatformRepeatPurchaseMapper platformRepeatPurchaseMapper;
	
	@Override
	public BasicMapper<PlatformRepeatPurchase> getBasicMapper() {
		return platformRepeatPurchaseMapper;
	}
	@Override
	public List<PlatformRepeatPurchase> queryByExamplePage(PlatformRepeatPurchase entity) throws Exception {
		beforQueryExample(entity);
		beforQueryAllOrExample(entity);
		if("fast shopping".equals(entity.getChooseType())){
			return platformRepeatPurchaseMapper.queryByExamplePage(entity);
		}else{
			return platformRepeatPurchaseMapper.brandQueryByExamplePage(entity);
		}
		
	}
}
