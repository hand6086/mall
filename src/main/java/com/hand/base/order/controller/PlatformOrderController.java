package com.hand.base.order.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.dao.mybatis.mapper.BasicCommonMapper;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.model.ListOfValue;
import com.hand.base.basic.model.ListValue;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.order.model.InterfaceOrder;
import com.hand.base.order.model.InterfaceOrderReturn;
import com.hand.base.order.model.LogisticsCompanyReturn;
import com.hand.base.order.model.OrderLogisticsReturn;
import com.hand.base.order.model.PlatformOrder;
import com.hand.base.order.service.PlatformOrderService;
import com.hand.base.user.model.Token;
import com.hand.base.user.service.TokenService;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.modules.export.ExportFactory;
import com.hand.core.modules.export.ExportWriter;
import com.hand.core.util.AppConstants;
import com.hand.core.util.DateUtil;
import com.hand.core.util.StringUtils;

@Controller
@RequestMapping("/action/portal/order/platformOrder")
public class PlatformOrderController extends BasicController<PlatformOrder>{

	private static final Logger logger = LogManager.getLogger(PlatformOrderController.class);
	
	@Autowired
	private PlatformOrderService platformOrderService;
	
	@Autowired
	private TokenService tokenService;
	
	@Autowired
	private BasicCommonMapper basicCommonMapper;
	
	@Override
	public BasicService<PlatformOrder> getBasicService() throws Exception {
		return platformOrderService;
	}
	
//	/**
//	 * 平台订单导出(允许导出的最大时间间隔为30天内的数据)
//	 */
//	@ResponseBody
//	public Map<String, Object> exportData(PlatformOrder entity, QueryParams qps, HttpSession session, 
//			HttpServletRequest request, HttpServletResponse response) {
//		logger.info("导出列表...");
//		Map<String, Object> result = new HashMap<String, Object>();
//		try{
//			qps.preDealSecurity(request);
//			ExportWriter exportWriter = ExportFactory.newInstance(qps);
//			PlatformOrder t = (PlatformOrder)BasicModel.transformClass(entity, qps);
//			beforQueryAllOrExample(t,request);
//			beforQueryExample(t,request);
//			while(!qps.stopExport){
//				//导出全部 不分页
//				t.setPageFlag(false);
//				List<PlatformOrder> list = platformOrderService.queryByExamplePage(t);
//				exportWriter.wirteData(list);
//			}
//			result.put("success", true);
//			result.put("url", exportWriter.getUrlPath());
//		}catch(Exception e){
//			e.printStackTrace();
//			result.put("success", false);
//			result.put("result", e.getMessage());
//		}
//		return result;
//	}
	
	/**
	 * 接口:订单物流信息更新
	 * @return
	 */
	@RequestMapping(value = "/queryLogisticsCompany", method = RequestMethod.POST, headers="Referer=http://www.hand-china.com/")
	@ResponseBody
	public Object queryLogisticsCompany(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		LogisticsCompanyReturn logisticsCompanyReturn = new LogisticsCompanyReturn();

		// 获取token
		String token = request.getParameter("session_token");
		String key = request.getParameter("key2");
		
		String params = "key2=" + key + "&session_token="+token;
		Map<String, String> map = validate(token, key, request.getHeader("Signiture"), params);
		if(!AppConstants.INTERFACE_QUERY_SUCCESS_CODE.equals(map.get("code"))){
			logisticsCompanyReturn.setReturnCode(map.get("code"));
			logisticsCompanyReturn.setReturnStatus(map.get("status"));
			logisticsCompanyReturn.setReturnMsg(map.get("msg"));
			return logisticsCompanyReturn;
		}
		
		try {
			// 查询物流公司名称
			List<ListValue> list = basicCommonMapper.queryLogisticsCompany();
			logisticsCompanyReturn.setList(list);
			logisticsCompanyReturn.setReturnCode(AppConstants.INTERFACE_QUERY_SUCCESS_CODE);
			logisticsCompanyReturn.setReturnStatus(AppConstants.INTERFACE_QUERY_SUCCESS_STATUS);
			return logisticsCompanyReturn;
		} catch (Exception e) {
			e.printStackTrace();
			logisticsCompanyReturn.setReturnCode(AppConstants.INTERFACE_QUERY_OTHER_ERROR_CODE);
			logisticsCompanyReturn.setReturnStatus(AppConstants.INTERFACE_QUERY_ERROR_STATUS);
			return logisticsCompanyReturn;
		}
	}
	
