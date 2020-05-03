package com.hand.base.workbench.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.workbench.dao.mybatis.mapper.CamCouponMapper;
import com.hand.base.workbench.model.CamCoupon;

@Service
public class CamCouponServiceImpl extends BasicServiceImpl<CamCoupon>implements CamCouponService {

	@Autowired
	private CamCouponMapper camCouponMapper;
	
	@Override
	public BasicMapper<CamCoupon> getBasicMapper(){
		return camCouponMapper;
	}

	
}
