package com.hand.base.coupon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.coupon.model.Coupon;
import com.hand.core.util.StringUtils;
import com.hand.base.coupon.dao.mybatis.mapper.CouponMapper;

@Service
public class CouponServiceImpl extends BasicServiceImpl<Coupon>implements CouponService {
	@Autowired
	private CouponMapper CouponMapper;
	public BasicMapper<Coupon> getBasicMapper() throws Exception {
		if(CouponMapper != null){
			return CouponMapper;
		}
		throw new BasicServiceException("获取Basic Mapper 失败，请确认程序是否正确！");
	}
	@Override
	public List<Coupon> querycouponinformation(Coupon record)throws Exception {
		beforQueryExample(record);
		beforQueryAllOrExample(record);
		return CouponMapper.querycouponinformation(record);
	}
	@Override
	public List<Coupon> queryConsumerInformationPage(Coupon record) throws Exception {
		beforQueryExample(record);
		beforQueryAllOrExample(record);
		return CouponMapper.queryConsumerInformationPage(record);
	}
	/*@Override
	public List<Coupon> querygoodsinformationPage(Coupon record) throws Exception {
		beforQueryExample(record);
		beforQueryAllOrExample(record);
		return CouponMapper.querygoodsinformationPage(record);
	}*/
	@Override
	public void couponinformationInsert(Coupon entity) throws Exception {
		// TODO Auto-generated method stub
		beforInsert(entity);
		beforUpsert(entity);
		postDefaultValue(entity);//设置默认值
		BasicModel model  = (BasicModel) entity;
		if(StringUtils.isBlank(model.getId())){
			model.setId(keyGenerateService.keyGenerate());
		}
		if(!checkData(entity)){//进行数据校验
			throw new BasicServiceException("校验不通过，请检查数据！");
		}
		
		CouponMapper.couponinformationInsert(entity);
	}
	/*@Override
	public void goodsInsert(Coupon entity) throws Exception {
		// TODO Auto-generated method stub
		CouponMapper.goodsInsert(entity);
	}*/
	@Override
	public void CouponUpdate(Coupon entity) throws Exception {
		// TODO Auto-generated method stub
		CouponMapper.CouponUpdate(entity);
	}
	/*@Override
	public void goodsUpdate(Coupon entity) throws Exception {
		CouponMapper.goodsUpdate(entity);
		
	}*/
	@Override
	public void customerInsert(Coupon entity) throws Exception {
		// TODO Auto-generated method stub
		CouponMapper.customerInsert(entity);
		
	}
	@Override
	public void customerUpdate(Coupon entity) throws Exception {
		// TODO Auto-generated method stub
		CouponMapper.customerUpdate(entity);
	}
	@Override
	public List<Coupon> customerPlistPage(Coupon t) throws Exception {
		// TODO Auto-generated method stub
		return CouponMapper.customerPlistPage(t);
	}
	@Override
	public Coupon queryCouponById(Coupon entity) throws Exception {
		// TODO Auto-generated method stub
		return CouponMapper.queryCouponById(entity);
	}
	@Override
	public Coupon queryconsumerById(Coupon entity) throws Exception {
		// TODO Auto-generated method stub
		return CouponMapper.queryconsumerById(entity);
	}
	/*@Override
	public Coupon querygoodsinformationById(Coupon entity) throws Exception {
		// TODO Auto-generated method stub
		return CouponMapper.querygoodsinformationById(entity);
	}*/

	public void count(Coupon entity)throws Exception{
		CouponMapper.count(entity);
	}
	@Override
	public int querycouponinformationCount(Coupon entity) throws Exception {
		return CouponMapper.querycouponinformationCount(entity);
	}
	

}
