package com.hand.base.o2oaccnt.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.o2oaccnt.dao.mybatis.mapper.StoreMapper;
import com.hand.base.o2oaccnt.model.Store;
import com.hand.base.o2oaccnt.model.StoreInfo;

@Service
public class StoreServiceImpl extends BasicServiceImpl<Store> implements StoreService{
	@Autowired
	private StoreMapper storeMapper;
	
	public BasicMapper<Store> getBasicMapper(){
		return storeMapper;
	}
	
	
	@Override
	public List<Store> provincePickListPage(Store record) throws Exception {
		return storeMapper.provincePickListPage(record);
	}

	@Override
	public List<Store> cityPickListPage(Store record) throws Exception {
		return storeMapper.cityPickListPage(record);
	}

	@Override
	public List<Store> districtPickListPage(Store record) throws Exception {
		// TODO Auto-generated method stub
		return storeMapper.districtPickListPage(record);
	}

	//查询入驻商户信息
	@Override
	public List<StoreInfo> queryStoreInfo(StoreInfo record) throws Exception {
		return storeMapper.queryStoreInfo(record);
	}


	@Override
	public Store qureyAccentDetail(Store t) throws Exception {
		// TODO Auto-generated method stub
		return storeMapper.qureyAccentDetail(t);
	}


	@Override
	public List<Store> queryAccntBycode(Store t) throws Exception {
		// TODO Auto-generated method stub
		return storeMapper.queryAccntBycode(t);
	}
	
	/*public List<Store> registerInsert(Store record) throws Exception{
		return storeMapper.registerInsert(record);
	}*/

	@Override
	@Transactional
	public void beforUpdate(Store entity) throws Exception{
		storeMapper.updateinvloc(entity);
	}
}
