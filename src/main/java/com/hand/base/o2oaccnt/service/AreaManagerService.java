package com.hand.base.o2oaccnt.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.common.model.Image;
import com.hand.base.o2oaccnt.model.AreaManager;
import com.hand.core.basic.query.QueryParams;

public interface AreaManagerService extends BasicService<AreaManager> {
	
	public List<AreaManager> organizationPickListPage(AreaManager record) throws Exception;
	/**
	 * 上传产品图片
	 * @param myfiles
	 * @throws BasicServiceException
	 */
	public List<Image> imgUpload(List<MultipartFile> myfiles) throws BasicServiceException;
	/**
	 * 添加行政区域图片
	 * @param list
	 * @throws BasicServiceException
	 */
	public void areaImageUpate(AreaManager record, List<Image> list) throws BasicServiceException;
	
}
