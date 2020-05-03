package com.hand.base.dept.service;

import java.util.List;

import com.hand.base.basic.service.BasicService;
import com.hand.base.dept.model.Department;

public interface DepartmentService extends BasicService<Department> {
	
	/**
	 * 查询根部门
	 */
	public Department queryRoot (Department entity) throws Exception;
	
	/**
	 * 查询部门列表表排除主键为Id的部门和其子部门
	 */
	public List<Department> queryDepartmentListRemoveIdAndChildrenPage(Department entity) throws Exception;
	
	/**
	 * 根据根部门查询部门树
	 */
	public void queryTreeByRoot(Department entity) throws Exception;
	//用于画结构图
	public void queryTreeByRoot1(Department entity) throws Exception;
	
	/**
	 * 根据ID递归删除该记录以及其子对象
	 */
	public void deleteWithChildById(Department entity) throws Exception;

}
