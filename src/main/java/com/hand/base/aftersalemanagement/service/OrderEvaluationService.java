package com.hand.base.aftersalemanagement.service;
import java.util.List;

import com.hand.base.aftersalemanagement.model.OrderEvaluation;

import com.hand.base.basic.service.BasicService;


public interface OrderEvaluationService extends BasicService<OrderEvaluation> {


	List<OrderEvaluation> queryevaluationPage(OrderEvaluation t)throws Exception;
	
	
	public int queryorderevaluationCount(OrderEvaluation entity) throws Exception;
	
	public int brandQueryorderevaluationCount(OrderEvaluation entity) throws Exception;


}
