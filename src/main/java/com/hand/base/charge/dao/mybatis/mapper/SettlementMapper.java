package com.hand.base.charge.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.charge.model.Settlement;

public interface SettlementMapper extends BasicMapper<Settlement> {
	public List<Settlement> queryCityPage(Settlement settlement) throws Exception;

	public List<Settlement> queryDetailPage(Settlement settlement) throws Exception;

	public List<Settlement> querySettlementDetailPage(Settlement settlement) throws Exception;

	public List<Settlement> querySettlementSubDetailPage(Settlement settlement) throws Exception;

	public void updateSubDetail(Settlement settlement) throws Exception;

	public void add(Settlement settlement) throws Exception;

	public Settlement queryDetailById(Settlement settlement) throws Exception;

	public void deleteDetailById(Settlement settlement) throws Exception;

	public void updateDetail(Settlement settlement) throws Exception;
	
	public Settlement querySubDetailById(Settlement settlement) throws Exception;
	
	public void insertCity(Settlement settlement) throws Exception;
}
