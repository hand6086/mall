package com.hand.base.platformfavorable.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.platformfavorable.dao.mybatis.mapper.PlatformfavorableMapper;
import com.hand.base.platformfavorable.model.Platformfavorable;
import com.hand.core.util.StringUtils;

@Service
public class PlatformfavorableServiceImpl extends BasicServiceImpl<Platformfavorable>
		implements PlatformfavorableService {
	@Autowired
	private PlatformfavorableMapper platformfavorableMapper;

	public BasicMapper<Platformfavorable> getBasicMapper() throws Exception {
		if (platformfavorableMapper != null) {
			return platformfavorableMapper;
		}
		throw new BasicServiceException("获取Basic Mapper 失败，请确认程序是否正确！");
	}

	@Override
	public List<Platformfavorable> queryActivityPage(Platformfavorable t) throws Exception {

		return platformfavorableMapper.queryActivityPage(t);
	}

	public List<Platformfavorable> queryFullOfGiftsPicklistPage(Platformfavorable t) throws Exception {
		return platformfavorableMapper.queryFullOfGiftsPicklistPage(t);
	}

	@Override
	public List<Platformfavorable> queryCouponpicklistPage(Platformfavorable t) throws Exception {
		// TODO Auto-generated method stub
		return platformfavorableMapper.queryCouponpicklistPage(t);
	}

	@Override
	public void CouponInsert(Platformfavorable entity) throws Exception {
		beforInsert(entity);
		beforUpsert(entity);
		postDefaultValue(entity);// 设置默认值
		BasicModel model = (BasicModel) entity;
		if (StringUtils.isBlank(model.getId())) {
			model.setId(keyGenerateService.keyGenerate());
		}
		if (!checkData(entity)) {// 进行数据校验
			throw new BasicServiceException("校验不通过，请检查数据！");
		}

		platformfavorableMapper.CouponInsert(entity);

	}

	// @Override
	/*
	 * public void insertCity(Platformfavorable entity) throws Exception {
	 * beforInsert(entity); beforUpsert(entity);
	 * postDefaultValue(entity);//设置默认值 BasicModel model = (BasicModel) entity;
	 * if(StringUtils.isBlank(model.getId())){
	 * model.setId(keyGenerateService.keyGenerate()); }
	 * if(!checkData(entity)){//进行数据校验 throw new
	 * BasicServiceException("校验不通过，请检查数据！"); }
	 * 
	 * platformfavorableMapper.insertCity(entity);
	 * 
	 * }
	 */
	@Override
	public void CouponUpdate(Platformfavorable entity) throws Exception {
		beforInsert(entity);
		beforUpsert(entity);
		postDefaultValue(entity);// 设置默认值
		BasicModel model = (BasicModel) entity;
		if (StringUtils.isBlank(model.getId())) {
			model.setId(keyGenerateService.keyGenerate());
		}
		if (!checkData(entity)) {// 进行数据校验
			throw new BasicServiceException("校验不通过，请检查数据！");
		}

		platformfavorableMapper.CouponUpdate(entity);

	}

	@Override
	public void updateCity(Platformfavorable entity) throws Exception {
		beforInsert(entity);
		beforUpsert(entity);
		postDefaultValue(entity);// 设置默认值
		BasicModel model = (BasicModel) entity;
		if (StringUtils.isBlank(model.getId())) {
			model.setId(keyGenerateService.keyGenerate());
		}
		if (!checkData(entity)) {// 进行数据校验
			throw new BasicServiceException("校验不通过，请检查数据！");
		}

		platformfavorableMapper.updateCity(entity);

	}

	@Override
	public List<Platformfavorable> queryCityPicklistPage(Platformfavorable t) throws Exception {
		// TODO Auto-generated method stub
		return platformfavorableMapper.queryCityPicklistPage(t);
	}

	@Override
	public Platformfavorable queryActivityPageById(Platformfavorable entity) throws Exception {
		// TODO Auto-generated method stub
		return platformfavorableMapper.queryActivityPageById(entity);
	}

	@Override
	public int queryActivityCount(Platformfavorable entity) throws Exception {
		return platformfavorableMapper.queryActivityCount(entity);
	}

	@Override
	public List<Platformfavorable> brandQueryCouponpicklistPage(Platformfavorable record) throws Exception {
		return platformfavorableMapper.brandQueryCouponpicklistPage(record);
	}

}
