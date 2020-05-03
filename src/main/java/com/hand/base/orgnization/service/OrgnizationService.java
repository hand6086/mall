package com.hand.base.orgnization.service;

import java.util.List;

import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicService;
import com.hand.base.duty.model.Duty;
import com.hand.base.orgnization.model.Orgnization;

public interface OrgnizationService extends BasicService<Orgnization> {
	
	/**
	 * 查询根组织
	 */
	public Orgnization queryRoot (Orgnization entity) throws Exception;
	
	/**
	 * 查询组织列表表排除主键为Id的组织和其子组织
	 */
	public List<Orgnization> queryListRemoveIdAndChildrenPage(Orgnization entity) throws Exception;
	
	/**
	 * 根据根组织查询组织树
	 */
	public void queryTreeByRoot(Orgnization entity) throws Exception;
	public void queryTreeByRoot1(Orgnization entity) throws Exception;
	
	/**
	 * 根据ID递归删除该记录以及其子对象
	 */
	public void deleteWithChildById(Orgnization entity) throws Exception;
	
	/**
	 * 存储过程更新CX_PT_BU_LV
	 * @param record
	 * @throws Exception
	 */
	public void getRunOrgUpdate(CallParam record) throws Exception;
	
	/**
	 * 查询组织中的所有公司
	 * @param params
	 * @return
	 */
	public List<Orgnization> queryCompanyInOrgnizationSelect(Orgnization entity) throws Exception;
	
	/**
	 * 更新企点部门ID
	 * @param orgId 组织ID
	 * @param qdDeptId 企点部门ID
	 */
	public void qdDeptIdUpdate(String orgId, String qdDeptId) throws Exception;

	
	
}
