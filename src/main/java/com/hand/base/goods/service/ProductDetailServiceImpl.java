package com.hand.base.goods.service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.common.model.Image;
import com.hand.base.goods.dao.mybatis.mapper.ProductDetailMapper;
import com.hand.base.goods.model.ProductDetail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ProductDetailServiceImpl extends BasicServiceImpl<ProductDetail>implements ProductDetailService {

	@Autowired
	private ProductDetailMapper productDetailMapper;

	@Autowired
	private KeyGenerateService keyGenerateService;
	
	@Override
	public BasicMapper<ProductDetail> getBasicMapper(){
		return productDetailMapper;
	}


	@Transactional
	public void picInsert(ProductDetail record, List<Image> list) throws BasicServiceException {
		try {
			for (Image img : list) {
				String rowId = keyGenerateService.keyGenerate();
				record.setId(rowId);
				record.setProductPicId(img.getId());
				productDetailMapper.insert(record);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}

}
