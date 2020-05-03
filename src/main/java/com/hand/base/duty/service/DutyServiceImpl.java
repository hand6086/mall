package com.hand.base.duty.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.common.dao.mybatis.mapper.MenuMapper;
import com.hand.base.common.model.InterObject;
import com.hand.base.common.model.Menu;
import com.hand.base.duty.dao.mybatis.mapper.DutyMapper;
import com.hand.base.duty.model.Duty;
import com.hand.base.urlinfo.model.UrlInfo;
import com.hand.base.user.model.User;
import com.hand.core.util.Constants;
import com.hand.core.util.StringUtils;
import com.hand.core.util.UserUtil;

@Service
public class DutyServiceImpl extends BasicServiceImpl<Duty> implements DutyService {

	@Autowired
	private DutyMapper dutyMapper;
	
	@Autowired
	private MenuMapper menuMapper;
	
	@Override
	public BasicMapper<Duty> getBasicMapper(){
		return dutyMapper;
	}
	
	@Override
	public List<Duty> queryDutyListPage(Duty record) throws Exception {
		beforQueryExample(record);
		beforQueryAllOrExample(record);
		return dutyMapper.queryDutyListPage(record);
	}

	public List<Menu> queryDutyOfMenuListPage(Menu record) throws Exception {
		return dutyMapper.queryDutyOfMenuListPage(record);
	}
	
	public List<User> queryDutyOfUserListPage(User record) throws Exception {
		return dutyMapper.queryDutyOfUserListPage(record);
	}

	public List<Menu> queryUnSelectMenuListPage(Menu record) throws Exception {
		return dutyMapper.queryUnSelectMenuListPage(record);
	}

	@Override
	public List<Menu> queryUnSelectSubMenuListPage(Menu record) throws Exception {
		return dutyMapper.queryUnSelectSubMenuListPage(record);
	}
	
	public List<User> queryUnSelectUserListPage(User record) throws Exception {
		return dutyMapper.queryUnSelectUserListPage(record);
	}
	
	@Transactional
	public void addMenuOfDutyInsert(Menu record) throws Exception {
		checkAdminCorp(record, record.getDutyId());
		InterObject interObject = dutyMapper.queryParentMenuExistByMenuOfDuty(record);
		// 查询中间表是否已经插入一级菜单
		if(interObject == null || StringUtils.isNull(interObject.getId()))
		{
			dutyMapper.addParentMenuOfDutyInsert(record);
		}
		dutyMapper.addMenuOfDutyInsert(record);
	}
	
	@Transactional
	public void addUserOfDutyInsert(User record) throws Exception {
		checkAdminCorp(record, record.getDutyId());
		dutyMapper.addUserOfDutyInsert(record);
	}
	
	/**
	 * 某种情况下，000账套的登录人员会帮助其他公司账套创建职责的数据，所以
	 * 如果当前账套为标准公司账套‘000’，则将职责的账套编号作为新建数据的账套编号
	 * @param record
	 * @param DutyId
	 */
	private void checkAdminCorp(BasicModel record, String DutyId) {
		try {
			if (StringUtils.equals(UserUtil.getUser(null).getCorpid(), Constants.ADMIN_CORPID)) {
				// 查询选中的职责信息
				Duty dutyParam = new Duty();
				dutyParam.setId(DutyId);
				Duty duty = queryById(dutyParam);
				record.setUsercorpid(duty.getCorpid());
				record.setCorpid(duty.getCorpid());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void delMenuOfDuty(InterObject record) throws Exception {
		// 根据菜单的row_id查询当前记录，如果是主菜单，则先删除其所有子菜单然后在删除主菜单
		/*Menu menu = menuMapper.queryMenuById(record);
		if(StringUtils.isNull(menu.getParentMenuId()) && Constants.MENU_GRADE_FST.equals(menu.getMenuGrade()))
		{// 父菜单Id为空且菜单等级为主菜单，则删除其所有子菜单
			Menu childMenu = new Menu();
			childMenu.setParentMenuId(record.getId());
			dutyMapper.delMenuByParentId(childMenu);
		}*/
		List<Menu> list = dutyMapper.querySecMenuIdListBySecMenuIdAndDutyIdFromMenuOfDuty(record);
		if(list.size() <= 1){
			dutyMapper.delMenuParentOfDuty(record);
		}
		dutyMapper.delMenuOfDuty(record);
	}
	
	public void delUserOfDuty(InterObject record) throws Exception {
		dutyMapper.delUserOfDuty(record);
	}

	@Override
	public int menuOfDutyUpdate(Menu record) throws Exception {
		if(StringUtils.isBlank(record.getId())){
			throw new BasicServiceException("对象id不能为空");
		}
		return dutyMapper.menuOfDutyUpdate(record);
	}

	@Override
	public List<UrlInfo> queryUnSelectUrlListPage(UrlInfo record) throws Exception {
		if(StringUtils.isBlank(record.getAttr1())){
			throw new BasicServiceException("职责id不能为空");
		}
		return dutyMapper.queryUnSelectUrlListPage(record);
	}

	@Override
	public void beforUpsert(Duty entity) throws Exception{
		if("Y".equals(entity.getIsDefault())){
			dutyMapper.defaultUpdate(entity);
		}
	}
	
	@Override
	public void beforBrandUpsert(Duty entity) throws Exception{
		if("Y".equals(entity.getIsDefault())){
			dutyMapper.defaultUpdate(entity);
		}
	}

}
