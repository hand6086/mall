package com.hand.base.position.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.dept.dao.mybatis.mapper.DepartmentMapper;
import com.hand.base.dept.model.Department;
import com.hand.base.position.dao.mybatis.mapper.PositionImpMapper;
import com.hand.base.position.dao.mybatis.mapper.PositionMapper;
import com.hand.base.position.model.Position;
import com.hand.base.user.model.User;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.util.UserUtil;

@Service
public class PositionImpServiceImpl extends BasicServiceImpl<Position> implements PositionImpService{
	
	@Autowired
	private PositionImpMapper positionImpMapper;
	
	@Autowired
	private PositionMapper positionMapper;
	
	@Autowired
	private DepartmentMapper departmentMapper;

	@Override
	public BasicMapper<Position> getBasicMapper(){
		return positionImpMapper;
	}
	
	@Override
	public void insert(Position record) throws BasicServiceException {
		QueryParams qps = new QueryParams();
		try {
			//如果父职位没有指定，则添加默认父职位
			if("".equals(record.getParentPositionName())||record.getParentPositionName() == null){
				//qps.setAttr1(Constants.IS_EFFECTIVE);
				//qps.setAttr2(Constants.POSTN_TYPE);
				Position t = (Position)BasicModel.transformClass(Position.class, qps);
				String parentPositionName = positionMapper.queryRoot(t).getText();//获取根职位的名称
				record.setParentPositionName(parentPositionName);
			}
			
			if("".equals(record.getDeptName())||record.getDeptName() == null){
				//qps.setAttr1(Constants.IS_EFFECTIVE);
				//qps.setAttr2(Constants.DEPT_TYPE);
				Department t = (Department)BasicModel.transformClass(Department.class, qps);
				String parentDeptName = departmentMapper.queryRoot(t).getText();//获取根部门的名称
				record.setDeptName(parentDeptName);//添加默认部门
			}
			record.setId(keyGenerateService.keyGenerate());
			positionImpMapper.insert(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	
	@Transactional
	public void runPositionCheck(CallParam record) throws BasicServiceException {
		try {
			User user = UserUtil.getUser(null);
			record.setParam1(user.getId());
			positionImpMapper.runPositionCheck(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	
	@Transactional
	public void runNewPositionForimp(CallParam record) throws BasicServiceException {
		try {
			User user = UserUtil.getUser(null);
			record.setParam1(user.getId());
			positionImpMapper.runPositionCheck(record);
			positionImpMapper.runNewPositionForimp(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
}
