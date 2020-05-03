package com.hand.base.platformfavorable.service;

import java.util.List;

import com.hand.base.basic.service.BasicService;
import com.hand.base.platformfavorable.model.Platformfavorable;

public interface PlatformfavorableService extends BasicService<Platformfavorable> {

	List<Platformfavorable> queryActivityPage(Platformfavorable t) throws Exception;

	List<Platformfavorable> queryFullOfGiftsPicklistPage(Platformfavorable t) throws Exception;

	List<Platformfavorable> queryCouponpicklistPage(Platformfavorable t) throws Exception;

	/**
	 * 品牌馆优惠券picklist查询
	 * @return
	 * @throws Exception
	 */
	public List<Platformfavorable> brandQueryCouponpicklistPage(Platformfavorable record) throws Exception;

	public void CouponInsert(Platformfavorable entity) throws Exception;

	// public void insertCity(Platformfavorable entity)throws Exception;
	public void CouponUpdate(Platformfavorable entity) throws Exception;

	public void updateCity(Platformfavorable entity) throws Exception;

	List<Platformfavorable> queryCityPicklistPage(Platformfavorable t) throws Exception;

	Platformfavorable queryActivityPageById(Platformfavorable entity) throws Exception;

	/**
	 * 平台优惠，同一个城市，某个时间段的活动数
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public int queryActivityCount(Platformfavorable entity) throws Exception;

}
