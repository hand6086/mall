package com.hand.base.promotion.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.o2oaccnt.service.AreaManagerService;
import com.hand.base.platformfavorable.model.Platformfavorable;
import com.hand.base.platformfavorable.service.PlatformfavorableService;
import com.hand.base.promotion.model.Promotion;
import com.hand.base.promotion.model.SalesPromotionSchema;
import com.hand.base.promotion.service.PromotionGoodsService;
import com.hand.base.promotion.service.PromotionService;
import com.hand.base.promotion.service.SalesPromotionSchemaService;
import com.hand.base.user.model.User;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.util.StringUtils;
import com.hand.core.util.UserUtil;

@Controller("PromotionController")
@RequestMapping("/action/portal/promotion")
public class PromotionController extends BasicController<Promotion> {
	
	private static final Logger logger = LogManager.getLogger(PromotionController.class);

	@Resource
	private KeyGenerateService keyGenerateService;

	@Resource
	private PromotionService promotionService;
	
	@Resource
	private SalesPromotionSchemaService salesPromotionSchemaService;

	@Override
	public BasicService<Promotion> getBasicService() throws Exception {
		return promotionService;
	}
	
	@Resource
	private PromotionGoodsService promotionGoodsService;
	
	@Resource
	private PlatformfavorableService platformfavorableService;

	@Resource
	private AreaManagerService areaManagerService;

	@RequestMapping(value = "/newInit")
	public String newInit( HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		return "brandShop/brandSingleProductCampaignNew";
	}
	
