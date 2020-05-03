package com.hand.base.duty.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.common.model.InterObject;
import com.hand.base.common.model.Menu;
import com.hand.base.duty.model.Duty;
import com.hand.base.urlinfo.model.UrlInfo;
import com.hand.base.user.model.User;

public interface DutyMapper extends BasicMapper<Duty> {
	
	/**
	 * 查询菜单列表：分页查询职责关联的菜单
	 * @param record
	 * @throws Exception
	 */
	public List<Menu> queryDutyOfMenuListPage(Menu record)throws Exception;
	
	/**
	 * 查询职责列表，如果是000账套，则去除cropid限制
	 * @param record
	 * @throws Exception
	 */
	public List<Duty> queryDutyListPage(Duty record)throws Exception;
	
	/**
	 * 查询用户列表：分页查询职责关联的用户
	 * @param record
	 * @throws Exception
	 */
	public List<User> queryDutyOfUserListPage(User record)throws Exception;
	
	/**
	 * 查询菜单列表：查询未关联职责的菜单
	 * @param record
	 * @throws Exception
	 */
	public List<Menu> queryUnSelectMenuListPage(Menu record)throws Exception;

	/**
	 * 查询安全性菜单列表：为关联职责菜单
	 * @param record
	 * @return
	 * @throws Exception
	 */
	public List<Menu> queryUnSelectSubMenuListPage(Menu record)throws Exception;
	
	/**
	 * 查询用户列表：查询未关联职责的用户
	 * @param record
	 * @throws Exception
	 */
	public List<User> queryUnSelectUserListPage(User record)throws Exception;
	
	/**
	 * 添加菜单：给职责添加菜单
	 * @param record
	 * @throws Exception
	 */
	public void addMenuOfDutyInsert(Menu record)throws Exception;
	
	/**
	 * 添加菜单：给职责添加菜单
	 * @param record
	 * @throws Exception
	 */
	public void addUserOfDutyInsert(User record)throws Exception;
	
	/**
	 * 添加菜单：给职责添加菜单的父菜单
	 * @param record
	 * @throws Exception
	 */
	public void addParentMenuOfDutyInsert(Menu record)throws Exception;
	
	/**
	 * 删除菜单：根据Id删除菜单
	 * @param record
	 * @throws Exception
	 */
	public void delMenuOfDuty(InterObject record) throws Exception;
	
	/**
	 * 删除菜单：根据Id删除父菜单
	 * @param record
	 * @throws Exception
	 */
	public void delMenuParentOfDuty(InterObject record) throws Exception;
	
	/**
	 * 根据二级菜单id和职责Id去中间表查询二级菜单对应的一级菜单下的所有二级菜单
	 * @param record
	 * @throws Exception
	 */
	public List<Menu> querySecMenuIdListBySecMenuIdAndDutyIdFromMenuOfDuty(InterObject record) throws Exception;
	
	/**
	 * 删除用户：根据Id删除用户
	 * @param record
	 * @throws Exception
	 */
	public void delUserOfDuty(InterObject record) throws Exception;
	
	/**
	 * 删除菜单：根据parentId删除菜单
	 * @param record
	 * @throws Exception
	 */
	public void delMenuByParentId(Menu record) throws Exception;
	
	/**
	 * 根据菜单类型获取菜单列表
	 * @param record
	 * @return
	 * @throws Exception
	 */
	public List<Menu> getMenuListByMenuTyepSelect(Menu record) throws Exception;
	
	/**
	 * 查询二级菜单的父菜单是否已存在中间表
	 * @param record
	 * @return
	 * @throws Exception
	 */
	public InterObject queryParentMenuExistByMenuOfDuty(Menu record) throws Exception;
	
	/**
	 * 
	 *<p>更新职责菜单中间表数据</p>
	 * @author yrf
	 * @param record
	 * @return
	 * @throws Exception
	 */
	public int menuOfDutyUpdate(Menu record) throws Exception;
	
	/**
	 * 
	 *<p>查询未选中关联职责的url信息</p>
	 * @author yrf
	 * @param record
	 * @return
	 * @throws Exception
	 */
	public List<UrlInfo> queryUnSelectUrlListPage(UrlInfo record)throws Exception;
	
	/**
	 * 更新其他职责的是否默认为‘N’
	 * @param entity
	 */
	public void defaultUpdate(Duty entity) throws Exception;
	
}