	/**
	 * 接口:订单物流信息更新
	 * @return
	 */
	@RequestMapping(value = "/updateOrderLogistics", method = RequestMethod.POST, headers="Referer=http://www.hand-china.com/")
	@ResponseBody
	public Object updateOrderLogistics(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		OrderLogisticsReturn orderLogisticsReturn = new OrderLogisticsReturn();
		// 获取token
		String token = request.getParameter("session_token");
		String orderNum = request.getParameter("orderNum");
		String logisticsCompany = request.getParameter("logisticsCompany");
		String logisticsNum = request.getParameter("logisticsNum");
		
		String key = request.getParameter("key2");
		
		String params = "key2=" + key + "&logisticsCompany=" + logisticsCompany
				+ "&logisticsNum=" + logisticsNum + "&orderNum=" + orderNum + "&session_token="+token;
		Map<String, String> map = validate(token, key, request.getHeader("Signiture"), params);
		if(!AppConstants.INTERFACE_QUERY_SUCCESS_CODE.equals(map.get("code"))){
			orderLogisticsReturn.setReturnCode(map.get("code"));
			orderLogisticsReturn.setReturnStatus(map.get("status"));
			orderLogisticsReturn.setReturnMsg(map.get("msg"));
			return orderLogisticsReturn;
		}
		String corpId = map.get("corpId");
		
		try {
			// 更新订单物流信息
			PlatformOrder platformOrder = new PlatformOrder();
			platformOrder.setOrderNum(orderNum);
			platformOrder.setLogisticsCompany(logisticsCompany);
			platformOrder.setLogisticsOddNumber(logisticsNum);
			platformOrder.setLastUpdatedBy(map.get("username"));
			
			// 根据订单编号查询订单
			PlatformOrder updateOrder = platformOrderService.queryIdByOrderNum(platformOrder);
			if(updateOrder == null || StringUtils.isNull(updateOrder.getId())){
				
				orderLogisticsReturn.setReturnCode(AppConstants.INTERFACE_QUERY_OTHER_ERROR_CODE);
				orderLogisticsReturn.setReturnStatus(AppConstants.INTERFACE_QUERY_SUCCESS_STATUS);
				orderLogisticsReturn.setReturnMsg("无法查询订单编号");
				return orderLogisticsReturn;
			}else{
				
				if(!StringUtils.isNull(updateOrder.getLogisticsOddNumber())){
					orderLogisticsReturn.setReturnCode(AppConstants.INTERFACE_QUERY_OTHER_ERROR_CODE);
					orderLogisticsReturn.setReturnStatus(AppConstants.INTERFACE_QUERY_ERROR_STATUS);
					orderLogisticsReturn.setReturnMsg("订单已发货，不允许重复发货！");
					return orderLogisticsReturn;
				}
				
				if(!"To Deliver".equals(updateOrder.getAttrib48())){
					orderLogisticsReturn.setReturnCode(AppConstants.INTERFACE_QUERY_OTHER_ERROR_CODE);
					orderLogisticsReturn.setReturnStatus(AppConstants.INTERFACE_QUERY_ERROR_STATUS);
					orderLogisticsReturn.setReturnMsg("订单状态不是待发货，不允许发货！");
					return orderLogisticsReturn;
				}
				
			}
			// 根据订单Id更新订单物流信息
			platformOrder.setId(updateOrder.getId());
			platformOrderService.updateOrderLogisticsById(platformOrder);
			
			orderLogisticsReturn.setReturnCode(AppConstants.INTERFACE_QUERY_SUCCESS_CODE);
			orderLogisticsReturn.setReturnStatus(AppConstants.INTERFACE_QUERY_SUCCESS_STATUS);
			return orderLogisticsReturn;
		} catch (Exception e) {
			e.printStackTrace();
			orderLogisticsReturn.setReturnCode(AppConstants.INTERFACE_QUERY_OTHER_ERROR_CODE);
			orderLogisticsReturn.setReturnStatus(AppConstants.INTERFACE_QUERY_ERROR_STATUS);
			return orderLogisticsReturn;
		}
	}
	
