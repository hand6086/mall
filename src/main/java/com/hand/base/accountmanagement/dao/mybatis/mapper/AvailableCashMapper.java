package com.hand.base.accountmanagement.dao.mybatis.mapper;

import java.util.List;
import java.util.Map;

import com.hand.base.accountmanagement.model.PayInfo;
import com.hand.base.basic.dao.mapper.BasicMapper;

public interface AvailableCashMapper extends BasicMapper<PayInfo> {
	
	/**
	 * 将提现对账单更新到订单中去
	 * 
	 * @param entity
	 * @throws Exception
	 */
	public void updateBillId(Map<String , Object> reqMap) throws Exception;
	
	/**
	 * 将订单的资金状态改为“提现中”
	 * @param entity
	 * @throws Exception
	 */
	public void fundsStatusUpdate(PayInfo entity) throws Exception;
	
	/**
	 * 更据billId 查询快购提现对账单行信息
	 * @param billId
	 * @return
	 * @throws Exception
	 */
	public List<PayInfo> queryByBillIdPage (PayInfo entity) throws Exception;
	
	/**
	 * 根据billId查询品牌馆对账单行信息
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public List<PayInfo> brandQueryByBillIdPage (PayInfo entity) throws Exception;
}
