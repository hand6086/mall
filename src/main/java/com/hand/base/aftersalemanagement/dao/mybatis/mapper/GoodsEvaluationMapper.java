package com.hand.base.aftersalemanagement.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.aftersalemanagement.model.GoodsEvaluation;
import com.hand.base.basic.dao.mapper.BasicMapper;




public interface GoodsEvaluationMapper extends BasicMapper<GoodsEvaluation> {
	
//第二个table的数据
		public List<GoodsEvaluation> queryevaluationPage(GoodsEvaluation record)  throws Exception;

		public int querygoodsevaluationCount(GoodsEvaluation entity) throws Exception;
		

	}
