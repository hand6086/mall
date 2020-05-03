package com.hand.base.o2oaddress.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.o2oaddress.model.O2OAddress;
import com.hand.base.o2oaddress.service.O2OAddressService;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.basic.query.Sorter;
@Controller
@RequestMapping("/action/portal/o2oaddress")
public class O2OAddressController extends BasicController<O2OAddress>{
	private static final Logger logger = LogManager.getLogger(O2OAddressController.class);
	@Resource
	private O2OAddressService o2oAddressService;
	
	@Override
	public BasicService<O2OAddress> getBasicService() throws Exception{
		return o2oAddressService;
	}
	
	@RequestMapping(value = "/provinceList")
	@ResponseBody
	public List<O2OAddress> provinceList(QueryParams qps, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		List<O2OAddress> list = null;
		O2OAddress record = new O2OAddress();
		record.setAreaType("Province");
		try{
			list = o2oAddressService.queryByExample(record);
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	
	@RequestMapping(value = "/cityList")
	@ResponseBody
	public List<O2OAddress> cityList(String parentAreaName, QueryParams qps, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		List<O2OAddress> list = null;
		//parentAreaName="北京市";
		O2OAddress record = new O2OAddress();
		try{
			Sorter sorter = new Sorter("areaName",Sorter.DIR_ASC);
			qps.addSorter(sorter);
			if(parentAreaName == null || "".equals(parentAreaName)){
				parentAreaName = "noMatchId";
			}
			record.setAreaType("city");
			record.setParentAreaName(parentAreaName);
			list = o2oAddressService.queryByExample(record);
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	
	@RequestMapping(value = "/districtList")
	@ResponseBody
	public List<O2OAddress> districtList(String parentAreaName,String parentAreaName2, String areaType, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		logger.debug("加载地址信息...");
		List<O2OAddress> list = null;
		try{
			QueryParams qps = new QueryParams();
			Sorter sorter = new Sorter("areaName",Sorter.DIR_ASC);
			qps.addSorter(sorter);
			if(parentAreaName == null || "".equals(parentAreaName)){
				parentAreaName = "noMatchId";
			}
			O2OAddress o2oaddress = new O2OAddress();
			o2oaddress.setParentAreaName(parentAreaName);
			o2oaddress.setParentAreaName2(parentAreaName2);
			o2oaddress.setAreaType(areaType);
			list = o2oAddressService.queryByExample(o2oaddress);
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
}
