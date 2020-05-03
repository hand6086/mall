package com.hand.base.coupon.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.coupon.dao.mybatis.mapper.GoodsinformationMapper;
import com.hand.base.coupon.model.Goodsinformation;

@Service
public class GoodsinformationServiceImpl extends BasicServiceImpl<Goodsinformation>implements GoodsinformationService {
	@Autowired
	private GoodsinformationMapper goodsinformationMapper;
	public BasicMapper<Goodsinformation> getBasicMapper() throws Exception {
		if(goodsinformationMapper != null){
			return goodsinformationMapper;
		}
		throw new BasicServiceException("获取Basic Mapper 失败，请确认程序是否正确！");
	}

}
