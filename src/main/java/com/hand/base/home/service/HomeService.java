package com.hand.base.home.service;

public interface HomeService {

	/**
	 * 本周新上架商品
	 * @param record
	 * @return
	 * @throws Exception
	 */
	public String queryProductCurentWeekCount() throws Exception;

	/**
	 * 本周新增订单
	 * @param record
	 * @return
	 * @throws Exception
	 */
	public String queryOrderCurentWeekCount() throws Exception;

	/**
	 * 本周销售收入
	 * @param record
	 * @return
	 * @throws Exception
	 */
	public String querySaleCurentWeekCount() throws Exception;

	/**
	 * 本周商品总销量
	 * @param record
	 * @return
	 * @throws Exception
	 */
	public String queryProductSaleCurentWeekCount() throws Exception;
}
