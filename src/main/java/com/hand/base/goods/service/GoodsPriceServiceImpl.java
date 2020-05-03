package com.hand.base.goods.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.goods.dao.mybatis.mapper.GoodsPriceMapper;
import com.hand.base.goods.model.GoodsPrice;
import com.hand.base.user.model.User;
import com.hand.core.util.UserUtil;

@Service
public class GoodsPriceServiceImpl extends BasicServiceImpl<GoodsPrice> implements GoodsPriceService {

	@Autowired
	private GoodsPriceMapper goodsPriceMapper;
	
	
	@Override
	public BasicMapper<GoodsPrice> getBasicMapper(){
		return goodsPriceMapper;
	}
	
	
	@Override
	@Transactional
	public void insertPic(GoodsPrice entity) throws Exception {
		if(!checkData(entity)){//进行数据校验
			throw new BasicServiceException("校验不通过，请检查数据！");
		}
		User user = UserUtil.getUser(null);
		entity.setCreatedBy(user.getId());
		entity.setLastUpdatedBy(user.getId());
		
		if(entity.getAttr5() != null && !entity.getAttr5().equals("")){
			goodsPriceMapper.insertPic(entity);
		}
	}
	
	public List<GoodsPrice> queryMerchandisePage(GoodsPrice entity) throws Exception{
		return goodsPriceMapper.queryMerchandisePage(entity);
	}
	
	@Override
	public List<GoodsPrice> brandQueryMerchandisePage(GoodsPrice entity) throws Exception {
		return goodsPriceMapper.brandQueryMerchandisePage(entity);
	}
	
	public List<GoodsPrice> queryAccountPage(GoodsPrice entity) throws Exception{
		return goodsPriceMapper.queryAccountPage(entity);
	}
	
	public List<GoodsPrice> queryPosterPicAll(GoodsPrice entity) throws Exception{
		return goodsPriceMapper.queryPosterPicAll(entity);
	}
	
	@Override
	@Transactional
	public void beforUpdate(GoodsPrice entity) throws Exception{
		if(!checkData(entity)){//进行数据校验
			throw new BasicServiceException("校验不通过，请检查数据！");
		}
		User user = UserUtil.getUser(null);
		entity.setCreatedBy(user.getId());
		entity.setLastUpdatedBy(user.getId());
		
		if(entity.getAttr5() != null && !entity.getAttr5().equals("")){
			entity.setPicArray(entity.getAttr5().split(","));
			goodsPriceMapper.insertPic(entity);
		}
		
		if(entity.getAttr6()!=null){
			entity.setDelPicArray(entity.getAttr6().split(","));
			goodsPriceMapper.deletePicById(entity);
		}
	}
	
	@Override
	public int countByCityIdAndName(GoodsPrice entity) throws Exception {
		return goodsPriceMapper.countByCityIdAndName(entity);
	}

}
