package com.hand.base.goods.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.common.model.Image;
import com.hand.base.goods.dao.mybatis.mapper.GoodsMapper;
import com.hand.base.goods.model.Goods;

@Service
public class GoodsServiceImpl extends BasicServiceImpl<Goods>implements GoodsService {

	@Autowired
	private GoodsMapper goodsMapper;
	
	@Override
	public BasicMapper<Goods> getBasicMapper(){
		return goodsMapper;
	}
	
	

	@Transactional
	public void goodsShareUpdate(Goods record, List<Image> list) throws BasicServiceException {
		try {
			for (Image img : list) {

				record.setPicId(img.getId());
				goodsMapper.goodsShareUpdate(record);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	
	@Override
	public void goodsImageUpdate(Goods record, List<Image> list) throws BasicServiceException {
		try {
			for (Image img : list) {

				record.setPicId(img.getId());
				goodsMapper.goodsImageUpdate(record);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
		
	}
	
	public List<Goods> queryProdCodeByPage(Goods entity) throws Exception{
		return goodsMapper.queryProdCodeByPage(entity);
	}
	
	public Goods queryDetailById(Goods entity) throws Exception{
		checkId(entity);
		return goodsMapper.queryDetailById(entity);
	}
	
	@Override
	public List<Goods> queryUnit(Goods entity) throws Exception {
		return goodsMapper.queryUnit(entity);
	}
	
	@Override
	@Transactional
	public void upsert(Goods entity) throws Exception {
		if(isInsertFlag(entity)){
			goodsMapper.insert(entity);
			goodsMapper.prodIntXInsert(entity);
			goodsMapper.vodInsert(entity);
		}else{
			goodsMapper.update(entity);
			goodsMapper.prodIntXUpdate(entity);
		}
	}

	@Override
	@Transactional
	public void detailUpdate(Goods entity) throws Exception {
		goodsMapper.detailUpdate(entity);
		goodsMapper.unitDetailUpdate(entity);
	}

	@Override
	public void saveAsSuitGoods(Goods entity) throws Exception {
		goodsMapper.unitDetailUpdate(entity);
	}

}
