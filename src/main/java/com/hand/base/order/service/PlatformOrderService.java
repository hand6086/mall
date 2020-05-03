package com.hand.base.order.service;

import java.util.List;

import com.hand.base.basic.model.ListOfValue;
import com.hand.base.basic.service.BasicService;
import com.hand.base.order.model.InterfaceOrder;
import com.hand.base.order.model.PlatformOrder;

public interface PlatformOrderService extends BasicService<PlatformOrder> {
	
	
	/**
	 * 更新推送记录
	 * @param entity
	 */
	public void updateRecordById(PlatformOrder entity) throws Exception;
	
	/**
	 * 根据订单编号查询订单ID
	 * @param record
	 * @return
	 * @throws Exception
	 */
	public void updateOrderLogisticsById(PlatformOrder record) throws Exception;
	
	/**
	 * 根据订单编号查询订单ID
	 * @param record
	 * @return
	 * @throws Exception
	 */
	public PlatformOrder queryIdByOrderNum(PlatformOrder record) throws Exception;
	
	
	/**
	 * 接口：根据订单编号查询订单列表
	 * @param interfaceOrder
	 * @return
	 * @throws Exception
	 */
	public InterfaceOrder queryInterfaceOrderByOrderNum(InterfaceOrder interfaceOrder) throws Exception;
	
	/**
	 * 接口：批量查询订单列表
	 * @param interfaceOrder
	 * @return
	 * @throws Exception
	 */
	public List<InterfaceOrder> batchQueryInterfaceOrder(InterfaceOrder interfaceOrder) throws Exception;
	
	/**
	 * 接口：批量查询订单列表数量
	 * @param interfaceOrder
	 * @return
	 * @throws Exception
	 */
	public String batchQueryInterfaceOrderCount(InterfaceOrder interfaceOrder) throws Exception;
	
	
	/**
	 * O2O平台订单第一个行结构
	 * @return
	 */
	public List<PlatformOrder> queryMerchantByPage(PlatformOrder platformOrder) throws Exception;

	/**
	 * O2O平台订单第二个行结构
	 * @return
	 */
	public List<PlatformOrder> queryProductByPage(PlatformOrder platformOrder) throws Exception;
	
	/**
	 * O2O平台订单 订单编号下的链接
	 * @return
	 */
	public PlatformOrder queryByOrderNum(PlatformOrder platformOrder) throws Exception;
	
	/**
	 * O2O平台订单 订单编号下的链接 tab页 订单推送记录
	 * @return
	 */
	public List<PlatformOrder> queryOrderPushRecord(PlatformOrder platformOrder) throws Exception;
	
	/**
	 * O2O平台订单 订单编号下的链接 tab页 订单评价
	 * @return
	 */
	public List<PlatformOrder> queryOrderEvaluation(PlatformOrder platformOrder) throws Exception;
	
	/**
	 * O2O平台订单 订单编号下的链接 tab页 订单促销活动
	 * @return
	 */
	public List<PlatformOrder> queryOrderPromotions(PlatformOrder platformOrder) throws Exception;
	
	/**
	 * O2O平台订单 客户名称picklist
	 * @return
	 */
	public List<PlatformOrder> queryCustomerNamePage(PlatformOrder platformOrder) throws Exception;
	
	/**
	 * 品牌馆订单查询
	 * @return
	 */
	public List<PlatformOrder> queryBrandPage(PlatformOrder platformOrder) throws Exception;
	
	/**
	 * 品牌馆订单发运查询
	 * @return
	 */
	public List<PlatformOrder> queryBfPage(PlatformOrder platformOrder) throws Exception;
	
	/**
	 * 品牌馆订单发运模板查询
	 * @return
	 */
	public List<PlatformOrder> queryTempPage(PlatformOrder platformOrder) throws Exception;
	
	/**
	 * 品牌馆订单发运筛选
	 * @return
	 */
	public List<ListOfValue> orderStatusAll(ListOfValue listOfValue) throws Exception;
	
	/**
	 * 品牌馆订单状态更新
	 * @param entity
	 */
	public void brandUpdate(PlatformOrder entity) throws Exception;
	
	/**
	 * 品牌馆物流更新
	 * @param entity
	 */
	public void brandLogisticsUpdate(PlatformOrder entity) throws Exception;
	
	/**
	 * 品牌馆通过ID查询
	 * @param entity
	 */
	public PlatformOrder queryBrandById(PlatformOrder entity) throws Exception;
}
