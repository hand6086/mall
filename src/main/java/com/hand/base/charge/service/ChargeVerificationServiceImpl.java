package com.hand.base.charge.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.charge.dao.mybatis.mapper.ChargeVerificationMapper;
import com.hand.base.charge.model.ChargeVerification;

@Service
public class ChargeVerificationServiceImpl extends BasicServiceImpl<ChargeVerification> implements ChargeVerificationService {
	@Autowired
	private ChargeVerificationMapper chargeVerificationMapper;

	@Override
	public BasicMapper<ChargeVerification> getBasicMapper() {
		return chargeVerificationMapper;
	}

	@Override
	public List<ChargeVerification> queryChargeDatePage(ChargeVerification chargeVerification) throws Exception {
		return chargeVerificationMapper.queryChargeDatePage(chargeVerification);
	}

	@Override
	public List<ChargeVerification> queryChargeDetailPage(ChargeVerification chargeVerification) throws Exception {
		return chargeVerificationMapper.queryChargeDetailPage(chargeVerification);
	}

	@Override
	public List<ChargeVerification> queryChargeOrderDetailPage(ChargeVerification chargeVerification) throws Exception {
		return chargeVerificationMapper.queryChargeOrderDetailPage(chargeVerification);
	}

	@Override
	public void insertDetail(ChargeVerification chargeVerification) throws Exception {
		chargeVerificationMapper.insertDetail(chargeVerification);
	}

	@Override
	public ChargeVerification queryDetailById(ChargeVerification chargeVerification) throws Exception {
		return chargeVerificationMapper.queryDetailById(chargeVerification);
	}

	@Override
	public void updateDetail(ChargeVerification chargeVerification) throws Exception {
		chargeVerificationMapper.updateDetail(chargeVerification);
	}

	@Override
	public void deleteDetailById(ChargeVerification chargeVerification) throws Exception {
		chargeVerificationMapper.deleteDetailById(chargeVerification);
	}

}
