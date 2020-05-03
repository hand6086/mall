package com.hand.core.basic.query;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonToken;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hand.base.user.model.User;
import com.hand.core.util.AppConstants;
import com.hand.core.util.StringUtils;
import com.hand.core.util.UserUtil;

public class QueryParams implements Serializable{

	private static final long serialVersionUID = 1190504473491867752L;
	private static final Logger logger = LogManager.getLogger(QueryParams.class);
	
	private String id;
	private String mvgParentId;					//MVG父对象Id
	private String importParentId;				//行导入使用的父对象ID
	private Integer page = -1;					//当前页数
	private Integer rows = 50;					//每页显示记录数
	private Integer total = -1;					//总记录数
	private Integer totalPage = -1;				//总页数
	private Integer startRow = 0;              	//当前页在数据库中的起始行
	private Integer endRow= 0;              	//当前页在数据库中的截止行
	private String sort;						//esayui 默认排序字段
	private String order;						//esayui 默认排序方式
	private List<Filter> filters = new ArrayList<Filter>();				//查询条件
	private String filtersRaw;					//前端查询条件
	private String sortersRaw;					//前端排序
	private String exportsRaw;					//前端导出列
	private String importsRaw;					//前端导入
	private List<Sorter> sorters;				//排序
	private List<ImportColumn> importColumns;
	private Map<String, String> importColumnMap;
	private List<ExportColumn> exportColumns;	//导出列名和对应字段映射关系
	private String fileName;					//导出文件名前缀
	protected String  LOGIN;					//查询登录用户名
	private String 	userOrgId;					//查询组织Id
	private String 	acctId;						//查询客户Id
	private String  userPositionId;				//查询职位Id
	private Boolean totalFlag = false;			//查询数据总数标志
	private Boolean pageFlag = true;			//分页查询标志
	private Boolean onlyCountFlag = false; //计算总数标记，设为true时只返回总数量，目前仅是为了解决当前模式下无法按条件查询记录总数的问题，注意不要人为的设置值

	public Boolean stopExport = false;			//停止导出查询(中间变量)
	private String createdId;//创建人ID
	private String integrationId;//集成ID
	
	private String oauth;
	private String userId;//用户id
	
	private String brandQuery;
	
	public String getBrandQuery() {
		return brandQuery;
	}

	public void setBrandQuery(String brandQuery) {
		this.brandQuery = brandQuery;
	}
	private String searchParam;	//搜索字段
	private String searchValue;	//搜索字段值
	private String searchCondition;//搜索条件
	
	private String attr1;		//备用字段1（公共查询条件）
	private String attr2;		//备用字段2（公共查询条件）
	private String attr3;		//备用字段3（公共查询条件）
	private String attr4;		//备用字段4（公共查询条件）
	private String attr5;
	private String attr6;
	private String attr7;
	private String usercorpid;//
	private String mvgMapperName;	//要启用的mapper实现类名称
	private String stayFields;//返回报文保留字段
	private String skipFields; //返回报文跳过字段
	private String stayFieldsFlag;//只查询指定字段标记
	
	public String getStayFieldsFlag() {
		return stayFieldsFlag;
	}

