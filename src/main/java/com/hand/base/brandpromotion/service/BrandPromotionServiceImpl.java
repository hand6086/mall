package com.hand.base.brandpromotion.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.brandpromotion.dao.mybatis.mapper.BrandPromotionMapper;
import com.hand.base.brandpromotion.model.BrandPromotion;
import com.hand.base.promotion.dao.mybatis.mapper.PromotionGoodsMapper;
import com.hand.base.promotion.model.Promotion;

@Service
public class BrandPromotionServiceImpl extends BasicServiceImpl<BrandPromotion> implements BrandPromotionService {

	@Resource
	private BrandPromotionMapper brandPromotionMapper;

	@Resource
	private PromotionGoodsMapper promotionGoodsMapper;

	@Override
	public BasicMapper<BrandPromotion> getBasicMapper() {
		return brandPromotionMapper;
	}

	@Override
	public List<BrandPromotion> queryCityPage(BrandPromotion brandPromotion) throws Exception {
		return brandPromotionMapper.queryCityPage(brandPromotion);
	}

	@Override
	public List<BrandPromotion> queryType(BrandPromotion brandPromotion) throws Exception {
		return brandPromotionMapper.queryType(brandPromotion);
	}

	@Override
	public List<BrandPromotion> querygoods(BrandPromotion brandPromotion) throws Exception {
		return brandPromotionMapper.querygoods(brandPromotion);
	}

	@Override
	@Transactional
	public void beforUpdate(BrandPromotion entity) throws Exception {
		BrandPromotion brandPromotion = new BrandPromotion();
		brandPromotion.setHeadId(entity.getId());
		if (entity.getStartTime() != null && entity.getEndTime() != null) {
			brandPromotion.setMerchStartTime(entity.getStartTime());
			brandPromotion.setMerchEndTime(entity.getEndTime());
			//promotionGoodsMapper.timeUpdate(brandPromotion);
		}
	}

	@Override
	public void batchUpdateStatus(BrandPromotion brandPromotion) throws Exception {
		brandPromotionMapper.batchUpdateStatus(brandPromotion);
	}
}