	/**
	 * 接口查询订单
	 * @return
	 */
	@RequestMapping(value = "/queryByOrderNum", method = RequestMethod.POST, headers="Referer=http://www.hand-china.com/")
	@ResponseBody
	public Object queryByOrderNum(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		InterfaceOrderReturn interfaceOrderReturn = new InterfaceOrderReturn();
		// 获取token
		String token = request.getParameter("session_token");
		String key = request.getParameter("key2");
		String orderNum = request.getParameter("orderNum");
		String headerStr = request.getHeader("Signiture");
		
		String params = "key2=" + key + "&orderNum=" + orderNum + "&session_token="+token;
		Map<String, String> map = validate(token, key, headerStr, params);
		if(!AppConstants.INTERFACE_QUERY_SUCCESS_CODE.equals(map.get("code"))){
			interfaceOrderReturn.setReturnCode(map.get("code"));
			interfaceOrderReturn.setReturnStatus(map.get("status"));
			interfaceOrderReturn.setReturnMsg(map.get("msg"));
			return interfaceReturnHandle(interfaceOrderReturn);
		}
		String corpId = map.get("corpId");
		
		try {
			InterfaceOrder param = new InterfaceOrder();
			param.setCorpid(corpId);
			param.setOrderNum(orderNum);
			List<InterfaceOrder> list  = platformOrderService.batchQueryInterfaceOrder(param);
			interfaceOrderReturn.setReturnCode(AppConstants.INTERFACE_QUERY_SUCCESS_CODE);
			interfaceOrderReturn.setReturnStatus(AppConstants.INTERFACE_QUERY_SUCCESS_STATUS);
			interfaceOrderReturn.setList(list);
			return interfaceReturnHandle(interfaceOrderReturn);
		} catch (Exception e) {
			e.printStackTrace();
			interfaceOrderReturn.setReturnCode(AppConstants.INTERFACE_QUERY_OTHER_ERROR_CODE);
			interfaceOrderReturn.setReturnStatus(AppConstants.INTERFACE_QUERY_ERROR_STATUS);
			return interfaceReturnHandle(interfaceOrderReturn);
		}
	}
	
