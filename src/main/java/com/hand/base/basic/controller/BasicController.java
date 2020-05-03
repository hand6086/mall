package com.hand.base.basic.controller;

import com.google.gson.ExclusionStrategy;
import com.google.gson.FieldAttributes;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.hand.base.audittrail.model.AuditTrail;
import com.hand.base.audittrail.service.AuditTrailService;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.user.model.User;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.modules.excel.HssfExcelHelper;
import com.hand.core.modules.excel.XssfExcelHelper;
import com.hand.core.modules.export.ExportFactory;
import com.hand.core.modules.export.ExportWriter;
import com.hand.core.modules.imports.ImportReader;
import com.hand.core.modules.imports.ImportsFactory;
import com.hand.core.util.RedisUtil;
import com.hand.core.util.StringUtils;
import com.hand.core.util.UserUtil;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import redis.clients.jedis.Jedis;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/action/portal/base")
public class BasicController<T extends BasicModel> {
	
	private static final Logger logger = LogManager.getLogger(BasicController.class);
	
	@Autowired
	private AuditTrailService auditTrailService;
	/**
	 * 根据条件查询记录,不分页
	 */
	@RequestMapping(value = "/queryAll")
	@ResponseBody
	public Map<String, Object> queryAll(QueryParams qps, T entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			T t = (T) BasicModel.transformClass(entity, qps);
			beforQueryAllOrExample(t,request);
			beforQueryAll(t,request);
			List<T> list = getBasicService().queryAll(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<T>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 根据条件查询记录,默认分页(若将'pageFlag'设置为'false'，则不分页)
	 */
	@RequestMapping(value = "/queryByExamplePage")
	@ResponseBody
	public Map<String, Object> queryByExamplePage(QueryParams qps, T entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		User user = UserUtil.getUser(session);
		try{
			qps.preDealSecurity(request);
			T t = (T)BasicModel.transformClass(entity, qps);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);

			List<T> list = getBasicService().queryByExamplePage(t);
			result.put("success", true);
			result.put("rows", list);
			if(!t.getOnlyCountFlag()){
				this.pushCurrentDataCache(list, session.getId(), "base", false);
			}
			result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<T>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 根据条件查询记录,默认分页(若将'pageFlag'设置为'false'，则不分页)
	 * @throws IOException 
	 */
	@RequestMapping(value = "/queryFieldsByExamplePage")
	public void queryByExamplePage2(QueryParams qps, T entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		//final String[] skips = qps.getSkipFields().split(",");
		final String[] stays = qps.getStayFields().split(",");
		qps.setStayFieldsFlag("onlyStayFields");
		result = queryByExamplePage(qps, entity, session, request, response);
		Gson gson = new GsonBuilder().setExclusionStrategies(new ExclusionStrategy() {
			@Override
			public boolean shouldSkipField(FieldAttributes f) {
				for(int i=0; i<stays.length; i++){
					if(f.getName().equals(stays[i])){
						return false;
					}
				}
//				return false;
				return true;
			}
			
			@Override
			public boolean shouldSkipClass(Class<?> clazz) {
				//过滤掉 类名包含 Bean的类
                return false;
			}
		}).create();
		PrintWriter out = null;
		String json = gson.toJson(result);
		try{
			response.setContentType("text/html;charset=utf-8");
			out = response.getWriter();
			out.write(json);
			out.flush();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(out != null){
				out.close();
			}
		}
	}
	
	/**
	 * 记录计数
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/countByExample")
	@ResponseBody
	public Map<String, Object> countByExample(QueryParams qps, T entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			T t = (T)BasicModel.transformClass(entity, qps);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			int count = getBasicService().countByExample(t);
			result.put("total", count);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<T>());
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 导出
	 */
	@RequestMapping(value = "/queryByExamplePage/exportData")
	@ResponseBody
	public Map<String, Object> exportData(T entity, QueryParams qps, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		logger.info("导出列表...");
		Map<String, Object> result = new HashMap<String, Object>();
		User user = UserUtil.getUser(session);
		try{
			qps.preDealSecurity(request);
			ExportWriter exportWriter = ExportFactory.newInstance(qps);
			T t = (T)BasicModel.transformClass(entity, qps);
			beforExportExample(t,request);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			//导出全部 不分页
			t.setPageFlag(false);
			List<T> list = getBasicService().queryByExamplePage(t);
			while(!qps.stopExport){
				exportWriter.wirteData(list);
			}
			result.put("success", true);
			result.put("url", exportWriter.getUrlPath());
			//result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 导入CSV
	 */
	@RequestMapping(value = "/importData")
	@ResponseBody
	@Transactional
	public Map<String, Object> importData(T entity, QueryParams qps, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		logger.info("导入列表。。。");
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			ImportReader importReader = ImportsFactory.newInstance(qps, request);
			List<T> list = (List<T>) importReader.readListFromInputStream(entity.getClass());
			
			
//			getBasicService().batchInsertList(list);
			for (int i = 0; list != null && i < list.size(); i++) {
				T record = list.get(i);
				beforeImport(record,request);
				getBasicService().insert(record);
			}
			result.put("success", true);
			result.put("total", list.size());
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	/**
	 * DMS导入Excel
	 */
	@RequestMapping(value = "/importExcel")
	@ResponseBody
	@Transactional
	public Map<String, Object> importExcel(T entity, QueryParams qps, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		logger.info("导入Excel...");
		Map<String, Object> result = new HashMap<String, Object>();
		//文件获取与类型转换
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request; 
		MultipartFile file=multipartRequest.getFile("file");
		CommonsMultipartFile cf= (CommonsMultipartFile)file;
        DiskFileItem fi = (DiskFileItem)cf.getFileItem();
        File f = fi.getStoreLocation();
		String isCheck = multipartRequest.getParameter("isCheck");
		String fileName = file.getOriginalFilename();
		String fileext = fileName.substring(fileName.lastIndexOf("."),fileName.length());  
   		fileext=fileext.toLowerCase();  
   		List<T> list = new ArrayList<T>();
   		//StringBuffer fieldNames = new StringBuffer();
   		String fieldNames="";//对应字段名
   		int sheetNo = 0;//默认0
   		boolean hasTitle = false;//默认无标题
   		boolean isHeadAndItem = false;//默认非头行导入模式
   		try {
   			//设置属性操作值
   			beforReadExcel(entity,qps,request);
   			fieldNames = qps.getAttr1();
   			if(qps.getAttr2() != null){
   				sheetNo = Integer.parseInt(qps.getAttr2());
   			}
   			if(qps.getAttr3() != null){
   				hasTitle = Boolean.parseBoolean(qps.getAttr3());
   			}
   			if(qps.getAttr4() != null){
   				isHeadAndItem = Boolean.parseBoolean(qps.getAttr4());
   			}
   			
		    if (".xls".equals(fileext)){  
		    	HssfExcelHelper excel2003 = HssfExcelHelper.getInstance(f);
		    	String[] fieldNamess = fieldNames.split(",");
		    	list = (List<T>) excel2003.readExcel(entity.getClass(), fieldNamess, sheetNo, hasTitle);
		    }else if(".xlsx".equals(fileext)){
		    	XssfExcelHelper excel2007 = XssfExcelHelper.getInstance(f);
		    	//beforReadExcel(entity,fieldNames,sheetNo,hasTitle,isHeadAndItem,request);
		    	String[] fieldNamess = fieldNames.split(",");
		    	list = (List<T>) excel2007.readExcel(entity.getClass(), fieldNamess, sheetNo, hasTitle);
		    }else{
		    	throw new BasicServiceException("不支持的Excel格式！");
		    }
		    if("true".equals(isCheck)){//检测excel数据是否有效
		    	importCheckExcel(list,request);
		    }else if(isHeadAndItem){//头行导入
		    	importHeadAndItemExcel(list,request);
		    }else{//行导入
		    	for (int i = 0; list != null && i < list.size(); i++) {
		    		T record = list.get(i);
		    		beforeImportExcel(record,request);
		    		getBasicService().insert(record);
		    	}
		    }
			result.put("success", true);
			result.put("total", list.size());
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	/**
	 * 深度复制
	 */
	@RequestMapping(value = "/deepCopy")
	@ResponseBody
	public Map<String, Object> deepCopy(T entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			throw new BasicServiceException("深度复制失败，请检查程序代码。");
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 新建一条记录
	 */
	@RequestMapping(value = "/insert")
	@ResponseBody
	public Map<String, Object> insert(T entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		User user = UserUtil.getUser(session);
		try{
			beforInsert(entity, request);
			beforUpsert(entity, request);
			getBasicService().insert(entity);
			T newEntry = getBasicService().queryById(entity);

			auditTrailInsert(entity,request,session,"N");    //审计追踪新建记录
			
			result.put("newRow", newEntry);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 新建默认值
	 */
	@RequestMapping(value = "/preDefaultValue", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public Map<String, Object> preDefaultValue(T entity, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			result.put("success", true);
			result.put("result", getBasicService().preDefaultValue(entity));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 新建多条记录
	 */
	@RequestMapping(value = "/batchInsert")
	@ResponseBody
	public Map<String, Object> batchInsert(@RequestBody List<T> list, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			T entity = null;
			for(int i =0;list != null && i < list.size();i++){				
				entity = list.get(i);				
				beforInsert(entity, request);
				beforUpsert(entity, request);

				auditTrailInsert(entity,request,session,"BN");    //审计追踪新建记录
			}
			getBasicService().batchInsert(list);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 
	 *<p>批量更新</p>
	 * @author yrf
	 * @param list
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/batchUpdate")
	@ResponseBody
	public Map<String, Object> batchUpdate(@RequestBody List<T> list, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			T entity = null;
			for(int i =0;list != null && i < list.size();i++){				
				entity = list.get(i);				
				beforUpdate(entity, request);
				beforUpsert(entity, request);

				auditTrailInsert(entity,request,session,"BU");    //审计追踪新建记录
			}
			getBasicService().batchUpdate(list);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}

	/**
	 * 查询一条记录
	 */
	@RequestMapping(value = "/queryById")
	@ResponseBody
	public Map<String, Object> queryById(T entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		User user = UserUtil.getUser(session);
		try{
			T record = getBasicService().queryById(entity);
			List<T> list = new ArrayList<T>();
			list.add(record);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("result", record);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 新建或更新一条记录
	 */
	@RequestMapping(value = "/upsert")
	@ResponseBody
	public Map<String, Object> upsert(T entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		User user = UserUtil.getUser(session);
		try{
			beforUpsert(entity, request);
			checkData(entity, request);
			/*if(!getBasicService().isInsertFlag(entity) && !checkExistDataCache("base", session, entity)){
				throw new BasicServiceException("您操作太快了，请点击下方刷新按钮后再修改记录！");
			}*/
			getBasicService().upsert(entity);
			T newEntry = getBasicService().queryById(entity);

			auditTrailInsert(entity,request,session,"US");    //审计追踪新建记录

			result.put("newRow", newEntry);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}

	/**
	 * 更新一条记录
	 */
	@RequestMapping(value = "/update")
	@ResponseBody
	public Map<String, Object> update(T entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		User user = UserUtil.getUser(session);
		try{
			T newEntry = null;
			beforUpdate(entity, request);
			beforUpsert(entity, request);
			checkData(entity, request);
			/*if(!checkExistDataCache("base", session, entity)){
				throw new BasicServiceException("您操作太快了，请点击下方刷新按钮后再修改记录！");
			}*/
			getBasicService().update(entity);
			newEntry = getBasicService().queryById(entity);


			auditTrailInsert(entity,request,session,"U");    //审计追踪新建记录
			
			
			result.put("newRow", newEntry);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 删除一条记录
	 */
	@RequestMapping(value = "/deleteById")
	@ResponseBody
	public Map<String, Object> deleteById(T entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		logger.info("删除一条列表信息...");
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			beforDelete(entity, request);
			checkData(entity, request);
			/*if(!checkExistDataCache("base", session, entity)){
				throw new BasicServiceException("您操作太快了，请点击下方刷新按钮后再修改记录！");
			}*/
			
			auditTrailInsert(entity,request,session,"D");    //审计追踪新建记录
			getBasicService().deleteById(entity);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 删除多条记录
	 */
	@RequestMapping(value = "/batchDelete")
	@ResponseBody
	public Map<String, Object> batchDelete(@RequestBody List<T> list, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			T entity = null;
			for(int i =0;list != null && i < list.size();i++){
				entity = list.get(i);
				beforDelete(entity, request);
				checkData(entity, request);
				/*if(!checkExistDataCache("base", session, entity)){
					throw new BasicServiceException("您操作太快了，请点击下方刷新按钮后再修改记录！");
				}*/
				auditTrailInsert(entity,request,session,"BD");    //审计追踪新建记录
			}
			getBasicService().batchDelete(list);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 获取Service
	 */
	public BasicService<T> getBasicService() throws Exception{
		throw new BasicControllerException("获取Basic Service 失败，请确认程序代码是否正确！");
	}
	
	public T postDefaultValue(T entity) throws Exception {
		return entity;
	}
	
	/**
	 * 查询所有记录前 或 根据条件查询记录前 做操作
	 */
	public void beforQueryAllOrExample(T entity, HttpServletRequest request) throws Exception{}
	
	/**
	 * 导出前做操作
	 */
	public void beforExportExample(T entity, HttpServletRequest request) throws Exception{}

	/**
	 * 查询所有记录前做操作
	 */
	public void beforQueryAll(T entity, HttpServletRequest request) throws Exception{}

	/**
	 * 根据条件查询记录前做操作
	 */
	public void beforQueryExample(T entity, HttpServletRequest request) throws Exception{}
	
	/**
	 * 更新前做操作
	 */
	public void beforUpdate(T entity, HttpServletRequest request) throws Exception{}
	
	/**
	 * 品牌馆更新前做操作
	 */
	public void beforBrandUpdate(T entity, HttpServletRequest request) throws Exception{}
	
	/**
	 * 插入前做操作
	 */
	public void beforInsert(T entity, HttpServletRequest request) throws Exception{}
	
	/**
	 * 品牌馆插入前做操作
	 */
	public void beforBrandInsert(T entity, HttpServletRequest request) throws Exception{}
	
	/**
	 * 删除前做操作
	 */
	public void beforDelete(T entity, HttpServletRequest request) throws Exception{}
	
	/**
	 * 插入或更新前做操作
	 */
	public void beforUpsert(T entity, HttpServletRequest request) throws Exception{}
	
	/**
	 * 品牌馆插入或更新前做操作
	 */
	public void beforBrandUpsert(T entity, HttpServletRequest request) throws Exception{}
	
	/**
	 * 导入前做操作
	 */
	public void beforeImport(T entity, HttpServletRequest request) throws Exception{}
	
	/**
	 * 数据校验
	 */
	public void checkData(T entity, HttpServletRequest request) throws Exception{}
	/**
	 * 导入读取Excel前做操作
	 */
	public void beforReadExcel(T entity, QueryParams qps, HttpServletRequest request) throws Exception{}
	/**
	 * 导入Excel前做操作
	 */
	public void beforeImportExcel(T entity, HttpServletRequest request) throws Exception{}
	/**
	 * 导入做的检测操作
	 */
	public void importCheckExcel(List<T> entity, HttpServletRequest request) throws Exception{}
	/**
	 * 导入头行时的操作
	 */
	public void importHeadAndItemExcel(List<T> entity, HttpServletRequest request) throws Exception{}
	/**
	 * 将list列表中的id存放到redis缓存中
	 * @param list
	 * @sessionId 
	 * @param key
	 * @param flag 是否追加对象
	 */
	public void pushCurrentDataCache(List<T> list, String sessionId, String key, boolean flag){
		//Jedis jedis = RedisUtil.getJedis();
		// 是否追加记录，不追加则清除redis中保存的记录
		/*if(!flag){
			jedis.del(key);
		}
		for(Object object : list){
			if(object instanceof BasicModel){
				String id = ((BasicModel) object).getId();
				jedis.lpush(sessionId + "-" + key, id);
			}
		}
		RedisUtil.returnResource(jedis);*/
	}
	
	/**
	 * 校验id是否存在缓存中
	 * @param key
	 * @param id
	 * @return
	 */
	public static boolean checkExistDataCache(String key, String sessionId, String id){
		Jedis jedis = RedisUtil.getJedis();
		// 是否追加记录，不追加则清除redis中保存的记录
		List<String> list = jedis.lrange(sessionId + "-" + key, 0, -1);
		boolean flag = list.contains(id);
		RedisUtil.returnResource(jedis);
		return flag;
	}
	
	/**
	 * 校验id是否存在缓存中
	 * @param key
	 * @param session
	 * @param entity
	 * @return
	 */
	public boolean checkExistDataCache(String key, HttpSession session, T entity){
		BasicModel basicModel = null;
		if(entity instanceof BasicModel){
			basicModel = (BasicModel)entity;
		}
		if(basicModel == null){
			throw new BasicServiceException("参数格式错误，请检查程序！");
		}
		String sessionId = session.getId();
		String basicModelId = basicModel.getId();
		return checkExistDataCache(key, sessionId, basicModelId);
	}

	
	
	public static Integer getCount(BasicModel basicModel, int len){
		if(basicModel.getTotalFlag()) return basicModel.getTotal();
		int startRow = basicModel.getStartRow();
		int rows = basicModel.getRows();
		if(len < rows) return startRow + len - 1;
		if(rows == len) return startRow+ rows;
		return basicModel.getTotal();
	}
	
	/**
	 * 操作时在审计追踪中新建记录
	 */
	public void auditTrailInsert(T entity, HttpServletRequest request,HttpSession session,String status) throws Exception{
		try{
			AuditTrail auditTrail = new AuditTrail();
			User user = UserUtil.getUser(session);		
			//处理审计追踪
			if(entity instanceof BasicModel){
				BasicModel basicModel = (BasicModel)entity;
				String statusFlag = basicModel.getRow_status();
				auditTrail.setBuscompName(entity.getClass().getName());
				if(StringUtils.equals(status, "N") || StringUtils.equals(status, "BN")){
					auditTrail.setAction("新建");
				}
				else if(StringUtils.equals(status, "US")){
					if(StringUtils.equals(statusFlag, "NEW")){					
						auditTrail.setAction("新建");
					}
					else if(StringUtils.equals(statusFlag, "UPDATE")){				
						auditTrail.setAction("更新");			
					}
				}
				else if(StringUtils.equals(status, "U")){
					auditTrail.setAction("更新");
				}
				else if(StringUtils.equals(status, "D") || StringUtils.equals(status, "BD")){
					auditTrail.setAction("删除");
				}				
				SimpleDateFormat dfFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date myDate = new Date();
				String sysdate = dfFormat.format(myDate);
				auditTrail.setDateTime(sysdate);
				auditTrail.setUserId(user.getId());
				auditTrail.setLineFlag(basicModel.getId());
				//实现所有参数传入进去
				StringBuilder sb = new StringBuilder();
				Enumeration<?> paramNames = request.getParameterNames();
				while (paramNames.hasMoreElements()) {
					String paramName = (String) paramNames.nextElement();
					String[] paramValues = request.getParameterValues(paramName);
					if (paramValues.length == 1) {
						String paramValue = paramValues[0];
						if (paramValue.length() != 0) {
							sb.append(paramName + ":" + paramValue + "\n\r");
						}
					}
				}
				String field = sb.toString();
				if(field.length() > 2000){
					field = field.substring(0, 2000);
				}				
				auditTrail.setField(field);
				auditTrail.setSourceName("CRM");
				
				auditTrailService.insert(auditTrail);//新建审计追踪项目
			}	
		} catch (Exception e){
			logger.info("--------------------- auditTrailInsert function err ------------------------");
			e.printStackTrace();
		}
	}
	
	public void responseJson(HttpServletRequest request,HttpServletResponse response, String json){
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
			out.append(json);
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (out != null) {
				out.close();
			}
		}
	}
}
