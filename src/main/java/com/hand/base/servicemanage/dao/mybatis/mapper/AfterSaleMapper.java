package com.hand.base.servicemanage.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.servicemanage.model.AfterSale;

public interface AfterSaleMapper extends BasicMapper<AfterSale> {
	/**
	 * 查询该记录的所有申请照片的URL
	 * @param qps
	 * @return
	 */
	public List<AfterSale> queryApplyPicAll(AfterSale entity) throws Exception;
	
	/**
	 * 查询该记录的所有退货照片的URL
	 * @param qps
	 * @return
	 */
	public List<AfterSale> queryReturnPicAll(AfterSale entity) throws Exception;
	
}