	public void setStayFieldsFlag(String stayFieldsFlag) {
		this.stayFieldsFlag = stayFieldsFlag;
	}
	public String getStayFields() {
		if(stayFields == null){
			return "";
		}
		return stayFields;
	}
	public void setStayFields(String stayFields) {
		this.stayFields = stayFields;
	}
	public String getSkipFields() {
		if(skipFields == null){
			return "";
		}
		return skipFields;
	}
	public void setSkipFields(String skipFields) {
		this.skipFields = skipFields;
	}
	public String getUserId() {
		if(userId!=null&&!"".equals(userId)){
			return userId;
		}
		User user = UserUtil.getUser(null);
        if(user == null){
            return null;
        }
        return user.getId();
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public Boolean getOnlyCountFlag() {
		return onlyCountFlag;
	}
	public void setOnlyCountFlag(Boolean onlyCountFlag) {
		this.onlyCountFlag = onlyCountFlag;
	}
	public String getUsercorpid() {
		if(usercorpid != null && !"".equals(usercorpid)){
			return usercorpid;
		}
		User user = UserUtil.getUser(null);
        if(user == null){
            return null;
        }
        return user.getCorpid();
	}
	public void setUsercorpid(String usercorpid) {
		this.usercorpid = usercorpid;
	}
	
	public String getMvgMapperName() {
		return mvgMapperName;
	}
	public void setMvgMapperName(String mvgMapperName) {
		this.mvgMapperName = mvgMapperName;
	}
	public String getIntegrationId() {
		return integrationId;
	}

	public void setIntegrationId(String integrationId) {
		this.integrationId = integrationId;
	}

	public String getCreatedId() {
	    User user = UserUtil.getUser(null);
	    if(user == null){
	        return null;
	    }
		return user.getId();
	}
	
	public void setCreatedId(String createdId) {
		this.createdId = createdId;
	}
	public Integer getPage() {
		return page;
	}
	public void setPage(Integer page) {
		this.page = page;
	}
	public Integer getRows() {
		return rows;
	}
	public void setRows(Integer rows) {
		this.rows = rows;
	}
	
	public String getFiltersRaw() {
		return filtersRaw;
	}
	public void setFiltersRaw(String filtersRaw) {
		this.filtersRaw = filtersRaw;
	}
	public String getSortersRaw() {
		return sortersRaw;
	}
	public void setSortersRaw(String sortersRaw) {
		this.sortersRaw = sortersRaw;
	}
	public Integer getStartRow() {
		if(page > 0)
			startRow = (page - 1) * rows + 1;	
		return startRow;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	/**
	 * 新增Filter
	 * @param id  filter id
	 * @param filter filter对象
	 */
	public void addFilter(Filter filter){
		if(filters == null) filters = new ArrayList<Filter>();
			
		Filter filterTmp = null;
		for(int i = 0; i < filters.size(); i ++){
			filterTmp = filters.get(i);
			if(filterTmp != null && filterTmp.equalsWithoutValue(filter)){
				filters.set(i, filter);
			}	
		}
		filters.add(filter);
	}
	
	/**
	 * 新增Filter
	 * @param id  filter id 指定位置
	 * @param filter filter对象
	 */
	private void addFilter(Filter filter,int index){
		if(filters == null) filters = new ArrayList<Filter>();
			
		Filter filterTmp = null;
		for(int i = 0; i < filters.size(); i ++){
			filterTmp = filters.get(i);
			if(filterTmp != null && filterTmp.equalsWithoutValue(filter)){
				filters.set(i, filter);
			}	
		}
		filters.add(index,filter);
	}
	/**
	 * 删除Filter
	 * @param id filter id
	 * @return 被删除的Filter对象
	 */
	public Filter removeFilter(Filter toRemove){
		Filter filter = null;
		for(int i = 0; i < filters.size(); i ++){
			filter = filters.get(i);
			if(filter != null && filter.equalsWithoutValue(toRemove)){
				filters.remove(i);
				return filter;
			}	
		}
		return null;
	}
	
	/**
	 * 获取Filter
	 * @param property filter property
	 * @param property filter operator
	 * @return filter 对象
	 */
	public Filter getFilter(String property,String operator){
		Filter filterExample = new Filter();
		filterExample.setProperty(property);
		filterExample.setOperator(operator);
		
		Filter filter;
		for(int i = 0; filters != null && i < filters.size(); i ++){
			filter = filters.get(i);
			if(filter != null && filter.equalsWithoutValue(filterExample)) {
				return filter;
			}
		}
		
		return null;
	}
	
	/**
	 * 获取Filter
	 * @param property filter property
	 * @return filter 对象
	 */
	public List<Filter> getFilterByProperty(String property){
		List<Filter> matchFilters = new ArrayList<Filter>();
		Filter filter = null;
		if(filters == null){
			return matchFilters;
		}
		for(int i = 0; i < filters.size(); i ++){
			filter = filters.get(i);
			if(filter != null && filter.getProperty()!=null && filter.getProperty().equalsIgnoreCase(property)) {
				matchFilters.add(filter);
			}
		}
		
		return matchFilters;
	}
	
	/**
	 * 根据property 获取sorter
	 * @param property
	 * @return
	 */
	public List<Sorter> getSorterByProperty(String property){
		List<Sorter> matchSorters = new ArrayList<Sorter>();
		if(sorters == null){
			return matchSorters;
		}
		for(int i = 0; i < sorters.size(); i ++){
			Sorter sorter = sorters.get(i);
			if(sorter != null && sorter.getProperty()!=null && sorter.getProperty().equalsIgnoreCase(property)) {
				matchSorters.add(sorter);
			}
		}
		return matchSorters;
	}
	
	/**
	 *  获取Sorter
	 * @param property sorter property
	 * @return sorter 对象
	 */
	public Sorter getSorter(String property){
		Sorter sorterExample = new Sorter();
		sorterExample.setProperty(property);
		
		Sorter sorter;
		for(int i = 0; i < sorters.size(); i ++){
			sorter = sorters.get(i);
			if(sorter != null && sorter.equalsWithoutDirection(sorterExample)) {
				return sorter;
			}
		}
		
		return null;
	}
	
	/**
	 * 新增Sorter
	 * @param id  sorter id
	 * @param sorter sorter对象
	 */
	public void addSorter(Sorter sorter){
		if(sorters == null) sorters = new ArrayList<Sorter>();
		Sorter sorterTmp = null;
		for(int i = 0; i < sorters.size(); i ++){
			sorterTmp = sorters.get(i);
			if(sorterTmp != null && sorterTmp.equalsWithoutDirection(sorter)){
				sorters.set(i, sorter);
			}	
		}
		sorters.add(sorter);
	}

	private void addSorter(Sorter sorter,int index){
		if(sorters == null) sorters = new ArrayList<Sorter>();
		Sorter sorterTmp = null;
		for(int i = 0; i < sorters.size(); i ++){
			sorterTmp = sorters.get(i);
			if(sorterTmp != null && sorterTmp.equalsWithoutDirection(sorter)){
				sorters.set(i, sorter);
			}	
		}
		sorters.add(index,sorter);
	}

	/**
	 * 删除Sorter
	 * @param id sorter id
	 * @return 被删除的Sorter对象
	 */
	public Sorter removeSorter(Sorter toRemove){
		Sorter sorter = null;
		for(int i = 0; i < sorters.size(); i ++){
			sorter = sorters.get(i);
			if(sorter != null && sorter.equalsWithoutDirection(sorter)){
				sorters.remove(i);
				return sorter;
			}	
		}
		
		return null;
	}
	public void parseFromRaw(){
		try{
			JsonFactory  jsonFacotry = new JsonFactory();
			//CustomObjectMapper objectMapper = new CustomObjectMapper();
			ObjectMapper objectMapper = new ObjectMapper();
			//从json字符串转换为 Filter对象
			if(filtersRaw !=null) {
				if(filters == null) filters = new ArrayList<Filter>();
				JsonParser jsonParse = jsonFacotry.createParser(filtersRaw);
				jsonParse.nextToken();
				while (jsonParse.nextToken() == JsonToken.START_OBJECT) {
					Filter filter = objectMapper.readValue(jsonParse, Filter.class);
					if(filter.getValue() != null){
						if(!filters.contains(filter)) filters.add(filter);
					}
				}
				jsonParse.close();
				filtersRaw = null;
			}
			
			//从json字符串转换为 Sorter对象
			if(sortersRaw !=null) {
				if(sorters == null) sorters = new ArrayList<Sorter>();
				JsonParser jsonParse = jsonFacotry.createJsonParser(sortersRaw);
				jsonParse.nextToken();
				while (jsonParse.nextToken() == JsonToken.START_OBJECT) {
					Sorter sorter = objectMapper.readValue(jsonParse, Sorter.class);
					if(!sorters.contains(sorter)) sorters.add(sorter);
				}
				jsonParse.close();
				sortersRaw = null;
			}
			
			if(importsRaw != null){
				if(importColumns == null) importColumns = new ArrayList<ImportColumn>();
				JsonParser jsonParse = jsonFacotry.createJsonParser(importsRaw);
				jsonParse.nextToken();
				importColumnMap = new HashMap<String, String>();
				while (jsonParse.nextToken() == JsonToken.START_OBJECT) {
					ImportColumn importColumn = objectMapper.readValue(jsonParse, ImportColumn.class);
					importParentId = importColumn.getParentid();
					if(!importColumns.contains(importColumn)) {
						importColumnMap.put(importColumn.getTitle(), importColumn.getField());
						importColumns.add(importColumn);
					}
				}
				jsonParse.close();
			}
			
			//从json字符串转换为 ExportColumn对象
			if(exportsRaw !=null) {
				if(exportColumns == null) exportColumns = new ArrayList<ExportColumn>();
				JsonParser jsonParse = jsonFacotry.createJsonParser(exportsRaw);
				jsonParse.nextToken();
				while (jsonParse.nextToken() == JsonToken.START_OBJECT) {
					ExportColumn exportColumn = objectMapper.readValue(jsonParse, ExportColumn.class);
					if(!exportColumns.contains(exportColumn)) exportColumns.add(exportColumn);
				}
				jsonParse.close();
				exportsRaw = null;
			}
			
			//如果没有分页时默认，不查询总数
			if(!pageFlag){
				totalFlag = false;
			}
		}catch(Exception e){
			logger.error("json parse error!", e);
			filters = null;
			sorters = null;
			importsRaw = null;
			exportColumns = null;
		}
	}
	
	public Integer getEndRow() {
		if(page > 0)
			endRow = page * rows;
		return endRow;
	}
	public String getLOGIN() {
		return LOGIN;
	}
	public void setLOGIN(String lOGIN) {
		LOGIN = lOGIN;
	}
	public String getUserOrgId() {
		return userOrgId;
	}
	public void setUserOrgId(String userOrgId) {
		this.userOrgId = userOrgId;
	}
	public String getUserPositionId() {
		return userPositionId;
	}
	public void setUserPositionId(String userPositionId) {
		this.userPositionId = userPositionId;
	}
	public List<Filter> getFilters() {
		return filters;
	}
	public void setFilters(List<Filter> filters) {
		this.filters = filters;
	}
	public List<Sorter> getSorters() {
		return sorters;
	}
	public void setSorters(List<Sorter> sorters) {
		this.sorters = sorters;
	}
	public Integer getTotal() {
		return total;
	}
	public void setTotal(Integer total) {
		this.total = total;
	}
	public Integer getTotalPage() {
		if(page == 1){
			totalPage = total/rows;
			if(total % rows != 0){
				totalPage++;
			}
		}
		return totalPage;
	}
	/**
	 * 将前端排序，搜索字段放入到filter、sorter中
	 */
	public void invokePreFilterAndSorter() {
		if(!StringUtils.isBlank(searchValue) && !StringUtils.isBlank(searchParam)){
			if("eq".equals(searchCondition)){
				addFilter(new Filter(searchParam,Filter.OP_EQUAL,searchValue),0);
			}else if( "between".equals(searchCondition) &&  "created".equals(searchParam) ){//查询创建日期当天数据
				String searchValue1="";
				if(StringUtils.equals(AppConstants.key_applicationDatabase, "mysql")){
					searchValue1 = "STR_TO_DATE('"+ searchValue+" 23:59:59','%Y-%m-%d %H:%i:%S')";
					searchValue = "STR_TO_DATE('"+ searchValue+" 00:00:00','%Y-%m-%d %H:%i:%S')";
				}else{
					searchValue1 = "TO_DATE('"+ searchValue+" 23:59:59','yyyy-mm-dd hh24:mi:ss')";
					searchValue = "TO_DATE('"+ searchValue+" 00:00:00','yyyy-mm-dd hh24:mi:ss')";
				}
				addFilter(new Filter(searchParam,Filter.OP_GREAT_EQUAL,searchValue),0);
				addFilter(new Filter(searchParam,Filter.OP_LESS_EQUAL,searchValue1),1);
			}else if(!StringUtils.isBlank(searchCondition)){
				addFilter(new Filter(searchParam,searchCondition,searchValue),0);
			}
			else{
				addFilter(new Filter(searchParam,Filter.OP_LIKE,searchValue),0);
			}
			
			searchParam = null;
			searchValue = null;
		}
		if(sort != null && order!= null && !sort.isEmpty() && !order.isEmpty()){
			addSorter(new Sorter(sort, order),0);
			sort = null;
			order = null;
		}
		parseFromRaw();
	}
	/**
	 * 添加按"id"排序
	 */
	public void addIdFilter(){
		List<Sorter> sorterList = getSorterByProperty("id");
		if(sorterList == null || sorterList.size() == 0){
			addSorter(new Sorter("id", "DESC"));
		}
	}
	
	/**
	 * 添加按"创建时间"排序
	 */
	public void addcreatedFilter(){
		List<Sorter> sorterList = getSorterByProperty("created");
		if(sorterList == null || sorterList.size() == 0){
			addSorter(new Sorter("created", "DESC"));
		}
	}
	
	
	public String getExportsRaw() {
		return exportsRaw;
	}
	public void setExportsRaw(String exportsRaw) {
		this.exportsRaw = exportsRaw;
	}
	public List<ExportColumn> getExportColumns() {
		return exportColumns;
	}
	public void setExportColumns(List<ExportColumn> exportColumns) {
		this.exportColumns = exportColumns;
	}
	public String getFileName() {
		if(fileName == null)
			fileName ="";
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	public Boolean getTotalFlag() {
		return totalFlag;
	}
	public void setTotalFlag(Boolean totalFlag) {
		this.totalFlag = totalFlag;
	}
	public Boolean getPageFlag() {
		return pageFlag;
	}
	public void setPageFlag(Boolean pageFlag) {
		this.pageFlag = pageFlag;
	}
	public String getAcctId() {
		return acctId;
	}
	public void setAcctId(String acctId) {
		this.acctId = acctId;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}

	public String getAttr1() {
		return attr1;
	}

	public void setAttr1(String attr1) {
		this.attr1 = attr1;
	}

	public String getAttr2() {
		return attr2;
	}

	public void setAttr2(String attr2) {
		this.attr2 = attr2;
	}

	public String getAttr3() {
		return attr3;
	}

	public void setAttr3(String attr3) {
		this.attr3 = attr3;
	}

	public String getAttr4() {
		return attr4;
	}

	public void setAttr4(String attr4) {
		this.attr4 = attr4;
	}

	public String getAttr5() {
		return attr5;
	}

	public void setAttr5(String attr5) {
		this.attr5 = attr5;
	}

	public String getAttr6() {
		return attr6;
	}

	public void setAttr6(String attr6) {
		this.attr6 = attr6;
	}

	public String getAttr7() {
		return attr7;
	}

	public void setAttr7(String attr7) {
		this.attr7 = attr7;
	}

	public String getSearchParam() {
		return searchParam;
	}

	public void setSearchParam(String searchParam) {
		this.searchParam = searchParam;
	}

	public String getSearchValue() {
		return searchValue;
	}

	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}
	public String getSearchCondition() {
		return searchCondition;
	}
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	public String getMvgParentId() {
		return mvgParentId;
	}
	public void setMvgParentId(String mvgParentId) {
		this.mvgParentId = mvgParentId;
	}
	public List<ImportColumn> getImportColumns() {
		return importColumns;
	}
	public void setImportColumns(List<ImportColumn> importColumns) {
		this.importColumns = importColumns;
	}
	public Map<String, String> getImportColumnMap() {
		return importColumnMap;
	}
	public void setImportColumnMap(Map<String, String> importColumnMap) {
		this.importColumnMap = importColumnMap;
	}
	public String getImportsRaw() {
		return importsRaw;
	}
	public void setImportsRaw(String importsRaw) {
		this.importsRaw = importsRaw;
	}
	public void preDealSecurity(HttpServletRequest request) {
		String oauthFlag = request.getParameter("oauthFlag");
		if(!StringUtils.equals(oauthFlag, "true")){
			oauth = "";
			return;
		}
		/*Cookie[] cookies = request.getCookies();
		for(int i=0;i<cookies.length;i++){
			if("oauth".equals(cookies[i].getName())){
				oauth = cookies[i].getValue();
			}
		}*/
	}
	public String getOauth() {
		return oauth;
	}
	public void setOauth(String oauth) {
		this.oauth = oauth;
	}
	public String getImportParentId() {
		return importParentId;
	}
	public void setImportParentId(String importParentId) {
		this.importParentId = importParentId;
	}
}
