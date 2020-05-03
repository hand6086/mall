package com.hand.base.charge.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.charge.model.PayInfo;

public interface PayInfoMapper extends BasicMapper<PayInfo> {
	public List<PayInfo> queryOrderNumPage(PayInfo payInfo) throws Exception;
}
