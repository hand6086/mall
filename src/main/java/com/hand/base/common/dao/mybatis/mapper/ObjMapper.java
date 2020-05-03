package com.hand.base.common.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.common.model.Obj;
import com.hand.base.common.model.ObjItem;
import com.hand.core.basic.query.QueryParams;

public interface ObjMapper {
	
public void objInsert(Obj record) throws Exception;
	
	public void objDelete(Obj record) throws Exception;
	
	public List<Obj> queryObjListPage(QueryParams qps) throws Exception;
	
	public List<ObjItem> queryObjItemListPage(QueryParams qps) throws Exception;
	
	public Obj queryObjByIdSelect(QueryParams qps) throws Exception;
	
	public void objUpdate(Obj records) throws Exception;
	
}