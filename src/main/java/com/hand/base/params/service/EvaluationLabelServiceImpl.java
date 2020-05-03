package com.hand.base.params.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.params.dao.mybatis.mapper.EvaluationLabelMapper;
import com.hand.base.params.model.EvaluationLabel;

@Service
public class EvaluationLabelServiceImpl extends BasicServiceImpl<EvaluationLabel> implements EvaluationLabelService {
	@Autowired
	private EvaluationLabelMapper evaluationLabelMapper;

	@Override
	public BasicMapper<EvaluationLabel> getBasicMapper() {
		return evaluationLabelMapper;
	}

}
