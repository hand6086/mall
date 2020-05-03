package com.hand.base.dept.service;

import java.util.List;

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
import com.hand.core.basic.query.Filter;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.util.AppConstants;
import com.hand.core.util.StringUtils;
import com.hand.core.util.UserUtil;

@Service
public class DepartmentServiceImpl extends BasicServiceImpl<Department> implements DepartmentService{
	
	@Autowired
	private DepartmentMapper departmentMapper;
	
	@Autowired
	private BasicCommonMapper basicCommonMapper;
	
	@Override
	public BasicMapper<Department> getBasicMapper(){
		return departmentMapper;
	}
	
	public List<Department> queryDepartmentListRemoveIdAndChildrenPage(Department entity) throws Exception {
		if(StringUtils.equals(AppConstants.key_applicationDatabase, "mysql")){
			String str=departmentMapper.getDeptChildStr(entity);
			entity.setAttr6(str);
		}
		return departmentMapper.queryDepartmentListRemoveIdAndChildrenPage(entity);
	}
	
	public Department queryRoot(Department entity) throws Exception {
		return departmentMapper.queryRoot(entity);
	}

	public void queryTreeByRoot(Department entity) throws Exception {
		treeDepartmentList(entity);
	}
	
	/**
	 * 递归查询部门树结构
	 * @throws BasicServiceException
	 */
	private void treeDepartmentList(Department entity) throws Exception
	{
		QueryParams params = new QueryParams();
		params.addFilter(new Filter("parentDeptId", entity.getId()));
		params.setPageFlag(false);
		Department t = (Department)BasicModel.transformClass(Department.class, params);
		List<Department> tempList = departmentMapper.queryByExamplePage(t);
		for(Department temp : tempList)
		{
			treeDepartmentList(temp);
		}
		entity.setChildren(tempList);
	}
	//用于画结构图
	public void queryTreeByRoot1(Department entity) throws Exception {
		treeDepartmentList1(entity);
	}
	
	private void treeDepartmentList1(Department entity) throws Exception
	{
		ListOfValue record = new ListOfValue();
		record.setType("ORG_TYPE");
		record.setVal(entity.getDeptType());
		record = basicCommonMapper.getLovName(record);
		entity.setDeptType(record.getName());
		
		QueryParams params = new QueryParams();
		params.addFilter(new Filter("parentDeptId", entity.getId()));
		params.setPageFlag(false);
		Department t = (Department)BasicModel.transformClass(Department.class, params);
		List<Department> tempList = departmentMapper.queryByExamplePage(t);
		for(Department temp : tempList)
		{
			record.setVal(temp.getDeptType());
			record = basicCommonMapper.getLovName(record);
			temp.setDeptType(record.getName());
			treeDepartmentList1(temp);
		}
		entity.setChildren(tempList);
	}

	@Override
	public void beforUpsert(Department entity) throws Exception {
		super.beforUpsert(entity);
		if(StringUtils.isBlank(entity.getIsEffective())){
			entity.setIsEffective("Y");
		}
	}
	
	@Override
	@Transactional
	public void insert(Department entity) throws BasicServiceException {
		try {
			QueryParams params = new QueryParams();
			Department t = (Department)BasicModel.transformClass(Department.class, params);
			//如果父部门没有指定，则添加默认父部门
			if(StringUtils.isBlank(entity.getParentDeptId())){
				String parentDeptId = departmentMapper.queryRoot(t).getId();//获取根部门的ID
				entity.setParentDeptId(parentDeptId);
			}
			super.insert(entity);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	
	@Transactional
	public void deleteWithChildById(Department entity) throws Exception {
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
	private void removeWithChilds(Department entity, QueryParams params) throws Exception{
		try {
			deleteById(entity);
			params.addFilter(new Filter("parentDeptId", entity.getId()));
			Department t = (Department)BasicModel.transformClass(Department.class, params);
			List<Department> list = departmentMapper.queryByExamplePage(t);
			for(Department department : list){
				this.removeWithChilds(department, params);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e.getMessage());
		}
	}

}
