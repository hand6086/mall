package com.hand.base.enterprise.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.KeyGenerateDao;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.common.model.Image;
import com.hand.base.duty.dao.mybatis.mapper.DutyMapper;
import com.hand.base.enterprise.dao.mybatis.mapper.EnterpriseMapper;
import com.hand.base.enterprise.model.Enterprise;
import com.hand.base.o2oaccnt.model.UserAudit;
import com.hand.base.user.model.User;
import com.hand.core.basic.query.Filter;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.util.AppConstants;
import com.hand.core.util.StringUtils;
import com.hand.core.util.UserUtil;


@Service
public class EnterpriseServiceImpl  extends BasicServiceImpl<Enterprise>implements EnterpriseService {

	@Resource
	private EnterpriseMapper enterpriseMapper;
	
	@Resource
	private DutyMapper dutyMapper;
	
	@Autowired
	private KeyGenerateDao keyGenerateDao;
	
	@Override
	public BasicMapper<Enterprise> getBasicMapper() {
		return enterpriseMapper;
	}
	
	@Transactional
	public Enterprise enterPriseIn(Enterprise entity) throws BasicServiceException {
		Enterprise newEnterprise = null;
		User user = UserUtil.getUser(null);
		String id =user.getId();
		entity.setUserId(id);
		entity.setCreatedBy(id);
		entity.setLastUpdatedBy(id);
		try {
			newEnterprise = enterpriseMapper.queryById(entity);//如果已经存在用户的资料信息则执行更新操作
			if(null == newEnterprise) {
					entity.setRow_status("NEW");
					String code = keyGenerateDao.corpIdGenerate();
					entity.setCode(code);
					entity.setCorpId(code);
					entity.setId(keyGenerateDao.keyGenerate());
					enterpriseMapper.insertEnterprise(entity);
					enterpriseMapper.updateEmpInfo(entity);//更新emp表的信息
					Enterprise newEntry = enterpriseMapper.queryById(entity);
					CallParam callParam = new CallParam();
					callParam.setParam1(newEntry.getId());
					enterpriseMapper.getEnterPriseRun(callParam);
				
			}else{
				entity.setRow_status("UPDATE");
				// 如果是更新
				enterpriseMapper.update(entity);
				enterpriseMapper.dutyUpdate(entity);
				enterpriseMapper.updateEmpInfo(entity);
			}
			newEnterprise = enterpriseMapper.queryById(entity);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return newEnterprise; 
	}
	
	@Transactional
	public void initializeCompany(CallParam record) throws BasicServiceException {
		try {
			enterpriseMapper.initializeCompany(record);
			System.err.println(record.getReturnStatus());
			System.err.println(record.getMsgData());
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	
	/**
	 * 删除企业
	 * @throws BasicServiceException
	 */
	public void deleteCompany(CallParam record) throws Exception {
		enterpriseMapper.deleteCompany(record);
	}

	@Override
	public Enterprise queryByCode(String code) throws Exception {
		Enterprise queryEp = new Enterprise();
		queryEp.setCode(code);
		queryEp.setPageFlag(false);
		List<Enterprise> list = queryByExamplePage(queryEp);
		if(list.size() == 0){
			throw new Exception("找不到对应的企业信息");
		}
		else if(list.size() > 1){
			throw new Exception("找到多个企业信息");
		}
		Enterprise enterprise = list.get(0);
		return enterprise;
	}
	
	
	public void qrCodeImageUpate(Enterprise record, List<Image> list) throws BasicServiceException{
		try {
			for (Image img : list) {
				enterpriseMapper.qrCodeImageUpdate(record);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	
	public void qidianAuthUpdate(Enterprise record) throws Exception{
		
		enterpriseMapper.qidianAuthUpdate(record);
	}
	
	public void authAccessTokenUpdate(Enterprise record) throws Exception{
		enterpriseMapper.authAccessTokenUpdate(record);
	}
	
	public List<Enterprise> queryQidianEnt() throws Exception{
		return enterpriseMapper.queryQidianEnt(new Enterprise());
	}
	
	public List<Enterprise> queryByAuthAppidPage(String authAppid) throws Exception{
		QueryParams qps = new QueryParams();
		qps.setPageFlag(false);
		qps.addFilter(new Filter("authAppid", authAppid));
		Enterprise t = (Enterprise)BasicModel.transformClass(Enterprise.class, qps);
		List<Enterprise> list = enterpriseMapper.queryByExamplePage(t);
		return list;
	}
	
	public String queryQiDianToken() throws Exception {
		User user = UserUtil.getUser(null);
		Enterprise enterprise = queryByCode(user.getCorpid());
		return "";
	}


	public void dutyInsert(Enterprise entity) throws Exception {
		enterpriseMapper.dutyInsert(entity);
	}

	@Override
	public void dutyUpdate(Enterprise entity) throws Exception {
		enterpriseMapper.dutyUpdate(entity);
	}

	@Override
	public void defaultMenuInsert(Enterprise entity) throws Exception {
		enterpriseMapper.defaultMenuInsert(entity);
	}

	@Transactional
	public void userAuditImageUpate(UserAudit record, List<Image> list) throws BasicServiceException {
		try {
			for (Image img : list) {

				record.setcLegalPersonIDNum(img.getId());
				enterpriseMapper.userAuditImageUpate(record);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	@Override
	public void storeStatusPassUpdate(Enterprise record) throws Exception {
		enterpriseMapper.storeStatusPassUpdate(record);
		
	}
	
	@Override
	public void storeStatuspassedNopaidUpdate(Enterprise record) throws Exception{
		enterpriseMapper.storeStatuspassedNopaidUpdate(record);
		
	}

	@Override
	public void storeStatusPayUpdate(Enterprise record) throws Exception {
		if(StringUtils.equals(record.getStoreStatus(), "PASSED_NOPAID")) {
			enterpriseMapper.storeStatusPayUpdate(record);
		}
	}

	@Override
	public Enterprise queryByUserId(Enterprise entity) throws Exception {
		User user=UserUtil.getUser(null);
		entity.setUserId(user.getId());
		entity =enterpriseMapper.queryByUserId(entity);
		return entity;
	}
	
	@Override
	public Enterprise queryByEntpID(Enterprise entity) throws Exception {
		return enterpriseMapper.queryByEntpID(entity);
	}

	@Override
	public void storeStatusRejectUpdate(Enterprise record) throws Exception {
		enterpriseMapper.storeStatusRejectUpdate(record);
	}

	@Override
	public List<Enterprise> queryDepositDetailsPage(Enterprise entity) throws Exception {
		
		return enterpriseMapper.queryDepositDetailsPage(entity);
	}

	@Transactional
	public void depositDetailsInsert(Enterprise record) throws Exception {
		record.setId(keyGenerateDao.keyGenerate());
		enterpriseMapper.depositDetailsInsert(record);
		//同步头押金信息
		enterpriseMapper.depositUpdate(record);
	}

	@Override
	public List<Enterprise> queryCustomerServicePage(Enterprise entity) throws Exception {
		return enterpriseMapper.queryCustomerServicePage(entity);
	}

	@Override
	public void customerServiceInsert(Enterprise record) throws Exception {
		record.setId(keyGenerateDao.keyGenerate());
		enterpriseMapper.customerServiceInsert(record);
		
	}

	@Override
	public void approvalOpinionUpdate(Enterprise record) throws Exception {
		enterpriseMapper.approvalOpinionUpdate(record);
	}

	@Override
	public void transferCodeUpdate(Enterprise record) throws Exception {
		enterpriseMapper.transferCodeUpdate(record);
		
	}
	
	@Override
	public List<Enterprise> queryShopKeeperPage(Enterprise entity) throws Exception {
		return enterpriseMapper.queryShopKeeperPage(entity);
	}

	@Override
	@Transactional
	public void shopKeeperInsert(Enterprise record,User user) throws Exception {
		String id = keyGenerateDao.keyGenerate();
		record.setId(id);
		enterpriseMapper.shopKeeperInsert(record);
		//插入职责用户中间表
		user.setId(id);
		dutyMapper.addUserOfDutyInsert(user);
	}	
}
