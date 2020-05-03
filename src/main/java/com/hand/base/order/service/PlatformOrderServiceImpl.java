package com.hand.base.order.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.ListOfValue;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.order.dao.mybatis.mapper.PlatformOrderMapper;
import com.hand.base.order.model.InterfaceOrder;
import com.hand.base.order.model.InterfaceOrderLine;
import com.hand.base.order.model.PlatformOrder;

@Service
public class PlatformOrderServiceImpl extends BasicServiceImpl<PlatformOrder> implements PlatformOrderService {
	@Autowired
	private PlatformOrderMapper platformOrderMapper;

	@Override
	public BasicMapper<PlatformOrder> getBasicMapper() {
		return platformOrderMapper;
	}
	
	@Override
	public List<InterfaceOrder> batchQueryInterfaceOrder(InterfaceOrder interfaceOrder) throws Exception {
		return platformOrderMapper.batchQueryInterfaceOrder(interfaceOrder);
	}
	

	@Override
	public PlatformOrder queryIdByOrderNum(PlatformOrder record) throws Exception {
		return platformOrderMapper.queryIdByOrderNum(record);
	}

	/**
	 * 批量查询数量
	 */
	public String batchQueryInterfaceOrderCount(InterfaceOrder interfaceOrder) throws Exception {
		return platformOrderMapper.batchQueryInterfaceOrderCount(interfaceOrder);
	}
	
	/**
	 * 接口：根据订单编号查询订单列表
	 * @param interfaceOrder
	 * @return
	 * @throws Exception
	 */
	public InterfaceOrder queryInterfaceOrderByOrderNum(InterfaceOrder interfaceOrder) throws Exception {
		List<InterfaceOrder> list = platformOrderMapper.queryInterfaceOrderByOrderNum(interfaceOrder);
		if(list != null && list.size() > 0){
			InterfaceOrder result = list.get(0);
			// 更加订单ID查询订单行
			List<InterfaceOrderLine> lineList = platformOrderMapper.queryInterfaceOrderLineByOrderId(result);
			result.setInterfaceOrderLineList(lineList);
			return result;
		}
		return new InterfaceOrder();
	}

	@Override
	public List<PlatformOrder> queryMerchantByPage(PlatformOrder platformOrder) throws Exception {
		return platformOrderMapper.queryMerchantByPage(platformOrder);
	}

	@Override
	public List<PlatformOrder> queryProductByPage(PlatformOrder platformOrder) throws Exception {
		return platformOrderMapper.queryProductByPage(platformOrder);
	}

	@Override
	public PlatformOrder queryByOrderNum(PlatformOrder platformOrder) throws Exception {
		return platformOrderMapper.queryByOrderNum(platformOrder);
	}

	@Override
	public List<PlatformOrder> queryOrderPushRecord(PlatformOrder platformOrder) throws Exception {
		return platformOrderMapper.queryOrderPushRecord(platformOrder);
	}

	@Override
	public List<PlatformOrder> queryOrderEvaluation(PlatformOrder platformOrder) throws Exception {
		return platformOrderMapper.queryOrderEvaluation(platformOrder);
	}

	@Override
	public List<PlatformOrder> queryOrderPromotions(PlatformOrder platformOrder) throws Exception {
		return platformOrderMapper.queryOrderPromotions(platformOrder);
	}

	@Override
	public List<PlatformOrder> queryCustomerNamePage(PlatformOrder platformOrder) throws Exception {
		return platformOrderMapper.queryCustomerNamePage(platformOrder);
	}
	
	@Override
	public List<PlatformOrder> queryBrandPage(PlatformOrder platformOrder) throws Exception {
		return platformOrderMapper.queryBrandPage(platformOrder);
	}
	
	@Override
	public List<PlatformOrder> queryBfPage(PlatformOrder platformOrder) throws Exception {
		return platformOrderMapper.queryBfPage(platformOrder);
	}
	
	@Override
	public List<PlatformOrder> queryTempPage(PlatformOrder platformOrder) throws Exception {
		return platformOrderMapper.queryTempPage(platformOrder);
	}
	
	@Override
	public List<ListOfValue> orderStatusAll(ListOfValue listOfValue) throws Exception {
		return platformOrderMapper.orderStatusAll(listOfValue);
	}
	
	@Override
	public void brandUpdate(PlatformOrder entity) throws Exception{
		if(!checkData(entity)){//进行数据校验
			throw new BasicServiceException("校验不通过，请检查数据！");
		}
		checkId(entity);
		platformOrderMapper.brandUpdate(entity);
	}
	
	@Transactional
	public void brandLogisticsUpdate(PlatformOrder entity) throws Exception{
		if(!checkData(entity)){//进行数据校验
			throw new BasicServiceException("校验不通过，请检查数据！");
		}
		checkId(entity);
		if(entity.getShippingTime()==null||entity.getShippingTime()==""){
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String date = df.format(new Date());
			entity.setShippingTime(date);
		}
		platformOrderMapper.brandLogisticsUpdate(entity);
		entity.setAttrib48("To_Receive");
		entity.setAttrib07("Delivered");
		platformOrderMapper.brandUpdate(entity);
	}

	@Override
	public void updateOrderLogisticsById(PlatformOrder record) throws Exception {
		platformOrderMapper.updateOrderLogisticsById(record);
	}
	
	@Override
	public PlatformOrder queryBrandById(PlatformOrder entity) throws Exception {
		checkId(entity);
		return platformOrderMapper.queryBrandById(entity);
	}

	@Override
	public void updateRecordById(PlatformOrder entity) throws Exception {
		platformOrderMapper.updateRecordById(entity);
	}

}
