package com.hand.base.charge.service;

import java.util.List;

import com.hand.base.basic.service.BasicService;
import com.hand.base.charge.model.Settlement;

public interface SettlementService extends BasicService<Settlement> {
	
	/**
	 * 查询O2O城市的pickList
	 * @return
	 * @throws Exception
	 */
	public List<Settlement> queryCityPage(Settlement settlement) throws Exception;
	
	/**
	 * 根据头的cityId得到第一个行结构 
	 * @return
	 * @throws Exception
	 */
	public List<Settlement> queryDetailPage(Settlement settlement) throws Exception;
	
	/**
	 * 第二个行结构 
	 * @return
	 * @throws Exception
	 */
	public List<Settlement> querySettlementDetailPage(Settlement settlement) throws Exception;
	
	/**
	 * 第二个行结构更新结算状态
	 * @throws Exception
	 */
	public void updateSubDetail(Settlement settlement) throws Exception;
	
	/**
	 * 第三个行结构 
	 * @return
	 * @throws Exception
	 */
	public List<Settlement> querySettlementSubDetailPage(Settlement settlement) throws Exception;
	
	/**
	 * 第一个行结构的新增记录
	 * @throws Exception
	 */
	public void add(Settlement settlement) throws Exception;
	
	/**
	 * 头结构的新增记录
	 * @throws Exception
	 */
	public void insertCity(Settlement settlement) throws Exception;
	
	/**
	 * 第一个行结构新增后根据id查询
	 * @return
	 * @throws Exception
	 */
	public Settlement queryDetailById(Settlement settlement) throws Exception;
	
	/**
	 * 第一个行结构的删除记录
	 * @return
	 * @throws Exception
	 */
	public void deleteDetailById(Settlement settlement) throws Exception;
	
	/**
	 * 第一个行结构更新记录
	 * @throws Exception
	 */
	public void updateDetail(Settlement settlement) throws Exception;
	
	/**
	 * 第二个行结构的新增后根据id查询
	 * @throws Exception
	 */
	public Settlement querySubDetailById(Settlement settlement) throws Exception;
}
