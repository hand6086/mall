package com.hand.base.doc.service;


import java.util.List;

import com.hand.base.basic.service.BasicService;
import com.hand.base.doc.model.LnkDocMenuLine;

	public interface LnkDocMenuLineService extends BasicService<LnkDocMenuLine>{

		List<LnkDocMenuLine> queryMenuLine(String s) throws Exception;

	
}

