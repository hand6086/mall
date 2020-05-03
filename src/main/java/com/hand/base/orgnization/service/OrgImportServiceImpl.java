package com.hand.base.orgnization.service;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.orgnization.dao.mybatis.mapper.OrgImportMapper;
import com.hand.base.orgnization.dao.mybatis.mapper.OrgnizationMapper;
import com.hand.base.orgnization.model.Orgnization;
import com.hand.base.user.model.User;
import com.hand.core.util.StringUtils;
import com.hand.core.util.UserUtil;

@Service
public class OrgImportServiceImpl extends BasicServiceImpl<Orgnization> implements OrgImportService{
	
	@Autowired
	private OrgImportMapper orgImportMapper;
	
	@Autowired
	private OrgnizationMapper organizationMapper;
	
	@Resource
	private KeyGenerateService keyGenerateService;
	
	@Override
	public BasicMapper<Orgnization> getBasicMapper(){
		return orgImportMapper;
	}
	
	@Override
	@Transactional
	public void insert(Orgnization record) throws BasicServiceException {
		String orgid = null;
		boolean flag =false;
		try {
			orgid = keyGenerateService.keyGenerate();
			record.setId(orgid);
			if(StringUtils.isNull(record.getParentOrgName()) ){
				flag = true;
			}
			//如果父组织没有指定，则添加默认父组织
			if(flag){
				Orgnization org = organizationMapper.queryRoot(record);//获取根组织
				record.setParentOrgName(org.getText());
			}
			orgImportMapper.insert(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}

	@Transactional
	public void runOrganizationCheck(CallParam record) throws BasicServiceException {
		try {
			User user = UserUtil.getUser(null);
			record.setParam1(user.getId());
			orgImportMapper.runOrganizationCheck(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	
	@Transactional
	public void runNewOrganizationForimp(CallParam record) throws BasicServiceException {
		try {
			User user = UserUtil.getUser(null);
			record.setParam1(user.getId());
			orgImportMapper.runOrganizationCheck(record);
			orgImportMapper.runNewOrganizationForimp(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
}
