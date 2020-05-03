package com.hand.base.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.order.dao.mybatis.mapper.FreightMapper;
import com.hand.base.order.model.Freight;
import com.hand.base.user.model.User;
import com.hand.core.util.StringUtils;
import com.hand.core.util.UserUtil;

@Service
public class FreightServiceImpl extends BasicServiceImpl<Freight> implements FreightService {
	@Autowired
	private FreightMapper freightMapper;

	@Override
	public BasicMapper<Freight> getBasicMapper() {
		return freightMapper;
	}

	@Override
	public List<Freight> queryCsPage(Freight entity) throws Exception {
		return freightMapper.queryCsPage(entity);
	}
	
	@Override
	public List<Freight> queryMaPage(Freight entity) throws Exception {
		return freightMapper.queryMaPage(entity);
	}
	
	@Override
	public List<Freight> queryNmaPage(Freight entity) throws Exception {
		return freightMapper.queryNmaPage(entity);
	}
	
	@Override
	@Transactional
	public void beforUpsert(Freight entity) throws Exception{
		if(isInsertFlag(entity)){
			if(StringUtils.isBlank(entity.getId())){
				String id = keyGenerateService.keyGenerate();
				entity.setId(id);
				Freight freight = entity;
				freight.setFreightId(entity.getId());
				if(entity.getMailArea() != null && !"".equals(entity.getMailArea())){
					freight.setMailAreaAll(entity.getMailArea().split(","));
				}
				
				User user = UserUtil.getUser(null);
				freight.setCreatedBy(user.getId());
				freight.setLastUpdatedBy(user.getId());
				
				if(freight.getMailArea()!=null){
				freightMapper.insertmailArea(freight);
				}
			}
		}else{
			Freight freight = entity;
			User user = UserUtil.getUser(null);
			freight.setCreatedBy(user.getId());
			freight.setLastUpdatedBy(user.getId());
			freight.setFreightId(entity.getId());
			if(freight.getMailArea()!=null){
				freight.setMailAreaAll(freight.getMailArea().split(","));
				freightMapper.insertmailArea(entity);
			}
			if(freight.getAttr5()!=null){
				freight.setMailAreaAll(entity.getAttr5().split(","));
				freightMapper.deleteYById(freight);
			}
		}
	}
	
	@Transactional
	public void beforBrandUpsert(Freight entity) throws Exception{
		if(isInsertFlag(entity)){
			if(StringUtils.isBlank(entity.getId())){
				String id = keyGenerateService.keyGenerate();
				entity.setId(id);
				Freight freight = entity;
				freight.setFreightId(entity.getId());
				if(entity.getMailArea() != null && !"".equals(entity.getMailArea())){
					freight.setMailAreaAll(entity.getMailArea().split(","));
				}
				
				User user = UserUtil.getUser(null);
				freight.setCreatedBy(user.getId());
				freight.setLastUpdatedBy(user.getId());
				
				if(freight.getMailArea()!=null){
				freightMapper.insertmailArea(freight);
				}
			}
		}else{
			Freight freight = entity;
			User user = UserUtil.getUser(null);
			freight.setCreatedBy(user.getId());
			freight.setLastUpdatedBy(user.getId());
			freight.setFreightId(entity.getId());
			if(freight.getMailArea()!=null){
				freight.setMailAreaAll(freight.getMailArea().split(","));
				freightMapper.insertmailArea(entity);
			}
			if(freight.getAttr5()!=null){
				freight.setMailAreaAll(entity.getAttr5().split(","));
				freightMapper.deleteYById(freight);
			}
		}
	}

	
	@Override
	public int countByCityIdAndName(Freight entity) throws Exception {
		return freightMapper.countByCityIdAndName(entity);
	}

	@Override
	public void nomailAreaUpsert(Freight entity) throws Exception {
		if(!checkData(entity)){//进行数据校验
			throw new BasicServiceException("校验不通过，请检查数据！");
		}
		if(isInsertFlag(entity)){
			entity.setId(keyGenerateService.keyGenerate());
			freightMapper.nomailAreaInsert(entity);
		}else{
			freightMapper.nomailAreaUpdate(entity);
		}
		
	}
	
}