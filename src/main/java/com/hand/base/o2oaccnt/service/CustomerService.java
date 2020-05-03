package com.hand.base.o2oaccnt.service;

import java.util.List;

import com.hand.base.basic.service.BasicService;
import com.hand.base.o2oaccnt.model.Customer;

public interface CustomerService extends BasicService<Customer> {
	public List<Customer> inviteeQueryPage(Customer record) throws Exception;
	public List<Customer> registerCityPickListPage(Customer record) throws Exception;
	public int queryCustomerCount(Customer entity) throws Exception;
}
