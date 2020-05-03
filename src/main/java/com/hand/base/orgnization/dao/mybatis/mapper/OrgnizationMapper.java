package com.hand.base.orgnization.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.CallParam;
import com.hand.base.orgnization.model.Orgnization;

public interface OrgnizationMapper extends BasicMapper<Orgnization> {
	
	/**
	 * 查询根组织
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Orgnization queryRoot(Orgnization entity) throws Exception;
	
	/**
	 * 查询组织列表表排除主键为Id的组织和其子组织，只取有效的信息
	 * @param params
	 * @return
	 */
	public List<Orgnization> queryListRemoveIdAndChildrenPage(Orgnization entity) throws Exception;
	
	/**
	 * 存储过程更新RUN_ORG_UPDATE
	 * @param record
	 * @throws Exception
	 */
	public void getRunOrgUpdate(CallParam record) throws Exception;
	
	/**
	 * 存储过程更新RUN_ORG_SUB_UPDATE
	 * @param record
	 * @throws Exception
	 */
	public void getRunOrgSubUpdate(CallParam record) throws Exception;
	
	/**
	 * 查询组织中的所有公司
	 * @param params
	 * @return
	 */
	public List<Orgnization> queryCompanyInOrgnizationSelect(Orgnization entity) throws Exception;

	public String getOrgChildStr(Orgnization entity) throws Exception;
	
	/**
	 * 更新企点部门ID
	 * @param entity
	 */
	public void qdDeptIdUpdate(Orgnization entity) throws Exception;

	
}