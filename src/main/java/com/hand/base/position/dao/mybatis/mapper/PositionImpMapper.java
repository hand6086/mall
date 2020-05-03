package com.hand.base.position.dao.mybatis.mapper;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.CallParam;
import com.hand.base.position.model.Position;

public interface PositionImpMapper extends BasicMapper<Position> {
	
	/**
	 * 检验职位各字段数据
	 * @throws Exception
	 */
	public void runPositionCheck(CallParam record) throws Exception;
	
	/**
	 * 插入到职位
	 * @throws Exception
	 */
	public void runNewPositionForimp(CallParam record) throws Exception;
	
}
