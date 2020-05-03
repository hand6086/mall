package com.hand.base.common.dao.mybatis.mapper;

import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.common.model.Announce;
import com.hand.base.common.model.Attachment;
import com.hand.base.common.model.InterObject;

public interface InterObjectMapper {
	
	/**
	 * 插入公告附件表
	 * @throws BasicServiceException
	 */
	public void announceAttachInsert(InterObject record) throws Exception;
	
	
	/**
	 * 通过公告Id删除中间表的记录
	 * @param record
	 * @throws Exception
	 */
	public void deleteAnnounceAttachByAnnounceId(Announce record) throws Exception;
	
	/**
	 * 根据附件id删除中间表记录
	 * @param record
	 * @throws Exception
	 */
	public void deleteAnnounceAttachByAttachId(Attachment record) throws Exception;
	
}
