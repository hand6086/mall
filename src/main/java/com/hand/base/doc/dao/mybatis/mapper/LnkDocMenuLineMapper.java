package com.hand.base.doc.dao.mybatis.mapper;


import java.util.List;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.doc.model.LnkDocMenuLine;

public interface LnkDocMenuLineMapper extends BasicMapper<LnkDocMenuLine>{

	List<LnkDocMenuLine> queryMenuLine(String s) throws Exception;
	
}
