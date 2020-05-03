package com.hand.base.basic.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.KeyGenerateDao;

@Service
public class KeyGenerateService {

	@Autowired
	private KeyGenerateDao keyGenerateDao;
	
	public String orderNoGenerate(){
		return keyGenerateDao.orderNoGenerate();
	}
	
	public String keyGenerate()
	{
		return keyGenerateDao.keyGenerate();
	}
	
	public String memCardNoGenerate(){
		return keyGenerateDao.memCardNoGenerate();
	}
	public String keyo2oCode(){
		return keyGenerateDao.keyo2oCode();
	}
	
	
	/**
	 * 生成公司账套编号
	 * @return
	 */
	public String corpIdGenerate(){
		return keyGenerateDao.corpIdGenerate();
	}
	
}