	/**
	 * 接口查询订单
	 * @return
	 */
	@RequestMapping(value = "/batchQueryCount", method = RequestMethod.POST, headers="Referer=http://www.hand-china.com/")
	@ResponseBody
	public Object batchQueryCount(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		InterfaceOrderReturn interfaceOrderReturn = new InterfaceOrderReturn();
		// 获取token
		String token = request.getParameter("session_token");
		String key = request.getParameter("key2");
		String datetimeStart = request.getParameter("datetimeStart");
		String datetimeEnd = request.getParameter("datetimeEnd");
		String headerStr = request.getHeader("Signiture");
		
		String params = "datetimeEnd="+ datetimeEnd + "&datetimeStart=" + datetimeStart + "&key2=" + key + "&session_token="+token;
		Map<String, String> map = validate(token, key, headerStr, params);
		if(!AppConstants.INTERFACE_QUERY_SUCCESS_CODE.equals(map.get("code"))){
			interfaceOrderReturn.setReturnCode(map.get("code"));
			interfaceOrderReturn.setReturnStatus(map.get("status"));
			interfaceOrderReturn.setReturnMsg(map.get("msg"));
			return interfaceReturnHandle(interfaceOrderReturn);
		}
		String corpId = map.get("corpId");
		
		if(!StringUtils.isNull(datetimeStart)){
			if(!StringUtils.isNum(datetimeStart) || 14 != datetimeStart.length()){
				interfaceOrderReturn.setReturnCode(AppConstants.INTERFACE_QUERY_PARAM_ERROR_CODE);
				interfaceOrderReturn.setReturnMsg("开始时间格式不对！");
				interfaceOrderReturn.setReturnStatus(AppConstants.INTERFACE_QUERY_ERROR_STATUS);
				return interfaceReturnHandle(interfaceOrderReturn);
			}
		}
		
		if(!StringUtils.isNull(datetimeEnd)){
			if(!StringUtils.isNum(datetimeEnd) || 14 != datetimeEnd.length()){
				interfaceOrderReturn.setReturnCode(AppConstants.INTERFACE_QUERY_PARAM_ERROR_CODE);
				interfaceOrderReturn.setReturnMsg("结束时间格式不对！");
				interfaceOrderReturn.setReturnStatus(AppConstants.INTERFACE_QUERY_ERROR_STATUS);
				return interfaceReturnHandle(interfaceOrderReturn);
			}
		}
		
		if(!StringUtils.isNull(datetimeStart) && !StringUtils.isNull(datetimeEnd)){
			
			Date startDateStr = null;
			Date endDateStr = null;
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			try {
				startDateStr = sdf.parse(datetimeStart);
				endDateStr = sdf.parse(datetimeEnd);
			} catch (ParseException e) {
				interfaceOrderReturn.setReturnCode(AppConstants.INTERFACE_QUERY_PARAM_ERROR_CODE);
				interfaceOrderReturn.setReturnMsg("参数错误！");
				interfaceOrderReturn.setReturnStatus(AppConstants.INTERFACE_QUERY_ERROR_STATUS);
				return interfaceReturnHandle(interfaceOrderReturn);
			}
			
			if(startDateStr.after(endDateStr)){
				interfaceOrderReturn.setReturnCode(AppConstants.INTERFACE_QUERY_PARAM_ERROR_CODE);
				interfaceOrderReturn.setReturnMsg("开始时间不能大于结束时间！");
				interfaceOrderReturn.setReturnStatus(AppConstants.INTERFACE_QUERY_ERROR_STATUS);
				return interfaceReturnHandle(interfaceOrderReturn);
			}
		}
		
		try {
			InterfaceOrder param = new InterfaceOrder();
			param.setCorpid(corpId);
			param.setStartTime(datetimeStart);
			param.setEndTime(datetimeEnd);
			String count = platformOrderService.batchQueryInterfaceOrderCount(param);
			interfaceOrderReturn.setReturnCode(AppConstants.INTERFACE_QUERY_SUCCESS_CODE);
			interfaceOrderReturn.setReturnStatus(AppConstants.INTERFACE_QUERY_SUCCESS_STATUS);
			interfaceOrderReturn.setCount(count);
			return interfaceReturnHandle(interfaceOrderReturn);
			
		} catch (Exception e) {
			e.printStackTrace();
			interfaceOrderReturn.setReturnCode(AppConstants.INTERFACE_QUERY_OTHER_ERROR_CODE);
			interfaceOrderReturn.setReturnStatus(AppConstants.INTERFACE_QUERY_ERROR_STATUS);
			return interfaceReturnHandle(interfaceOrderReturn);
		}
	}
	
