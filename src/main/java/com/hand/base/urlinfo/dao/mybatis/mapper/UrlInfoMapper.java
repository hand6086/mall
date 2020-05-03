package com.hand.base.urlinfo.dao.mybatis.mapper;


import java.util.List;

import com.hand.base.urlinfo.model.UrlInfo;
import com.hand.base.basic.dao.mapper.BasicMapper;

public interface UrlInfoMapper extends BasicMapper<UrlInfo>{
	
	/**
	 * 
	 *<p>查询用户间接关联的url</p>
	 * @author yrf
	 * @param example
	 * @return
	 */
	public List<UrlInfo> queryUrlByUser(UrlInfo example);
}
