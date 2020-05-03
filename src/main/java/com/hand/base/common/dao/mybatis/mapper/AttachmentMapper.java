package com.hand.base.common.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.common.model.Announce;
import com.hand.base.common.model.Attachment;

public interface AttachmentMapper extends BasicMapper<Attachment>{
	
	/**
	 * 查询资源库列表
	 */
	public List<Attachment> queryAttachmentLibraryListPage(Attachment record) throws Exception;
	
	/**
	 * 根据公告id删除附件表
	 * @param record
	 * @throws Exception
	 */
	public void deleteAttachmentByAnnounceId(Announce record) throws Exception;
	
	/**
	 * 根据公告Id查询公告对应附件的列表
	 * @param record
	 * @return
	 * @throws Exception
	 */
	public List<Attachment> queryAttachmentListByAnnounceId(Announce record) throws Exception;
	
	/**
	 * 根据附件Id查询附件隶属的公告信息
	 * @param record
	 * @throws Exception
	 */
	public Announce queryAnnouceByAttachmentId(Attachment record) throws Exception;
}