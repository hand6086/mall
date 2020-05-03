package com.hand.base.home.dao.mybatis.mapper;

import com.hand.base.user.model.User;

public interface HomeMapper {
	
	/**
	 * 查询本周新上架商品
	 * @param record
	 * @return
	 * @throws Exception
	 */
	public String queryProductCurentWeekCount(User record) throws Exception;

	/**
	 * 查询本周新增订单
	 * @param record
	 * @return
	 * @throws Exception
	 */
	public String queryOrderCurentWeekCount(User record) throws Exception;

	/**
	 * 查询本周销售收入
	 * @param record
	 * @return
	 * @throws Exception
	 */
	public String querySaleCurentWeekCount(User record) throws Exception;

	/**
	 * 查询本周商品总销量
	 * @param record
	 * @return
	 * @throws Exception
	 */
	public String queryProductSaleCurentWeekCount(User record) throws Exception;
}
