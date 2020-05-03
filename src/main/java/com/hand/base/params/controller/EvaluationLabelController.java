package com.hand.base.params.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.service.BasicService;
import com.hand.base.params.model.EvaluationLabel;
import com.hand.base.params.service.EvaluationLabelService;

@Controller
@RequestMapping("/action/portal/params/evaluationLabel")
public class EvaluationLabelController extends BasicController<EvaluationLabel> {
	@Autowired
	private EvaluationLabelService evaluationLabelService;

	@Override
	public BasicService<EvaluationLabel> getBasicService() throws Exception {
		if (evaluationLabelService != null) {
			return evaluationLabelService;
		}
		throw new BasicControllerException("获取Basic Service 失败，请确认程序代码是否正确！");
	}
}
