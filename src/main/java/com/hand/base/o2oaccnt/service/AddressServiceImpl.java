package com.hand.base.o2oaccnt.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.o2oaccnt.dao.mybatis.mapper.AddressMapper;
import com.hand.base.o2oaccnt.model.Address;

@Service
public class AddressServiceImpl extends BasicServiceImpl<Address> implements AddressService {
	@Autowired
	private AddressMapper addressMapper;
	@Override
	public BasicMapper<Address> getBasicMapper(){
		return addressMapper;
	}
	@Override
	public List<Address> custmNamePickListPage(Address record) throws Exception {
		// TODO Auto-generated method stub
		return addressMapper.custmNamePickListPage(record);
	}
	
	@Override
	public List<Address> labelNamePickListAll(Address record) throws Exception {
		// TODO Auto-generated method stub
		return addressMapper.labelNamePickListAll(record);
	}
}
