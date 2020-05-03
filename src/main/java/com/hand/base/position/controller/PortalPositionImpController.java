package com.hand.base.position.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicService;
import com.hand.base.position.model.Position;
import com.hand.base.position.service.PositionImpService;
import com.hand.base.user.model.User;
import com.hand.core.util.UserUtil;

@Controller
@RequestMapping("/action/portal/positionImp")
public class PortalPositionImpController extends BasicController<Position> {
	//private static final Logger logger = LogManager.getLogger(PortalPositionImpController.class);

	@Resource
	private PositionImpService positionImpService;
	
	@Override
	public BasicService<Position>  getBasicService() throws Exception{
		return positionImpService;
	}
	
	@Override
	public void beforQueryAllOrExample(Position entity, HttpServletRequest request) throws Exception{
		User user = UserUtil.getUser(null);
		if(entity.getConditionSql() == null){
			entity.setConditionSql("");
		}
		entity.setConditionSql(entity.getConditionSql()+" and createdBy="+"'"+user.getId()+"'");
	}
	
	@RequestMapping(value = "/check", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> check(CallParam callParam, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			positionImpService.runPositionCheck(callParam);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/positionImpInsert", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> positionImpInsert(CallParam callParam, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			positionImpService.runNewPositionForimp(callParam);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
}
