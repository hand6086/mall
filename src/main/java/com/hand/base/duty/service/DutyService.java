package com.hand.base.duty.service;

import java.util.List;

import com.hand.base.basic.service.BasicService;
import com.hand.base.common.model.InterObject;
import com.hand.base.common.model.Menu;
import com.hand.base.duty.model.Duty;
import com.hand.base.urlinfo.model.UrlInfo;
import com.hand.base.user.model.User;

public interface DutyService extends BasicService<Duty> {
	
	/**
	 * 查询菜单列表：查询职责关联的菜单
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
	 * 查询用户列表：查询职责关联的用户
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
	
	public List<User> queryUnSelectUserListPage(User record)throws Exception;
	
	
	
	/**
	 * 添加菜单：给职责添加菜单
	 * @param record
	 * @throws Exception
	 */
	public void addMenuOfDutyInsert(Menu record) throws Exception;
	
	/**
	 * 添加用户：给职责添加用户
	 * @param record
	 * @throws Exception
	 */
	public void addUserOfDutyInsert(User record) throws Exception;
	
	/**
	 * 删除菜单：删除职责下的菜单
	 * @param record
	 * @throws Exception
	 */
	public void delMenuOfDuty(InterObject record) throws Exception;
	
	/**
	 * 删除用户：删除职责下的用户
	 * @param record
	 * @throws Exception
	 */
	public void delUserOfDuty(InterObject record) throws Exception;
	
	/**
	 * 
	 *<p>修改职责下的菜单</p>
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
}
