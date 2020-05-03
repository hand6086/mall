package com.hand.core.autoconfig.controller;

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
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.core.autoconfig.model.LnkInnerObject;
import com.hand.core.autoconfig.service.LnkInnerObjectService;
import com.hand.core.modules.BatchExportFileWriter;
import com.hand.core.modules.export.ExportTextFileWriter;

@Controller
@RequestMapping("/portal/autoconfig")
public class LnkInnerObjectController extends BasicController<LnkInnerObject> {
	@Resource
	private KeyGenerateService	keyGenerateService;
	@Resource
	private LnkInnerObjectService	lnkInnerObjectService;
	
	@Override
	public BasicService<LnkInnerObject> getBasicService() throws Exception {
		return lnkInnerObjectService;
	}
	
	@RequestMapping(value = "/newTable", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> newTable(LnkInnerObject record, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		ExportTextFileWriter writer = null;
		try {
			writer = new ExportTextFileWriter();
			String text = "";
			if("MySql".equals(record.getAttr1())){
				text = lnkInnerObjectService.newTable(record);
			}else{
				text = lnkInnerObjectService.newTable(record);
			}
			writer.writeText2(text);
			writer.getFilePath();
			writer.getUrlPath();
			System.out.print(writer.getFilePath());
			System.out.print(writer.getUrlPath());
			result.put("url", writer.getUrlPath());
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/test", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> Test(LnkInnerObject record, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		ExportTextFileWriter writer = null;
		try {
			writer = new ExportTextFileWriter();
			String text = "";
			record = lnkInnerObjectService.getFullLnkInnerObjectById(record);
			text = lnkInnerObjectService.test(record);
			writer.writeText2(text);
			writer.getFilePath();
			writer.getUrlPath();
			System.out.print(writer.getFilePath());
			System.out.print(writer.getUrlPath());
			result.put("url", writer.getUrlPath());
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/newQueryTable", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> newQueryTable(LnkInnerObject record, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		ExportTextFileWriter writer = null;
		try {
			writer = new ExportTextFileWriter();
			
			String text = "";
			if("MySql".equals(record.getAttr1())){
				text = lnkInnerObjectService.newQueryTable(record);
			}else{
				text = lnkInnerObjectService.newQueryTable(record);
			}
			writer.writeText2(text);
			writer.getFilePath();
			writer.getUrlPath();
			System.out.print(writer.getFilePath());
			System.out.print(writer.getUrlPath());
			result.put("url", writer.getUrlPath());
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/newObjectFile", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> newObjectFile(LnkInnerObject record, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		BatchExportFileWriter writer = null;
		try {
			writer = new BatchExportFileWriter();
			if("app".equals(record.getAttr2())){ //生成App代码
				writer.writeBatchText(lnkInnerObjectService.newAppFile(record));
			}else{
				writer.writeBatchText(lnkInnerObjectService.newObjectFile(record));
			}
			
			writer.getFilePath();
			writer.getUrlPath();
			result.put("url", writer.getUrlZipPath());
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/newAppFile", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> newAppFile(LnkInnerObject record, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		BatchExportFileWriter writer = null;
		try {
			writer = new BatchExportFileWriter();
			writer.writeBatchText(lnkInnerObjectService.newAppFile(record));
			writer.getFilePath();
			writer.getUrlPath();
			result.put("url", writer.getUrlZipPath());
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/getmodelinfo", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getmodelinfo(LnkInnerObject record, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			lnkInnerObjectService.getmodelinfo(record);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/updatemodelinfo", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updatemodelinfo(LnkInnerObject record, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			lnkInnerObjectService.updatemodelinfo(record);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/Check", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> Check(LnkInnerObject record, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			lnkInnerObjectService.Check(record);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/DeepCopy", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> DeepCopy(LnkInnerObject record, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			lnkInnerObjectService.DeepCopy(record);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
}
