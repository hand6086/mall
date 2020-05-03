package com.hand.base.coupon.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.coupon.model.Coupon;


public interface CouponMapper extends BasicMapper<Coupon> {
//第二个table的数据
	public List<Coupon> querycouponinformation(Coupon record)  throws Exception;
	public List<Coupon> queryConsumerInformationPage(Coupon record)throws Exception;
	/*public List<Coupon> querygoodsinformationPage(Coupon record)throws Exception;*/
	public void couponinformationInsert(Coupon entity)throws Exception;
	public void CouponUpdate(Coupon entity)throws Exception;
	/*public void goodsInsert(Coupon entity)throws Exception;
	public void goodsUpdate(Coupon entity)throws Exception;*/
	public void customerInsert(Coupon entity)throws Exception;
	public void customerUpdate(Coupon entity)throws Exception;
	public List<Coupon> customerPlistPage(Coupon record)throws Exception;
	public Coupon queryCouponById(Coupon entity)throws Exception;
	public Coupon queryconsumerById(Coupon entity)throws Exception;
	/*public Coupon querygoodsinformationById(Coupon entity)throws Exception;*/
	public void count(Coupon entity)throws Exception;
	
	
	public int querycouponinformationCount(Coupon entity) throws Exception;
	

}
