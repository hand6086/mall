package com.hand.base.common.service;


import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.hand.base.basic.dao.KeyGenerateDao;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.common.dao.mybatis.mapper.ImageMapper;
import com.hand.base.common.dao.mybatis.mapper.MyFileMapper;
import com.hand.base.common.model.Image;
import com.hand.base.common.model.MyFile;
import com.hand.core.util.AppConstants;
import com.hand.core.util.DateUtil;

@Service
public class MyFileServiceImpl extends BasicServiceImpl<MyFile> implements MyFileService{
	
	@Autowired
	private MyFileMapper myFilesMapper;
	
	@Autowired
	private KeyGenerateDao keyGenerateDao;
	
	@Autowired
	private ImageMapper imageMapper;
	
	@Override
	public BasicMapper<MyFile> getBasicMapper(){
		return myFilesMapper;
	}

	@Override
	@Transactional
	public List<Image> imgUpload(List<MultipartFile> myfiles) throws BasicServiceException {
		List<Image> list = new ArrayList<Image>();
		String realativPath = "/" + DateUtil.getYYYYMMDD2();
		String realPath = AppConstants.portalSharePicDir + realativPath;
		try {
			for (MultipartFile myfile : myfiles) {
				String originalName = myfile.getOriginalFilename();
				String newfileName = DateUtil.getYYYYMMDDHHMMSS() + (int) (Math.random() * 100)
						+ originalName.substring(originalName.lastIndexOf('.'));
				try {
					FileUtils.copyInputStreamToFile(myfile.getInputStream(), new File(realPath, newfileName));
				} catch (IOException e) {
					throw new BasicServiceException(e.getMessage());
				}
				Image img = new Image();
				img.setId(keyGenerateDao.keyGenerate());
				img.setUrl(realativPath +"/"+ newfileName);
				img.setCode(originalName.substring(originalName.lastIndexOf('.') + 1));
				img.setDbLastUpdSrc("APP");
				img.setName(newfileName);
				img.setThumbUrl(realativPath + "/" + newfileName);
				imageMapper.imageInsert(img);
				list.add(img);
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	
}
