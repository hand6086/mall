package com.hand.core.autoconfig.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.core.autoconfig.model.LnkInnerField;
import com.hand.core.autoconfig.service.LnkInnerFieldService;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.modules.imports.ImportReader;
import com.hand.core.modules.imports.ImportsFactory;
import com.hand.core.util.StringUtils;

@Controller
@RequestMapping("/portal/LnkInnerField")
public class LnkInnerFieldController extends BasicController<LnkInnerField> {
	@Resource
	private KeyGenerateService		keyGenerateService;
	@Resource
	private LnkInnerFieldService	lnkInnerFieldService;
	
	@Override
	public BasicService<LnkInnerField> getBasicService() throws Exception {
		return lnkInnerFieldService;
	}
	
	/**
	 * 导入
	 */
	@Override
	@RequestMapping(value = "/importData")
	@ResponseBody
	@Transactional
	public Map<String, Object> importData(LnkInnerField entity, QueryParams qps, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		//logger.info("导入列表。。。");
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			ImportReader importReader = ImportsFactory.newInstance(qps, request);
			List<LnkInnerField> list = importReader.readList(LnkInnerField.class);
			for (int i = 0; list != null && i < list.size(); i++) {
				LnkInnerField record = list.get(i);
				record.setParentid(qps.getImportParentId());
				getBasicService().insert(record);
			}
			result.put("success", true);
			result.put("total", list.size());
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@Override
	public void beforQueryAllOrExample(LnkInnerField entity, HttpServletRequest request) throws Exception {
		super.beforQueryAllOrExample(entity, request);
		if(StringUtils.isBlank(entity.getParentid())){
			entity.setParentid("noMatchId");
		}
	}
}
