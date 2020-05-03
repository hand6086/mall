package com.hand.base.o2oaddress.service;

import java.util.List;

import com.hand.base.basic.service.BasicService;
import com.hand.base.o2oaddress.model.O2OAddress;

public interface O2OAddressService extends BasicService<O2OAddress>{
	/**
	 * 查询所有
	 * @param qps
	 * @return
	 * @throws Exception
	 */
	public List<O2OAddress> queryByExample(O2OAddress record) throws Exception;
}
