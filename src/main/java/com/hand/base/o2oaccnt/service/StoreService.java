package com.hand.base.o2oaccnt.service;

import java.util.List;
import java.util.Map;

import com.hand.base.basic.service.BasicService;
import com.hand.base.o2oaccnt.model.Store;
import com.hand.base.o2oaccnt.model.StoreInfo;

public interface StoreService extends BasicService<Store>{
	public List<Store> provincePickListPage(Store record) throws Exception;
	public List<Store> cityPickListPage(Store record) throws Exception;
	public List<Store> districtPickListPage(Store record) throws Exception;
	//商户注册
	//public List<Store> registerInsert(Store record) throws Exception;
	//查询注册商户信息
	public List<StoreInfo> queryStoreInfo(StoreInfo record)throws Exception;
	public Store qureyAccentDetail(Store t)throws Exception;
	public List<Store> queryAccntBycode(Store t)throws Exception;
}
