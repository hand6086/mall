package com.hand.base.accountmanagement.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.accountmanagement.model.BillInfo;
import com.hand.base.basic.dao.mapper.BasicMapper;

public interface ApplyingCashMapper extends BasicMapper<BillInfo> {

	/**
	 * 更新对账单状态
	 * 
	 * @param entity
	 * @throws Exception
	 */
	public void billStatusUpdate(BillInfo entity) throws Exception;

	/**
	 * 更据条件查询对账单不分页
	 * 
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public List<BillInfo> queryByExample(BillInfo entity) throws Exception;

	/**
	 * 更新到账金额和手续费
	 * 
	 * @param entity
	 * @throws Exception
	 */
	public void billAccountUpdate(BillInfo entity) throws Exception;

	/**
	 * 更新审批意见
	 * 
	 * @param entity
	 * @throws Exception
	 */
	public void approvalOpinionUpdate(BillInfo entity) throws Exception;

	/**
	 * 查询申请中对账单信息状态不是转账成功的
	 * 
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public List<BillInfo> queryApplyingCashPage(BillInfo entity) throws Exception;

	/**
	 * 查询对账单状态为“新建”或者“审批拒绝”的对账单
	 * 
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public List<BillInfo> queryNewOrRejectBill(BillInfo entity) throws Exception;

}
