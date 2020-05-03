package com.hand.base.accountmanagement.service;

import java.util.List;

import com.hand.base.accountmanagement.model.PayInfo;
import com.hand.base.basic.service.BasicService;

public interface AvailableCashService extends BasicService<PayInfo>{
	/**
	 * 更新订单中的状态
	 * 
	 * @param entity
	 * @throws Exception
	 */
	public void fundStatusUpdate(PayInfo entity) throws Exception;
	/**
	 * 根据提现对账单id查询，快购提现对账单行明细信息
	 * @param billId
	 * @return
	 * @throws Exception
	 */
	public List<PayInfo> queryByBillId (PayInfo entity) throws Exception;
	/**
	 * 根据提现对账单id查询，品牌馆提现对账单行明细信息
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public List<PayInfo> brandQueryByBillId (PayInfo entity) throws Exception;
}
