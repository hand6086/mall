package com.hand.base.promotion.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.promotion.dao.mybatis.mapper.GroupTeamsMapper;
import com.hand.base.promotion.model.GroupTeams;


@Service
public class GroupTeamsServiceImpl extends BasicServiceImpl<GroupTeams>implements GroupTeamsService {
	@Autowired
	private GroupTeamsMapper groupTeamsMapper;
	
	@Override
	public BasicMapper<GroupTeams> getBasicMapper(){
		return groupTeamsMapper;
	}
}
