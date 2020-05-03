package com.hand.base.o2oaccnt.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.o2oaccnt.model.Address;

public interface AddressMapper extends BasicMapper<Address>{
	
	public List<Address> custmNamePickListPage(Address record) throws Exception;
	
	public List<Address> labelNamePickListAll(Address record) throws Exception;
	
}
