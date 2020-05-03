package com.hand.base.aftersalemanagement.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.aftersalemanagement.model.OrderEvaluation;
import com.hand.base.basic.dao.mapper.BasicMapper;




public interface OrderEvaluationMapper extends BasicMapper<OrderEvaluation> {
	
//第二个table的数据
		public List<OrderEvaluation> queryevaluationPage(OrderEvaluation record)  throws Exception;

		
		public int queryorderevaluationCount(OrderEvaluation entity) throws Exception;
		
		public int brandQueryorderevaluationCount(OrderEvaluation entity) throws Exception;

	}
