package com.hand.base.o2oaddress.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.o2oaddress.dao.mybatis.mapper.O2OAddressMapper;
import com.hand.base.o2oaddress.model.O2OAddress;
@Service
public class O2OAddressServiceImpl extends BasicServiceImpl<O2OAddress> implements O2OAddressService{
	@Autowired
	private O2OAddressMapper o2oAddressMapper;
	@Override
	public BasicMapper<O2OAddress> getBasicMapper(){
		return o2oAddressMapper;
	}
	@Override
	public List<O2OAddress> queryByExample(O2OAddress record) throws Exception {
		List<O2OAddress> list = null;
		try {
			list = o2oAddressMapper.queryByExample(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
		return list;
	}
	
}
