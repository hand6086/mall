package com.hand.base.charge.service;

import java.util.List;

import com.hand.base.basic.service.BasicService;
import com.hand.base.charge.model.PayInfo;

public interface PayInfoService extends BasicService<PayInfo> {
	/**
	 *  订单号picklist
	 * @return
	 */
	public List<PayInfo> queryOrderNumPage(PayInfo payInfo) throws Exception;
}
