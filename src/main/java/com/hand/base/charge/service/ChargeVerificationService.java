package com.hand.base.charge.service;

import java.util.List;

import com.hand.base.basic.service.BasicService;
import com.hand.base.charge.model.ChargeVerification;

public interface ChargeVerificationService extends BasicService<ChargeVerification> {
	
	/**
	 * 查询第一个行结构
	 * @return
	 * @throws Exception
	 */
	public List<ChargeVerification> queryChargeDatePage(ChargeVerification chargeVerification) throws Exception;

	/**
	 * 查询第二个行结构
	 * @return
	 * @throws Exception
	 */
	public List<ChargeVerification> queryChargeDetailPage(ChargeVerification chargeVerification) throws Exception;

	/**
	 * 查询第三个行结构
	 * @return
	 * @throws Exception
	 */
	public List<ChargeVerification> queryChargeOrderDetailPage(ChargeVerification chargeVerification) throws Exception;

	/**
	 * 第一个行结构的新增记录
	 * @return
	 * @throws Exception
	 */
	public void insertDetail(ChargeVerification chargeVerification) throws Exception;

	/**
	 * 第一个行结构更新记录
	 * @return
	 * @throws Exception
	 */
	public void updateDetail(ChargeVerification chargeVerification) throws Exception;

	/**
	 * 第一个行结构的根据id查询
	 * @throws Exception
	 */
	public ChargeVerification queryDetailById(ChargeVerification chargeVerification) throws Exception;
	
	/**
	 * 第一个行结构的根据id删除
	 * @throws Exception
	 */
	public void deleteDetailById(ChargeVerification chargeVerification) throws Exception;

}
