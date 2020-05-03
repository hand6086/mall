package com.hand.base.order.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.order.model.Freight;

public interface FreightMapper extends BasicMapper<Freight> {
	/**
	 * 根据ID记录商品范围,默认分页(若将'pageFlag'设置为'true'，则不分页)
	 * @param qps
	 * @return
	 */
	public List<Freight> queryCsPage(Freight entity) throws Exception;
	/**
	 * 根据ID记录包邮区域,默认分页(若将'pageFlag'设置为'true'，则不分页)
	 * @param qps
	 * @return
	 */
	public List<Freight> queryMaPage(Freight entity) throws Exception;
	/**
	 * 根据ID记录不包邮区域,默认分页(若将'pageFlag'设置为'true'，则不分页)
	 * @param qps
	 * @return
	 */
	public List<Freight> queryNmaPage(Freight entity) throws Exception;
	
	public void insertmailArea(Freight entity) throws Exception;
	
	public void nomailAreaInsert(Freight entity) throws Exception;
	
	public void nomailAreaUpdate(Freight entity) throws Exception;
	
	public void deleteYById(Freight entity) throws Exception;
	
	public void deleteNById(Freight entity) throws Exception;
	
	/**
	 * 快够查询：根据城市ID和模板名称查询数量，同一个城市下不能有相同的模板名
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public int countByCityIdAndName(Freight entity) throws Exception;
	
	
}