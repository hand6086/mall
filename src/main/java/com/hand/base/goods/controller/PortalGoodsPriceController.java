package com.hand.base.goods.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.goods.model.GoodsPrice;
import com.hand.base.goods.service.GoodsPriceService;
import com.hand.core.basic.query.QueryParams;

@Controller
@RequestMapping("/action/portal/goodsPrice")
public class PortalGoodsPriceController extends BasicController<GoodsPrice> {
	@Autowired
	private GoodsPriceService goodsPriceService;
    
	@Override
	public BasicService<GoodsPrice> getBasicService() throws Exception {
		return goodsPriceService;
	}
	
	/**
	 * 插入或更新前做操作
	 */
	public void beforUpsert(GoodsPrice entity, HttpServletRequest request) throws Exception{
		if(("goodsPrice").equals(entity.getAttr1())){
			if(("N").equals(entity.getIsRetailMerchandise()) && (("").equals(entity.getRetailPrice()) || entity.getRetailPrice() == null)){
				if(("N").equals(entity.getIsGpMerchandise()) && (("").equals(entity.getGroupPurchasePrice()) ||entity.getGroupPurchasePrice() == null)){
					throw new BasicControllerException("请在是否零售和是否团购中任选一种");
				}
			}
		 	if(("Y").equals(entity.getIsRetailMerchandise()) && (("").equals(entity.getRetailPrice()) || entity.getRetailPrice() == null)){
		 		throw new BasicControllerException("请选择零售价格");
			}
		 	
		 	if(("Y").equals(entity.getIsDrinkNow()) && (("").equals(entity.getFreightName()) || entity.getFreightName() == null)){
		 		throw new BasicControllerException("请选择配送费模板");
			}
			
			if(("Y").equals(entity.getIsGpMerchandise()) && (("").equals(entity.getGroupPurchasePrice()) ||entity.getGroupPurchasePrice() == null)){
				throw new BasicControllerException("请选择团购价格");
			}
			if(0 < goodsPriceService.countByCityIdAndName(entity) ){
				throw new BasicControllerException("同一个城市下面不能维护相同的商品");
			}
			if("".equals(entity.getFreightName()) || entity.getFreightName() == null){
				entity.setFreightId("");
			}
		}
	}
	
	/**
	 * 新建一条记录
	 */
	@RequestMapping(value = "/insert")
	@ResponseBody
	@Transactional
	public Map<String, Object> insert(GoodsPrice entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			
			goodsPriceService.insert(entity);		
			auditTrailInsert(entity,request,session,"N");    //审计追踪新建记录
			GoodsPrice newEntry = goodsPriceService.queryById(entity);
			
			if(entity.getAttr5() != null && !entity.getAttr5().equals("")){
				entity.setPicArray(entity.getAttr5().split(","));
				goodsPriceService.insertPic(entity);
			}
			
			result.put("newRow", newEntry);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/queryMerchandisePage")
	@ResponseBody
	public Map<String, Object> queryMerchandisePage(QueryParams qps,GoodsPrice entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			if(!"free".equals(entity.getAttr1()) && !"price".equals(entity.getAttr1())){
				qps.preDealSecurity(request);
			}else{
				qps.setOauth("");
			}
			GoodsPrice t = (GoodsPrice)BasicModel.transformClass(entity, qps);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			List<GoodsPrice> list = goodsPriceService.queryMerchandisePage(t);
			result.put("success", true);
			result.put("rows", list);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<GoodsPrice>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/brandQueryMerchandisePage")
	@ResponseBody
	public Map<String, Object> brandQueryMerchandisePage(QueryParams qps,GoodsPrice entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			GoodsPrice t = (GoodsPrice)BasicModel.transformClass(entity, qps);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			List<GoodsPrice> list = goodsPriceService.brandQueryMerchandisePage(t);
			result.put("success", true);
			result.put("rows", list);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<GoodsPrice>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/queryAccountPage")
	@ResponseBody
	public Map<String, Object> queryAccountPage(QueryParams qps,GoodsPrice entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			GoodsPrice t = (GoodsPrice)BasicModel.transformClass(entity, qps);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			List<GoodsPrice> list = goodsPriceService.queryAccountPage(t);
			result.put("success", true);
			result.put("rows", list);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<GoodsPrice>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 查询详情页面
	 */
	@RequestMapping(value = "/queryByDetailId")
	@ResponseBody
	public Map<String, Object> queryByDetailId(GoodsPrice entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			GoodsPrice record = goodsPriceService.queryById(entity);
			List<GoodsPrice> poster = goodsPriceService.queryPosterPicAll(entity);
			result.put("result", record);
			result.put("poster", poster);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
}
