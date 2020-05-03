package com.hand.base.workbench.service;

import com.hand.base.workbench.model.H5Image;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.common.model.Image;



public interface H5ImageService extends BasicService<H5Image> {
	
    public void h5ImageUpdate(H5Image record, List<Image> list) throws BasicServiceException;
	
}
