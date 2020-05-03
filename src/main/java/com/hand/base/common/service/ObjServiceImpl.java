package com.hand.base.common.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.common.dao.mybatis.mapper.ObjMapper;
import com.hand.base.common.model.Obj;
import com.hand.base.common.model.ObjItem;
import com.hand.core.basic.query.QueryParams;

@Service
@Transactional
public class ObjServiceImpl implements ObjService{
	
	@Autowired
	private ObjMapper objMapper;

	public void objInsert(Obj record) throws BasicServiceException {

		try {
			objMapper.objInsert(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}

	public void objDelete(Obj record) throws BasicServiceException {
		try {
			objMapper.objDelete(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
		
	}

	public List<Obj> queryObjListPage(QueryParams qps) throws BasicServiceException {
		List<Obj> list = null;
		try {
			list = objMapper.queryObjListPage(qps);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
		return list;
	}

	public Obj queryObjByIdSelect(QueryParams qps) throws BasicServiceException {
		Obj obj = null;
		try {
			obj = objMapper.queryObjByIdSelect(qps);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
		return obj;
	}

	public void objUpdate(Obj record) throws BasicServiceException {
		try {
			objMapper.objUpdate(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}

	
	public List<ObjItem> queryObjItemListPage(QueryParams qps) throws BasicServiceException {
		List<ObjItem> list = null;
		try {
			list = objMapper.queryObjItemListPage(qps);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
		return list;
	}

	
}
