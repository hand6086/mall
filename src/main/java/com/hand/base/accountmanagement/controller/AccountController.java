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
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.accountmanagement.model.Account;
import com.hand.base.accountmanagement.model.BillInfo;
import com.hand.base.accountmanagement.model.PayInfo;
import com.hand.base.accountmanagement.service.AccountService;
import com.hand.base.accountmanagement.service.ApplyingCashService;
import com.hand.base.accountmanagement.service.AvailableCashService;
import com.hand.base.accountmanagement.service.DepositService;
import com.hand.base.accountmanagement.service.UnIntoAccountService;
import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.user.model.User;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.util.UserUtil;

@Controller
@RequestMapping("/action/portal/account")
public class AccountController extends BasicController<Account> {

	@Resource
	private KeyGenerateService keyGenerateService;

	@Resource
	private AccountService accountService;

	@Resource
	private ApplyingCashService applyingCashService;
	
	@Resource
	private AvailableCashService availableCashService;
	
	@Resource
	private UnIntoAccountService unIntoAccountService;
	
	@Resource
	private DepositService depositService;

	@Override
	public BasicService<Account> getBasicService() throws Exception {
		return accountService;
	}
	
	@RequestMapping(value = "/queryByExample")
	@ResponseBody
	public Map<String, Object> queryByExample(QueryParams qps, Account entity, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			qps.preDealSecurity(request);
			Account t = (Account) BasicModel.transformClass(entity, qps);
			beforQueryAllOrExample(t, request);
			beforQueryExample(t, request);
			List<Account> list = accountService.queryByExample(t);
			// 计算各类金额合计
			entity.setCorpid(list.get(0).getCorpid());
			Account sumMoney = accountService.querySumMoney(entity);
			
			//计算可提现金额
			List<Account> accountList = new ArrayList<Account>();
			PayInfo payInfo = new PayInfo();
			User user = UserUtil.getUser(session);
			payInfo.setUsercorpid(user.getCorpid());
			payInfo.setPageFlag(false);
			List<PayInfo> payInfoList = availableCashService.queryByExamplePage(payInfo);
			for (PayInfo payInfo1 : payInfoList) {
				Account account = new Account();
				account.setWithdrawalsMoney(payInfo1.getArrivedAmount());
				account.setFundingDirection(payInfo1.getFundingDirection());
				accountList.add(account);
			}
			sumMoney.setWithdrawalsMoney(accountService.querySumMoney(accountList,"withDrawalsMoney"));
			
			//计算未入账金额
			accountList = new ArrayList<Account>();
			payInfoList = unIntoAccountService.queryByExamplePage(payInfo);
			for (PayInfo payInfo1 : payInfoList) {
				Account account = new Account();
				account.setNoArrivalMoney(payInfo1.getArrivedAmount());
				account.setFundingDirection(payInfo1.getFundingDirection());
				accountList.add(account);
			}	
			sumMoney.setNoArrivalMoney(accountService.querySumMoney(accountList,"noArrivalMoney"));
			
			//计算申请中金额
			accountList = new ArrayList<Account>();
			BillInfo billInfo = new BillInfo();
			billInfo.setUsercorpid(user.getUsercorpid());
			billInfo.setPageFlag(false);
			List<BillInfo> billInfoList = new ArrayList<BillInfo>();
			billInfoList = applyingCashService.queryApplyingCashPage(billInfo);
			for (BillInfo billInfo1 : billInfoList) {
				Account account = new Account();
				account.setApplyMoney(billInfo1.getArrivedAmount());
				account.setFundingDirection(billInfo1.getFundingDirection());
				accountList.add(account);
			}
			sumMoney.setApplyMoney(accountService.querySumMoney(accountList, "applyMoney"));
			
			//计算商家保证金金额
			payInfoList = new ArrayList<PayInfo>();
			payInfoList = depositService.queryByExamplePage(payInfo);
			for (PayInfo payInfo1 : payInfoList) {
				Account account = new Account();
				account.setDeposit(payInfo1.getArrivedAmount());
				account.setFundingDirection(payInfo1.getFundingDirection());
				accountList.add(account);
			}
			sumMoney.setDeposit(accountService.querySumMoney(accountList, "deposit"));
			
			result.put("success", true);
			result.put("result", list);
			result.put("result2", sumMoney);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}

