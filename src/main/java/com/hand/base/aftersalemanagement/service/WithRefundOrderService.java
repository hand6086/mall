package com.hand.base.aftersalemanagement.service;
import java.util.List;

import com.hand.base.aftersalemanagement.model.WithRefundOrder;
import com.hand.base.basic.service.BasicService;
import com.hand.base.goods.model.GoodsSeries;


public interface WithRefundOrderService extends BasicService<WithRefundOrder> {


	List<WithRefundOrder> queryoOderGoodsPage(WithRefundOrder t)throws Exception;
	
	List<WithRefundOrder> brandQueryoOderGoodsPage(WithRefundOrder t)throws Exception;
	
	/**
	 * 查询字段类型
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public List<WithRefundOrder> queryType(WithRefundOrder entity) throws Exception;
	

}
