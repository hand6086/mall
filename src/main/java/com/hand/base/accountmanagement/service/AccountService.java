package com.hand.base.accountmanagement.service;

import java.math.BigDecimal;
import java.util.List;
import com.hand.base.accountmanagement.model.Account;
import com.hand.base.basic.service.BasicService;

public interface AccountService extends BasicService<Account> {
	/**
	 * 根据条件查询商家账户信息不分页
	 * 
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public List<Account> queryByExample(Account entity) throws Exception;

	/**
	 * 快购查询支付信息中可提现的订单信息
	 * 
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public List<Account> queryCanCashOrderPage(Account entity) throws Exception;
	
	/**
	 * 品牌馆查询支付信息中可提现的订单信息
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public List<Account> brandQueryCashingOrderPage(Account entity) throws Exception;

	/**
	 * 申请提现的时候初始化对账单数据
	 * 
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public Account billInit(Account entity) throws Exception;
	
	/**
	 * 原querySumMoney()
	 * 
	 * @param account
	 * @return
	 * @throws Exception
	 */
	public Account querySumMoney(Account account) throws Exception;

	/**
	 * 各类金额求和
	 * 
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public BigDecimal querySumMoney(List<Account> entityList,String type) throws Exception;

	/**
	 * 企业账户新建
	 * 
	 * @param entity
	 * @throws Exception
	 */
	public void accountInsert(Account entity) throws Exception;
	/**
	 * 企业账户更新或新建
	 * 
	 * @param entity
	 * @throws Exception
	 */
	public void accountUpsert(Account entity) throws Exception;

	/**
	 * 银行账户picklist
	 * 
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public List<Account> queryAccountPickListPage(Account entity) throws Exception;

	/**
	 * 管理员查看对账单时，查询该对账单对应的订单的详细信息
	 * 
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public List<Account> queryCashingOrderPage(Account entity) throws Exception;
	
	/**
	 * 银行账户去重
	 */
	public Integer removalDuplicateBankCard(Account entity) throws Exception;
	
	
}