	/**
	 * 查询支付信息中所有可提现的订单信息
	 * 
	 * @param qps
	 * @param entity
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/queryCanCashOrderPage")
	@ResponseBody
	public Map<String, Object> queryCanCashOrderPage(QueryParams qps, Account entity, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		String billId = request.getParameter("billId");
		String amount = request.getParameter("amount");
		String servCharge = request.getParameter("serviceCharge");

		BigDecimal arrivedAmount = new BigDecimal(amount);
		BigDecimal serviceCharge = new BigDecimal(servCharge);

		entity.setBillId(billId);
		entity.setArrivedAmount(arrivedAmount);
		entity.setServiceCharge(serviceCharge);
		try {
			qps.preDealSecurity(request);
			Account t = (Account) BasicModel.transformClass(entity, qps);
			beforQueryAllOrExample(t, request);
			beforQueryExample(t, request);
			List<Account> list = accountService.queryCanCashOrderPage(t);
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
	 * 新建银行账户
	 * 
	 * @param entity
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/accountInsert")
	@ResponseBody
	public Map<String, Object> accountInsert(Account entity, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			beforInsert(entity, request);
			beforUpsert(entity, request);
			accountService.accountInsert(entity);

			auditTrailInsert(entity, request, session, "N"); // 审计追踪新建记录

			Account newEntry = accountService.queryById(entity);
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
	 * 提现银行账户picklist
	 * 
	 * @param qps
	 * @param entity
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/queryAccountPickListPage")
	@ResponseBody
	public Map<String, Object> queryAccountPickListPage(QueryParams qps, Account entity, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			qps.preDealSecurity(request);
			Account t = (Account) BasicModel.transformClass(entity, qps);
			List<Account> list = accountService.queryAccountPickListPage(t);
			result.put("success", true);
			if(!t.getOnlyCountFlag()){
				this.pushCurrentDataCache(list, session.getId(), "base", false);
			}
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
	 * 管理员查看状态为“提现中的订单信息”
	 * 
	 * @param qps
	 * @param entity
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/queryCashingOrderPage")
	@ResponseBody
	public Map<String, Object> queryCashingOrderPage(QueryParams qps, Account entity, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			qps.preDealSecurity(request);
			User user = UserUtil.getUser(session);
			Account t = (Account) BasicModel.transformClass(entity, qps);
			//List<Account> list = accountService.queryCashingOrderPage(t);
			List<Account> list = new ArrayList<Account>();
			list = accountService.queryCashingOrderPage(t);
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
	 * 计算金额总计
	 * 
	 * @param qps
	 * @param entity
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/querySumMoney")
	@ResponseBody
	public Map<String, Object> querySumMoney(QueryParams qps, Account entity, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			qps.preDealSecurity(request);
			Account account = accountService.querySumMoney(entity);
			result.put("result", account);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 新建或更新一条企业账户记录
	 */
	@RequestMapping(value = "/accountUpsert")
	@ResponseBody
	public Map<String, Object> accountUpsert(Account entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		User user = UserUtil.getUser(session);
		try{
			beforUpsert(entity, request);
			checkData(entity, request);
			if(!getBasicService().isInsertFlag(entity) && !checkExistDataCache("base", session, entity)){
				throw new BasicServiceException("您操作太快了，请点击下方刷新按钮后再修改记录！");
			}
			entity.setAccntHolder(user.getId());
			entity.setCorpid(user.getCorpid());
			accountService.accountUpsert(entity);

			auditTrailInsert(entity,request,session,"US");    //审计追踪新建记录
			entity.setAttr1("queryById");
			entity.setPageFlag(false);
			Account newEntry = accountService.queryAccountPickListPage(entity).get(0);
			result.put("newRow", newEntry);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	/**
	 * 去重银行卡
	 * @param entity
	 * @param session
	 * @param request
	 * @param response
	 * @return 
	 */
	@RequestMapping(value="removalDuplicateBankCard",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> removalDuplicateBankCard(Account entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response){
		Map<String, Object> result = new HashMap<String,Object>();
		try {
			User user = UserUtil.getUser(session);
			entity.setCorpid(user.getCorpid());
			int isDuplicate = accountService.removalDuplicateBankCard(entity);
			if(isDuplicate!=0) {
				//当前银行卡号在lnk_enterprise_account中已存在
				result.put("duplicated", true);
			}else {
				result.put("duplicated", false);
			}
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
		}
		return result;
	}
}
