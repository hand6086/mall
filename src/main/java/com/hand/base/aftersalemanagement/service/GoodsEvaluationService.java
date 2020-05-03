package com.hand.base.aftersalemanagement.service;
import java.util.List;

import com.hand.base.aftersalemanagement.model.GoodsEvaluation;

import com.hand.base.basic.service.BasicService;


public interface GoodsEvaluationService extends BasicService<GoodsEvaluation> {


	List<GoodsEvaluation> queryevaluationPage(GoodsEvaluation t)throws Exception;
	
	public int querygoodsevaluationCount(GoodsEvaluation entity) throws Exception;
	


}
