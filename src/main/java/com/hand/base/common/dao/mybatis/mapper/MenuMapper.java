package com.hand.base.common.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.common.model.Menu;
import com.hand.core.basic.query.QueryParams;

public interface MenuMapper extends BasicMapper<Menu>{
	
	/**
	 * 根据菜单类型查询菜单列表
	 * @param qps
	 * @return
	 * @throws Exception
	 */
	public List<Menu> queryMenuListByTypeSelect(Menu record) throws Exception;
	
	/**
	 * 查询权限菜单子项列表
	 */
	public List<Menu> querySubItemListByDutyItemIdSelect(Menu record) throws Exception;
	
	public Menu queryByMenuType(String menuType) throws Exception;
	
	/**
	 * 查询一级菜单
	 * @param userId 用户ID
	 */
	public List<Menu> queryFstMenuList(String userId) throws Exception;
	
	/**
	 * 根据用户ID查询职责内DMS的菜单
	 * @param userId 用户ID
	 */
	public List<Menu> queryDmsMenuByUserId(String userId) throws Exception;
	
	/**
	 * 根据菜单类型获取菜单列表
	 * @param qps
	 * @return
	 * @throws Exception
	 */
	public List<Menu> getMenuListByMenuTyepSelect(QueryParams qps) throws Exception;
	
	/**
	 * 删除菜单:根据parenId删除菜单
	 * @param record
	 * @throws Exception
	 */
	public void delMenuByParentId(Menu record) throws Exception;
	
}