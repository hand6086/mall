package com.hand.base.workbench.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.common.model.Image;
import com.hand.base.workbench.dao.mybatis.mapper.ButtonMapper;
import com.hand.base.workbench.model.Button;

@Service
public class ButtonServiceImpl extends BasicServiceImpl<Button> implements ButtonService {

	@Autowired
	private ButtonMapper buttonMapper;
	
	
	@Override
	public BasicMapper<Button> getBasicMapper(){
		return buttonMapper;
	}
	
	@Transactional
	public void buttonImageUpdate(Button record, List<Image> list) throws BasicServiceException {
		try {
			for (Image img : list) {

				record.setImageId(img.getId());
				buttonMapper.buttonImageUpdate(record);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	@Transactional
	public void cityImageUpdate(Button record, List<Image> list) throws BasicServiceException {
		try {
			for (Image img : list) {

				record.setImageId(img.getId());
				buttonMapper.cityImageUpdate(record);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	
}
