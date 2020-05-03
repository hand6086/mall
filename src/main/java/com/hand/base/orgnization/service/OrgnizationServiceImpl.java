package com.hand.base.orgnization.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.dao.mybatis.mapper.BasicCommonMapper;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.model.ListOfValue;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.orgnization.dao.mybatis.mapper.OrgnizationMapper;
import com.hand.base.orgnization.model.Orgnization;
import com.hand.core.basic.query.Filter;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.util.AppConstants;
import com.hand.core.util.StringUtils;
import com.hand.core.util.UserUtil;

@Service
public class OrgnizationServiceImpl extends BasicServiceImpl<Orgnization> implements OrgnizationService{
	
	@Autowired
	private OrgnizationMapper orgnizationMapper;
	
	@Autowired
	private BasicCommonMapper basicCommonMapper;
	
	@Override
	public BasicMapper<Orgnization> getBasicMapper(){
		return orgnizationMapper;
	}
	
	public List<Orgnization> queryListRemoveIdAndChildrenPage(Orgnization entity) throws Exception {
		if(StringUtils.equals(AppConstants.key_applicationDatabase, "mysql")){
			String str = orgnizationMapper.getOrgChildStr(entity);
			entity.setAttr6(str);
		}
		return orgnizationMapper.queryListRemoveIdAndChildrenPage(entity);
	}
	
	public Orgnization queryRoot(Orgnization entity) throws Exception {
		return orgnizationMapper.queryRoot(entity);
	}

	public void queryTreeByRoot(Orgnization entity) throws Exception {
		treeOrgnizationList(entity);
	}
	
	/**
	 * 递归查询组织树结构
	 * @throws BasicServiceException
	 */
	private void treeOrgnizationList(Orgnization entity) throws Exception
	{
		QueryParams params = new QueryParams();
		params.addFilter(new Filter("parentOrgId", entity.getId()));
		params.setPageFlag(false);
		Orgnization t = (Orgnization)BasicModel.transformClass(Orgnization.class, params);
		List<Orgnization> tempList = orgnizationMapper.queryByExamplePage(t);
		for(Orgnization temp : tempList)
		{
			treeOrgnizationList(temp);
		}
		entity.setChildren(tempList);
	}
	
	public void queryTreeByRoot1(Orgnization entity) throws Exception {
		treeOrgnizationList1(entity);
	}
	/**
	 * 递归查询组织树结构
	 * @throws BasicServiceException
	 */
	private void treeOrgnizationList1(Orgnization entity) throws Exception
	{
		ListOfValue record = new ListOfValue();
		record.setType("ORG_TYPE");
		record.setVal(entity.getOrgType());
		record = basicCommonMapper.getLovName(record);
		entity.setOrgType(record.getName());
		
		
		QueryParams params = new QueryParams();
		params.addFilter(new Filter("parentOrgId", entity.getId()));
		params.setPageFlag(false);
		Orgnization t = (Orgnization)BasicModel.transformClass(Orgnization.class, params);
		List<Orgnization> tempList = orgnizationMapper.queryByExamplePage(t);
		for(Orgnization temp : tempList)
		{
			record.setVal(temp.getOrgType());
			record = basicCommonMapper.getLovName(record);
			temp.setOrgType(record.getName());
			treeOrgnizationList1(temp);
		}
		entity.setChildren(tempList);
	}

	@Override
	public void beforUpsert(Orgnization entity) throws Exception {
		super.beforUpsert(entity);
		if(StringUtils.isBlank(entity.getIsEffective())){
			entity.setIsEffective("Y");
		}
	}
	
	@Override
	@Transactional
	public void insert(Orgnization entity) throws BasicServiceException {
		try {
			QueryParams params = new QueryParams();
			Orgnization t = (Orgnization)BasicModel.transformClass(Orgnization.class, params);
			//如果父组织没有指定，则添加默认父组织
			if(StringUtils.isBlank(entity.getParentOrgId())){
				String parentOrgId = orgnizationMapper.queryRoot(t).getId();//获取根组织的ID
				entity.setParentOrgId(parentOrgId);
			}
			super.insert(entity);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	
	@Transactional
	public void deleteWithChildById(Orgnization entity) throws Exception {
		beforDelete(entity);
		checkId(entity);
		QueryParams params = new QueryParams();
		params.setUsercorpid(UserUtil.getUser(null).getUsercorpid());
		params.setPageFlag(false);
		removeWithChilds(entity, params);
	}
	
	/**
	 * 递归删除
	 */
	private void removeWithChilds(Orgnization entity, QueryParams params) throws Exception{
		try {
			deleteById(entity);
			params.addFilter(new Filter("parentOrgId", entity.getId()));
			Orgnization t = (Orgnization)BasicModel.transformClass(Orgnization.class, params);
			List<Orgnization> list = orgnizationMapper.queryByExamplePage(t);
			for(Orgnization orgnization : list){
				this.removeWithChilds(orgnization, params);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e.getMessage());
		}
	}
	
	@Transactional
	public void getRunOrgUpdate(CallParam record) throws BasicServiceException {
		try {
			// 更新组织架构
			orgnizationMapper.getRunOrgUpdate(record);
			if("OK".equals(record.getReturnStatus())){
				// 更新子组织架构
				orgnizationMapper.getRunOrgSubUpdate(record);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	
	public List<Orgnization> queryCompanyInOrgnizationSelect(Orgnization entity) throws BasicServiceException {
		List<Orgnization> list = null;
		try {
			list = orgnizationMapper.queryCompanyInOrgnizationSelect(entity);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
		return list;
	}
	
	@Override
	public void qdDeptIdUpdate(String orgId, String qdDeptId) throws Exception {
		if(StringUtils.isBlank(orgId)){
			throw new Exception("组织ID不能为空");
		}
		Orgnization entity = new Orgnization();
		entity.setId(orgId);
		entity.setQdDeptId(qdDeptId);
		orgnizationMapper.qdDeptIdUpdate(entity);
	}
}

