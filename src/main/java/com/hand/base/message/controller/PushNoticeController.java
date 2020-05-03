package com.hand.base.message.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.message.model.PushNotice;
import com.hand.base.message.service.PushNoticeService;
import com.hand.base.user.model.User;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.util.UserUtil;

@Controller
@RequestMapping("/action/portal/pushNotice")
public class PushNoticeController extends BasicController<PushNotice>{

	@Autowired
	private PushNoticeService pushNoticeService;
	
	public BasicService<PushNotice> getBasicService() throws Exception{
		if(pushNoticeService != null){
			return pushNoticeService;
		}
		throw new BasicControllerException("获取Basic Service 失败，请确认程序代码是否正确！");
	}
	
	public void beforQueryAllOrExample(PushNotice entity, HttpServletRequest request) throws Exception{
		User user = UserUtil.getUser(null);
		if(entity.getUserId() == null || "".equals(entity.getUserId())){
			String conditionSql = entity.getConditionSql();
			if(conditionSql == null){
				conditionSql = "";
			}
			entity.setConditionSql(conditionSql+" and userId="+"'"+user.getId()+"'");
		}
	}

	/**
	 * 
	 *<p>更新通知为已读</p>
	 * @author yrf
	 * @param pushNotice
	 * @return
	 */
	@RequestMapping("/read")
	@ResponseBody
	public Map<String, Object> updateRead(PushNotice pushNotice){
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			pushNoticeService.updateRead(pushNotice);
			result.put("success", true);
		}catch(Exception e){
			result.put("success", false);
			result.put("result", e.getLocalizedMessage());
		}
		return result;
	}
	
	/**
	 * 
	 *<p>更新所有通知为已读</p>
	 * @author yrf
	 * @param pushNotice
	 * @return
	 */
	@RequestMapping("/readAll")
	@ResponseBody
	public Map<String, Object> updateReadAll(PushNotice pushNotice){
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			pushNoticeService.updateReadAll(pushNotice);
			result.put("success", true);
		}catch(Exception e){
			result.put("success", false);
			result.put("result", e.getLocalizedMessage());
		}
		return result;
	}
	
	/**
	 * 根据条件查询待办事项记录,默认分页(若将'pageFlag'设置为'false'，则不分页)
	 */
	@RequestMapping(value = "/queryFlowPage")
	@ResponseBody
	public Map<String, Object> queryFlowPage(QueryParams qps, PushNotice entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		User user = UserUtil.getUser(session);
		try{
			qps.preDealSecurity(request);
			PushNotice t = (PushNotice)BasicModel.transformClass(entity, qps);
			List<PushNotice> list = new ArrayList<PushNotice>();
			if("101".equals(user.getUsercorpid())){
				
			}else if("super_administrator".equals(user.getUsersystemRole())){
				list = pushNoticeService.queryFlowByAdminPage(t);
				for(int i = list.size() - 1; i >= 0; i--){
					PushNotice pushNotice = list.get(i);
					if("待审核商品提示".equals(pushNotice.getType())){ //待审核商品提示
						if("您好！您有0个商品等待审核，请及时处理".equals(pushNotice.getPushNote())){
							list.remove(pushNotice);
						}else{
							pushNotice.setAttr1("商品管理");
							pushNotice.setAttr2("品牌馆-商品审核");
							pushNotice.setAttr3("O2O_GOODS_MANAGE");
							pushNotice.setAttr4("/portal/goods/brandGoodsApproveList.jsp");
						}
					}else if("待审核促销活动提示".equals(pushNotice.getType())){	//待审核促销活动提示
						pushNotice.setAttr1("促销管理-品牌馆");
						pushNotice.setAttr2("促销方案");
						pushNotice.setAttr3("BRAND_CAMPAIGN_MANAGEMENT");
						pushNotice.setAttr4("/portal/brandPromotion/brandPromotionSchema.jsp?id="+pushNotice.getId()+"&headId="+pushNotice.getIntegrationId());
					}else if("企业资质审核提示".equals(pushNotice.getType())){	//企业资质审核提示
						pushNotice.setAttr1("商户管理");
						pushNotice.setAttr2("企业管理");
						pushNotice.setAttr3("O2O_MERCHANT_MANAGE");
						pushNotice.setAttr4("/portal/enterprise/enterpriseList.jsp?id="+pushNotice.getId());
					}else {	//企业转账审核提示
						pushNotice.setAttr1("商户管理");
						pushNotice.setAttr2("网店押金管理");
						pushNotice.setAttr3("O2O_MERCHANT_MANAGE");
						pushNotice.setAttr4("/portal/enterprise/storeDepositManage.jsp?id="+pushNotice.getId());
					}
				}
			}else{
				list = pushNoticeService.queryFlowPage(t);
				
				for(int i = list.size() - 1; i >= 0; i--){
					PushNotice pushNotice = list.get(i);
					if("待发货订单提示".equals(pushNotice.getType())){ //待发货订单提示
						if("您好！您有0个订单等待发货，请及时处理".equals(pushNotice.getPushNote())){
							list.remove(pushNotice);
						}else{
							pushNotice.setAttr1("订单管理");
							pushNotice.setAttr2("订单发运");
							pushNotice.setAttr3("O2O_ORDER_MANAGE");
							pushNotice.setAttr4("/portal/brandorder/orderDeliveryList.jsp");
						}
					}else if("待退款订单提示".equals(pushNotice.getType())){	//待退款订单提示
						pushNotice.setAttr1("售后管理");
						pushNotice.setAttr2("待退款订单-品牌馆");
						pushNotice.setAttr3("aftersalemanagement");
						pushNotice.setAttr4("/portal/servicemanagement/withrefundorder.jsp?id="+pushNotice.getId());
					}else{
						pushNotice.setAttr1("服务管理");
						pushNotice.setAttr2("售后服务");
						pushNotice.setAttr3("service_manage");
						pushNotice.setAttr4("/portal/servicemanagement/afterSalesList.jsp?id="+pushNotice.getId());
					}
				}
			}
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<PushNotice>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 根据条件查询系统通知记录,默认分页(若将'pageFlag'设置为'false'，则不分页)
	 */
	@RequestMapping(value = "/queryPushNoticePage")
	@ResponseBody
	public Map<String, Object> queryPushNoticePage(QueryParams qps, PushNotice entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		User user = UserUtil.getUser(session);
		try{
			qps.preDealSecurity(request);
			PushNotice t = (PushNotice)BasicModel.transformClass(entity, qps);
			List<PushNotice> list = new ArrayList<PushNotice>();
			if("101".equals(user.getUsercorpid())){
				
			}else if("super_administrator".equals(user.getUsersystemRole())){
				
			}else{
				list = pushNoticeService.queryPushNoticePage(t);
				for(PushNotice pushNotice:list){
					pushNotice.setPushType("系统通知");
					if("消费者退货提示".equals(pushNotice.getType())){ //售后订单消费者退货提示
						pushNotice.setAttr4("服务管理");
						pushNotice.setAttr5("售后服务");
						pushNotice.setAttr6("service_manage");
						pushNotice.setAttr7("/portal/servicemanagement/afterSalesList.jsp");
						pushNotice.setAttr2(pushNotice.getPushNote());
						pushNotice.setAttr1("");
						pushNotice.setAttr3("");
					}else if("商品通过审核".equals(pushNotice.getType())){ //商品通过审核
						pushNotice.setAttr4("商品管理");
						pushNotice.setAttr5("品牌馆-商品");
						pushNotice.setAttr6("O2O_GOODS_MANAGE");
						pushNotice.setAttr7("/portal/goods/brandGoodsList.jsp");
						pushNotice.setAttr2("您好！您的商品");
						pushNotice.setAttr3("已经通过审核，可以上架啦!");
					}else if("商品未通过审核".equals(pushNotice.getType())){ //商品未通过审核
						pushNotice.setAttr4("商品管理");
						pushNotice.setAttr5("品牌馆-商品");
						pushNotice.setAttr6("O2O_GOODS_MANAGE");
						pushNotice.setAttr7("/portal/goods/brandGoodsList.jsp");
						pushNotice.setAttr2("您好！您的商品");
						pushNotice.setAttr3("未通过审核，请您修改商品信息后再提交审核!");
					}else if("商品强制下架".equals(pushNotice.getType())){ //商品强制下架
						pushNotice.setAttr4("商品管理");
						pushNotice.setAttr5("品牌馆-商品");
						pushNotice.setAttr6("O2O_GOODS_MANAGE");
						pushNotice.setAttr7("/portal/goods/brandGoodsList.jsp");
						pushNotice.setAttr2("抱歉，您的商品");
						pushNotice.setAttr3("已被管理员强制下架，请您尽快修改商品信息!");
					}else if("促销活动通过审核".equals(pushNotice.getType())){ //促销活动通过审核
						pushNotice.setAttr4("促销管理-品牌馆");
						pushNotice.setAttr6("BRAND_CAMPAIGN_MANAGEMENT");
						if("Second Kill".equals(pushNotice.getAttr2())){
							pushNotice.setAttr5("秒杀已报名列表");
							pushNotice.setAttr7("/portal/brandPromotion/brandSeckillCampaignApplyList.jsp");
						}else{
							pushNotice.setAttr5("拼团已报名列表");
							pushNotice.setAttr7("/portal/brandPromotion/brandGroupCampaignApplyList.jsp");
						}
						pushNotice.setAttr2("您好！您报名的促销活动");
						pushNotice.setAttr3("已经通过审核!");
						
					}else{
						pushNotice.setAttr4("促销管理-品牌馆");
						pushNotice.setAttr6("BRAND_CAMPAIGN_MANAGEMENT");
						if("Second Kill".equals(pushNotice.getAttr2())){
							pushNotice.setAttr5("秒杀已报名列表");
							pushNotice.setAttr7("/portal/brandPromotion/brandSeckillCampaignApplyList.jsp");
						}else{
							pushNotice.setAttr5("拼团已报名列表");
							pushNotice.setAttr7("/portal/brandPromotion/brandGroupCampaignApplyList.jsp");
						}
						pushNotice.setAttr2("抱歉，您报名的促销活动");
						pushNotice.setAttr3("审批被拒绝，请您修改促销活动信息后再次提交!");
					}
				}
			}
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<PushNotice>());
			result.put("result", e.getMessage());
		}
		return result;
	}
}
