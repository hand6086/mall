package com.hand.base.orgnization.dao.mybatis.mapper;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.orgnization.model.Orgnization;

public interface OrgImportMapper extends BasicMapper<Orgnization> {
	
	/**
	 * 检验组织类型、父组织、是否有效
	 * @throws BasicServiceException
	 */
	public void runOrganizationCheck(CallParam record) throws Exception;
	
	/**
	 * 插入到组织
	 * @throws BasicServiceException
	 */
	public void runNewOrganizationForimp(CallParam record) throws Exception;
    
}