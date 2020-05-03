package com.hand.base.common.service;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.common.dao.mybatis.mapper.AnnounceMapper;
import com.hand.base.common.dao.mybatis.mapper.AttachmentMapper;
import com.hand.base.common.dao.mybatis.mapper.InterObjectMapper;
import com.hand.base.common.model.Announce;
import com.hand.base.common.model.Attachment;
import com.hand.base.orgnization.model.Orgnization;
import com.hand.core.basic.query.QueryParams;

@Service
public class AnnounceServiceImpl extends BasicServiceImpl<Announce> implements AnnounceService{
	
	@Autowired
	private AnnounceMapper announceMapper;
	
	@Autowired
	private AttachmentMapper attachmentMapper;
	
	@Autowired
	private InterObjectMapper interObjectMapper;
	
	@Override
	public BasicMapper<Announce> getBasicMapper(){
		return announceMapper;
	}
	
	public List<Announce> queryAnneInterPage(QueryParams qps) throws BasicServiceException{
		
		List<Announce> list = null;
		try {
			list = announceMapper.queryAnneInterPage(qps);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
		return list;
	}
	
	public List<Announce> queryAnneSalesTrendListPage(QueryParams qps) throws BasicServiceException{
		
		List<Announce> list = null;
		try {
			list = announceMapper.queryAnneSalesTrendListPage(qps);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
		return list;
	}


	public void announceInsert(Announce record) throws BasicServiceException {
		try {
			announceMapper.announceInsert(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	
	public void announceManageUpdate(Announce record) throws BasicServiceException {
		try {
			announceMapper.announceManageUpdate(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	
	public void announceUpdate(Announce record) throws BasicServiceException{
		try{
			announceMapper.announceUpdate(record);
		}catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
		
	}
	
	@Override
	@Transactional
	public void deleteById(Announce record) throws BasicServiceException{
		try{
			List<Attachment> list = attachmentMapper.queryAttachmentListByAnnounceId(record);
			attachmentMapper.deleteAttachmentByAnnounceId(record);
			interObjectMapper.deleteAnnounceAttachByAnnounceId(record);
			announceMapper.deleteById(record);
			for(Attachment attachment : list)    //删除附件
			{
				String fileUrl = attachment.getAttachmentRelativePath();//获取服务器路径
				File file = new File(fileUrl);
				if(file.exists() && file.isFile())
				{
					file.delete();
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}

	public List<Announce> querySimpleAnnounceListSelect() throws BasicServiceException {
		List<Announce> list = null;
		try{
			list = announceMapper.querySimpleAnnounceListSelect(new QueryParams());
		}catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
		return list;
	}
	
	public List<Orgnization> querySelectedOrgListPage(QueryParams qps) throws BasicServiceException {
		List<Orgnization> list = null;
		try{
			list = announceMapper.querySelectedOrgListPage(qps);
		}catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
		return list;
	}
	
	public List<Orgnization> queryUnSelectedOrgListPage(QueryParams qps) throws BasicServiceException {
		List<Orgnization> list = null;
		try{
			list = announceMapper.queryUnSelectedOrgListPage(qps);
		}catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
		return list;
	}
	
	public void orgOfAnnounceInsert(Announce record) throws BasicServiceException {
		try {
			announceMapper.orgOfAnnounceInsert(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	
	public void orgOfAnnounceDel(Announce record) throws BasicServiceException {
		try {
			announceMapper.orgOfAnnounceDel(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}

	@Override
	public void publishAnnounceUpdate(Announce record) throws BasicServiceException {
		// TODO Auto-generated method stub
		announceMapper.publishAnnounceUpdate(record);
	}
}
