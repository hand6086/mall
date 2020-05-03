package com.hand.base.order.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.order.model.TransactionRecord;
import com.hand.base.order.service.TransactionRecordService;
import com.hand.base.user.model.User;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.modules.export.ExportFactory;
import com.hand.core.modules.export.ExportWriter;
import com.hand.core.util.UserUtil;

@Controller
@RequestMapping("/action/portal/order/transactionRecord")
public class TransactionRecordController extends BasicController<TransactionRecord>{
	@Autowired
	private TransactionRecordService transactionRecordService;

	@Override
	public BasicService<TransactionRecord> getBasicService() throws Exception {
		return transactionRecordService;
	}
	
	/**
	 * 导出
	 */
	@RequestMapping(value = "/queryByExamplePage/exportData")
	@ResponseBody
	public Map<String, Object> exportData(TransactionRecord entity, QueryParams qps, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		User user = UserUtil.getUser(session);
		try{
			qps.preDealSecurity(request);
			ExportWriter exportWriter = ExportFactory.newInstance(qps);
			TransactionRecord t = (TransactionRecord)BasicModel.transformClass(entity, qps);
			beforExportExample(t,request);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			//导出全部 不分页
			t.setPageFlag(false);
			List<TransactionRecord> list = null;
			if("101".equals(user.getUsercorpid()) && "0".equals(entity.getBrandQuery())){
				list = transactionRecordService.queryByExamplePage(t);
			}else{
				list = transactionRecordService.brandQueryByExamplePage(t);
			}
			for(TransactionRecord transactionRecord : list){
				transactionRecord.setPaymentNumber("=\""+transactionRecord.getPaymentNumber()+"\"");
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