	/**
	 * 接口查询订单
	 * @return
	 */
	@RequestMapping(value = "/batchQuery", method = RequestMethod.POST, headers="Referer=http://www.hand-china.com/")
	@ResponseBody
	public Object batchQuery(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		InterfaceOrderReturn interfaceOrderReturn = new InterfaceOrderReturn();
		// 获取token
		String token = request.getParameter("session_token");
		String datetimeStart = request.getParameter("datetimeStart");
		String datetimeEnd = request.getParameter("datetimeEnd");
		String startRowValue = request.getParameter("startRow");
		String endRowValue = request.getParameter("endRow");
		String key = request.getParameter("key2");
		
		String params = "datetimeEnd="+ datetimeEnd + "&datetimeStart=" + datetimeStart + "&endRow=" + endRowValue 
				+ "&key2=" + key + "&session_token="+token +"&startRow=" + startRowValue;
		Map<String, String> map = validate(token, key, request.getHeader("Signiture"), params);
		if(!AppConstants.INTERFACE_QUERY_SUCCESS_CODE.equals(map.get("code"))){
			interfaceOrderReturn.setReturnCode(map.get("code"));
			interfaceOrderReturn.setReturnStatus(map.get("status"));
			interfaceOrderReturn.setReturnMsg(map.get("msg"));
			return interfaceReturnHandle(interfaceOrderReturn);
		}
		String corpId = map.get("corpId");
		
		int startRow = 0;
		int endRow = 0;
		
		try{
			startRow = Integer.valueOf(startRowValue);
			endRow =Integer.valueOf(endRowValue);
			if(startRow >= endRow){
				interfaceOrderReturn.setReturnCode(AppConstants.INTERFACE_QUERY_PARAM_ERROR_CODE);
				interfaceOrderReturn.setReturnMsg("参数错误！");
				interfaceOrderReturn.setReturnStatus(AppConstants.INTERFACE_QUERY_ERROR_STATUS);
				return interfaceReturnHandle(interfaceOrderReturn);
			}
		}catch(Exception e){
			interfaceOrderReturn.setReturnCode(AppConstants.INTERFACE_QUERY_PARAM_ERROR_CODE);
			interfaceOrderReturn.setReturnMsg("参数错误！");
			interfaceOrderReturn.setReturnStatus(AppConstants.INTERFACE_QUERY_ERROR_STATUS);
			return interfaceReturnHandle(interfaceOrderReturn);
		}
		
		
		if(!StringUtils.isNull(datetimeStart)){
			if(!StringUtils.isNum(datetimeStart) || 14 != datetimeStart.length()){
				interfaceOrderReturn.setReturnCode(AppConstants.INTERFACE_QUERY_PARAM_ERROR_CODE);
				interfaceOrderReturn.setReturnMsg("开始时间格式不对！");
				interfaceOrderReturn.setReturnStatus(AppConstants.INTERFACE_QUERY_ERROR_STATUS);
				return interfaceReturnHandle(interfaceOrderReturn);
			}
		}
		
		if(!StringUtils.isNull(datetimeEnd)){
			if(!StringUtils.isNum(datetimeEnd) || 14 != datetimeEnd.length()){
				interfaceOrderReturn.setReturnCode(AppConstants.INTERFACE_QUERY_PARAM_ERROR_CODE);
				interfaceOrderReturn.setReturnMsg("结束时间格式不对！");
				interfaceOrderReturn.setReturnStatus(AppConstants.INTERFACE_QUERY_ERROR_STATUS);
				return interfaceReturnHandle(interfaceOrderReturn);
			}
		}
		
		if(!StringUtils.isNull(datetimeStart) && !StringUtils.isNull(datetimeEnd)){
			
			Date startDateStr = null;
			Date endDateStr = null;
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			try {
				startDateStr = sdf.parse(datetimeStart);
				endDateStr = sdf.parse(datetimeEnd);
			} catch (ParseException e) {
				interfaceOrderReturn.setReturnCode(AppConstants.INTERFACE_QUERY_PARAM_ERROR_CODE);
				interfaceOrderReturn.setReturnMsg("参数错误！");
				interfaceOrderReturn.setReturnStatus(AppConstants.INTERFACE_QUERY_ERROR_STATUS);
				return interfaceReturnHandle(interfaceOrderReturn);
			}
			
			if(startDateStr.after(endDateStr)){
				interfaceOrderReturn.setReturnCode(AppConstants.INTERFACE_QUERY_PARAM_ERROR_CODE);
				interfaceOrderReturn.setReturnMsg("开始时间不能大于结束时间！");
				interfaceOrderReturn.setReturnStatus(AppConstants.INTERFACE_QUERY_ERROR_STATUS);
				return interfaceReturnHandle(interfaceOrderReturn);
			}
		}
		
		try {
			InterfaceOrder param = new InterfaceOrder();
			param.setCorpid(corpId);
			param.setStartTime(datetimeStart);
			param.setEndTime(datetimeEnd);
			param.setStartRow(startRow);
			param.setEndRow(endRow);
			List<InterfaceOrder> list  = platformOrderService.batchQueryInterfaceOrder(param);
			interfaceOrderReturn.setReturnCode(AppConstants.INTERFACE_QUERY_SUCCESS_CODE);
			interfaceOrderReturn.setReturnStatus(AppConstants.INTERFACE_QUERY_SUCCESS_STATUS);
			interfaceOrderReturn.setList(list);
			return interfaceReturnHandle(interfaceOrderReturn);
		} catch (Exception e) {
			e.printStackTrace();
			interfaceOrderReturn.setReturnCode(AppConstants.INTERFACE_QUERY_OTHER_ERROR_CODE);
			interfaceOrderReturn.setReturnStatus(AppConstants.INTERFACE_QUERY_ERROR_STATUS);
			return interfaceReturnHandle(interfaceOrderReturn);
		}
	}
	
