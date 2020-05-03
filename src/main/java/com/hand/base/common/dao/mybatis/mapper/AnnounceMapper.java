package com.hand.base.common.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.common.model.Announce;
import com.hand.base.orgnization.model.Orgnization;
import com.hand.core.basic.query.QueryParams;

public interface AnnounceMapper extends BasicMapper<Announce> {
	
	/**
	 * 首页查询公告信息
	 * @param qps
	 * @return
	 * @throws Exception
	 */
	public List<Announce> querySimpleAnnounceListSelect(QueryParams qps) throws Exception;
	
	/**
	 * 插入公告
	 * @param record
	 * @throws Exception
	 */
	public void announceInsert(Announce record) throws Exception;
	
	/**
	 * 公告管理的更新
	 * @param record
	 * @throws Exception
	 */
	public void announceManageUpdate(Announce record) throws Exception;
	
	/**
	 * 发布公告
	 * @param record
	 * @throws BasicServiceException
	 */
	public void publishAnnounceUpdate(Announce record) throws BasicServiceException;
	
	/**
	 * 查询 内部公告
	 * @param qps
	 * @return
	 * @throws Exception
	 */
	public List<Announce> queryAnneInterPage(QueryParams qps) throws Exception;
	
	/**
	 * 查询 销售动态 公告
	 * @param qps
	 * @return
	 * @throws Exception
	 */
	public List<Announce> queryAnneSalesTrendListPage(QueryParams qps) throws Exception;
	
	/**
	 * 修改公告
	 * @param record
	 * @throws Exception
	 */
	public void announceUpdate(Announce record) throws Exception;
	
	
	/* ******************公告-营销渠道（组织）中间表操作    start   ********************** */
	/**
	 * 已选择的营销渠道
	 * @param qps
	 * @return
	 * @throws Exception
	 */
	public List<Orgnization> querySelectedOrgListPage(QueryParams qps) throws Exception;
	
	/**
	 * 未选择的营销渠道
	 * @param qps
	 * @return
	 * @throws Exception
	 */
	public List<Orgnization> queryUnSelectedOrgListPage(QueryParams qps) throws Exception;
	
	/**
	 * 新增营销渠道
	 * @param record
	 * @throws Exception
	 */
	public void orgOfAnnounceInsert(Announce record) throws Exception;
	
	/**
	 * 删除营销渠道
	 * @param record
	 * @throws Exception
	 */
	public void orgOfAnnounceDel(Announce record) throws Exception;
	
	/* ******************公告-营销渠道（组织）中间表操作      end  ********************** */
}