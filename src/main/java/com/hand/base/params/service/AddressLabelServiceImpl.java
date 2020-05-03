package com.hand.base.params.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.params.dao.mybatis.mapper.AddressLabelMapper;
import com.hand.base.params.model.AddressLabel;

@Service
public class AddressLabelServiceImpl extends BasicServiceImpl<AddressLabel> implements AddressLabelService {
	@Autowired
	private AddressLabelMapper addressLabelMapper;

	@Override
	public BasicMapper<AddressLabel> getBasicMapper() {
		return addressLabelMapper;
	}

}
