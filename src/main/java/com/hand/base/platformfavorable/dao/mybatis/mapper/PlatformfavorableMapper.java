package com.hand.base.platformfavorable.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.platformfavorable.model.Platformfavorable;

public interface PlatformfavorableMapper extends BasicMapper<Platformfavorable> {

	// 第二个table的数据
	public List<Platformfavorable> queryActivityPage(Platformfavorable record) throws Exception;

	public List<Platformfavorable> queryFullOfGiftsPicklistPage(Platformfavorable record) throws Exception;

	public List<Platformfavorable> queryCouponpicklistPage(Platformfavorable record) throws Exception;
	
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

	public List<Platformfavorable> queryCityPicklistPage(Platformfavorable t) throws Exception;

	public Platformfavorable queryActivityPageById(Platformfavorable entity) throws Exception;

	/**
	 * 平台优惠，同一个城市，某个时间段的活动数
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public int queryActivityCount(Platformfavorable entity) throws Exception;

}
