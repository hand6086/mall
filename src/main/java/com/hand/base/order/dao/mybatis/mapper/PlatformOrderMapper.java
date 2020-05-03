package com.hand.base.order.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.ListOfValue;
import com.hand.base.order.model.InterfaceOrder;
import com.hand.base.order.model.InterfaceOrderLine;
import com.hand.base.order.model.PlatformOrder;

public interface PlatformOrderMapper extends BasicMapper<PlatformOrder> {
	
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
	 * 接口：批量查询订单列表数量
	 * @param interfaceOrder
	 * @return
	 * @throws Exception
	 */
	public String batchQueryInterfaceOrderCount(InterfaceOrder interfaceOrder) throws Exception;
	
	/**
	 * 接口：批量查询订单列表数量
	 * @param interfaceOrder
	 * @return
	 * @throws Exception
	 */
	public void getQueryInterfaceOrderCount(InterfaceOrder record) throws Exception;
	
	/**
	 * 接口：批量查询订单列表
	 * @param interfaceOrder
	 * @return
	 * @throws Exception
	 */
	public List<InterfaceOrder> batchQueryInterfaceOrder(InterfaceOrder interfaceOrder) throws Exception;
	
	/**
	 * 接口：根据订单编号查询订单列表
	 * @param interfaceOrder
	 * @return
	 * @throws Exception
	 */
	public List<InterfaceOrder> queryInterfaceOrderByOrderNum(InterfaceOrder interfaceOrder) throws Exception;
	
	/**
	 * 接口：根据订单ID查询订单行
	 * @param interfaceOrder
	 * @return
	 * @throws Exception
	 */
	public List<InterfaceOrderLine> queryInterfaceOrderLineByOrderId(InterfaceOrder interfaceOrder) throws Exception;
	
	public List<PlatformOrder> queryMerchantByPage(PlatformOrder platformOrder) throws Exception;

	public List<PlatformOrder> queryProductByPage(PlatformOrder platformOrder) throws Exception;
	
	public PlatformOrder queryByOrderNum(PlatformOrder platformOrder) throws Exception;
	
	public List<PlatformOrder> queryOrderPushRecord(PlatformOrder platformOrder) throws Exception;
	
	public List<PlatformOrder> queryOrderEvaluation(PlatformOrder platformOrder) throws Exception;
	
	public List<PlatformOrder> queryOrderPromotions(PlatformOrder platformOrder) throws Exception;
	
	public List<PlatformOrder> queryCustomerNamePage(PlatformOrder platformOrder) throws Exception;
	
	public List<PlatformOrder> queryBrandPage(PlatformOrder platformOrder) throws Exception;
	
	public List<PlatformOrder> queryBfPage(PlatformOrder platformOrder) throws Exception;
	
	public List<PlatformOrder> queryTempPage(PlatformOrder platformOrder) throws Exception;
	
	public List<ListOfValue> orderStatusAll(ListOfValue listOfValue) throws Exception;
	
	/**
	 * 品牌馆更新
	 * @param entity
	 */
	public void brandUpdate(PlatformOrder entity) throws Exception;
	public void brandLogisticsUpdate(PlatformOrder entity) throws Exception;
	
	public PlatformOrder queryBrandById(PlatformOrder entity) throws Exception;
	
}
