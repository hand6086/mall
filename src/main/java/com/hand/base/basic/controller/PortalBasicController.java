package com.hand.base.basic.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.ExclusionStrategy;
import com.google.gson.FieldAttributes;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.model.ListOfValue;
import com.hand.base.basic.service.BasicCommonService;
import com.hand.base.basic.service.BasicService;
import com.hand.core.autoconfig.service.LnkInnerLinkService;

import com.hand.core.basic.query.Filter;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.basic.query.Sorter;
import com.hand.core.util.RedisUtil;
import com.hand.core.util.StringUtils;
import com.hand.core.util.UserUtil;

import net.sf.json.JSONObject;
import redis.clients.jedis.Jedis;

@Controller
@RequestMapping("/action/portal/basic")
public class PortalBasicController extends BasicController<ListOfValue> {
	private static final Logger	logger	= LogManager.getLogger(PortalBasicController.class);
	private static final String lovRedisPrefix = "LOV_CACHE_";
	private static final int expireTime = 2; //值列表缓存时长24 * 60 * 60
	@Resource
	private BasicCommonService	basicService;
//	@Resource
//	private LnkInnerLinkService	lnkAutoConfigService;
	
//	@Autowired
//	private EnterpriseService enterpriseService;
	
	@Override
	public BasicService<ListOfValue> getBasicService() throws Exception {
		return basicService;
	}
	
	/**
	 * 插入或更新前做操作
	 */
	public void beforUpsert(ListOfValue entity, HttpServletRequest request) throws Exception{
		
		// 根据类型，独立源代码查询是否存在
		if("NEW".equals(entity.getRow_status())){
			ListOfValue listOfValue = basicService.getLovByNameAndType(entity.getVal(), entity.getType());
			if(null != listOfValue) throw new BasicControllerException("类型和独立源代码不能重复！");
 		}
		
		
	}
	
