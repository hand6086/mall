package com.hand.base.message.dao.mybatis.mapper;

import com.hand.base.message.model.PushNotice;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;

public interface PushNoticeMapper extends BasicMapper<PushNotice>{

	/**
	 * 
	 *<p>更新通知为已读</p>
	 * @author yrf
	 * @param pushNotice
	 */
	public void updateRead(PushNotice pushNotice);
	
	/**
	 * 
	 *<p>更新所有通知为已读</p>
	 * @author yrf
	 */
	public void updateReadAll(PushNotice pushNotice);
	
	/**
	 * 
	 *<p>更新web端推送状态</p>
	 * @author yrf
	 * @param pushNotice
	 */
	public void updateWebPushStatus(PushNotice pushNotice);
	
	/**
	 * 根据管理员查询待办事项记录
	 * @param qps
	 * @return
	 */
	public List<PushNotice> queryFlowByAdminPage(PushNotice entity) throws Exception;
	
	/**
	 * 根据店铺查询待办事项记录
	 * @param qps
	 * @return
	 */
	public List<PushNotice> queryFlowPage(PushNotice entity) throws Exception;
	
	/**
	 * 根据店铺查询系统通知记录
	 * @param qps
	 * @return
	 */
	public List<PushNotice> queryPushNoticePage(PushNotice entity) throws Exception;
}