	/**
	 * 参数校验
	 * @param token 秘钥1
	 * @param key	秘钥2
	 * @param signiture header信息
	 * @param params 字符串拼接
	 * @return
	 */
	private Map<String, String> validate(String token, String key, String signiture, String params){
		Map<String, String> map = new HashMap<String, String>();
		
		logger.debug("params is : " + params);
		
		// 非空判断
		if(StringUtils.isNull(token) || StringUtils.isNull(key) || StringUtils.isNull(signiture)){
			map.put("code", AppConstants.INTERFACE_QUERY_PARAM_ERROR_CODE);
			map.put("status", AppConstants.INTERFACE_QUERY_ERROR_STATUS);
			map.put("msg", "缺少参数！");
			return map;
		}
		
		// 字符串拼接后md5加密，与heder信息进行对比
		String resultStr = StringUtils.md5(params);
		if(!signiture.equalsIgnoreCase(resultStr)){
			map.put("code", AppConstants.INTERFACE_QUERY_PARAMS_ERROR_CODE);
			map.put("status", AppConstants.INTERFACE_QUERY_ERROR_STATUS);
			map.put("msg", "参数错误！");
			return map;
		}
		
		// 根据key获取企业编码
		Token t = new Token();
		t.setToken(token);
		t.setMdKey(key);
		Token queryToken = tokenService.queryTokenByTokenAndKey(t);
		if(queryToken == null){
			map.put("code", AppConstants.INTERFACE_QUERY_ENTERPRICE_ERROR_CODE);
			map.put("status", AppConstants.INTERFACE_QUERY_ERROR_STATUS);
			map.put("msg", "未维护企业编码，请联系管理员！");
			return map;
		}
		map.put("code", AppConstants.INTERFACE_QUERY_SUCCESS_CODE);
		map.put("corpId", queryToken.getCorpid());
		map.put("username", queryToken.getUsername());
		return map;
	}
	
