package com.hand.base.common.service;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.AppContext;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.common.dao.mybatis.mapper.MenuMapper;
import com.hand.base.common.model.Menu;
import com.hand.base.user.model.User;
import com.hand.core.util.StringUtils;
import com.hand.core.util.UserUtil;

@Service
public class MenuServiceImpl extends BasicServiceImpl<Menu> implements MenuService{
	
	private static final Logger logger = LogManager.getLogger(MenuServiceImpl.class);

	@Autowired
	private MenuMapper menuMapper;
	
	@Override
	public BasicMapper<Menu> getBasicMapper(){
		return menuMapper;
	}
	
	public List<Menu> getMenuListByMenuTyepSelect(String menuType,HttpSession session) throws BasicServiceException {
		List<Menu> list = null;
		User user = UserUtil.getUser(null);
		String userId = user.getId();
		Menu param = new Menu();
		Menu subParam = new Menu();
		param.setMenuType(menuType);
		param.setAttr1(userId);
		subParam.setAttr1(userId);
		subParam.setMenuGrade("2");//安全性菜单查询参数
		subParam.setCorpid(user.getCorpid());
		subParam.setMenuType(menuType);
		AppContext actx = (AppContext)session.getAttribute("AppContext");
		String ctxPath = actx.getCtxPath();
		try {
			list = menuMapper.queryMenuListByTypeSelect(param);
			List<Menu> subList = querySubItemListByDutyItemIdSelect(subParam);
			
			if(list != null){
				list = menuAuthProcessor(list, null);//二级菜单权限计算
				subList = menuAuthProcessor(subList, list);//安全性菜单权限计算
				LinkedHashMap<String, Menu> map = new LinkedHashMap<String, Menu>(list.size()); //需要保证菜单顺序
				
				//二级菜单合并，权限最终确定
				for(int i=0; i<list.size(); i++){
					Menu menu = list.get(i);
					String u = menu.getMenuUrl();
					System.out.println(u);
					logger.debug(u);
					logger.debug(ctxPath);
					Menu mapMenu = map.get(menu.getId());
					if(menu.getMenuUrl() != null){
						String url = ctxPath + menu.getMenuUrl();
						menu.setMenuUrl(url);
					}
					if(mapMenu == null){
						map.put(menu.getId(), menu);
					}else{
						menuAuthMerge(menu, mapMenu);
					}
				}
				
				//安全性菜单合并，权限最终确定，并设置到二级菜单下
				for(int i=0; i<subList.size(); i++){
					Menu subMenu = subList.get(i);
					Menu menu = map.get(subMenu.getParentMenuId());
					if(subMenu.getMenuUrl() != null){
						String url = ctxPath + subMenu.getMenuUrl();
						subMenu.setMenuUrl(url);
					}
					if(menu == null ){
						continue;
					}
					if(menu.getSubMenus() != null){
						menuAuthMerge(subMenu, menu.getSubMenus());
					}else{
						List<Menu> subMenus = new ArrayList<Menu>();
						subMenus.add(subMenu);
						menu.setSubMenus(subMenus);
					}
				}
				list = new ArrayList<Menu>(map.values());
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
		return list;
	}
	/**
	 * 
	 *<p>菜单列表的只读、可添加、可修改等权限的处理计算,返回最终结果</p>
	 * @author yrf
	 * @param list
	 * @param parentList
	 * @return
	 */
	private List<Menu> menuAuthProcessor(List<Menu> list, List<Menu> parentList){
		if(list == null ){
			return null;
		}
		for(int i=0; i<list.size(); i++){
			Menu menu = list.get(i);
			Menu parentMenu = null;//父菜单
			
			/**
			 * 处理可导出标记，与只读标记无关的标记
			 */
			if("N".equals(menu.getDutyExportFlag())){//职责下不可导出
				menu.setExportFlag("N");
			}else{
				if("Y".equals(menu.getExportFlag())){//职责下及菜单原本都可导出，则查找父菜单
					if(parentList != null ){
						for(int j=0; j<parentList.size(); j++){
							parentMenu = parentList.get(j);
							if(StringUtils.equals(parentMenu.getId(), menu.getParentMenuId()) && 
									StringUtils.equals(parentMenu.getDutyId(), menu.getDutyId())){ //父子菜单id、职责id相等才视为父子菜单
								menu.setExportFlag(parentMenu.getExportFlag());//取父菜单标记作为最终标记
								break;
							}else{
								parentMenu = null;
							}
						}
					}
				}
			}
			
			/**
			 * 处理与数据修改相关权限标记
			 */
			if("Y".equals(menu.getDutyReadonlyFlag())){ //职责下菜单只读
				menu.setReadonlyFlag("Y");
				menu.setAddFlag("N");
				menu.setEditFlag("N");
				menu.setDeleteFlag("N");
			}else{
				if("Y".equals(menu.getReadonlyFlag())){ //菜单原本只读
					menu.setReadonlyFlag("Y");
					menu.setAddFlag("N");
					menu.setEditFlag("N");
					menu.setDeleteFlag("N");
				}else{
					String parentReadonlyFlag = "N";
					String parentAddFlag = "Y";
					String parentEditFlag = "Y";
					String parentDeleteFlag = "Y";
					if(parentList != null ){
						if(parentMenu == null){
							for(int j=0; j<parentList.size(); j++){
								parentMenu = parentList.get(j);
								if(StringUtils.equals(parentMenu.getId(), menu.getParentMenuId()) && 
										StringUtils.equals(parentMenu.getDutyId(), menu.getDutyId())){ //父子菜单id、职责id相等才视为父子菜单
									
									parentReadonlyFlag = parentMenu.getReadonlyFlag();
									parentAddFlag = parentMenu.getAddFlag();
									parentEditFlag = parentMenu.getEditFlag();
									parentDeleteFlag = parentMenu.getDeleteFlag();
								}
							}
						}else{//前面计算可导出标记时已获取到父菜单对象
							parentReadonlyFlag = parentMenu.getReadonlyFlag();
							parentAddFlag = parentMenu.getAddFlag();
							parentEditFlag = parentMenu.getEditFlag();
							parentDeleteFlag = parentMenu.getDeleteFlag();
						}
						
					}
					//父菜单只读
					if("Y".equals(parentReadonlyFlag)){
						menu.setReadonlyFlag("Y");
						menu.setAddFlag("N");
						menu.setEditFlag("N");
						menu.setDeleteFlag("N");
					}else{
						
						menu.setReadonlyFlag("N");
						
						//菜单及父菜单可添加的情况下再判断当前职责下菜单是否可添加
						if("Y".equals(menu.getAddFlag()) && "Y".equals(parentAddFlag)){
							menu.setAddFlag(menu.getDutyAddFlag());
						}else{
							menu.setAddFlag("N");
						}
						
						//菜单及父菜单可编辑的情况下再判断当前职责下菜单是否可编辑
						if("Y".equals(menu.getEditFlag()) && "Y".equals(parentEditFlag)){
							menu.setEditFlag(menu.getDutyEditFlag());
						}else{
							menu.setEditFlag("N");
						}
						
						//菜单及父菜单可删除的情况下再判断当前职责下菜单是否可删除
						if("Y".equals(menu.getDeleteFlag()) && "Y".equals(parentDeleteFlag)){
							menu.setDeleteFlag(menu.getDutyDeleteFlag());
						}else{
							menu.setDeleteFlag("N");
						}
					}
					
				}
			}
		}
		return list;
	}
	
	/**
	 * 
	 *<p>合并两个菜单列表，相同菜单不同权限配置则取大权限作为最终权限</p>
	 * @author yrf
	 * @param listA
	 * @param listB 该列表会被修改
	 * @return
	 */
	private List<Menu> menuAuthMerge(List<Menu> listA, List<Menu> listB){
		if(listA == null){
			return listB;
		}
		int sizeA = listA.size();
		int sizeB = listB.size();
		for(int i=0; i<sizeA; i++){
			Menu menuA = listA.get(i);
			boolean foundFlag = false;
			for(int j=0; j<sizeB; j++){
				Menu menuB = listB.get(j);
				if(StringUtils.equals(menuB.getId(), menuA.getId())){//菜单id相等
					menuAuthMerge(menuA, menuB);
					foundFlag = true;
					break;
				}
			}
			if(!foundFlag){ //在listB中没找到与menuA相等的
				listB.add(menuA);
			}
		}
		//Collections.sort(listB, new );
		return listB;
	}
	
	/**
	 * 
	 *<p>合并一个菜单到菜单列表，相同菜单不同权限配置则取大权限作为最终权限</p>
	 * @author yrf
	 * @param menu
	 * @param list 该列表会被修改
	 * @return
	 */
	private List<Menu> menuAuthMerge(Menu menu, List<Menu> list){
		if(menu == null){
			return list;
		}
		int size = list.size();
		boolean foundFlag = false;
		for(int i=0; i<size; i++){
			Menu menuL = list.get(i);
			
			if(StringUtils.equals(menu.getId(), menuL.getId())){//菜单id相等
				menuAuthMerge(menu, menuL);
				foundFlag = true;
				break;
			}
		}
		if(!foundFlag){ //在listB中没找到与menuA相等的
			list.add(menu);
		}
		//Collections.sort(listB, new );
		return list;
	}
	/**
	 * 
	 *<p>合并两个菜单权限，相同菜单不同权限配置则取大权限作为最终权限</p>
	 * @author yrf
	 * @param menuA
	 * @param menuB 该对象内容会被修改
	 * @return
	 */
	private Menu menuAuthMerge(Menu menuA, Menu menuB){
		//菜单id相等
		String readOnlyFlag = menuB.getReadonlyFlag();
		if("Y".equals(readOnlyFlag) && !"Y".equals(menuA.getReadonlyFlag())){//menuB只读，menuA不只读，menuA代替menuB
			menuB.setReadonlyFlag(menuA.getReadonlyFlag());
			menuB.setAddFlag(menuA.getAddFlag());
			menuB.setEditFlag(menuA.getEditFlag());
			menuB.setDeleteFlag(menuA.getDeleteFlag());
		}else if(!"Y".equals(readOnlyFlag) && !"Y".equals(menuA.getReadonlyFlag())){//两者都不只读，取大的权限
			if("Y".equals(menuA.getAddFlag())){
				menuB.setAddFlag(menuA.getAddFlag());//menuA权限大则取menuA代替当前menuB
			}
			if("Y".equals(menuA.getEditFlag())){
				menuB.setEditFlag(menuA.getEditFlag());
			}
			if("Y".equals(menuA.getDeleteFlag())){
				menuB.setDeleteFlag(menuA.getDeleteFlag());
			}
		}
		//可导出权限
		if("Y".equals(menuA.getExportFlag())){
			menuB.setExportFlag("Y");
		}
		return menuB;
	}
	@Override
	public List<Menu> querySubItemListByDutyItemIdSelect(Menu record) throws Exception {
		return menuMapper.querySubItemListByDutyItemIdSelect(record);
	}
	
	public Menu queryByMenuType(String menuType) throws BasicServiceException {
		Menu menu = null;
		try {
			menu = menuMapper.queryByMenuType(menuType);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
		return menu;
	}

	public List<Menu> queryFstMenuList(String userId) throws BasicServiceException {
		List<Menu> list = null;
		try {
			list = menuMapper.queryFstMenuList(userId);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
		return list;
	}
	
	public List<Menu> queryDmsMenuByUserId(String userId) throws BasicServiceException {
		List<Menu> list = null;
		try {
			list = menuMapper.queryDmsMenuByUserId(userId);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
		return list;
	}
	
}
