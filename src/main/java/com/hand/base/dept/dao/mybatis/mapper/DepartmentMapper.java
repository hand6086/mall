package com.hand.base.dept.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.dept.model.Department;

public interface DepartmentMapper extends BasicMapper<Department> {
	
	/**
	 * 查询根部门
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Department queryRoot(Department entity) throws Exception;
	
	/**
	 * 查询部门列表表排除主键为Id的部门和其子部门，只取有效的信息
	 * @param params
	 * @return
	 */
	public List<Department> queryDepartmentListRemoveIdAndChildrenPage(Department entity) throws Exception;

	public String getDeptChildStr(Department entity) throws Exception;
    
}