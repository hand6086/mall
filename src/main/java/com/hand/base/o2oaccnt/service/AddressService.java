package com.hand.base.o2oaccnt.service;

import java.util.List;

import com.hand.base.basic.service.BasicService;
import com.hand.base.o2oaccnt.model.Address;

public interface AddressService extends BasicService<Address>{
	
	public List<Address> custmNamePickListPage(Address record) throws Exception;
	
	public List<Address> labelNamePickListAll(Address record) throws Exception;

}
