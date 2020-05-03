package com.hand.base.aftersalemanagement.service;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.aftersalemanagement.dao.mybatis.mapper.WithRefundOrderMapper;
import com.hand.base.aftersalemanagement.model.WithRefundOrder;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;


@Service
public class WithRefundOrderServiceImpl extends BasicServiceImpl<WithRefundOrder>implements WithRefundOrderService {
	
	@Autowired
	private WithRefundOrderMapper withrefundorderMapper;
	
	public BasicMapper<WithRefundOrder> getBasicMapper() throws Exception {
		if(withrefundorderMapper != null){
			return withrefundorderMapper;
		}
		throw new BasicServiceException("获取Basic Mapper 失败，请确认程序是否正确！");
	}
	
	@Override
	public List<WithRefundOrder> queryoOderGoodsPage(WithRefundOrder t) throws Exception {
		
		return withrefundorderMapper.queryoOderGoodsPage(t);
	}
	
	@Override
	public List<WithRefundOrder> brandQueryoOderGoodsPage(WithRefundOrder t) throws Exception {
		
		return withrefundorderMapper.brandQueryoOderGoodsPage(t);
	}
	
	@Override
	public List<WithRefundOrder> queryType(WithRefundOrder entity) throws Exception {
		return withrefundorderMapper.queryType(entity);
	}
	

}
