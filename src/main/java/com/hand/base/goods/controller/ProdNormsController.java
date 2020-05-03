package com.hand.base.goods.controller;



import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.goods.model.ProdNorms;
import com.hand.base.goods.service.ProdNormsService;

@Controller("ProdNormsController")
@RequestMapping("/action/portal/prodNorms")
public class ProdNormsController extends BasicController<ProdNorms>{
 
	@Resource
	private KeyGenerateService keyGenerateService;

	@Resource
	private ProdNormsService prodNormsService;

	@Override
	public BasicService<ProdNorms> getBasicService() throws Exception {
		return prodNormsService;
	}	 
}
