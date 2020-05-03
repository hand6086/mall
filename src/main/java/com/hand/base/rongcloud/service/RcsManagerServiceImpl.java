package com.hand.base.rongcloud.service;

import com.hand.core.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.rongcloud.dao.mybatis.mapper.RcsManagerMapper;
import com.hand.base.rongcloud.model.RcsManager;
import com.hand.base.rongcloud.model.RcsEmail;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class RcsManagerServiceImpl  extends BasicServiceImpl<RcsManager>implements RcsManagerService{
	@Autowired
	RcsManagerMapper managerMapper;
	
	@Override
	public BasicMapper<RcsManager> getBasicMapper(){
		return managerMapper;
	}

	@Transactional
	public void zcInsert(RcsEmail rcsEmail) throws Exception {
		if(StringUtils.isBlank(rcsEmail.getId())){
			rcsEmail.setId(keyGenerateService.keyGenerate());
		}
		managerMapper.insertZc(rcsEmail);
	}

	/**
	 * 查询消息列表
	 * @param
	 */
	public List<RcsEmail> queryMsgList(RcsEmail entity) throws Exception{
		return managerMapper.queryMsgList(entity);
	}

	/**
	 * 查询最后一条消息
	 * @param
	 */
	public RcsEmail queryLastMsg(RcsEmail entity) throws Exception{
		return managerMapper.queryLastMsg(entity);
	}


	/**
	 * 新建一条消息列表数据
	 * @param
	 */
	@Transactional
	public void insertZcList(RcsEmail rcsEmail) throws Exception{
		if(StringUtils.isBlank(rcsEmail.getId())){
			rcsEmail.setId(keyGenerateService.keyGenerate());
		}
		managerMapper.insertZcList(rcsEmail);
	}

	/**
	 * 修改一条消息列表数据
	 * @param
	 */
	@Transactional
	public void updateZcList(RcsEmail rcsEmail) throws Exception{
		managerMapper.updateZcList(rcsEmail);
	}

	/**
	 * 通过CID修改一条消息列表数据
	 * @param
	 */
	@Transactional
	public void updateZcByCid(RcsEmail rcsEmail) throws Exception{
		managerMapper.updateZcByCid(rcsEmail);
	}
}
