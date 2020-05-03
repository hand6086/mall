package com.hand.base.accountmanagement.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.accountmanagement.model.Account;
import com.hand.base.accountmanagement.model.BillInfo;
import com.hand.base.basic.service.BasicService;

public interface ApplyingCashService extends BasicService<BillInfo> {

	/**
	 * 提交提现对账单
	 * 
	 * @param entity
	 * @throws Exception
	 */
	public void submitBill(BillInfo entity) throws Exception;

	
	/**
	 * 更新对账单状态
	 * 
	 * @param entity
	 * @throws Exception
	 */
	public void billStatusUpdate(BillInfo entity) throws Exception;
	
	/**
	 * 审批拒绝
	 * @param entity
	 * @throws Exception
	 */
	public void approvalRejected(BillInfo entity) throws Exception;
	
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
	public BillInfo queryNewOrRejectBill(BillInfo entity) throws Exception;
	
	/**
	 * 查询对账单状态为"待审核"对账单
	 * 
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public List<BillInfo> queryPendingReviewBill(BillInfo entity) throws Exception;

	/**
	 * 计算可提现订单的总金额,和手续费
	 * @param canCashOrderList
	 * @param payInfoIds
	 * @return
	 */
	public Map<String,BigDecimal> calculateAmount(List<Account> canCashOrderList, List<String> payInfoIds,BigDecimal scProportion) throws Exception;
	
	/**
	 * 更新提现对账单金额同时，关联提现对账单id
	 * @param reqMap
	 * @param bill
	 * @throws Exception 
	 */
	public void updateBill(Map<String,Object> reqMap ,BillInfo bill) throws Exception;
	
	/**
	 * 插入对账单表，同时关联行信息
	 * @param billInfo
	 * @param reqMap
	 * @throws Exception
	 */
	public void insertBill(BillInfo billInfo,Map<String,Object> reqMap) throws Exception;

}
