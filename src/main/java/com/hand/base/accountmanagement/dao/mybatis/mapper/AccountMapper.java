package com.hand.base.accountmanagement.dao.mybatis.mapper;

import java.util.List;
import com.hand.base.accountmanagement.model.Account;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.CallParam;

public interface AccountMapper extends BasicMapper<Account> {
	/**
	 * 根据条件查询不分页
	 * 
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public List<Account> queryByExample(Account entity) throws Exception;

	/**
	 * 查询支付信息中可提现的订单信息
	 * 
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public List<Account> queryCanCashOrderPage(Account entity) throws Exception;

	/**
	 * 各类金额求和
	 * 
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public Account querySumMoney(Account entity) throws Exception;

	/**
	 * 统计账单信息并将其更新到企业表
	 * 
	 * @param record
	 * @throws Exception
	 */
	public void sumAndUpdateEnterprise(CallParam record) throws Exception;

	/**
	 * 企业账户新建
	 * 
	 * @param entity
	 * @throws Exception
	 */
	public void accountInsert(Account entity) throws Exception;
	/**
	 * 企业账户更新
	 * 
	 * @param entity
	 * @throws Exception
	 */
	public void accountUpdate(Account entity) throws Exception;

	/**
	 * 银行账户picklist
	 * 
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public List<Account> queryAccountPickListPage(Account entity) throws Exception;

	/**
	 * 快购管理员查看对账单时，查询该对账单对应的订单的详细信息
	 * 
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public List<Account> queryCashingOrderPage(Account entity) throws Exception;
	
	/**
	 * 品牌馆管理员查看对账单时，查询该对账单对应的订单的详细信息
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public List<Account> brandQueryCashingOrderPage(Account entity) throws Exception;
	
	/**
	 * 查询可提现订单
	 * 
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public List<Account> queryWithDrawalsMoney(Account entity) throws Exception;
	
	/**
	 * 银行账户去重
	 */
	public Integer removalDuplicateBankCard(Account entity) throws Exception;

}
