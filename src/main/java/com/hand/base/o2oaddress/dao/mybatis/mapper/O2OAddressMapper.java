package com.hand.base.o2oaddress.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.o2oaddress.model.O2OAddress;

public interface O2OAddressMapper extends BasicMapper<O2OAddress> {
	/**
	 * 查询所有
	 * @param qps
	 * @return
	 * @throws Exception
	 */
	public List<O2OAddress> queryByExample(O2OAddress record) throws Exception;
}
