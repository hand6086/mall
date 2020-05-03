package com.hand.base.o2oaccnt.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.coupon.model.Coupon;
import com.hand.base.o2oaccnt.model.Customer;

public interface CustomerMapper extends BasicMapper<Customer> {
	public List<Customer> inviteeQueryPage(Customer record) throws Exception;
	public List<Customer> registerCityPickListPage(Customer record) throws Exception;
	public void orgExtInsert(Customer entity) throws Exception;
	public void orgExtXInsert(Customer entity) throws Exception;
	public int queryCustomerCount(Customer entity) throws Exception;
}
