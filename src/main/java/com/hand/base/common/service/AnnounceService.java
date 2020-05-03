package com.hand.base.common.service;

import java.util.List;

import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.common.model.Announce;
import com.hand.base.orgnization.model.Orgnization;
import com.hand.core.basic.query.QueryParams;

public interface AnnounceService extends BasicService<Announce>{
	
	/**
	 * 首页查询公告信息
	 * @param qps
	 * @return
	 * @throws BasicServiceException
	 */
	public List<Announce> querySimpleAnnounceListSelect() throws BasicServiceException;
	
	/**
	 * 插入公告
	 * @param record
	 * @throws BasicServiceException
	 */
	public void announceInsert(Announce record) throws BasicServiceException;
	
	/**
	 * 发布公告
	 * @param record
	 * @throws BasicServiceException
	 */
	public void publishAnnounceUpdate(Announce record) throws BasicServiceException;
	/**
	 * 公告管理的更新
	 * @param record
	 * @throws BasicServiceException
	 */
	public void announceManageUpdate(Announce record) throws BasicServiceException;
	
	/**
	 * 查询 内部公告
	 * @param qps
	 * @return
	 * @throws BasicServiceException
	 */
	public List<Announce> queryAnneInterPage(QueryParams qps) throws BasicServiceException;
	
	/**
	 * 查询 销售动态 公告
	 * @param qps
	 * @return
	 * @throws BasicServiceException
	 */
	public List<Announce> queryAnneSalesTrendListPage(QueryParams qps) throws BasicServiceException;
	
	/* ******************公告-营销渠道（组织）中间表操作    start   ********************** */
	/**
	 * 已选择的营销渠道
	 * @param qps
	 * @return
	 * @throws BasicServiceException
	 */
	public List<Orgnization> querySelectedOrgListPage(QueryParams qps) throws BasicServiceException;
	
	/**
	 * 未选择的营销渠道
	 * @param qps
	 * @return
	 * @throws BasicServiceException
	 */
	public List<Orgnization> queryUnSelectedOrgListPage(QueryParams qps) throws BasicServiceException;
	
	/**
	 * 新增营销渠道
	 * @param record
	 * @throws BasicServiceException
	 */
	public void orgOfAnnounceInsert(Announce record) throws BasicServiceException;
	
	/**
	 * 删除营销渠道
	 * @param record
	 * @throws BasicServiceException
	 */
	public void orgOfAnnounceDel(Announce record) throws BasicServiceException;
	
	/* ******************公告-营销渠道（组织）中间表操作      end  ********************** */
}