	/**
	 * 接口返回处理
	 * @param InterfaceOrderReturn
	 * @return
	 */
	private static InterfaceOrderReturn interfaceReturnHandle(InterfaceOrderReturn interfaceOrderReturn){
		// 返回成功的时候，对接口进行加密
		if(AppConstants.INTERFACE_QUERY_SUCCESS_STATUS.equals(interfaceOrderReturn.getReturnStatus())){
			try {
				// 数量进行处理
				if(!StringUtils.isNull(interfaceOrderReturn.getCount())){
					String CountVal = interfaceOrderReturn.getCount();
					interfaceOrderReturn.setCount(CountVal);
				}
				// 订单列表进行处理
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return interfaceOrderReturn;
	}
	
	/**
	 * 第一个行结构
	 * @return
	 */
	@RequestMapping(value = "/queryMerchantByPage", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> queryMerchantByPage(QueryParams qps, PlatformOrder platformOrder, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			PlatformOrder t = (PlatformOrder) BasicModel.transformClass(PlatformOrder.class, qps);
			t.preDealSecurity(request);
			List<PlatformOrder> list = platformOrderService.queryMerchantByPage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((PlatformOrder) t), list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<PlatformOrder>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 第二个行结构
	 * @return
	 */
	@RequestMapping(value = "/queryProductByPage", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> queryProductByPage(QueryParams qps, PlatformOrder platformOrder, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			PlatformOrder t = (PlatformOrder) BasicModel.transformClass(PlatformOrder.class, qps);
			t.preDealSecurity(request);
			List<PlatformOrder> list = platformOrderService.queryProductByPage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((PlatformOrder) t), list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<PlatformOrder>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 订单推送记录
	 * @return
	 */
	@RequestMapping(value = "/queryOrderPushRecord", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> queryOrderPushRecord(QueryParams qps, PlatformOrder platformOrder, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			platformOrder = (PlatformOrder) BasicModel.transformClass(PlatformOrder.class, qps);
			String orderNum = request.getParameter("orderNum");
			platformOrder.setOrderNum(orderNum);
			platformOrder.preDealSecurity(request);
			List<PlatformOrder> list = platformOrderService.queryOrderPushRecord(platformOrder);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((PlatformOrder) platformOrder), list.size()));
			
			if(!platformOrder.getOnlyCountFlag()){
				this.pushCurrentDataCache(list, session.getId(), "base", false);
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<PlatformOrder>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * tab页 订单评价
	 * @return
	 */
	@RequestMapping(value = "/queryOrderEvaluation", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> queryOrderEvaluation(QueryParams qps, PlatformOrder platformOrder, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			platformOrder = (PlatformOrder) BasicModel.transformClass(PlatformOrder.class, qps);
			String orderId = request.getParameter("orderId");
			platformOrder.setOrderId(orderId);
			platformOrder.preDealSecurity(request);
			List<PlatformOrder> list = platformOrderService.queryOrderEvaluation(platformOrder);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((PlatformOrder) platformOrder), list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<PlatformOrder>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * tab页 订单促销活动
	 * @return
	 */
	@RequestMapping(value = "/queryOrderPromotions", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> queryOrderPromotions(QueryParams qps, PlatformOrder platformOrder, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			platformOrder = (PlatformOrder) BasicModel.transformClass(PlatformOrder.class, qps);
			String orderId = request.getParameter("orderId");
			platformOrder.setOrderId(orderId);
			platformOrder.preDealSecurity(request);
			List<PlatformOrder> list = platformOrderService.queryOrderPromotions(platformOrder);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((PlatformOrder) platformOrder), list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<PlatformOrder>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/queryOrderDetail",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> queryOrderDetail(QueryParams qps,PlatformOrder platformOrder,HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		String orderNum = platformOrder.getOrderNum();
		if(StringUtils.isBlank(orderNum)){
			throw new BasicServiceException("orderNum不能为空！");
		}
		try{
			platformOrder = platformOrderService.queryByOrderNum(platformOrder);
			if(platformOrder == null){
				throw new BasicServiceException("未查找到对应的订单编号记录！");
			}
			result.put("success", true);
			result.put("rows", platformOrder);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<PlatformOrder>());
			result.put("result", e.getMessage());
		}
		request.getSession().setAttribute("result", result);
		return result;
	}
	
	/**
	 * picklist 客户名称
	 * @return
	 */
	@RequestMapping(value = "/queryCustomerNamePage", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> queryCustomerNamePage(QueryParams qps, PlatformOrder platformOrder, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			PlatformOrder t = (PlatformOrder) BasicModel.transformClass(PlatformOrder.class, qps);
			t.preDealSecurity(request);
			List<PlatformOrder> list = platformOrderService.queryCustomerNamePage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((PlatformOrder) t), list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<PlatformOrder>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 品牌馆订单查询
	 * @return
	 */
	@RequestMapping(value = "/queryBrandPage", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> queryBrandPage(QueryParams qps, PlatformOrder platformOrder, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			PlatformOrder t = (PlatformOrder) BasicModel.transformClass(PlatformOrder.class, qps);
			t.preDealSecurity(request);
			List<PlatformOrder> list = platformOrderService.queryBrandPage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((PlatformOrder) t), list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<PlatformOrder>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 品牌馆订单发运查询
	 * @return
	 */
	@RequestMapping(value = "/queryBfPage", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> queryBfPage(QueryParams qps, PlatformOrder platformOrder, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			PlatformOrder t = (PlatformOrder) BasicModel.transformClass(PlatformOrder.class, qps);
			t.preDealSecurity(request);
			List<PlatformOrder> list = platformOrderService.queryBfPage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((PlatformOrder) t), list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<PlatformOrder>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 品牌馆订单发运筛选
	 * @return
	 */
	@RequestMapping(value = "/orderStatusAll", method = RequestMethod.POST)
	@ResponseBody
	public Object orderStatusAll(QueryParams qps, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		ListOfValue listOfValue = new ListOfValue();
		List<ListOfValue> list = null;
		try {
			list = platformOrderService.orderStatusAll(listOfValue);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	/**
	 * 更新订单推送记录，重新推送
	 */
	@RequestMapping(value = "/updateRecordById")
	@ResponseBody
	public Map<String, Object> updateRecordById(PlatformOrder entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			if(StringUtils.isNull(entity.getId())){
				result.put("success", false);
				result.put("result", "没有有效的推送记录Id！");
				return result;
			}
			platformOrderService.updateRecordById(entity);	
			auditTrailInsert(entity,request,session,"U");    //审计追踪新建记录
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 品牌馆订单状态更新
	 */
	@RequestMapping(value = "/brandUpdate")
	@ResponseBody
	public Map<String, Object> brandUpdate(PlatformOrder entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			beforUpdate(entity, request);
			beforUpsert(entity, request);
			checkData(entity, request);
			if(!checkExistDataCache("base", session, entity)){
				throw new BasicServiceException("非法更新数据！");
			}
			platformOrderService.brandUpdate(entity);	

			auditTrailInsert(entity,request,session,"U");    //审计追踪新建记录
			
			PlatformOrder newEntry = platformOrderService.queryBrandById(entity);
			result.put("newRow", newEntry);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 导出
	 */
	@RequestMapping(value = "/queryBfPage/exportData")
	@ResponseBody
	public Map<String, Object> export(PlatformOrder entity, QueryParams qps, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			ExportWriter exportWriter = ExportFactory.newInstance(qps);
			entity.setPageFlag(false);
			PlatformOrder t = (PlatformOrder)BasicModel.transformClass(entity, qps);
			
			while(!qps.stopExport){
				t.setTotalFlag(qps.getTotalFlag());
				beforQueryAllOrExample(t,request);
				beforQueryExample(t,request);
				List<PlatformOrder> list = platformOrderService.queryBfPage(t);
				if(qps.getPage() == 1){
					qps.setTotal(t.getTotal());
				}
				exportWriter.wirteData1(list);
				t.setPage(qps.getPage());
				t.setTotalFlag(qps.getTotalFlag());
			}
			result.put("success", true);
			result.put("url", exportWriter.getUrlPath());
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 品牌馆物流信息更新
	 */
	@RequestMapping(value = "/brandLogisticsUpdate")
	@ResponseBody
	public Map<String, Object> brandLogisticsUpdate(PlatformOrder entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			beforUpdate(entity, request);
			beforUpsert(entity, request);
			checkData(entity, request);
			if(!checkExistDataCache("base", session, entity)){
				throw new BasicServiceException("非法更新数据！");
			}
			
			Pattern pattern = Pattern.compile("^[0-9]*$");
			Matcher matcher = pattern.matcher(entity.getLogisticsOddNumber());
			boolean isChecked = matcher.matches();
			
			if(!isChecked){
				throw new BasicControllerException("物流单号格式有误，请输入正确的物流单号!");
			}
			platformOrderService.brandLogisticsUpdate(entity);	
			
			auditTrailInsert(entity,request,session,"U");    //审计追踪新建记录
			
			PlatformOrder newEntry = platformOrderService.queryBrandById(entity);
			result.put("newRow", newEntry);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
}
