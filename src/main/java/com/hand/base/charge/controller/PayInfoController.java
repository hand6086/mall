package com.hand.base.charge.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.charge.model.PayInfo;
import com.hand.base.charge.service.PayInfoService;
import com.hand.base.user.model.User;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.basic.query.Sorter;
import com.hand.core.modules.export.ExportFactory;
import com.hand.core.modules.export.ExportWriter;
import com.hand.core.util.UserUtil;

@Controller
@RequestMapping("/action/portal/charge/payInfo")
public class PayInfoController extends BasicController<PayInfo> {
	@Autowired
	private PayInfoService payInfoService;

	@Override
	public BasicService<PayInfo> getBasicService() throws Exception {
		if (payInfoService != null) {
			return payInfoService;
		}
		throw new BasicControllerException("获取Basic Service 失败，请确认程序代码是否正确！");
	}

	@RequestMapping(value = "/queryOrderNumPage", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> queryOrderNumPage(QueryParams qps, PayInfo payInfo, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			qps.addSorter(new Sorter("orderDt", Sorter.DIR_DESC));// 按创建时间来排序
			PayInfo t = (PayInfo) BasicModel.transformClass(PayInfo.class, qps);
			t.preDealSecurity(request);
			List<PayInfo> list = payInfoService.queryOrderNumPage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((BasicModel) t), list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<PayInfo>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 导出
	 */
	@RequestMapping(value = "/queryByExamplePage/exportData")
	@ResponseBody
	public Map<String, Object> exportData(PayInfo entity, QueryParams qps, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		User user = UserUtil.getUser(session);
		try{
			qps.preDealSecurity(request);
			ExportWriter exportWriter = ExportFactory.newInstance(qps);
			PayInfo t = (PayInfo)BasicModel.transformClass(entity, qps);
			beforExportExample(t,request);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			//导出全部 不分页
			t.setPageFlag(false);
			List<PayInfo> list = null;
			if("101".equals(user.getUsercorpid()) && "0".equals(entity.getBrandQuery())){
				list = payInfoService.queryByExamplePage(t);
			}else{
				list = payInfoService.brandQueryByExamplePage(t);
			}
			for(PayInfo payInfo : list){
				payInfo.setPaymentNumber("=\""+payInfo.getPaymentNumber()+"\"");
			}
			while(!qps.stopExport){
				exportWriter.wirteData(list);
			}
			result.put("success", true);
			result.put("url", exportWriter.getUrlPath());
			//result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
}
