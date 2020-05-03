package com.hand.base.urlinfo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.hand.base.urlinfo.dao.mybatis.mapper.UrlInfoMapper;
import com.hand.base.urlinfo.model.UrlInfo;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.core.util.AppConstants;
import com.hand.core.util.RedisUtil;

import redis.clients.jedis.Jedis;


	@Service
	public class UrlInfoServiceImpl  extends BasicServiceImpl<UrlInfo>implements UrlInfoService {

	@Resource
	private UrlInfoMapper	urlInfoMapper;
	@Override
	public BasicMapper<UrlInfo> getBasicMapper() {
		return urlInfoMapper;
	}
	/*@PostConstruct
	private void loadUrlToRedisAuto() throws Exception{
		loadUrlToRedis();
	}*/
	@Override
	public void loadUrlToRedis() throws Exception {
		Jedis jedis = RedisUtil.getJedis();
		jedis.del(AppConstants.LINKCRM_RESTRICT_ACCESS_URL);
		
		UrlInfo example = new UrlInfo();
		example.setDefaultAccessFlag("N");
		example.setType("CRM");
		example.setPageFlag(false);
		
		List<UrlInfo> list = urlInfoMapper.queryByExamplePage(example);
		Map<String, String> map = new HashMap<String, String>();
		if(list != null && list.size()>0){
			for(int i=0; i<list.size(); i++){
				UrlInfo urlInfo = list.get(i);
				map.put(urlInfo.getUrl(), "N");
			}
			jedis.hmset(AppConstants.LINKCRM_RESTRICT_ACCESS_URL, map);
		}
	}
	@Override
	public List<UrlInfo> queryUrlByUser(UrlInfo example) {
		// TODO Auto-generated method stub
		if(StringUtils.isBlank(example.getAttr1())){
			throw new BasicServiceException("用户id不能为空");
		}
		return urlInfoMapper.queryUrlByUser(example);
	}
}
