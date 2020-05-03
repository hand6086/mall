package com.hand.base.basic.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.model.BasicLog;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicLogService;
import com.hand.base.basic.service.BasicService;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.modules.export.ExportFactory;
import com.hand.core.modules.export.ExportWriter;

@Controller
@RequestMapping("/portal/basicLog")
public class PortalBasicLogController {
	
	@Resource
	private BasicLogService	basicLogService;
	
	public BasicService<BasicLog> getBasicService() throws Exception {
		return basicLogService;
	}
	
	/**
	 * 根据条件查询记录,默认分页(若将'noPage'设置为'true'，则不分页)
	 */
	@RequestMapping(value = "/queryByExamplePage")
	@ResponseBody
	public Map<String, Object> queryByExamplePage(QueryParams qps, BasicLog record, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.invokePreFilterAndSorter();
			BasicLog basicLog = (BasicLog)BasicModel.transformClass(record.getClass(), qps);
			List<BasicLog> list = getBasicService().queryByExamplePage(basicLog);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", this.getCount(basicLog, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<BasicLog>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 导出
	 */
	@RequestMapping(value = "/queryByExamplePage/exportData")
	@ResponseBody
	public Map<String, Object> exportData(BasicLog entity, QueryParams qps, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			ExportWriter exportWriter = ExportFactory.newInstance(qps);
			BasicLog t = (BasicLog)BasicModel.transformClass(entity.getClass(), qps);
			while(!qps.stopExport){
				t = (BasicLog)BasicModel.transformClass(entity.getClass(), qps);
				exportWriter.wirteData(getBasicService().queryByExamplePage(t));
			}
			result.put("success", true);
			result.put("url", exportWriter.getUrlPath());
			result.put("total", ((BasicModel)t).getTotal());
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	public static Integer getCount(BasicLog basicModel, int len){
		int startRow = basicModel.getStartRow();
		int rows = basicModel.getRows();
		if(len < rows) return startRow + len - 1;
		if(rows == len) return startRow * basicModel.getPage() + rows;
		return basicModel.getTotal();
	}
}
