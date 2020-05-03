package com.hand.base.o2oaccnt.service;

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
import com.hand.base.basic.model.UploadImgInfo;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.common.dao.mybatis.mapper.ImageMapper;
import com.hand.base.common.model.Image;
import com.hand.base.o2oaccnt.dao.mybatis.mapper.AreaManagerMapper;
import com.hand.base.o2oaccnt.model.AreaManager;
import com.hand.base.user.model.User;
import com.hand.core.util.AppConstants;
import com.hand.core.util.DateUtil;
import com.hand.core.util.ImageUtil;
import com.hand.core.util.UserUtil;

@Service
public class AreaManagerServiceImpl extends BasicServiceImpl<AreaManager> implements AreaManagerService {
	@Autowired
	private AreaManagerMapper areaManaMapper;
	@Autowired
	private KeyGenerateDao keyGenerateDao;

	@Autowired
	private ImageMapper service;

	public BasicMapper<AreaManager> getBasicMapper() {
		return areaManaMapper;
	}

	@Override
	public List<AreaManager> organizationPickListPage(AreaManager record) throws Exception {
		return areaManaMapper.organizationPickListPage(record);
	}
	
	public List<Image> imgUpload(List<MultipartFile> myfiles) throws BasicServiceException {
		List<Image> list = new ArrayList<Image>();
		User user = UserUtil.getUser(null);
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
				img.setId(keyGenerateDao.keyGenerate());
				img.setCode(originalName.substring(originalName.lastIndexOf('.') + 1));
				img.setDbLastUpdSrc("APP");
				img.setName(newfileName);
				img.setUrl(AppConstants.portalSharePicHttpDir+"/"+DateUtil.getYYYYMMDD2()+"/"+newfileName);
				service.imageInsert(img);
				list.add(img);
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	
	@Transactional
	public void areaImageUpate(AreaManager record, List<Image> list) throws BasicServiceException {
		try {
			for (Image img : list) {

				record.setAreaImgId(img.getId());
				areaManaMapper.areaImageUpate(record);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
}
