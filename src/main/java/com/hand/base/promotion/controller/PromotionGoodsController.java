package com.hand.base.promotion.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.goods.service.GoodsPriceService;
import com.hand.base.promotion.model.Promotion;
import com.hand.base.promotion.service.PromotionGoodsService;
import com.hand.base.smscode.dao.mybatis.mapper.SystemConfigMapper;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.util.StringUtils;


@Controller
@RequestMapping("/action/portal/promotionGoods")
public class PromotionGoodsController extends BasicController<Promotion> {

	@Resource
	private KeyGenerateService keyGenerateService;

	@Resource
	private PromotionGoodsService promotionGoodsService;

	@Resource
	private GoodsPriceService goodsPriceService;
	
	@Autowired
	private SystemConfigMapper configMapper;

	/**
	 * 品牌馆插入前做操作
	 */
	public void beforBrandInsert( Promotion promotion, HttpServletRequest request) throws Exception{

		BigDecimal lmtAmt = promotion.getLmtAmt();//单人限赠数量
		BigDecimal promotionPrice = promotion.getPromotionPrice();//活动价
		BigDecimal totalQty = promotion.getTotalQty();/* 限购总量/赠送总量 */
		String brandDiscountType = promotion.getBrandDiscountType();//活动类型	
		
		
		String bpDcInfo = configMapper.getByCode("Brand_BP_DC_Limit_Buy_Info");//特价、打折限购信息文字
		
		String bofoInfo = configMapper.getByCode("Brand_BOFO_Limit_Buy_Info");//买赠限购信息文字

		if(StringUtils.equals(brandDiscountType, "Bargain_Price")){
			String info = String.format(bpDcInfo, lmtAmt, promotionPrice,totalQty);
			promotion.setLmtBInfo(info);
		}
		if(StringUtils.equals(brandDiscountType , "Discount")){
			String info2 = String.format(bpDcInfo, lmtAmt, promotionPrice,totalQty);
			promotion.setLmtBInfo(info2);
			
		}
		if(StringUtils.equals(brandDiscountType ,"BOFO")){
			promotion.setLmtBInfo(String.format(bofoInfo,totalQty,lmtAmt));
		}

	}
	@Override
	public BasicService<Promotion> getBasicService() throws Exception {
			return promotionGoodsService;
	}
	
	@RequestMapping("/brandQueryCombinationPromotion")
	@ResponseBody
	public Map<String, Object> brandQueryCombinationPromotion(QueryParams qps, Promotion promotion,HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			qps.preDealSecurity(request);
			Promotion t = (Promotion) BasicModel.transformClass(promotion, qps);
			beforQueryAllOrExample(t, request);
			beforQueryExample(t, request);
			List<Promotion> list = promotionGoodsService.brandQueryCombinationPromotion(t);
			result.put("success", true);
			result.put("rows", list);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount((BasicModel) t, list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Promotion>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	@RequestMapping("/querySeckillManPage")
	@ResponseBody
	public Map<String, Object> querySeckillManPage(QueryParams qps, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			qps.preDealSecurity(request);
			Promotion t = (Promotion) BasicModel.transformClass(Promotion.class, qps);
			beforQueryAllOrExample(t, request);
			beforQueryExample(t, request);
			List<Promotion> list = promotionGoodsService.querySeckillManPage(t);
			result.put("success", true);
			result.put("rows", list);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount((BasicModel) t, list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Promotion>());
			result.put("result", e.getMessage());
		}
		return result;
	}

	/**
	 * 商品级的活动一个商品只能有一个活动
	 * 
	 */
	public void beforUpsert(Promotion entity, HttpServletRequest request) throws Exception {
		// 不是删除按钮控制的跟新才进行判断
		if( !"delete".equals(entity.getAttr1()) ){
			int merchNum;
			if (entity.getMerchStartTime() != null && !"".equals(entity.getMerchStartTime())
					&& entity.getMerchEndTime() != null && !"".equals(entity.getMerchEndTime())) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date startTime = sdf.parse(entity.getStartTime());
				Date endTime = sdf.parse(entity.getEndTime());
				Date merchStartTime = sdf.parse(entity.getMerchStartTime());
				Date merchEndTime = sdf.parse(entity.getMerchEndTime());
				if (!(merchStartTime.getTime() < merchEndTime.getTime() && merchStartTime.getTime() >= startTime.getTime()
						&& merchEndTime.getTime() <= endTime.getTime())) {
					throw new BasicControllerException("商品活动时间不在促销活动时间之内!");
				}
			}
	
			if (entity.getBuyMerchName() != null && !"".equals(entity.getBuyMerchName())) {
				merchNum = promotionGoodsService.queryByMerchCode(entity);
				if (merchNum != 0) {
					throw new BasicControllerException("一个商品只能有一个促销活动");
				}
			}
			if ("groupActivity".equals(entity.getAttr1())) {
				BigDecimal a = new BigDecimal(2);
				if (a.compareTo(entity.getGroupsNumber()) == 1) {
					throw new BasicControllerException("拼团人数必须大于1");
				}
			}
			if (!"".equals(entity.getPromotionPrice()) && entity.getPromotionPrice() != null
					&& !"".equals(entity.getTotalPrice()) && entity.getTotalPrice() != null) {
				double a = entity.getPromotionPrice().doubleValue();
				double b = entity.getTotalPrice().doubleValue();
				if (a >= b) {
					throw new BasicControllerException("促销价应低于商品原价");
				}
			}
		}
	}

	@Override
	public void beforBrandUpdate(Promotion entity, HttpServletRequest request) throws Exception {
		// 不是删除按钮控制的跟新才进行判断
		if( !"delete".equals(entity.getAttr1()) ){
			if(("Bargain_Price".equals(entity.getBrandDiscountType()) || "Discount".equals(entity.getBrandDiscountType()) 
					|| "BOFO".equals(entity.getBrandDiscountType())) && "Active".equals(entity.getStatus()) ){
				int count = promotionGoodsService.brandQueryByMerchId(entity);
				if( count != 0 ){
					throw new BasicControllerException("每件单品同一时间只可参与一个单品优惠活动");
				}
			}
		}
	}
}
