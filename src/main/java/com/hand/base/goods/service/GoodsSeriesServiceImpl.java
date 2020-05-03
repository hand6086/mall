package com.hand.base.goods.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.common.model.Image;
import com.hand.base.goods.dao.mybatis.mapper.GoodsSeriesMapper;
import com.hand.base.goods.model.GoodsSeries;

@Service
public class GoodsSeriesServiceImpl extends BasicServiceImpl<GoodsSeries>implements GoodsSeriesService {

	@Autowired
	private GoodsSeriesMapper goodsSeriesMapper;
	
	@Override
	public BasicMapper<GoodsSeries> getBasicMapper(){
		return goodsSeriesMapper;
	}
	
	@Transactional
	public void goodsSeriesImageUpate(GoodsSeries record, List<Image> list) throws BasicServiceException {
		try {
			for (Image img : list) {

				record.setPicId(img.getId());
				goodsSeriesMapper.goodsSeriesImageUpdate(record);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	
	public List<GoodsSeries> queryByPkAll(GoodsSeries entity) throws Exception{
		return goodsSeriesMapper.queryByPkAll(entity);
	}
}
