package com.hand.base.orgnization.service;

import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.orgnization.model.Orgnization;

public interface OrgImportService extends BasicService<Orgnization> {
	
	/**
	 * 检验组织类型、父组织、是否有效
	 * @throws BasicServiceException
	 */
	public void runOrganizationCheck(CallParam record) throws BasicServiceException;
	
	/**
	 * 插入到组织
	 * @throws BasicServiceException
	 */
	public void runNewOrganizationForimp(CallParam record) throws BasicServiceException;
}
