package com.hand.base.coupon.service;

import java.util.List;

import com.hand.base.basic.service.BasicService;

import com.hand.base.coupon.model.Coupon;



public interface CouponService extends BasicService<Coupon> {
	public  List<Coupon> querycouponinformation(Coupon t)throws Exception;
	
	public List<Coupon> queryConsumerInformationPage(Coupon t)throws Exception;	
	
	/*public 	List<Coupon> querygoodsinformationPage(Coupon t)throws Exception;*/
	
	public  void CouponUpdate(Coupon entity)throws Exception;
	
	public 	void couponinformationInsert(Coupon entity)throws Exception;
	
	public void customerInsert(Coupon entity)throws Exception;
	
	public void customerUpdate(Coupon entity)throws Exception;
	
	/*public void goodsInsert(Coupon entity)throws Exception;
	
	public void goodsUpdate(Coupon entity)throws Exception;*/
	
	public List<Coupon> customerPlistPage(Coupon t)throws Exception;
	
	public Coupon queryCouponById(Coupon entity)throws Exception;
	
	public Coupon queryconsumerById(Coupon entity)throws Exception;

	/*public Coupon querygoodsinformationById(Coupon entity)throws Exception;*/
	
	public void count(Coupon entity)throws Exception;
	
	public int querycouponinformationCount(Coupon entity) throws Exception;

}
