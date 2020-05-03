package com.hand.base.urlinfo.service;


import java.util.List;

import com.hand.base.urlinfo.model.UrlInfo;
import com.hand.base.basic.service.BasicService;

	public interface UrlInfoService extends BasicService<UrlInfo>{

	/**
	 * 
	 *<p>加载限制访问url到redis</p>
	 * @author yrf
	 * @throws Exception
	 */
	public void loadUrlToRedis() throws Exception;
	
	/**
	 * 
	 *<p>查询用户间接关联的url</p>
	 * @author yrf
	 * @param example
	 * @return
	 */
	public List<UrlInfo> queryUrlByUser(UrlInfo example);
}
