package com.hand.base.promotion.service;

import java.util.List;

import javax.annotation.Resource;

import com.hand.core.util.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.promotion.dao.mybatis.mapper.PromotionGoodsMapper;
import com.hand.base.promotion.dao.mybatis.mapper.PromotionMapper;
import com.hand.base.promotion.model.Promotion;

@Service
public class PromotionServiceImpl extends BasicServiceImpl<Promotion> implements PromotionService {

	@Resource
	private PromotionMapper promotionMapper;

	@Resource
	private PromotionGoodsMapper promotionGoodsMapper;

	@Override
	public BasicMapper<Promotion> getBasicMapper() {
		return promotionMapper;
	}

	@Override
	public List<Promotion> queryCityPage(Promotion promotion) throws Exception {
		return promotionMapper.queryCityPage(promotion);
	}

	@Override
	public List<Promotion> queryType(Promotion promotion) throws Exception {
		return promotionMapper.queryType(promotion);
	}

	public Promotion queryStoreInfoByCode(Promotion promotion) throws Exception{
		return promotionMapper.queryStoreInfoByCode(promotion);
	}
	
	@Override
	public List<Promotion> querygoods(Promotion promotion) throws Exception {
		return promotionMapper.querygoods(promotion);
	}
	
	/**
	 * 根据方案id查询活动记录
	 * @throws Exception
	 */
	public Promotion brandQueryBySchemaId(Promotion promotion) throws Exception{
		return promotionMapper.brandQueryBySchemaId(promotion);
	}
	
	@Override
	@Transactional
	public void beforUpdate(Promotion entity) throws Exception {
		Promotion promotion = new Promotion();
		promotion.setHeadId(entity.getId());
		if (entity.getStartTime() != null && entity.getEndTime() != null) {
			promotion.setMerchStartTime(entity.getStartTime());
			promotion.setMerchEndTime(entity.getEndTime());
			promotionGoodsMapper.timeUpdate(promotion);
		}
		
		if("delete".equals(entity.getAttr1())){
			promotionGoodsMapper.updateStatusByHeadId(promotion);
		}
	}
	
	@Override
	@Transactional
	public void beforBrandUpdate(Promotion entity) throws Exception {
		Promotion promotion = new Promotion();
		promotion.setHeadId(entity.getId());
		if (entity.getStartTime() != null && entity.getEndTime() != null) {
			promotion.setMerchStartTime(entity.getStartTime());
			promotion.setMerchEndTime(entity.getEndTime());
			promotionGoodsMapper.timeUpdate(promotion);
		}
		if("delete".equals(entity.getAttr1())){
			promotionGoodsMapper.updateStatusByHeadId(promotion);
		}
	}

	@Override
	public void batchUpdateStatus(Promotion promotion) throws Exception {
		promotionMapper.batchUpdateStatus(promotion);
	}

	@Override
	public int brandQueryShopPromotionCount(Promotion promotion) throws Exception {
		return promotionMapper.brandQueryShopPromotionCount(promotion);
	}

	@Override
	public Promotion querySchemaTimeBySchemaId(String schemaId) throws Exception {
		return promotionMapper.querySchemaTimeBySchemaId(schemaId);
	}

	@Override
	public void updateHead(Promotion promotion) throws Exception {
		promotionMapper.updateHead(promotion);
	}

	@Override
	public void updateStatusBySchemaId(Promotion promotion) throws Exception {
		promotionMapper.updateStatusBySchemaId(promotion);
		promotionGoodsMapper.updateStatusBySchemaId(promotion);
	}

	@Override
	public void beforBrandInsert(Promotion entity) throws Exception {
		if (StringUtils.isBlank(entity.getifCashDeduction())) {
			if ("Second Kill".equals(entity.getType())) {
				entity.setifCashDeduction("N");
			} else {
				entity.setifCashDeduction("Y");
			}
		}
	}
}
