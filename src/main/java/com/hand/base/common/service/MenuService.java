package com.hand.base.common.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.common.model.Menu;

public interface MenuService extends BasicService<Menu>{
	
	/**
	 * 根据菜单类型获取菜单列表
	 * @param menuType
	 * @return
	 * @throws BasicServiceException
	 */
	public List<Menu> getMenuListByMenuTyepSelect(String menuType,HttpSession session) throws BasicServiceException;
	
	
	/**
	 * 根据子菜单Id，查询安全性菜单项信息
	 * @param qps
	 * @return
	 * @throws BasicServiceException
	 */
	public List<Menu> querySubItemListByDutyItemIdSelect(Menu menu) throws Exception;
	
	/**
	 * 查询一级菜单
	 * @param userId
	 * @return
	 * @throws BasicServiceException
	 */
	public List<Menu> queryFstMenuList(String userId) throws BasicServiceException;
	
	/**
	 * 根据用户ID查询职责内DMS的菜单
	 * @param userId 用户ID
	 */
	public List<Menu> queryDmsMenuByUserId(String userId) throws Exception;
	
	/**
	 * 根据菜单类型查询一级菜单
	 * @param menuType
	 * @return
	 * @throws BasicServiceException
	 */
	public Menu queryByMenuType(String menuType) throws BasicServiceException;
	
}
