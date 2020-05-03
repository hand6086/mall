package com.hand.base.position.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.position.model.Position;
import com.hand.base.position.service.PositionService;
import com.hand.base.user.model.User;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.basic.query.Sorter;
import com.hand.core.util.StringUtils;
import com.hand.core.util.UserUtil;

@Controller
@RequestMapping("/action/portal/position")
public class PortalPositionController extends BasicController<Position> {
	private static final Logger logger = LogManager.getLogger(PortalPositionController.class);

	@Resource
	private PositionService positionService;
	
	@Override
	public BasicService<Position>  getBasicService() throws Exception{
		return positionService;
	}
	
	/**
	 * 加载树
	 */
	@RequestMapping(value = "/treelist", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> treelist(QueryParams qps, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			Position root = positionService.queryRoot(new Position());
			positionService.queryTreeByRoot(root);
			result.put("success", true);
			result.put("tree", true);
			result.put("list", root);//传根节点
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("list", new Position());
			result.put("result", e.getMessage());
		}
		return result;
	}
	/**
	 * 加载结构框图树
	 */
	@RequestMapping(value = "/treelist/{initPosId}")
	@ResponseBody
	public Position treelist(@PathVariable String initPosId,QueryParams qps, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Position root = new Position(); 
		try{
			root.setId(initPosId);
			root = positionService.queryById(root);
			positionService.queryTreeByRoot1(root);
		}catch(Exception e){
			e.printStackTrace();
		}
		return root;
	}
	/**
	 * 选择父对象时的picklist
	 */
	@RequestMapping(value = "/parentPicklist", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> parentPicklist(Position entity, QueryParams qps, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.setAttr3(entity.getId());
			qps.addSorter(new Sorter("created",Sorter.DIR_DESC));//按创建时间来排序
			Position t = (Position)BasicModel.transformClass(Position.class, qps);
			t.preDealSecurity(request);//设置安全性
			List<Position> list = positionService.queryPositionListRemoveIdAndChildrenPage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((BasicModel)t), list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Position>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 通用picklist
	 */
	@RequestMapping(value = "/picklist", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> picklist(QueryParams qps, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			Position t = (Position)BasicModel.transformClass(Position.class, qps);
			t.preDealSecurity(request);//设置安全性
			List<Position> list = positionService.queryByExamplePage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((BasicModel)t), list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Position>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 获取登录用户的所有职位
	 */
	@RequestMapping(value = "/postnOfUser")
	@ResponseBody
	public Object list(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		QueryParams qps = new QueryParams();
		String userId = UserUtil.getUser(session).getId();
		if(StringUtils.isNull(userId)){
			userId = "noMactchId";
		}
		qps.setPageFlag(false);
		List<Position> list = null;
		try{
			Position t = (Position)BasicModel.transformClass(Position.class, qps);
			t.setUserId(userId);
			list = positionService.queryByUserPage(t);
		}catch(Exception e){
			e.printStackTrace();
			list = new ArrayList<Position>();
		}
		return list;
	}
	
	/**
	 * 修改session中的职位信息
	 */
	@RequestMapping(value = "/changeLoginPostn")
	@ResponseBody
	public Map<String, Object> changeLoginPostn(Position entity, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			Position position = positionService.queryById(entity);
			User user = UserUtil.getUser(session);
			if(user != null && position != null){
				user.setPostnId(position.getId());
				user.setPostnName(position.getText());
				user.setDeptId(position.getDeptId());
				user.setDeptName(position.getDeptName());
				user.setOrgId(position.getOrgId());
				user.setOrgName(position.getOrgName());
			} else {
				throw new BasicServiceException("修改失败，职位或用户信息查询错误。");
			}
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 根据ID删除该记录以及其子对象
	 */
	@RequestMapping(value = "/deleteWithChildById")
	@ResponseBody
	public Map<String, Object> deleteWithChildById(Position entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		logger.info("根据ID删除该记录以及其子对象信息...");
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			beforDelete(entity, request);
			checkData(entity, request);
			if(!checkExistDataCache("base", session, entity)){
				throw new BasicServiceException("非法删除数据！");
			}
			positionService.deleteWithChildById(entity);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
}
