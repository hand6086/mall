package com.hand.base.aftersalemanagement.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.aftersalemanagement.model.WithRefundOrder;
import com.hand.base.basic.dao.mapper.BasicMapper;




public interface WithRefundOrderMapper extends BasicMapper<WithRefundOrder> {
	
		/**
		 * 第二个table的数据
		 * @param record
		 * @return
		 * @throws Exception
		 */
		public List<WithRefundOrder> queryoOderGoodsPage(WithRefundOrder record)  throws Exception;
		/**
		 * 品牌馆第二个table的数据
		 * @param record
		 * @return
		 * @throws Exception
		 */
		public List<WithRefundOrder> brandQueryoOderGoodsPage(WithRefundOrder record)  throws Exception;

		/**
		 * 查询字段类型
		 * @param entity
		 * @return
		 * @throws Exception
		 */
		public List<WithRefundOrder> queryType(WithRefundOrder entity) throws Exception;
		

	}
