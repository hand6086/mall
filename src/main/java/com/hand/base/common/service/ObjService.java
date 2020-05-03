package com.hand.base.common.service;

import java.util.List;

import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.common.model.Obj;
import com.hand.base.common.model.ObjItem;
import com.hand.core.basic.query.QueryParams;

public interface ObjService {
	
	public void objInsert(Obj record) throws BasicServiceException;
	
	public void objDelete(Obj record) throws BasicServiceException;
	
	public List<Obj> queryObjListPage(QueryParams qps) throws BasicServiceException;
	
	public List<ObjItem> queryObjItemListPage(QueryParams qps) throws BasicServiceException;
	
	public Obj queryObjByIdSelect(QueryParams qps) throws BasicServiceException;
	
	public void objUpdate(Obj record) throws BasicServiceException;
	
}
