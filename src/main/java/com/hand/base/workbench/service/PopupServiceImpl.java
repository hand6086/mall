package com.hand.base.workbench.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.common.model.Image;
import com.hand.base.workbench.dao.mybatis.mapper.PopupMapper;
import com.hand.base.workbench.model.Popup;

@Service
public class PopupServiceImpl extends BasicServiceImpl<Popup>implements PopupService {

	@Autowired
	private PopupMapper popupMapper;
	
	@Override
	public BasicMapper<Popup> getBasicMapper(){
		return popupMapper;
	}
	
	@Transactional
	public void popupImageUpdate(Popup record, List<Image> list) throws BasicServiceException {
		try {
			for (Image img : list) {

				record.setImageId(img.getId());
				popupMapper.popupImageUpdate(record);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	
	
}
