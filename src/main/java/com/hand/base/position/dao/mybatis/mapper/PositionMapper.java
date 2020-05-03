package com.hand.base.position.dao.mybatis.mapper;

import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.position.model.Position;

public interface PositionMapper extends BasicMapper<Position> {
	
	/**
	 * 查询根职位
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Position queryRoot(Position entity) throws Exception;
	
	/**
	 * 查询职位列表表排除主键为Id的职位和其子职位，只取有效的信息
	 * @param params
	 * @return
	 */
	public List<Position> queryPositionListRemoveIdAndChildrenPage(Position entity) throws Exception;
	
	/**
	 * 通过用户ID查询用户的职位
	 */
	public List<Position> queryByUserPage(Position entity) throws Exception;

	public String getPostnChildStr(Position entity) throws Exception;
	
	/**
	 * 修改主要负责人
	 */
	public void mainUserUpdate(Position entity) throws Exception;
	
}
