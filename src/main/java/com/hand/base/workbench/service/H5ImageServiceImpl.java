package com.hand.base.workbench.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.common.model.Image;
import com.hand.base.workbench.dao.mybatis.mapper.H5ImageMapper;
import com.hand.base.workbench.model.H5Image;

@Service
public class H5ImageServiceImpl extends BasicServiceImpl<H5Image>implements H5ImageService {

	@Autowired
	private H5ImageMapper h5ImageMapper;
	
	@Override
	public BasicMapper<H5Image> getBasicMapper(){
		return h5ImageMapper;
	}
	
	@Transactional
	public void h5ImageUpdate(H5Image record, List<Image> list) throws BasicServiceException {
		try {
			for (Image img : list) {

				record.setImgId(img.getId());
				h5ImageMapper.h5ImageUpdate(record);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}

}