	@RequestMapping(value = "/parentPickList")
	@ResponseBody
	public Map<String, Object> parentPickList(QueryParams qps, ListOfValue entity, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			qps.preDealSecurity(request);
			ListOfValue t = (ListOfValue) BasicModel.transformClass(ListOfValue.class, qps);
			t.setActiveFlag("Y");//筛选有效的
			List<ListOfValue> list = getBasicService().queryByExamplePage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(t, list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<ListOfValue>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/flushCache")
	@ResponseBody
	public Map<String, Object> flushCache(HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Jedis jedis = RedisUtil.getJedis();
			String keyPrefix = lovRedisPrefix;
			String corpId = UserUtil.getUser(null) != null ? UserUtil.getUser(null).getCorpid() : "";
			Set<String> set = jedis.keys(keyPrefix +"*"+"_"+corpId);  
			if(set.size() > 0){
				String[] keyStrs = new String[set.size()];
				int i = 0;
		        Iterator<String> it = set.iterator();  
		        while(it.hasNext()){  
		            String keyStr = it.next();  
		            keyStrs[i] = keyStr;  
		            i++;
		        }  
		        jedis.del(keyStrs);
			}
	        result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/list/{type}")
	public void list(@PathVariable String type, ListOfValue entity, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		QueryParams qps = new QueryParams();
		String redisKey = lovRedisPrefix;
		qps.addFilter(new Filter("type", type.toUpperCase()));
		redisKey += type.toUpperCase();
		if (StringUtils.isNotBlank(entity.getParentName())) {
			qps.addFilter(new Filter("parentName", entity.getParentName()));
			redisKey += "#1"+entity.getParentName();
		}
		if (StringUtils.isNotBlank(entity.getParentVal())) {
			qps.addFilter(new Filter("parentVal", entity.getParentVal()));
			redisKey += "#2"+entity.getParentVal();
		}
		if (StringUtils.isNotBlank(entity.getParentId())) {
			qps.addFilter(new Filter("parentId", entity.getParentId()));
			redisKey += "#3"+entity.getParentId();
		}
		Jedis jedis = RedisUtil.getJedis();
		redisKey += "_";
		redisKey += UserUtil.getUser(null) != null ? UserUtil.getUser(null).getCorpid() : "";
		//String listJson = jedis.get(redisKey);
		String listJson = null;
		if(!StringUtils.isBlank(listJson)){
			jedis.expire(redisKey, expireTime);
			this.responseJson(request, response, listJson);
			return ;
		}
		
		qps.addSorter(new Sorter("seq", "ASC"));
		try {
			qps.setPageFlag(false);
			ListOfValue t = (ListOfValue) BasicModel.transformClass(ListOfValue.class, qps);
			t.setActiveFlag("Y");//筛选有效的
			String json = getAndSet(redisKey, t);
			
			this.responseJson(request, response, json);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 根据值列表类型查询
	 * @param types 类型  '"[*,*,..]"'
	 * @return
	 */
	@RequestMapping(value = "/listOfVal/types")
	//@ResponseBody
	public void listOfValTypes(String types, ListOfValue entity, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		//Map<String, Object> result = new HashMap<String, Object>();
		try {
			//解析types字符串，分解为多个值列表类型，然后逐个查询后拼接成一个list返回
			String startStr = "\"[";
			String endStr = "]\"";
			//String corpId = UserUtil.getUser(null) != null ? UserUtil.getUser(null).getCorpid() : "";//在值列表上去掉crop_id
			String typeArray[] = types.substring(types.indexOf(startStr) + startStr.length(),types.indexOf(endStr)).split(",");
			Jedis jedis = RedisUtil.getJedis();
			StringBuilder resultJsonStrb = new StringBuilder("[");
			for(int i=0; i<typeArray.length; i++){
				String str = typeArray[i];
				//String redisKey = lovRedisPrefix+str.toUpperCase()+"_" + corpId;//代码修改anxb
				String redisKey = lovRedisPrefix+str.toUpperCase();
				entity.setConditionSql(" and activeFlag = 'Y' and type ='"+str.toUpperCase()+"'");//筛选有效的和指定类型
				entity.setOrderByClause(" seq asc ");
				entity.setPageFlag(false);
				String jsonStr = getAndSet(redisKey, entity);
				//String jsonStr = jedis.get(redisKey);
				if(!StringUtils.isBlank(jsonStr) && !"[]".equals(jsonStr)){
					/*JSONArray jsonArray = JSONArray.fromObject(jsonStr);
					list.addAll(JSONArray.toList(jsonArray, ListOfValue.class));*/
					jsonStr = jsonStr.substring(1, jsonStr.length()-1);
					resultJsonStrb.append(jsonStr);
					resultJsonStrb.append(",");
					jedis.expire(redisKey, expireTime);
					continue;
				}else{
					/*if(!StringUtils.isBlank(typeStr)){
						typeStr += ", '"+str+"' ";
					}else{
						typeStr += "'"+str+"' ";
					}*/
					logger.error("Can not find lov result with type '"+str+"' ");
				}
			}
			/*if(!StringUtils.isBlank(typeStr)){
				entity.setConditionSql(" and activeFlag = 'Y' and type in ( "+typeStr+")");//筛选有效的和指定类型
				entity.setOrderByClause(" type, seq asc ");
				entity.setPageFlag(false);
				
				List<ListOfValue> list1 = basicService.queryByExamplePage(entity);
				String type = "";
				if(list1 != null && list1.size()>0){
					type = list1.get(0).getType();
				}
				int i=0;
				int j=0;
				for( i=0; i<list1.size(); i++){
					ListOfValue lov = list1.get(i);
					
					*//** 根据类型分类进行缓存 *//*
					if(!type.equals(lov.getType()) || i == list1.size()-1){
						List<ListOfValue> list2 = null;
						if(i == list1.size()-1){
							list2 = list1.subList(j, list1.size());
						}else{
							list2 = list1.subList(j, i);
						}
						String redisKey = lovRedisPrefix+type.toUpperCase()+"_" + corpId;
						String json = JSONArray.fromObject(list2).toString();
						jedis.set(redisKey, json);
						jedis.expire(redisKey, expireTime);
						json = json.substring(1, json.length()-1);
						if(i == list1.size()-1){
							resultJsonStrb.append(json);
						}else{
							resultJsonStrb.append(json);
							resultJsonStrb.append(",");
						}
						type = lov.getType();
						j = i;
					}
				}
			}*/
			resultJsonStrb.append("]");
			JSONObject jsonObj = JSONObject.fromObject("{}");
			jsonObj.put("success", true);
			jsonObj.put("rows", resultJsonStrb.toString());
			String resultJson = jsonObj.toString();
			this.responseJson(request, response, resultJson);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 
	 *<p>防止值列表缓存被击穿</p>
	 * @author yrf
	 * @param key
	 * @param example
	 * @return
	 * @throws Exception
	 */
	private String getAndSet(String key, ListOfValue example) throws Exception{
		Jedis jedis = RedisUtil.getJedis();
		String result = jedis.get(key);
		result=null;//代码更新anxb
		if(result == null){
			if(example == null){
				return null;
			}
			final String[] stayFields = {"id", "type","val","name","parentId", "parentType", "parentVal", "parentName", "seq"};
			String mutexKey = key +"_mutex";
			//if(jedis.setnx(mutexKey, "Y") == 1){ //代码修改anxb
			if(1 == 1){ //设置成功
				List<ListOfValue> list = basicService.queryByExamplePage(example);
				
				Gson gson = new GsonBuilder().setExclusionStrategies(new ExclusionStrategy() {
					@Override
					public boolean shouldSkipField(FieldAttributes f) {
						for(int i=0; i<stayFields.length; i++){
							if(f.getName().equals(stayFields[i])){
								return false;
							}
						}
						return true;
					}
					
					@Override
					public boolean shouldSkipClass(Class<?> clazz) {
						//过滤掉 类名包含 Bean的类
		                return false;
					}
				}).create();
				
				
				/** 缓存 */
				String json = gson.toJson(list);
				//String json = JSONArray.fromObject(list).toString();
				jedis.set(key, json);
				jedis.expire(key, expireTime);
				jedis.del(mutexKey);
				result = json;
			}else{ //表示有其他线程正在db查询相同值列表，等待
				Thread.sleep(100);
				result = getAndSet(key, example);
			}
		}
		return result;
	}
	@RequestMapping(value = "/getobjlink/get")
	@ResponseBody
	public Object getobjlink(@RequestParam("parentid") String parentid, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		QueryParams qps = new QueryParams();
		qps.addFilter(new Filter("parentid", parentid));
		List<ListOfValue> list = null;
		try {
//			list = lnkAutoConfigService.queryObjectLink(qps);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@RequestMapping(value = "/getobjwhere/{type}")
	@ResponseBody
	public Object getobjwhre(@PathVariable String type, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		QueryParams qps = new QueryParams();
		qps.addFilter(new Filter("parentid", type.toUpperCase()));
		List<ListOfValue> list = null;
		try {
//			list = lnkAutoConfigService.queryObjectLink(qps);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public void beforeImport(ListOfValue entity, HttpServletRequest request) throws Exception{
		
//		QueryParams queryParams = new QueryParams();
//		queryParams.addFilter(new Filter("name",entity.getCorpName()));
//		Enterprise enterprise = (Enterprise)BasicModel.transformClass(Enterprise.class, queryParams);
//		enterprise.setPageFlag(false);
//		List<Enterprise> list = enterpriseService.queryByExamplePage(enterprise);
//		if(list.size() == 1){
//			entity.setCorpid(list.get(0).getCode());
//		}else{
//			throw new Exception("导入公司套帐有误，请修改后重新导入！");
//		}
	}

}
