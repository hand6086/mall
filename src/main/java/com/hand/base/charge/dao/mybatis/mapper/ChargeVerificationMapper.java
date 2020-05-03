package com.hand.base.charge.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.charge.model.ChargeVerification;

public interface ChargeVerificationMapper extends BasicMapper<ChargeVerification> {
	
	public List<ChargeVerification> queryChargeDatePage(ChargeVerification chargeVerification) throws Exception;

	public List<ChargeVerification> queryChargeDetailPage(ChargeVerification chargeVerification) throws Exception;

	public List<ChargeVerification> queryChargeOrderDetailPage(ChargeVerification chargeVerification) throws Exception;

	public void insertDetail(ChargeVerification chargeVerification) throws Exception;
	
	public ChargeVerification queryDetailById(ChargeVerification chargeVerification) throws Exception;
	
	public void updateDetail(ChargeVerification chargeVerification) throws Exception;
	
	public void deleteDetailById(ChargeVerification chargeVerification) throws Exception;
}