	/**
	 * 更新一条记录
	 */
	@RequestMapping(value = "/updateHead")
	@ResponseBody
	public Map<String, Object> updateHead(Promotion entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		User user = UserUtil.getUser(session);
		try{
			
			if(StringUtils.isNull(entity.getSchemaId())){
				throw new BasicControllerException("该活动没有关联方案！");
			}
			// 根据方案时间查询方案
			Promotion schemaPromotion = promotionService.querySchemaTimeBySchemaId(entity.getSchemaId());
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			// 这里使用Promotion已有的merchStartTime等字段,代表活动头即方案的时间
			//方案时间
			Date merchStartTime = sdf.parse(schemaPromotion.getMerchStartTime());
			Date merchEndTime = sdf.parse(schemaPromotion.getMerchEndTime());
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
			
			promotionService.updateHead(entity);
			Promotion newEntry = getBasicService().queryById(entity);
			auditTrailInsert(entity,request,session,"U");    //审计追踪新建记录
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
	 * 根据方案id查询活动记录
	 */
	@RequestMapping(value = "/brandQueryBySchemaId")
	@ResponseBody
	public Map<String, Object> brandQueryBySchemaId(Promotion entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		//User user = UserUtil.getUser(session);
		try{
			Promotion record = promotionService.brandQueryBySchemaId(entity);
			//报名新建活动时 活动不能为空
			if (record == null &&entity.getActivityName() != null ) {
				//新建促销活动
				//entity.setUsercorpid(user.getUsercorpid());
				Promotion storeInfo = promotionService.queryStoreInfoByCode(entity);
				//获取当前登录人的店铺Id
				entity.setStoreId(storeInfo.getStoreId());
				//设置活动名为方案名
				//entity.setActivityName(storeInfo.getStoreName() + "-" + entity.getActivityName());
				entity.setActivityName(entity.getActivityName());
				promotionService.brandInsert(entity);
				record = promotionService.brandQueryBySchemaId(entity);
			}
			List<Promotion> list = new ArrayList<Promotion>();
			list.add(record);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("result", record);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 查询活动方案已选择大区 picklist
	 * 
	 * @return
	 */
	@RequestMapping(value = "/queryCityPage")
	@ResponseBody
	public Map<String, Object> queryCityPage(QueryParams qps, Promotion promotion, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			promotion = (Promotion) BasicModel.transformClass(Promotion.class, qps);
			// 获取活动行 大区 初始化请求 参数lineId,并赋给对象
			promotion.setSchemaId(request.getParameter("schemaId"));
			List<Promotion> list = promotionService.queryCityPage(promotion);
			result.put("success", true);
			result.put("rows", list);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount(promotion, list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Promotion>());
			result.put("result", e.getMessage());
		}
		return result;
	}

	/**
	 * 查询活动行 促销类型(活动方案)
	 * 
	 * @return
	 */
	@RequestMapping(value = "/queryType")
	@ResponseBody
	public List<Promotion> queryType(QueryParams qps, Promotion entity, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		List<Promotion> list = null;
		try {
			list = promotionService.queryType(entity);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	/**
	 * 提交活动
	 */
	@RequestMapping(value = "/submit")
	@ResponseBody
	public Map<String, Object> submit(Promotion entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			checkData(entity, request);
			if(!checkExistDataCache("base", session, entity)){
				throw new BasicServiceException("您操作太快了，请点击下方刷新按钮后再修改记录！");
			}
			if("Platform Promotion".equals(entity.getType())){
				Platformfavorable platformfavorable = new Platformfavorable();
				platformfavorable.setId(entity.getId());
				platformfavorable = platformfavorableService.queryActivityPageById(platformfavorable);
				if( 	"".equals(platformfavorable.getActivityName())  || platformfavorable.getActivityName() == null
						|| "".equals(platformfavorable.getMinOrdAmount()) || platformfavorable.getMinOrdAmount() == null
						|| "".equals(platformfavorable.getPmoType()) || platformfavorable.getPmoType() == null
						|| "".equals(platformfavorable.getStartTime()) || platformfavorable.getStartTime() == null
						|| "".equals(platformfavorable.getEndTime()) || platformfavorable.getEndTime() == null){
					throw new BasicControllerException("请完成活动信息后再提交!");
				}
			}else{
				Promotion promotion = new Promotion();
				promotion.setAttr1("submit");
				promotion.setHeadId(entity.getId());
				promotion.setPageFlag(false);
				List<Promotion> promotionGoodsList=promotionGoodsService.queryByExamplePage(promotion);
				if(promotionGoodsList.size() == 0){
					throw new BasicControllerException("请完善活动商品后提交!");
				}
				
				if("Limited Purchase".equals(entity.getType())){
					for(int i = 0 ; i < promotionGoodsList.size() ; i++ ){
						if(		"".equals(promotionGoodsList.get(i).getBuyMerchId())  || promotionGoodsList.get(i).getBuyMerchId() == null
								|| "".equals(promotionGoodsList.get(i).getPromotionPrice()) || promotionGoodsList.get(i).getPromotionPrice() == null
								|| "".equals(promotionGoodsList.get(i).getTotalQty()) || promotionGoodsList.get(i).getTotalQty() == null
								|| "".equals(promotionGoodsList.get(i).getLmtAmt()) || promotionGoodsList.get(i).getLmtAmt() == null
								|| "".equals(promotionGoodsList.get(i).getStatus()) || promotionGoodsList.get(i).getStatus() == null){
							throw new BasicControllerException("请完善活动商品后提交!");
						}
					}
				}
				
				if("Second Kill".equals(entity.getType())){
					for(int i = 0 ; i < promotionGoodsList.size() ; i++ ){
						if(		"".equals(promotionGoodsList.get(i).getBuyMerchId())  || promotionGoodsList.get(i).getBuyMerchId() == null
								|| "".equals(promotionGoodsList.get(i).getPromotionPrice()) || promotionGoodsList.get(i).getPromotionPrice() == null
								|| "".equals(promotionGoodsList.get(i).getSuccessRate()) || promotionGoodsList.get(i).getSuccessRate() == null
								|| "".equals(promotionGoodsList.get(i).getTotalQty()) || promotionGoodsList.get(i).getTotalQty() == null
								|| "".equals(promotionGoodsList.get(i).getLmtAmt()) || promotionGoodsList.get(i).getLmtAmt() == null
								|| "".equals(promotionGoodsList.get(i).getStatus()) || promotionGoodsList.get(i).getStatus() == null){
							throw new BasicControllerException("请完善活动商品后提交!");
						}
					}
				}
				
				if("FightGroup".equals(entity.getType())){
					for(int i = 0 ; i < promotionGoodsList.size() ; i++ ){
						if(		"".equals(promotionGoodsList.get(i).getBuyMerchId())  || promotionGoodsList.get(i).getBuyMerchId() == null
								|| "".equals(promotionGoodsList.get(i).getPromotionPrice()) || promotionGoodsList.get(i).getPromotionPrice() == null
								|| "".equals(promotionGoodsList.get(i).getGroupsNumber()) || promotionGoodsList.get(i).getGroupsNumber() == null
								|| "".equals(promotionGoodsList.get(i).getTotalQty()) || promotionGoodsList.get(i).getTotalQty() == null
								|| "".equals(promotionGoodsList.get(i).getStatus()) || promotionGoodsList.get(i).getStatus() == null){
							throw new BasicControllerException("请完善活动商品后提交!");
						}
					}
				}
				
				if("Combination".equals(entity.getType())){
					for(int i = 0 ; i < promotionGoodsList.size() ; i++ ){
						if(		"".equals(promotionGoodsList.get(i).getBuyMerchId())  || promotionGoodsList.get(i).getBuyMerchId() == null
								|| "".equals(promotionGoodsList.get(i).getPromotionPrice()) || promotionGoodsList.get(i).getPromotionPrice() == null
								|| "".equals(promotionGoodsList.get(i).getLmtAmt()) || promotionGoodsList.get(i).getLmtAmt() == null
								|| "".equals(promotionGoodsList.get(i).getTotalQty()) || promotionGoodsList.get(i).getTotalQty() == null
								|| "".equals(promotionGoodsList.get(i).getStatus()) || promotionGoodsList.get(i).getStatus() == null){
							throw new BasicControllerException("请完善活动商品后提交!");
						}
					}
				}
				
				if("Free Buy".equals(entity.getType())){
					for(int i = 0 ; i < promotionGoodsList.size() ; i++ ){
						if(		"".equals(promotionGoodsList.get(i).getBuyMerchId())  || promotionGoodsList.get(i).getBuyMerchId() == null
								|| "".equals(promotionGoodsList.get(i).getBuyAmt()) || promotionGoodsList.get(i).getBuyAmt() == null
								|| "".equals(promotionGoodsList.get(i).getFreeMerchId()) || promotionGoodsList.get(i).getFreeMerchId() == null
								|| "".equals(promotionGoodsList.get(i).getTotalQty()) || promotionGoodsList.get(i).getTotalQty() == null
								|| "".equals(promotionGoodsList.get(i).getFreeAmt()) || promotionGoodsList.get(i).getFreeAmt() == null
								|| "".equals(promotionGoodsList.get(i).getLmtAmt()) || promotionGoodsList.get(i).getLmtAmt() == null
								|| "".equals(promotionGoodsList.get(i).getStatus()) || promotionGoodsList.get(i).getStatus() == null){
							throw new BasicControllerException("请完善活动商品后提交!");
						}
					}
				}
			}
			
			promotionService.update(entity);	

			Promotion newEntry = promotionService.queryById(entity);
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
	 * 提交活动
	 */
	@RequestMapping(value = "/cancel")
	@ResponseBody
	public Map<String, Object> cancel(Promotion entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			checkData(entity, request);
			if(!checkExistDataCache("base", session, entity)){
				throw new BasicServiceException("您操作太快了，请点击下方刷新按钮后再修改记录！");
			}
			if(!"Pending".equals(promotionService.queryById(entity).getApprovalStatus())){
				throw new BasicServiceException("此条记录已被其他登录人员修改，请刷新后操作!");
			}
			
			promotionService.update(entity);	

			Promotion newEntry = promotionService.queryById(entity);
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
	 * 品牌馆 提交活动
	 */
	@RequestMapping(value = "/brandSubmit")
	@ResponseBody
	public Map<String, Object> brandSubmit(Promotion entity, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			checkData(entity, request);
			if (!checkExistDataCache("base", session, entity)) {
				throw new BasicServiceException("非法更新数据！");
			}
			
			if("Pending".equals(entity.getApprovalStatus())){
				SalesPromotionSchema salesPromotionSchema  = new SalesPromotionSchema();
				salesPromotionSchema.setId(entity.getSchemaId());
				salesPromotionSchema = salesPromotionSchemaService.brandQueryById(salesPromotionSchema);
				Date now = new Date();
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				if(now.after(format.parse(salesPromotionSchema.getTattr14()))
						|| now.before(format.parse(salesPromotionSchema.getTattr13()))){
					throw new BasicControllerException("抱歉，活动的报名时间已截止，提交失败!");
				}
				
				Promotion promotion = new Promotion();
				promotion.setHeadId(entity.getId());
				promotion.setPageFlag(false);
				List<Promotion> promotionGoodsList = promotionGoodsService.brandQueryByExamplePage(promotion);
				
				if (promotionGoodsList.size() == 0) {
					throw new BasicControllerException("请完善活动商品后提交!");
				}else{
					List<String> buyMerchId1 = new ArrayList<String>();
					for(Promotion promotionGoods : promotionGoodsList){
						buyMerchId1.add(promotionGoods.getBuyMerchId());
					}
					
					if(buyMerchId1.size() != new HashSet<Object>(buyMerchId1).size()){
						throw new BasicControllerException("您提交的商品中包含重复商品，提交失败!");
					}
					
					promotion.setHeadId("");
					promotion.setAttr1("submitGoods");
					promotion.setAttr2(entity.getId());
					promotion.setUsersystemRole("super_administrator");
					promotion.setStartTime(salesPromotionSchema.getStartDate());
					promotion.setEndTime(salesPromotionSchema.getEndDate());
					List<Promotion> submitGoodsList = promotionGoodsService.brandQueryByExamplePage(promotion);
					
					List<String> buyMerchId2 = new ArrayList<String>();
					for(Promotion promotionGoods : submitGoodsList){
						buyMerchId2.add(promotionGoods.getBuyMerchId());
					}
					
					if(!Collections.disjoint(buyMerchId1,buyMerchId2)){
						throw new BasicControllerException("每件单品同一时间只可参与一个促销活动!");
					}
				}
			}
			
			
			promotionService.brandUpdate(entity);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}

	/**
	 * 在更新或者插入的时候比较开始时间不能大于结束时间，
	 */
	@Transactional
	public void beforUpsert(Promotion entity, HttpServletRequest request) throws Exception {
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
					/*List<Promotion> promotionlist = promotionService.querygoods(entity);
					if(promotionlist.size() >0){
						
						Promotion promotion = new Promotion();
						if("FightGroup".equals(entity.getType()) || "Second Kill".equals(entity.getType())){
							promotion.setMerchStartTime(entity.getStartTime());
							promotion.setMerchEndTime(entity.getEndTime());
						}
						promotion.setHeadId(entity.getId());
						promotion.setStatus("Inactive");
						
						promotion.setCostProportionD("0");
						promotion.setCostMaxProportionD("9999");
						promotion.setCostMinProportionD("0");
						promotion.setCostProportionW("0");
						promotion.setCostMaxProportionW("9999");
						promotion.setCostMinProportionW("0");
						promotion.setCostProportionR("0");
						promotion.setCostMaxProportionR("9999");
						promotion.setCostMinProportionR("0");
						promotion.setPurchasedQty("0");
						
						for(int i = 0; i<promotionlist.size(); i++){
							promotion.setBuyMerchId(promotionlist.get(i).getBuyMerchId());
							promotionlist.set(i, promotion);
							promotion.setId(keyGenerateService.keyGenerate());
							promotionGoodsService.insert(promotion);
						}
					}*/
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
	public Map<String, Object> batchUpdateStatus(Promotion promotion, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			beforUpdate(promotion, request);
			checkData(promotion, request);
			if (!checkExistDataCache("base", session, promotion)) {
				throw new BasicServiceException("非法更新数据！");
			}
			promotionService.batchUpdateStatus(promotion);
			auditTrailInsert(promotion, request, session, "U"); // 审计追踪新建记录
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	/**
	 * 品牌馆 组合套餐的插入(一个活动，多个商品就有多个行结构)
	 */
	@RequestMapping(value = "/brandInsertCampaign")
	@ResponseBody
	public Map<String, Object> brandInsertCampaign(Promotion promotion, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			checkData(promotion, request);
			// 新建组合套餐活动
			promotionService.brandInsert(promotion);
			// 为活动行获取活动Id
			promotion.setHeadId(promotion.getId());
			
			BigDecimal[] buyAmts = promotion.getBuyAmts();
			String[] buyMerchIds = promotion.getBuyMerchIds();
			BigDecimal[] pmoPrices = promotion.getPmoPrices();
			// 获取商品购买数量、平摊价、商品Id
			BigDecimal tempTotalpmoPrice = new BigDecimal(0);
			for( int i = buyAmts.length - 1 ; i >= 0; i-- ){
				BigDecimal buyAmt = buyAmts[i];
				BigDecimal pmoPrice = pmoPrices[i];
				String buyMerchId = buyMerchIds[i];
				promotion.setBuyAmt(buyAmt);
				promotion.setBuyMerchId(buyMerchId);
				
				// 最后一个组合商品，用套餐价格减去 前面所有的套餐组合商品的折合价格
				logger.info("主商品用套餐价格减去 前面所有的套餐组合商品的折合价格");
				promotion.setPromotionPrice(pmoPrice);
				if(0 != i){
					tempTotalpmoPrice = tempTotalpmoPrice.add(pmoPrice);
					promotion.setPromotionPrice(pmoPrice);
				}else{
					promotion.setPromotionPrice(promotion.getMinOrdAmount().subtract(tempTotalpmoPrice));
				}
				logger.info("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
				logger.info("promotion.getMinOrdAmount() is " + promotion.getMinOrdAmount());
				logger.info("pmoPrice is " + pmoPrice);
				logger.info("tempTotalpmoPrice is " + tempTotalpmoPrice);
				promotion.setId(keyGenerateService.keyGenerate());
				if( i == 0 ){
					promotion.setIsHomeProd("Y");
				} else{
					promotion.setIsHomeProd("N");
				}
				promotionGoodsService.brandInsert(promotion);
			}
			auditTrailInsert(promotion, request, session, "N"); // 审计追踪新建记录
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	/**
	 * 删除方案时级联更新活动头、活动行表
	 * @param promotion
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/updateStatusBySchemaId")
	@ResponseBody
	public Map<String, Object> updateStatusBySchemaId(Promotion promotion, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			promotionService.updateStatusBySchemaId(promotion);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 品牌馆插入更新之前操作
	 */
	@Override
	public void beforBrandUpsert(Promotion entity, HttpServletRequest request) throws Exception {
		if( !"delete".equals(entity.getAttr1()) ){
			if("brandPromotionSchema".equals(entity.getAttr1())){
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
			
			// 获取当前新建活动类型
			String brandDiscountType = entity.getBrandDiscountType();
			// 只有店铺优惠(满赠商品，满减现金，满赠优惠券)才进行判断
			if("Cash Deduction".equals(brandDiscountType) || "Reward for gifts".equals(brandDiscountType) 
					|| "Dispatch Coupon".equals(brandDiscountType)){
				int count = promotionService.brandQueryShopPromotionCount(entity);
				if( count != 0 ){
					throw new BasicControllerException("检查到已有其他的店铺活动和此活动时间交叉，若需要发布新的店铺活动，需要将同时段的店铺活动删除");
				}
				
			}
		}
	}
}
