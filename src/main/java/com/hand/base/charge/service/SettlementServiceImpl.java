package com.hand.base.charge.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.charge.dao.mybatis.mapper.SettlementMapper;
import com.hand.base.charge.model.Settlement;

@Service
public class SettlementServiceImpl extends BasicServiceImpl<Settlement> implements SettlementService {
	@Autowired
	private SettlementMapper settlementMapper;

	@Override
	public BasicMapper<Settlement> getBasicMapper() {
		return settlementMapper;
	}

	@Override
	public List<Settlement> queryCityPage(Settlement settlement) throws Exception {
		return settlementMapper.queryCityPage(settlement);
	}

	@Override
	public List<Settlement> queryDetailPage(Settlement settlement) throws Exception {
		return settlementMapper.queryDetailPage(settlement);
	}

	@Override
	public List<Settlement> querySettlementDetailPage(Settlement settlement) throws Exception {
		return settlementMapper.querySettlementDetailPage(settlement);
	}

	@Override
	public List<Settlement> querySettlementSubDetailPage(Settlement settlement) throws Exception {
		return settlementMapper.querySettlementSubDetailPage(settlement);
	}

	@Override
	public void updateSubDetail(Settlement settlement) throws Exception {
		 settlementMapper.updateSubDetail(settlement);
	}

	@Override
	public void add(Settlement settlement) throws Exception {
		settlementMapper.add(settlement);
	}

	@Override
	public Settlement queryDetailById(Settlement settlement) throws Exception {
		return settlementMapper.queryDetailById(settlement);
	}

	@Override
	public void deleteDetailById(Settlement settlement) throws Exception {
		settlementMapper.deleteDetailById(settlement);
	}

	@Override
	public void updateDetail(Settlement settlement) throws Exception {
		settlementMapper.updateDetail(settlement);
	}

	@Override
	public Settlement querySubDetailById(Settlement settlement) throws Exception {
		return settlementMapper.querySubDetailById(settlement);
	}

	@Override
	public void insertCity(Settlement settlement) throws Exception {
		settlementMapper.insertCity(settlement);
	}

}
