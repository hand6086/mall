package com.hand.base.position.service;

import java.util.List;

import com.hand.base.basic.service.BasicService;
import com.hand.base.position.model.Position;

public interface PositionService extends BasicService<Position>{
	
	/**
	 * 查询根职位
	 */
	public Position queryRoot (Position entity) throws Exception;
	
	/**
	 * 查询职位列表表排除主键为Id的职位和其子职位
	 */
	public List<Position> queryPositionListRemoveIdAndChildrenPage(Position entity) throws Exception;
	
	/**
	 * 通过用户ID查询用户的职位
	 */
	public List<Position> queryByUserPage (Position entity) throws Exception;
	
	/**
	 * 根据根职位查询职位树
	 */
	public void queryTreeByRoot(Position entity) throws Exception;
	//用于画结构图
	public void queryTreeByRoot1(Position entity) throws Exception;
	
	/**
	 * 根据ID递归删除该记录以及其子对象
	 */
	public void deleteWithChildById(Position entity) throws Exception;
	
	/**
	 * 修改主要负责人
	 * @param postnId 职位ID
	 * @param userId 用户ID
	 */
	public void mainUserUpdate(String postnId, String userId) throws Exception;
	
}
