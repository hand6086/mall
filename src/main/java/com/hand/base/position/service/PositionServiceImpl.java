package com.hand.base.position.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.dao.mybatis.mapper.BasicCommonMapper;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.model.ListOfValue;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.dept.dao.mybatis.mapper.DepartmentMapper;
import com.hand.base.dept.model.Department;
import com.hand.base.position.dao.mybatis.mapper.PositionMapper;
import com.hand.base.position.model.Position;
import com.hand.base.user.service.UserService;
import com.hand.core.basic.query.Filter;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.util.AppConstants;
import com.hand.core.util.StringUtils;
import com.hand.core.util.UserUtil;

@Service
public class PositionServiceImpl extends BasicServiceImpl<Position> implements PositionService{
	
	@Autowired
	private PositionMapper positionMapper;
	@Autowired
	private BasicCommonMapper basicCommonMapper;
	@Autowired
	private DepartmentMapper departmentMapper;
	@Resource
	private UserService userService;
	
	
	@Override
	public BasicMapper<Position> getBasicMapper(){
		return positionMapper;
	}
	
	public List<Position> queryPositionListRemoveIdAndChildrenPage(Position entity) throws Exception {
		if(StringUtils.equals(AppConstants.key_applicationDatabase, "mysql")){
			String str = positionMapper.getPostnChildStr(entity);
			entity.setAttr6(str);
		}
		return positionMapper.queryPositionListRemoveIdAndChildrenPage(entity);
	}
	
	public Position queryRoot(Position entity) throws Exception {
		return positionMapper.queryRoot(entity);
	}
	
	public List<Position> queryByUserPage(Position entity) throws Exception {
		return positionMapper.queryByUserPage(entity);
	}

	public void queryTreeByRoot(Position entity) throws Exception {
		treePositionList(entity);
	}
	
	/**
	 * 递归查询职位树结构
	 * @throws BasicServiceException
	 */
	private void treePositionList(Position entity) throws Exception
	{
		QueryParams params = new QueryParams();
		params.addFilter(new Filter("parentPositionId", entity.getId()));
		params.setPageFlag(false);
		Position t = (Position)BasicModel.transformClass(Position.class, params);
		List<Position> tempList = positionMapper.queryByExamplePage(t);
		for(Position temp : tempList)
		{
			treePositionList(temp);
		}
		entity.setChildren(tempList);
	}
	//用于画结构图
	public void queryTreeByRoot1(Position entity) throws Exception {
		treePositionList1(entity);
	}
	private void treePositionList1(Position entity) throws Exception
	{
		ListOfValue record = new ListOfValue();
		record.setType("POSTN_TYPE");
		record.setVal(entity.getPositionType());
		record = basicCommonMapper.getLovName(record);
		entity.setPositionType(record.getName());
		
		QueryParams params = new QueryParams();
		params.addFilter(new Filter("parentPositionId", entity.getId()));
		params.setPageFlag(false);
		Position t = (Position)BasicModel.transformClass(Position.class, params);
		List<Position> tempList = positionMapper.queryByExamplePage(t);
		for(Position temp : tempList)
		{
			record.setVal(temp.getPositionType());
			record = basicCommonMapper.getLovName(record);
			temp.setPositionType(record.getName());
			treePositionList1(temp);
		}
		entity.setChildren(tempList);
	}

	@Override
	public void beforUpsert(Position entity) throws Exception {
		super.beforUpsert(entity);
		if(StringUtils.isBlank(entity.getIsEffective())){
			entity.setIsEffective("Y");
		}
	}
	
	@Override
	@Transactional
	public void insert(Position entity) throws BasicServiceException {
		try {
			QueryParams params = new QueryParams();
			Position t = (Position)BasicModel.transformClass(Position.class, params);
			//如果父职位没有指定，则添加默认父职位
			if(StringUtils.isBlank(entity.getParentPositionId())){
				t.setUsercorpid(entity.getUsercorpid());
				String parentPositionId = positionMapper.queryRoot(t).getId();//获取根职位的ID
				entity.setParentPositionId(parentPositionId);
			}
			//如果部门没有指定，则添加默认部门
			if(StringUtils.isBlank(entity.getDeptId())){
				String parentDeptId = departmentMapper.queryRoot(new Department()).getId();//获取根部门的ID
				entity.setDeptId(parentDeptId);//添加默认部门
			}
			super.insert(entity);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	
	@Override
	public void upsert(Position entity) throws Exception {
		super.upsert(entity);
		//同时修改用户的主要职位
		String postnId = entity.getId();
		String userId = entity.getUserId();
		if(StringUtils.isNotBlank(userId)){
			QueryParams qps = new QueryParams();
			qps.setPageFlag(false);
			qps.addFilter(new Filter("id", postnId));
			/*Mvg mvgParam = (Mvg)BasicModel.transformClass(Mvg.class, qps);
			mvgParam.setMvgParentId(userId);
			List<HashMap<String, String>> postnMapList = userPostnMvgMapper.queryRightListPage(mvgParam);
			if(postnMapList.size() == 1){
				userService.mainPostnUpdate(userId, postnId);
			}*/
		}
	}
	
	@Transactional
	public void deleteWithChildById(Position entity) throws Exception {
		beforDelete(entity);
		checkId(entity);
		QueryParams params = new QueryParams();
		params.setUsercorpid(UserUtil.getUser(null).getUsercorpid());
		params.setPageFlag(false);
		removeWithChilds(entity, params);
	}
	
	/**
	 * 递归删除
	 */
	private void removeWithChilds(Position entity, QueryParams params) throws Exception{
		try {
			deleteById(entity);
			params.addFilter(new Filter("parentPositionId", entity.getId()));
			Position t = (Position)BasicModel.transformClass(Position.class, params);
			List<Position> list = positionMapper.queryByExamplePage(t);
			for(Position position : list){
				this.removeWithChilds(position, params);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e.getMessage());
		}
	}
	
	@Override
	public void mainUserUpdate(String postnId, String userId) throws Exception {
		Position entity = new Position();
		entity.setId(postnId);
		entity.setUserId(userId);
		positionMapper.mainUserUpdate(entity);
	}
}
