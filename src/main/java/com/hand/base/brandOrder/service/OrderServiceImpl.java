package com.hand.base.brandOrder.service;

import java.util.List;

import javax.annotation.Resource;

import com.hand.base.smscode.dao.mybatis.mapper.SystemConfigMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.basic.service.LovService;
import com.hand.base.brandOrder.dao.mybatis.mapper.OrderMapper;
import com.hand.base.brandOrder.model.Order;
import com.hand.base.smscode.service.SmsService;
import com.hand.base.user.dao.mybatis.mapper.AppUserMapper;
import com.hand.base.user.model.AppUser;
import com.hand.base.workbench.service.MesPushService;
import com.hand.core.util.SmsUtil;

@Service
public class OrderServiceImpl  extends BasicServiceImpl<Order>implements OrderService {
	@Resource
	private OrderMapper	orderMapper;
	
	@Autowired
	private AppUserMapper userMapper;
	
	@Autowired
	private MesPushService pdService;
	
	@Autowired
	private SmsService smsService;
	
	@Autowired
	private LovService lovService;

	@Autowired
	private SystemConfigMapper configMapper;
	
	@Override
	public BasicMapper<Order> getBasicMapper() {
		return orderMapper;
	}
	
	/**
	 * 根据品牌馆订单头和行
	 * @param qps
	 * @return
	 */
	public List<Order> batchQueryOrderPage(Order entity) throws Exception{
		return orderMapper.batchQueryOrderPage(entity);
	}

	/**
	 * 根据品牌馆订单头和行
	 * @param qps
	 * @return
	 */
	public List<Order> batchQueryOrderExportPage(Order entity) throws Exception{
		return orderMapper.batchQueryOrderExportPage(entity);
	}
	
	@Override
	public void afterUpdate(Order entity) throws Exception{
		if("push".equals(entity.getAttr1())){
			String notifyType = entity.getAttr2();
			String logisticsCompany = lovService.getLovName("LOGISTICS_COMPANY", entity.getLogisticsCompany());
			entity = orderMapper.queryById(entity);
			AppUser user = new AppUser();
			user.setPageFlag(false);
			user.setAttr1("storeInfo");
			user.setAttr2(entity.getCustomerId());
			List<AppUser> userList = userMapper.queryByExamplePage(user);
			if(userList.size() != 0){
				user = userMapper.queryByExamplePage(user).get(0);
				SmsUtil.notifUser(user, "", pdService, smsService, notifyType, entity.getId(),
						entity.getOrderNum(), "", "", "",logisticsCompany, entity.getLogisticsOddNumber());
			}
		}
	}

	@Override
	public void beforBrandUpdate(Order entity) throws Exception{
		if("closeOrder".equals(entity.getAttr1())){
			String afterSaleCycle = configMapper.getByCode("Brand_After_Sale_Service_Cycle");//获取智齿APPID
			entity.setAfterSaleCycle(afterSaleCycle);
		}
	}
}
