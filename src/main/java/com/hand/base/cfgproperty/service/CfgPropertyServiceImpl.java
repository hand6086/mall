package com.hand.base.cfgproperty.service;


import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.cfgproperty.dao.mybatis.mapper.CfgPropertyMapper;
import com.hand.base.cfgproperty.model.CfgProperty;
import com.hand.base.user.model.User;
import com.hand.core.util.AppConstants;
import com.hand.core.util.RedisUtil;
import com.hand.core.util.UserUtil;

import redis.clients.jedis.Jedis;
/**
 * 
 * <p>Title</p>
 * <p>Description</p>
 * <p>Company</p>
 * @author yrf
 * @date 2016年8月4日  下午4:14:22
 */
@Service
public class CfgPropertyServiceImpl extends BasicServiceImpl<CfgProperty>implements CfgPropertyService {

	@Autowired
	private CfgPropertyMapper cfgPropertyMapper;
	
	public BasicMapper<CfgProperty> getBasicMapper() throws Exception {
		if(cfgPropertyMapper != null){
			return cfgPropertyMapper;
		}
		throw new BasicServiceException("获取Basic Mapper 失败，请确认程序是否正确！");
	}
	
	/*@PostConstruct
	private void loadCfg(){
		try{
			//logger.info("Loading Config from database...");
			//System.err.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>..");
			//System.out.println("Loading Config from database...");
			loadCfgFromProperties();
			loadCfg(null);
		}catch(Exception e){
			e.printStackTrace();
		}
	}*/

	@Override
	public void loadCfg(CfgProperty cfgProperty) throws Exception {
		if(cfgProperty == null){
			cfgProperty = new CfgProperty();
		}
		cfgProperty.setPageFlag(false);
		List<CfgProperty> list = cfgPropertyMapper.queryAllPage(cfgProperty);
		Map<String, String> propsMap = new HashMap<String, String>();
		for(int i=0; i<list.size(); i++){
			propsMap.put(list.get(i).getKey(), list.get(i).getValue());
		}
        Class<AppConstants> app = AppConstants.class;
        Field[] fs = app.getDeclaredFields();
        
        for(int i=0; i<fs.length; i++){
        	Field f = fs[i];
        	f.setAccessible(true);
        	if( (f.getModifiers() & 8) == 8){
        		String val = propsMap.get( f.getName() );
        		if(val != null){
        			if( f.getType().toString().endsWith("String")){
        				f.set(null, val);
        			}else if(f.getType().toString().endsWith("int") || f.getType().toString().endsWith("Integer")){
        				f.set(null, Integer.parseInt(val));
        			}else if(f.getType().toString().endsWith("boolean") || f.getType().toString().endsWith("Boolean")){
        				f.set(null, Boolean.parseBoolean(val));
        			}else if(f.getType().toString().endsWith("float") || f.getType().toString().endsWith("Float")){
        				f.set(null, Float.parseFloat(val));
        			}else if(f.getType().toString().endsWith("double") || f.getType().toString().endsWith("Double")){
        				f.set(null, Double.parseDouble(val));
        			}else{
        				System.err.println("数据库不支持的配置参数类型");
        			}
        		}
        	}
        }
        
        loadCfgToRedis(list);
	}
	
	private void loadCfgToRedis(List<CfgProperty> list){
		Jedis jedis = RedisUtil.getJedis();
		Map<String, String> comMap = new HashMap<String, String>();
		for(CfgProperty cfgProperty : list){
			if("N".equals(cfgProperty.getType())){
				//类型N为企业私有参数
				jedis.hset(AppConstants.SYS_PROPERTY_CORP_KEY+cfgProperty.getCorpid(), cfgProperty.getKey(), cfgProperty.getValue());
			}else{
				comMap.put(cfgProperty.getKey(), cfgProperty.getValue());
				//jedis.hset(PropertyUtil.commonKey, cfgProperty.getKey(), cfgProperty.getValue());
			}
		}
		if(comMap.size()>0){
			jedis.hmset(AppConstants.SYS_PROPERTY_COMMON_KEY, comMap);
		}	
	}
	
	
	public void beforUpsert(CfgProperty cfgProperty){
		if("Y".equals(cfgProperty.getType())){
			User user = UserUtil.getUser(null);
			if(!"000".equals(user.getCorpid())){
				throw new BasicServiceException("您无权新建/设置公共系统参数");
			}
		}
	}
	
	public void beforDelete(CfgProperty cfgProperty) throws Exception{
		CfgProperty result = queryById(cfgProperty) ;
		if(result == null ){
			return ;
		}
		if("Y".equals(result.getType())){
			User user = UserUtil.getUser(null);
			if(!"000".equals(user.getCorpid())){
				throw new BasicServiceException("您无权删除公共系统参数");
			}
		}
	}
}
