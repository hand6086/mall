package com.hand.base.goods.service;

import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.common.model.Image;
import com.hand.base.goods.model.ProductDetail;

import java.util.List;


public interface ProductDetailService extends BasicService<ProductDetail> {


    /**
     * 添加产品明细图片
     * @param list
     * @throws BasicServiceException
     */
    public void picInsert(ProductDetail record, List<Image> list) throws BasicServiceException;

}
