package com.hand.base.aftersalemanagement.service;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.aftersalemanagement.dao.mybatis.mapper.OrderEvaluationMapper;
import com.hand.base.aftersalemanagement.model.OrderEvaluation;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;


@Service
public class OrderEvaluationServiceImpl extends BasicServiceImpl<OrderEvaluation>implements OrderEvaluationService {
	@Autowired
	private OrderEvaluationMapper orderevaluationMapper;
	public BasicMapper<OrderEvaluation> getBasicMapper() throws Exception {
		if(orderevaluationMapper != null){
			return orderevaluationMapper;
		}
		throw new BasicServiceException("获取Basic Mapper 失败，请确认程序是否正确！");
	}
	@Override
	public List<OrderEvaluation> queryevaluationPage(OrderEvaluation t) throws Exception {
		
		return orderevaluationMapper.queryevaluationPage(t);
	}
	

	@Override
	public int queryorderevaluationCount(OrderEvaluation entity) throws Exception {
		return orderevaluationMapper.queryorderevaluationCount(entity);
	}
	
	@Override
	public int brandQueryorderevaluationCount(OrderEvaluation entity) throws Exception {
		return orderevaluationMapper.brandQueryorderevaluationCount(entity);
	}


	

}
