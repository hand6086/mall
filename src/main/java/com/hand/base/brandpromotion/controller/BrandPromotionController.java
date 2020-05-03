package com.hand.base.brandpromotion.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.brandpromotion.model.BrandPromotion;
import com.hand.base.brandpromotion.service.BrandPromotionService;
import com.hand.base.o2oaccnt.service.AreaManagerService;
import com.hand.base.platformfavorable.model.Platformfavorable;
import com.hand.base.platformfavorable.service.PlatformfavorableService;
import com.hand.base.promotion.model.Promotion;
import com.hand.base.promotion.service.PromotionGoodsService;
import com.hand.core.basic.query.QueryParams;

@Controller
@RequestMapping("/action/portal/brandPromotion")
public class BrandPromotionController extends BasicController<BrandPromotion> {

	@Resource
	private KeyGenerateService keyGenerateService;

	@Resource
	private BrandPromotionService brandPromotionService;

	@Override
	public BasicService<BrandPromotion> getBasicService() throws Exception {
		return brandPromotionService;
	}
	
	@Resource
	private PromotionGoodsService promotionGoodsService;
	
	@Resource
	private PlatformfavorableService platformfavorableService;

	@Resource
	private AreaManagerService areaManagerService;


	/**
	 * 查询活动行 促销类型(活动方案)
	 * 
	 * @return
	 */
	@RequestMapping(value = "/queryType")
	@ResponseBody
	public List<BrandPromotion> queryType(QueryParams qps, BrandPromotion entity, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		List<BrandPromotion> list = null;
		try {
			list = brandPromotionService.queryType(entity);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * 在更新或者插入的时候比较开始时间不能大于结束时间，
	 */
	@Transactional
	public void beforUpsert(BrandPromotion entity, HttpServletRequest request) throws Exception {
		if(!"salesPromotionSchemaApproval".equals(entity.getAttr1())){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			// 这里使用Promotion已有的merchStartTime等字段,代表活动头即方案的时间
			//方案时间
			Date merchStartTime = sdf.parse(entity.getMerchStartTime());
			Date merchEndTime = sdf.parse(entity.getMerchEndTime());
			//活动时间
			Date startTime = sdf.parse(entity.getStartTime());
			Date endTime = sdf.parse(entity.getEndTime());
			if (startTime != null && !"".equals(startTime) && endTime != null && !"".equals(endTime)
					&& merchStartTime != null && !"".equals(merchStartTime) && merchEndTime != null
					&& !"".equals(merchEndTime)) {
				if (!(endTime.getTime()>startTime.getTime() && startTime.getTime()>=merchStartTime.getTime() 
						&& merchEndTime.getTime()>=endTime.getTime())) {
					throw new BasicControllerException("活动开始时间不能晚于结束时间,并需要在方案时间之间");
				}
			} else {
				throw new BasicControllerException("方案时间及活动时间都不能为空");
			}
		}
		
		if("salesPromotionSchema".equals(entity.getAttr1())){
			if(!"Platform Promotion".equals(entity.getType())){
				if("NEW".equals(entity.getRow_status()) && !"Coupon".equals(entity.getType())){
					if("Combination".equals(entity.getType())){
						entity.setAttr1("Combination");
					}
				}
			}else{
				entity.setCostProportionD("0");
				entity.setCostMaxProportionD("9999");
				entity.setCostMinProportionD("0");
				entity.setCostProportionW("0");
				entity.setCostMaxProportionW("9999");
				entity.setCostMinProportionW("0");
				entity.setCostProportionR("0");
				entity.setCostMaxProportionR("9999");
				entity.setCostMinProportionR("0");
			}
		}
		
		// 平台优惠，不允许在同一个城市，同时间段内出现两个有效的。
		if("Platform Promotion".equals(entity.getType())){
			int activityNum;
			Platformfavorable platformfavorable = new Platformfavorable();
			platformfavorable.setId(entity.getId());
			platformfavorable.setCityId(entity.getCityId());
			platformfavorable.setStartTime(entity.getStartTime());
			platformfavorable.setEndTime(entity.getEndTime());
			//平台优惠，同一个城市，某个时间段的活动数量
			activityNum = platformfavorableService.queryActivityCount(platformfavorable);
			if (activityNum != 0) {
				throw new BasicControllerException("同一个城市,同时间段内只能有一个有效的促销活动");
			}
		}
	}
	
	/**
	 * 更新一条记录
	 */
	@RequestMapping(value = "/batchUpdateStatus")
	@ResponseBody
	public Map<String, Object> batchUpdateStatus(BrandPromotion promotion, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			beforUpdate(promotion, request);
			checkData(promotion, request);
			if (!checkExistDataCache("base", session, promotion)) {
				throw new BasicServiceException("非法更新数据！");
			}
			brandPromotionService.batchUpdateStatus(promotion);
			auditTrailInsert(promotion, request, session, "U"); // 审计追踪新建记录
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
}
