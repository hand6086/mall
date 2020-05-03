package com.hand.base.goods.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.goods.dao.mybatis.mapper.GoodsSuitMapper;
import com.hand.base.goods.model.Goods;
import com.hand.base.goods.model.GoodsSuit;

@Service
public class GoodsSuitServiceImpl extends BasicServiceImpl<GoodsSuit>implements GoodsSuitService {

	@Autowired
	private GoodsSuitMapper goodsSuitMapper;
	
	@Override
	public BasicMapper<GoodsSuit> getBasicMapper(){
		return goodsSuitMapper;
	}
	
	@Override
	@Transactional
	public void upsert(GoodsSuit entity) throws Exception {
		if(isInsertFlag(entity)){
			goodsSuitMapper.insert(entity);
			goodsSuitMapper.prodIntXInsert(entity);
			goodsSuitMapper.vodInsert(entity);
		}else{
			goodsSuitMapper.update(entity);
			goodsSuitMapper.prodIntXUpdate(entity);
		}
	}
	
	public List<GoodsSuit> queryOrderPkAll(GoodsSuit entity) throws Exception{
		return goodsSuitMapper.queryOrderPkAll(entity);
	}
	
	public List<GoodsSuit> queryCustomerPkAll(GoodsSuit entity) throws Exception{
		return goodsSuitMapper.queryCustomerPkAll(entity);
	}

	@Override
	public void saveAsGoods(GoodsSuit entity) throws Exception {
		goodsSuitMapper.prodIntXUpdate(entity);
		
	}
}
