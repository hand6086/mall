package com.hand.base.o2oaccnt.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.o2oaccnt.dao.mybatis.mapper.CustomerMapper;
import com.hand.base.o2oaccnt.model.Customer;

@Service
public class CustomerServiceImpl extends BasicServiceImpl<Customer> implements CustomerService {
	@Autowired
	private CustomerMapper custmMapper;

	@Override
	public BasicMapper<Customer> getBasicMapper() {
		return custmMapper;
	}

	@Override
	public List<Customer> inviteeQueryPage(Customer record) throws Exception {
		return custmMapper.inviteeQueryPage(record);
	}

	@Override
	public List<Customer> registerCityPickListPage(Customer record) throws Exception {
		// TODO Auto-generated method stub
		return custmMapper.registerCityPickListPage(record);
	}

	public int queryCustomerCount(Customer entity) throws Exception{
		return custmMapper.queryCustomerCount(entity);
	}
}
