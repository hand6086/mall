package com.hand.base.accountmanagement.service;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.accountmanagement.dao.mybatis.mapper.AccountMapper;
import com.hand.base.accountmanagement.dao.mybatis.mapper.ApplyingCashMapper;
import com.hand.base.accountmanagement.dao.mybatis.mapper.AvailableCashMapper;
import com.hand.base.accountmanagement.model.Account;
import com.hand.base.accountmanagement.model.BillInfo;
import com.hand.base.accountmanagement.model.PayInfo;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.basic.service.KeyGenerateService;

@Service
public class ApplyingCashServiceImpl extends BasicServiceImpl<BillInfo> implements ApplyingCashService {
	@Autowired
	protected KeyGenerateService keyGenerateService;
	@Resource
	private ApplyingCashMapper applyingCashMapper;

	@Resource
	private AvailableCashMapper availableCashMapper;
	@Resource
	private AccountMapper accountMapper;

	@Override
	public BasicMapper<BillInfo> getBasicMapper() {
		return applyingCashMapper;
	}

	@Transactional
	public void submitBill(BillInfo entity) throws Exception {
		// applyingCashMapper.insert(entity);
		applyingCashMapper.billStatusUpdate(entity);
		PayInfo payInfo = new PayInfo();
		payInfo.setBillId(entity.getId());
		payInfo.setUsercorpid(entity.getUsercorpid());
		payInfo.setStatus("cashing");
		availableCashMapper.fundsStatusUpdate(payInfo);
	}

	

	@Override
	public void billStatusUpdate(BillInfo entity) throws Exception {
		applyingCashMapper.billStatusUpdate(entity);
	}

	@Transactional
	public void approvalRejected(BillInfo entity) throws Exception {
		applyingCashMapper.approvalOpinionUpdate(entity);
		applyingCashMapper.billStatusUpdate(entity);
		// 审批拒绝之后不更改订单状态
		/*
		 * PayInfo payInfo = new PayInfo(); payInfo.setBillId(entity.getId());
		 * payInfo.setUsercorpid(entity.getUsercorpid());
		 * payInfo.setStatus("can_cash");
		 * availableCashMapper.fundsStatusUpdate(payInfo);
		 */
	}

	@Override
	public List<BillInfo> queryApplyingCashPage(BillInfo entity) throws Exception {
		return applyingCashMapper.queryApplyingCashPage(entity);
	}

	@Override
	public BillInfo queryNewOrRejectBill(BillInfo entity) throws Exception {
		entity.setPageFlag(false);
		List<BillInfo> list = applyingCashMapper.queryNewOrRejectBill(entity);
		if (list.size() > 0) {
			entity = list.get(0);
		} else {
			entity = null;
		}
		return entity;
	}

	@Override
	public List<BillInfo> queryPendingReviewBill(BillInfo entity) throws Exception {
		entity.setStatus("pending_review");
		return applyingCashMapper.queryByExample(entity);
	}
	/**
	 * 计算可提现订单行的总金额和手续费
	 * @param list
	 * @return
	 * @throws Exception 
	 */
	public Map<String,BigDecimal> calculateAmount(List<Account> list,List<String> payInfoIds,BigDecimal scProportion) throws Exception{
		
		Map<String,BigDecimal> result = new HashMap<String,BigDecimal>();
		BigDecimal totalAmount  = new BigDecimal(0);
		BigDecimal serviceCharge  = new BigDecimal(0);
		if(list !=null && list.size() >0){
			for(Account billItem : list){
				totalAmount = totalAmount.add(billItem.getArrivedAmount());
				payInfoIds.add(billItem.getId());
			}
		}
		if (scProportion != null) {
			serviceCharge = totalAmount.multiply(scProportion);// 保留两位小数四舍五入
		}
		
		result.put("totalAmount", totalAmount);
		result.put("serviceCharge", serviceCharge);
		
		return result;
	}
	
	/**
	 * 更新提现对账单金额同时关联提现对账单id
	 * @throws Exception 
	 */
	@Transactional
	public void updateBill(Map<String,Object> reqMap ,BillInfo bill) throws Exception{
		applyingCashMapper.billAccountUpdate(bill);// 更新提现对账单中的金额
		availableCashMapper.updateBillId(reqMap);// 更新提现对账单id
	}

	/**
	 * 新建提现对账单,同时关联提现对账单id
	 * @param billInfo
	 */
	@Transactional
	public void insertBill(BillInfo billInfo, Map<String, Object> reqMap) throws Exception {
		applyingCashMapper.insert(billInfo);
		availableCashMapper.updateBillId(reqMap);
	}
}
