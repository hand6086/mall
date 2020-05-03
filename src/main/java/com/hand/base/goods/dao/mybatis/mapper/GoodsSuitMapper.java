package com.hand.base.goods.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.goods.model.GoodsSuit;

public interface GoodsSuitMapper extends BasicMapper<GoodsSuit>{
	
	public void prodIntXInsert(GoodsSuit entity) throws Exception;
	
    public void vodInsert(GoodsSuit entity) throws Exception;
	
	public void prodIntXUpdate(GoodsSuit entity) throws Exception;
	
	public List<GoodsSuit> queryOrderPkAll(GoodsSuit entity) throws Exception;
	
	public List<GoodsSuit> queryCustomerPkAll(GoodsSuit entity) throws Exception;
}