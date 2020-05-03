package com.hand.base.accountmanagement.service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.accountmanagement.dao.mybatis.mapper.AccountMapper;
import com.hand.base.accountmanagement.dao.mybatis.mapper.ApplyingCashMapper;
import com.hand.base.accountmanagement.dao.mybatis.mapper.AvailableCashMapper;
import com.hand.base.accountmanagement.model.Account;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.core.util.DateUtil;
import com.hand.core.util.StringUtils;

@Service
public class AccountServiceImpl extends BasicServiceImpl<Account> implements AccountService {

	@Autowired
	protected KeyGenerateService keyGenerateService;
	@Resource
	private AccountMapper accountMapper;

	@Resource
	private AvailableCashMapper availableCashMapper;

	@Resource
	private ApplyingCashMapper applyingCashMapper;

	@Override
	public BasicMapper<Account> getBasicMapper() {
		return accountMapper;
	}

	@Override
	public List<Account> queryByExample(Account entity) throws Exception {
		return accountMapper.queryByExample(entity);
	}
	/**
	 * 根据套账id和提现对账单id查询可提现订单
	 */
	public List<Account> queryCanCashOrderPage(Account entity) throws Exception {
		List<Account> list = accountMapper.queryCanCashOrderPage(entity);
		/*if (reqMap.get("billId") != null) {
			BillInfo bill = new BillInfo();
			bill.setId(reqMap.get("billId"));
			bill.setArrivedAmount(entity.getArrivedAmount());
			bill.setServiceCharge(entity.getServiceCharge());
			applyingCashMapper.billAccountUpdate(bill);// 更新提现对账单中的金额

			PayInfo payInfo = new PayInfo();
			payInfo.setBillId(entity.getBillId());
			availableCashMapper.billIdUpdate(payInfo);// 更新提现对账单id
		}*/
		return list;
	}

	@Override
	public Account billInit(Account entity) throws Exception {
		// applyingCashMapper.countByExample(entity);
		Account account = accountMapper.queryById(entity);
		String id = keyGenerateService.keyGenerate();
		Date date = new Date();
		String current = DateUtil.getYY_MM_DDHHmmss(date);
		entity.setId(id);
		entity.setStatus("New");
		entity.setCreated(current);
		entity.setMerchantAccount(account.getMerchantAccount());
		entity.setEnterpriseName(account.getEnterpriseName());
		entity.setApplicantPhone(account.getApplicantPhone());
		entity.setServChargeProportion(account.getServChargeProportion());
		return entity;
	}
	
	@Override
	public Account querySumMoney(Account account) throws Exception {
		return accountMapper.querySumMoney(account);
	}

	@Override
	public BigDecimal querySumMoney(List<Account> entityList,String type) throws Exception {
		BigDecimal withdrawalsMoney = new BigDecimal("0.00");
		for (Account account : entityList) {
			if(StringUtils.equals(type, "withDrawalsMoney")) {
				if(StringUtils.equals(account.getFundingDirection(), "+")) {
					withdrawalsMoney = withdrawalsMoney.add(account.getWithdrawalsMoney());
				} else if(StringUtils.equals(account.getFundingDirection(), "-")) {
					withdrawalsMoney = withdrawalsMoney.subtract(account.getWithdrawalsMoney());
				}
			}else if(StringUtils.equals(type, "noArrivalMoney")) {
				if(StringUtils.equals(account.getFundingDirection(), "+")) {
					withdrawalsMoney = withdrawalsMoney.add(account.getNoArrivalMoney());
				} else if(StringUtils.equals(account.getFundingDirection(), "-")) {
					withdrawalsMoney = withdrawalsMoney.subtract(account.getNoArrivalMoney());
				}
			}else if(StringUtils.equals(type, "applyMoney")) {
				if(StringUtils.equals(account.getFundingDirection(), "+")) {
					withdrawalsMoney = withdrawalsMoney.add(account.getApplyMoney());
				} else if(StringUtils.equals(account.getFundingDirection(), "-") && account.getApplyMoney() != null) {
					withdrawalsMoney = withdrawalsMoney.subtract(account.getApplyMoney());
				}
			}else if(StringUtils.equals(type, "deposit")) {
				if(StringUtils.equals(account.getFundingDirection(), "+")) {
					withdrawalsMoney = withdrawalsMoney.add(account.getDeposit());
				} else if(StringUtils.equals(account.getFundingDirection(), "-") && account.getDeposit() != null) {
					withdrawalsMoney = withdrawalsMoney.subtract(account.getDeposit());
				}
			}
			
		}
		return withdrawalsMoney;
	}

	// 在执行queryByExample之前对所有的企业金额信息进行统计，然后更新到企业表中
	public void beforQueryExample(Account entity) throws Exception {
		CallParam callParam = new CallParam();
		accountMapper.sumAndUpdateEnterprise(callParam);
	}

	@Transactional
	public void accountInsert(Account entity) throws Exception {
		entity.setId(keyGenerateService.keyGenerate());
		accountMapper.accountInsert(entity);
		accountMapper.update(entity);
	}
	
	@Transactional
	public void accountUpsert(Account entity) throws Exception {
		if(isInsertFlag(entity)){
			postDefaultValue(entity);//设置默认值
			if(StringUtils.isBlank(entity.getId())){
				entity.setId(keyGenerateService.keyGenerate());
			}
			if(!checkData(entity)){//进行数据校验
				throw new BasicServiceException("校验不通过，请检查数据！");
			}
			accountMapper.accountInsert(entity);
		}else{
			if(!checkData(entity)){//进行数据校验
				throw new BasicServiceException("校验不通过，请检查数据！");
			}
			checkId(entity);
			accountMapper.accountUpdate(entity);
		}
	}

	@Override
	public List<Account> queryAccountPickListPage(Account entity) throws Exception {
		return accountMapper.queryAccountPickListPage(entity);
	}

	@Override
	public List<Account> queryCashingOrderPage(Account entity) throws Exception {
		return accountMapper.queryCashingOrderPage(entity);
	}

	@Override
	public Integer removalDuplicateBankCard(Account entity) throws Exception {
		return accountMapper.removalDuplicateBankCard(entity);
	}

	@Override
	public List<Account> brandQueryCashingOrderPage(Account entity) throws Exception {
		return accountMapper.brandQueryCashingOrderPage(entity);
	}

}
