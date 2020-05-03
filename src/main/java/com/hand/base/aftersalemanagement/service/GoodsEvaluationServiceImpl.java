package com.hand.base.aftersalemanagement.service;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.aftersalemanagement.dao.mybatis.mapper.GoodsEvaluationMapper;
import com.hand.base.aftersalemanagement.model.GoodsEvaluation;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;


@Service
public class GoodsEvaluationServiceImpl extends BasicServiceImpl<GoodsEvaluation>implements GoodsEvaluationService {
	@Autowired
	private GoodsEvaluationMapper goodsevaluationMapper;
	public BasicMapper<GoodsEvaluation> getBasicMapper() throws Exception {
		if(goodsevaluationMapper != null){
			return goodsevaluationMapper;
		}
		throw new BasicServiceException("获取Basic Mapper 失败，请确认程序是否正确！");
	}
	public List<GoodsEvaluation> queryevaluationPage(GoodsEvaluation t) throws Exception {
		// TODO Auto-generated method stub
		return goodsevaluationMapper.queryevaluationPage(t);
	}
	@Override
	public int querygoodsevaluationCount(GoodsEvaluation entity) throws Exception {
		return goodsevaluationMapper.querygoodsevaluationCount(entity);
	}




	

}
