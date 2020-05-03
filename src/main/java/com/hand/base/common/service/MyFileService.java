package com.hand.base.common.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.common.model.Image;
import com.hand.base.common.model.MyFile;

public interface MyFileService extends BasicService<MyFile>{
	
	/**
	 * 上传图片
	 * @param myfiles
	 * @return
	 * @throws BasicServiceException
	 */
	public List<Image> imgUpload(List<MultipartFile> myfiles) throws BasicServiceException;
	
	
}
