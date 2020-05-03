package com.hand.base.accountmanagement.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.accountmanagement.model.Account;
import com.hand.base.accountmanagement.model.BillInfo;
import com.hand.base.accountmanagement.service.AccountService;
import com.hand.base.accountmanagement.service.ApplyingCashService;
import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.user.model.User;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.util.UserUtil;

@Controller
@RequestMapping("/action/portal/applyingcash")
public class ApplyingCashController extends BasicController<BillInfo> {
	@Resource
	private KeyGenerateService keyGenerateService;

	@Resource
	private ApplyingCashService applyingCashService;

	@Resource
	private AccountService accountService;

	private static final Logger LOGGER = Logger.getLogger(BasicController.class);
	@Override
	public BasicService<BillInfo> getBasicService() throws Exception {
		return applyingCashService;
	}

	@RequestMapping(value = "/submitBill")
	@ResponseBody
	public Map<String, Object> submitBill(BillInfo entity, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			beforInsert(entity, request);
			beforUpsert(entity, request);
			applyingCashService.submitBill(entity);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}

	/**
	 * 更新对账单状态
	 * 
	 * @param entity
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/billStatusUpdate")
	@ResponseBody
	public Map<String, Object> billStatusUpdate(BillInfo entity, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			applyingCashService.billStatusUpdate(entity);
			BillInfo newEntry = applyingCashService.queryById(entity);
			result.put("newRow", newEntry);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 查询状态为新建或审批拒绝的对账单
	 * @param entity
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	/*@RequestMapping(value = "/queryNewOrRejectBill")
	@ResponseBody
	public Map<String, Object> queryNewOrRejectBill(BillInfo entity, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			BillInfo bill = applyingCashService.queryNewOrRejectBill(entity);
			if (bill != null) {
				Account acc = new Account();
				acc.setPageFlag(false);
				acc.setBillId(bill.getId());
				//查询可提现订单，包括可提现的和bill中的
				List<Account> list = accountService.queryCanCashOrderPage(acc);
				BigDecimal servChargeProportion = bill.getServChargeProportion();
				BigDecimal totalMoney = new BigDecimal(0);
				for (int i = 0; i < list.size(); i++) {
					Account account = list.get(i);
					BigDecimal arrivedAmount = account.getArrivedAmount();
					totalMoney = totalMoney.add(arrivedAmount);
				}
				BigDecimal applySerCharge = new BigDecimal(0);
				if (servChargeProportion != null) {
					applySerCharge = totalMoney.multiply(servChargeProportion);
				}
				totalMoney = totalMoney.subtract(applySerCharge);
				bill.setArrivedAmount(totalMoney);
				bill.setServiceCharge(applySerCharge);
				
			}
			result.put("result", bill);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	*/
	/**
	 * 审批拒绝
	 * @param entity
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/approvalRejected")
	@ResponseBody
	public Map<String, Object> approvalRejected(BillInfo entity, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			applyingCashService.approvalRejected(entity);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 查询所有状态不为转账成功的对账单
	 * @param qps
	 * @param entity
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/queryApplyingCashPage")
	@ResponseBody
	public Map<String, Object> queryApplyingCashPage(QueryParams qps, BillInfo entity, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			qps.preDealSecurity(request);
			BillInfo t = (BillInfo) BasicModel.transformClass(entity, qps);
			List<BillInfo> list = applyingCashService.queryApplyingCashPage(t);
			result.put("rows", list);
			result.put("total", getCount(((BasicModel) entity), list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 查询状态为“待审核”的对账单
	 * @param entity
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/queryPendingReviewBill")
	@ResponseBody
	public Map<String, Object> queryPendingReviewBill(BillInfo entity, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			List<BillInfo> list = applyingCashService.queryPendingReviewBill(entity);
			
			result.put("result", list);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 初始化提现对账单
	 * @param entity
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/billInit")
	@ResponseBody
	public Map<String, Object> billInit(BillInfo entity, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			//查询状态为“新建”或者"审批拒绝"的提现对账单，如果存在执行update操作
			BillInfo bill = applyingCashService.queryNewOrRejectBill(entity);
			
			List<String> payInfoIds = new ArrayList<String>();//支付信息行id
			
			if(bill !=null){
				LOGGER.info("查询可提现订单。。。。。。。");
				Account accnt = new Account();
				accnt.setBillId(bill.getId());
				accnt.setUsercorpid(bill.getCorpid());
				accnt.setPageFlag(false);
				
				List <Account> canCashOrderList = accountService.queryCanCashOrderPage(accnt);
				
				LOGGER.info("查询账户信息");
				accnt.setId(entity.getEnterpId());
				Account account = accountService.queryById(accnt);
				
				LOGGER.info("计算可提现订单的总价和手续费");
				Map<String,BigDecimal> amount = applyingCashService.calculateAmount(canCashOrderList,payInfoIds, account.getServChargeProportion());
				
				bill.setArrivedAmount(amount.get("totalAmount").subtract(amount.get("serviceCharge")));
				bill.setServiceCharge(amount.get("serviceCharge"));
				bill.setPhone(account.getApplicantPhone());//更新的时候确保是最新的联系电话
				bill.setServChargeProportion(account.getServChargeProportion());//更新最新的手续费比例
				
				//更新提现对账单，更新金额的同时更新，订单行的提现对账单id
				Map<String ,Object> paraMap = new HashMap<String,Object>();
				paraMap.put("usercorpid", bill.getCorpid());
				paraMap.put("billId", bill.getId());
				if(payInfoIds.size()<=0){
					payInfoIds.add("");
				}
				paraMap.put("list", payInfoIds);
				
				LOGGER.info("更新提现对账单金额，同时关联支付信息表的对账单号billId:"+bill.getId());
				applyingCashService.updateBill(paraMap, bill);
				
				bill = applyingCashService.queryById(bill);
				
				if(StringUtils.isNotBlank(bill.getBank())&&StringUtils.isNotBlank(bill.getMerchantAccount())) {
					bill.setMerchantAccount(bill.getBank()+"-"+bill.getMerchantAccount());
				}else {
					bill.setMerchantAccount("");
				}
				LOGGER.info("更新提现对账单,set MerchantAccount"+bill.getMerchantAccount());
				result.put("result", bill);
				
			}else{//新建一个提现对账单
				String rowId =keyGenerateService.keyGenerate();
				LOGGER.info("查询账户信息");
				Account accnt = new Account();
				accnt.setId(entity.getEnterpId());
				Account account = accountService.queryById(accnt);
				
				BillInfo newBill = new BillInfo();
				newBill.setId(rowId);
				newBill.setFundingDirection("-");
				newBill.setReceiptCode(rowId);
				newBill.setReceiptType("提现对账单");
				newBill.setBillId(rowId);
				newBill.setPhone(account.getApplicantPhone());
				newBill.setServChargeProportion(account.getServChargeProportion());
				newBill.setEntpName(account.getEnterpriseName());
				newBill.setStatus("New");
				LOGGER.info("￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥");
				LOGGER.info("account.getBank()"+account.getBank());
				LOGGER.info("account.getCardNum()"+account.getCardNum());
				if(StringUtils.isNotBlank(account.getBank()) && StringUtils.isNotBlank(account.getCardNum())) {
					newBill.setMerchantAccount(account.getMerchantAccount());
				}else {
					newBill.setMerchantAccount("");
				}
				LOGGER.info("新建提现对账单newBill MerchantAccount"+newBill.getMerchantAccount());
				User user = UserUtil.getUser(null);
				account.setBillId(rowId);
				account.setUsercorpid(account.getCorpid());
				account.setPageFlag(false);
				
				List <Account> canCashOrderList = accountService.queryCanCashOrderPage(account);
				
				LOGGER.info("计算可提现订单的总价和手续费");
				Map<String,BigDecimal> amount = applyingCashService.calculateAmount(canCashOrderList,payInfoIds, account.getServChargeProportion());
				
				newBill.setArrivedAmount(amount.get("totalAmount").subtract(amount.get("serviceCharge")));
				newBill.setServiceCharge(amount.get("serviceCharge"));
				
				Map<String ,Object> paraMap = new HashMap<String,Object>();
				paraMap.put("usercorpid", user.getUsercorpid());
				paraMap.put("billId", newBill.getId());
				if(payInfoIds.size()<=0){
					payInfoIds.add("");
				}
				paraMap.put("list", payInfoIds);
				
				LOGGER.info("新建提现对账单，同时关联支付信息表。rowId" +rowId);
				applyingCashService.insertBill(newBill,paraMap);
				
				bill = applyingCashService.queryById(newBill);
				result.put("result", newBill);
			}
			
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
}
