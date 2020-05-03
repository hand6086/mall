package com.hand.base.o2oaccnt.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.o2oaccnt.model.Store;
import com.hand.base.o2oaccnt.model.StoreInfo;

public interface StoreMapper extends BasicMapper<Store> {
	public List<Store> provincePickListPage(Store record) throws Exception;
	public List<Store> cityPickListPage(Store record) throws Exception;
	public List<Store> districtPickListPage(Store record) throws Exception;
	//public List<Store> registerInsert(Store record) throws Exception;
	public List<StoreInfo> queryStoreInfo(StoreInfo record)throws Exception;
	public Store qureyAccentDetail(Store t)throws Exception;
	public List<Store> queryAccntBycode(Store t)throws Exception;
	public void updateinvloc(Store entity) throws Exception;
}
