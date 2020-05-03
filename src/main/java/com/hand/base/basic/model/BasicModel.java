package com.hand.base.basic.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.user.model.User;
import com.hand.core.basic.query.Filter;
import com.hand.core.basic.query.QueryException;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.basic.query.Sorter;
import com.hand.core.util.AppConstants;
import com.hand.core.util.DateUtil;
import com.hand.core.util.UserUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.BeanUtils;

import javax.servlet.http.HttpServletRequest;
import java.io.Serializable;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class BasicModel implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -3319042594736606998L;
	private String	createdBy;				// 创建人Id
	private String	created;				// 创建日期
	private String	lastUpdated;			// 最后更新时间
	private String	lastUpdatedBy;			// 最后更新人Id
	private String	id;						// 对象Id
	private String	corpid;					// 企业帐套编号
	private String  corpName;				// 企业帐套名称
	private String  storeName;				// 店铺名称
	private String  storeId;				// 店铺Id
	private String	orgId;					// 组织Id
	private String	orgName;				// 组织名称
	private String	postnId;				// 职位id
	private String	postnName;				// 职位名称
	private String	createdId;				// 职位名称
	@JsonIgnore
	private String	anonymousFlag;			// 匿名标志--只允许服务端设置值
	private String	usercorpid;				// 当前登录人所属公司
	private String	usersystemRole;			// 系统角色
	private String	row_status;				// 操作类型:
											// NEW为插入，UPDATE为更新;用于接收识别前端框架的操作状态
	private Integer	page		= -1;		// 当前页数
	private Integer	rows		= 50;		// 每页显示记录数
	private Integer	total		= -1;		// 总记录数
	private Integer	totalPage	= -1;		// 总页数
	private Integer	startRow	= 0;		// 当前页在数据库中的起始行
	private Integer	startRows	= 0;		// 当前页在数据库中的起始行(不使用框架,直接在sql中写limit时使用)
	private Integer	endRow		= 0;		// 当前页在数据库中的截止行
	private Boolean	totalFlag	= false;	    // 查询数据总数标志
	private Boolean	pageFlag	= true;	// 分页查询标志
	private Boolean onlyCountFlag = false; //计算总数标记，设为true时只返回总数量，目前仅是为了解决当前模式下无法按条件查询记录总数的问题，注意不要人为的设置值
	
	private String	attr1;					// 备用字段1（公共查询条件）
	private String	attr2;					// 备用字段2（公共查询条件）
	private String	attr3;					// 备用字段3（公共查询条件）
	private String	attr4;					// 备用字段4（公共查询条件）
	private String	attr5;
	private String	attr6;
	private String	attr7;
	//@JsonIgnore
	private String	isDefault;				// 是否为主要的（MVGlist使用）
	private String  mvgMapperName;			// 要启用的mapper实现类名称
	private String  mvgParentId;			// MVG父对象ID(MVG模块有用到)
    protected String orderByClause;			// 排序逻辑
    private String  oauth;					// 安全性菜单
    
    @JsonIgnore
	private String  conditionSql;					//查询条件Sql--只允许服务端设置值
    
	private String stayFields;//返回报文保留字段
    @JsonIgnore
	private String skipFields; //返回报文跳过字段, 暂时不用
    @JsonIgnore
	private String stayFieldsFlag;//只查询指定字段标记--只允许服务端设置值
	
	private String security;
	private String searchText;
	private String securityModel;
	
	public String getStoreId() {
		return storeId;
	}

	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}
	private String brandQuery = "0";
	
	private String brandUpdate = "0";
	
	private String brandInsert = "0";
	
	private String brandUpsert = "0";
	
	public String getBrandUpdate() {
		return brandUpdate;
	}

	public void setBrandUpdate(String brandUpdate) {
		this.brandUpdate = brandUpdate;
	}

	public String getBrandInsert() {
		return brandInsert;
	}

	public void setBrandInsert(String brandInsert) {
		this.brandInsert = brandInsert;
	}

	public String getBrandUpsert() {
		return brandUpsert;
	}

	public void setBrandUpsert(String brandUpsert) {
		this.brandUpsert = brandUpsert;
	}

	public String getBrandQuery() {
		return brandQuery;
	}

	public void setBrandQuery(String brandQuery) {
		this.brandQuery = brandQuery;
	}

	public void setCreatedId(String createdId) {
		this.createdId = createdId;
	}

	public String getSearchText() {
		return searchText;
	}

	public void setSearchText(String searchText) {
		this.searchText = searchText;
	}

	public String getSecurityModel() {
		return securityModel;
	}

	public void setSecurityModel(String securityModel) {
		this.securityModel = securityModel;
	}

	public String getSecurity() {
		return security;
	}

	public void setSecurity(String security) {
		this.security = security;
	}

	public String getStayFieldsFlag() {
		return stayFieldsFlag;
	}

	public void setStayFieldsFlag(String stayFieldsFlag) {
		this.stayFieldsFlag = stayFieldsFlag;
	}

	public String getStayFields() {
		return stayFields;
	}

	public void setStayFields(String stayFields) {
		this.stayFields = stayFields;
	}

	public String getSkipFields() {
		return skipFields;
	}

	public void setSkipFields(String skipFields) {
		this.skipFields = skipFields;
	}

	public String getConditionSql() {
		return conditionSql;
	}

	public void setConditionSql(String conditionSql) {
		this.conditionSql = conditionSql;
	}

	public Boolean getPageFlag() {
		return pageFlag;
	}

	public void setPageFlag(Boolean pageFlag) {
		this.pageFlag = pageFlag;
	}

	public Boolean getOnlyCountFlag() {
		return onlyCountFlag;
	}

	public void setOnlyCountFlag(Boolean onlyCountFlag) {
		this.onlyCountFlag = onlyCountFlag;
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
	
	public String getMvgMapperName() {
		return mvgMapperName;
	}

	public void setMvgMapperName(String mvgMapperName) {
		this.mvgMapperName = mvgMapperName;
	}

	public String getMvgParentId() {
		return mvgParentId;
	}

	public void setMvgParentId(String mvgParentId) {
		this.mvgParentId = mvgParentId;
	}

	public Boolean getTotalFlag() {
		return totalFlag;
	}

	public void setTotalFlag(Boolean totalFlag) {
		this.totalFlag = totalFlag;
	}

	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}

	public Integer getTotalPage() {
		if (page == 1) {
			totalPage = total / rows;
			if (total % rows != 0) {
				totalPage++;
			}
		}
		return totalPage;
	}
	
	public Integer getStartRow() {
		if (page > 0)
			startRow = (page - 1) * rows + 1;
		return startRow;
	}
	
	public Integer getStartRows() {
		if (page > 0)
			startRows = (page - 1) * rows;
		return startRows;
	}
	
	public Integer getEndRow() {
		if (page > 0)
			endRow = page * rows;
		return endRow;
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
	
	public Integer getTotal() {
		return total;
	}
	
	public void setTotal(Integer total) {
		this.total = total;
	}
	
	public String getUsercorpid() {
		return usercorpid;
	}
	
	public void setUsercorpid(String usercorpid) {
		this.usercorpid = usercorpid;
	}
	
	public String getUsersystemRole() {
		return usersystemRole;
	}
	
	public void setUsersystemRole(String usersystemRole) {
		this.usersystemRole = usersystemRole;
	}
	
	public String getCorpid() {
		return corpid;
	}
	
	public void setCorpid(String corpid) {
		this.corpid = corpid;
	}
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getCreatedBy() {
		return createdBy;
	}
	
	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}
	
	public String getCreated() {
		if(created != null && created.length() > 16){
			return created.substring(0, 16);
		}
		return created;
	}
	
	public String getCreated(int length){
		try{
			if(length <= 0){
				return created;
			}else{
				return created.substring(0, 16);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return created;
	}
	
	public void setCreated(String created) {
		this.created = created;
	}
	
	public String getLastUpdated() {
		if(lastUpdated != null && lastUpdated.length() > 16){
			return lastUpdated.substring(0, 16);
		}
		return lastUpdated;
	}
	
	public String getLastUpdated(int length){
		try{
			if(length <= 0){
				return lastUpdated;
			}else{
				return lastUpdated.substring(0, 16);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return lastUpdated;
	}
	
	public void setLastUpdated(String lastUpdated) {
		this.lastUpdated = lastUpdated;
	}
	
	public String getLastUpdatedBy() {
		return lastUpdatedBy;
	}
	
	public void setLastUpdatedBy(String lastUpdatedBy) {
		this.lastUpdatedBy = lastUpdatedBy;
	}
	
	public void installCreateUpdateData() {
		User user = UserUtil.getUser(null);
		this.created = DateUtil.getYY_MM_DDHHmmss(new Date());
		this.lastUpdated = this.created;
		this.createdBy = user == null ? "0-1" : user.getId();
		this.lastUpdatedBy = this.createdBy;
		if (this.getCorpid() == null || "".equals(this.getCorpid())) {
			this.corpid = user == null ? "": user.getCorpid();
		}
	}
	
	public void installAnonymousCreateUpdateData() {
		this.created = DateUtil.getYY_MM_DDHHmmss(new Date());
		this.lastUpdated = this.created;
		if (this.getAnonymousFlag() == null || "N".equals(this.getAnonymousFlag().toUpperCase())) {
			this.setAnonymousFlag("noMatchId");
		}
		this.createdBy = this.getAnonymousFlag();
		this.lastUpdatedBy = this.createdBy;
	}
	
	/**
	 * 
	 *<p>更新数据时设置更新人及更新时间</p>
	 * @author yrf
	 */
	public void installUpdateData() {
		User user = UserUtil.getUser(null);
		this.lastUpdated = DateUtil.getYY_MM_DDHHmmss(new Date());
		this.lastUpdatedBy = user == null ? "0-1" : user.getId();
		if (this.getCorpid() == null || "".equals(this.getCorpid())) {
			this.corpid = user == null ? "": user.getCorpid();
		}
	}
	/**
	 * 
	 *<p>匿名更新数据时设置更新人及更新时间</p>
	 * @author yrf
	 */
	public void installAnonymousUpdateData() {
		this.lastUpdated = DateUtil.getYY_MM_DDHHmmss(new Date());
		if (this.getAnonymousFlag() == null || "N".equals(this.getAnonymousFlag().toUpperCase())) {
			this.setAnonymousFlag("noMatchId");
		}
		this.lastUpdatedBy = this.getAnonymousFlag();
	}
	public String getAnonymousFlag() {
		return anonymousFlag;
	}
	
	public void setAnonymousFlag(String anonymousFlag) {
		this.anonymousFlag = anonymousFlag;
	}
	
	public String getOrgId() {
		return orgId;
	}
	
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	
	public String getOrgName() {
		return orgName;
	}
	
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	
	public String getPostnId() {
		return postnId;
	}
	
	public void setPostnId(String postnId) {
		this.postnId = postnId;
	}
	
	public String getPostnName() {
		return postnName;
	}
	
	public void setPostnName(String postnName) {
		this.postnName = postnName;
	}
	
	public String getRow_status() {
		return row_status;
	}
	
	public void setRow_status(String row_status) {
		this.row_status = row_status;
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
	
	public String getCreatedId() {
		return createdId;
	}
	
	/*public void setCreatedId(String createdId) {
		this.createdId = createdId;
	}*/
	
	public String getIsDefault() {
		return isDefault;
	}
	
	public void setIsDefault(String isDefault) {
		this.isDefault = isDefault;
	}
	
	public String getOrderByClause() {
		return orderByClause;
	}

	public void setOrderByClause(String orderByClause) {
		this.orderByClause = orderByClause;
	}
	/**
	 * 
	 *<p>查询条件设置到entity里，返回entity对象不是新对象</p>
	 * @author yrf
	 * @param entity
	 * @param qps
	 * @return
	 */
	public static Object transformClass(BasicModel entity, QueryParams qps) {
		//Object object = null;
		Class<? extends BasicModel> clz = entity.getClass();
		
		qps.invokePreFilterAndSorter();
		for (Filter f : qps.getFilters()) {
			String field = f.getProperty();
			String value = f.getValue();
			String op = f.getOperator();
			Method[] methods = clz.getDeclaredMethods();// 获取类中的所有方法集合
			for (Method method : methods) {// 循环方法集合
//				System.out.println(method.getName());
				if (("set" + field.toLowerCase()).equals(method.getName().toLowerCase())) {
//					System.out.println("hint it");
					try {
						if(op == Filter.OP_EQUAL){
							method.invoke(entity, value);// args是Object[]类型的，用于向方法中传递参数
						}
					} catch (Exception e) {
						System.out.println("get error");
						e.printStackTrace();
						// throw convertReflectionExceptionToUnchecked(e);
					}
				}
			}
		}
		
		if(qps.getSorters() != null && qps.getSorters().size() != 0){
			String orderStr = "";
			for(Sorter sorter:qps.getSorters()){
				if(!"".equals(orderStr)){
					orderStr += ",";
				}
				orderStr += sorter.getProperty() + " " + sorter.getDirection();
			}
			try {
				entity.setOrderByClause(orderStr);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		try{
			String sql = buildFilterSql(qps);
			if(StringUtils.isNotBlank(sql)){
				entity.setConditionSql(sql);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		//BeanUtils.copyProperties(qps, entity);
		entity.setOauth(qps.getOauth());
		return entity;
	}
	
	
	public static Object transformClass(Class clz, QueryParams qps) {
		Object object = null;
		try {
			object = clz.newInstance();
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}
		qps.invokePreFilterAndSorter();
		for (Filter f : qps.getFilters()) {
			String field = f.getProperty();
			String value = f.getValue();
			String op = f.getOperator();
//			System.out.println("field is" + field);
//			System.out.println("value is:" + value);
			Method[] methods = clz.getDeclaredMethods();// 获取类中的所有方法集合
			for (Method method : methods) {// 循环方法集合
//				System.out.println(method.getName());
				if (("set" + field.toLowerCase()).equals(method.getName().toLowerCase())) {
//					System.out.println("hint it");
					try {
						if(op == Filter.OP_EQUAL){
							method.invoke(object, value);// args是Object[]类型的，用于向方法中传递参数
						}
					} catch (Exception e) {
						System.out.println("get error");
						e.printStackTrace();
						// throw convertReflectionExceptionToUnchecked(e);
					}
				}
			}
		}
		
		if(qps.getSorters() != null && qps.getSorters().size() != 0){
			String orderStr = "";
			for(Sorter sorter:qps.getSorters()){
				if(!"".equals(orderStr)){
					orderStr += ",";
				}
				orderStr += sorter.getProperty() + " " + sorter.getDirection();
			}
			try {
				Method method = clz.getMethod("setOrderByClause",java.lang.String.class);
				method.invoke(object , orderStr);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		/*****  临时查询解决方案 */
		try{
			String sql = buildFilterSql(qps);
			if(StringUtils.isNotBlank(sql)){
				Method method = clz.getMethod("setConditionSql",java.lang.String.class);
				method.invoke(object , sql);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		/*****  临时查询解决方案 */
		BeanUtils.copyProperties(qps, object);
		/*Method[] methods = clz.getSuperclass().getDeclaredMethods();// 获取父类中的所有方法集合
		try {
			Method setIdMethod = clz.getMethod("setId", new Class[] { String.class });
			setIdMethod.invoke(object, qps.getId());
			// 分页参数设置
			Method setPageMethod = clz.getMethod("setPage", new Class[] { Integer.class });
			setPageMethod.invoke(object, qps.getPage());
			Method setRowsMethod = clz.getMethod("setRows", new Class[] { Integer.class });
			setRowsMethod.invoke(object, qps.getRows());
			Method setTotalMethod = clz.getMethod("setTotal", new Class[] { Integer.class });
			setTotalMethod.invoke(object, qps.getTotal());
			Method setNoPageMethod = clz.getMethod("setPageFlag", new Class[] { Boolean.class });
			setNoPageMethod.invoke(object, qps.getPageFlag());
			Method setNoTotalMethod = clz.getMethod("setTotalFlag", new Class[] { Boolean.class });
			setNoTotalMethod.invoke(object, qps.getTotalFlag());
			Method setOnlyCountMethod = clz.getMethod("setOnlyCountFlag", new Class[] { Boolean.class });
			setOnlyCountMethod.invoke(object, qps.getOnlyCountFlag());
			//安全性菜单
			Method setOauthMethod = clz.getMethod("setOauth", new Class[] { String.class });
			setOauthMethod.invoke(object, qps.getOauth());
			// 公共参数设置
			Method setAttr1Method = clz.getMethod("setAttr1", new Class[] { String.class });
			setAttr1Method.invoke(object, qps.getAttr1());
			Method setAttr2Method = clz.getMethod("setAttr2", new Class[] { String.class });
			setAttr2Method.invoke(object, qps.getAttr2());
			Method setAttr3Method = clz.getMethod("setAttr3", new Class[] { String.class });
			setAttr3Method.invoke(object, qps.getAttr3());
			Method setAttr4Method = clz.getMethod("setAttr4", new Class[] { String.class });
			setAttr4Method.invoke(object, qps.getAttr4());
			Method setAttr5Method = clz.getMethod("setAttr5", new Class[] { String.class });
			setAttr5Method.invoke(object, qps.getAttr5());
			Method setAttr6Method = clz.getMethod("setAttr6", new Class[] { String.class });
			setAttr6Method.invoke(object, qps.getAttr6());
			Method setAttr7Method = clz.getMethod("setAttr7", new Class[] { String.class });
			setAttr7Method.invoke(object, qps.getAttr7());
			// MVG参数设置
			Method setMvgMapperNameMethod = clz.getMethod("setMvgMapperName", new Class[] { String.class });
			setMvgMapperNameMethod.invoke(object, qps.getMvgMapperName());
			Method setMvgParentIdMethod = clz.getMethod("setMvgParentId", new Class[] { String.class });
			setMvgParentIdMethod.invoke(object, qps.getMvgParentId());
		} catch (Exception e) {
			e.printStackTrace();
		}*/
		return object;
	}
	
	/**
	 * 
	 *<p>根据filter生成查询条件</p>
	 * @param qps
	 * @return
	 * @throws Exception
	 */
	private static String buildFilterSql(QueryParams qps) throws Exception{
    	List<Filter> filters = qps.getFilters();
    	StringBuffer sbf = new StringBuffer();
    	if(filters != null){
			Iterator<Filter> filterIter = filters.iterator();
			while(filterIter.hasNext()){
				Filter filter = filterIter.next();
				String prop = filter.getProperty();
				//String propType = filter.getType();
				String op = filter.getOperator();
				String valueRaw = filter.getValue();
				valueRaw = valueRaw.replaceAll("'", "''");
				Object value = null;
				List<Object> valueList = null;
				String nodeSql = " and";
				if(op == null){
					op = Filter.OP_EQUAL;
				}else{
					op = op.trim();
				}
				if(op.equalsIgnoreCase(Filter.OP_IS_NULL) || op.equalsIgnoreCase(Filter.OP_NOT_NULL)){
					valueRaw = "noNeedValue";
				}
				//转换 value 的数据类型
				if(prop != null && !prop.equals("") && valueRaw != null && !valueRaw.equals("")){
					//Class<?> propertyType = getFilterType(propType);
					Class<?> propertyType = String.class;
					if(op.equalsIgnoreCase(Filter.OP_IN) || op.equalsIgnoreCase(Filter.OP_NOT_IN)|| op.equalsIgnoreCase(Filter.OP_AND_OR)){
						valueList = parseListValue(valueRaw,propertyType);
						//throw new QueryException("不支持的过滤条件");
					}else{	
						//value = convertValueByType(valueRaw,propertyType);
						//if(StringUtils.equals(AppConstants.key_applicationDatabase, "mysql")){
						if( (valueRaw.length() >= 7 && "to_date".equals(valueRaw.substring(0, 7).toLowerCase()) && !StringUtils.equals(AppConstants.key_applicationDatabase, "mysql")) 
							|| 	(valueRaw.length() >= 11 && "str_to_date".equals(valueRaw.substring(0, 11).toLowerCase()) && StringUtils.equals(AppConstants.key_applicationDatabase, "mysql"))){
							value = valueRaw;
						}else{
							value = "'"+valueRaw+"' ";
						}
					}
					if(value != null || (valueList!=null && !valueList.isEmpty())){
						if(op.equalsIgnoreCase(Filter.OP_EQUAL)){
							nodeSql = nodeSql + " "+ prop +" = "+ value;
						}else if(op.equalsIgnoreCase(Filter.OP_GREAT_EQUAL)){
							nodeSql = nodeSql + " "+ prop +" >= "+ value;
						}else if(op.equalsIgnoreCase(Filter.OP_GREAT_THEN)){
							nodeSql = nodeSql + " "+ prop +" > "+ value;
						}else if(op.equalsIgnoreCase(Filter.OP_LESS_EQUAL)){
							nodeSql = nodeSql + " "+ prop +" <= "+ value;
						}else if(op.equalsIgnoreCase(Filter.OP_LESS_THEN)){
							nodeSql = nodeSql + " "+ prop +" < "+ value;
						}else if(op.equalsIgnoreCase(Filter.OP_NOT_EQUAL)){
//							nodeSql = nodeSql + " ("+ prop +" != "+ value +" OR "+ prop +" IS NULL)";
							if(AppConstants.key_applicationDatabase.equals("mysql")){
								nodeSql = nodeSql + " "+ prop +" != "+ value/* +" OR "+ prop +" IS NULL"*/;
							}else{
								nodeSql = nodeSql + " ("+ prop +" != "+ value +" OR "+ prop +" IS NULL) ";
							}
						}else if(op.equalsIgnoreCase(Filter.OP_IS_NULL)){
							//nodeSql = nodeSql + " "+ prop +" IS NULL ";
							if(AppConstants.key_applicationDatabase.equals("mysql")){
								nodeSql = nodeSql + " "+ prop +" IS NULL or " + prop + " = '' ";
							}else{
								nodeSql = nodeSql + " "+ prop +" IS NULL ";
							}
						}else if(op.equalsIgnoreCase(Filter.OP_NOT_NULL)){
							//nodeSql = nodeSql + " "+ prop +" IS NOT NULL ";
							if(AppConstants.key_applicationDatabase.equals("mysql")){
								nodeSql = nodeSql + " "+ prop +" IS NOT NULL and " + prop + " != '' ";
							}else{
								nodeSql = nodeSql + " "+ prop +" IS NOT NULL ";
							}
						}else if(op.equalsIgnoreCase(Filter.OP_LIKE)){
							if(AppConstants.key_applicationDatabase.equals("mysql")){
								nodeSql = nodeSql + " "+ prop +" like concat('%', "+ value+", '%') ";
							}else{
								nodeSql = nodeSql + " "+ prop +" like '%'||"+ value+"||'%' ";
							}
						}else if (op.equalsIgnoreCase(Filter.OP_OR_LIKE)) {
							nodeSql = nodeSql + " ( " + buildOrLikeSql(prop, value) + " ) ";
						} else if (op.equalsIgnoreCase(Filter.OP_IN)) {
							nodeSql = nodeSql + " " + prop + " in " + formateList(valueList);
						} else if (op.equalsIgnoreCase(Filter.OP_NOT_IN)) {
							nodeSql = nodeSql + " " + prop + " not in " + formateList(valueList);
						} else if (op.equalsIgnoreCase(Filter.OP_OR_LIKE)) {
							nodeSql = nodeSql + " ( " + buildOrLikeSql(prop, value) + " ) ";
						} else if (op.equalsIgnoreCase(Filter.OP_AND_OR)) {
							nodeSql = nodeSql + " ( " + buildAndOrSql(prop, valueList) + " ) ";
						} else{
							throw new QueryException("不支持的过滤条件");
						}
						sbf.append(nodeSql);
					}
				}
			}
    	}
    	
    	return sbf.toString();
    }
	
	/**
	 * 拼接多指模糊查询
	 * @param prop
	 * @param value
	 * @return
	 */
	private static String buildOrLikeSql(String prop, Object value) throws Exception {
		boolean lessOne = true; // 没有一个条件字段为正，将抛错
		String sql = "";
		Pattern pattern = Pattern.compile("\\[.*\\]");
		Matcher matcher = pattern.matcher(prop);
		if (matcher.find()) {
			String propRaw = matcher.group();
			propRaw = propRaw.substring(1, propRaw.length() - 1);
			String[] propArray = propRaw.split(",");
			for (int i = 0; i < propArray.length; i++) {
				String propValueRaw = propArray[i];
				propValueRaw = propValueRaw.trim();
				if (i == 0) {
					sql += propValueRaw + " like '%'||" + value + "||'%'";
				} else {
					sql += "or " + propValueRaw + " like '%'||" + value + "||'%'";
				}
				lessOne = false;
			}
		}
		if (lessOne) {
			throw new BasicServiceException("至少有一个模糊搜索查询条件！");
		}
		return sql;
	}
	
	/**
	 * 拼接多条件or
	 * 
	 * @param prop
	 * @param value
	 * @return
	 * @throws Exception
	 */
	private static String buildAndOrSql(String prop, List<Object> objs) throws Exception {
		boolean lessOne = true; // 没有一个条件字段为正，将抛错
		String sql = "(";
		for (int i = 0; objs != null && i < objs.size(); i++) {
			if (i == objs.size() - 1) {
				sql += prop + " = " + objs.get(i) + ")";
			} else {
				sql += prop + " = " + objs.get(i) + " or ";
			}
			lessOne = false;
		}
		if (objs == null || objs.size() == 0) {
			sql += ")";
		}
		if (lessOne) {
			throw new BasicServiceException("至少有一个And Or搜索查询条件！");
		}
		return sql;
	}
	
	/**
	 * 把参数字符串转换成参数列表
	 * 
	 * @param valueRaw
	 *            参数字符串
	 * @param valueType
	 *            参数类型
	 * @return
	 */
	public static List<Object> parseListValue(String valueRaw, Class<?> propertyType) {
		List<Object> valueList = new ArrayList<Object>();
		Pattern pattern = Pattern.compile("\\[.*\\]");
		Matcher matcher = pattern.matcher(valueRaw);
		if (matcher.find()) {
			String matchValueRaw = matcher.group();
			matchValueRaw = matchValueRaw.substring(1, matchValueRaw.length() - 1);
			String[] valueRawArray = matchValueRaw.split(",");
			for (int i = 0; i < valueRawArray.length; i++) {
				String singleValueRaw = valueRawArray[i];
				singleValueRaw = singleValueRaw.trim();
				Object value = convertValueByType(singleValueRaw, propertyType);
				valueList.add(value);
			}
		}
		return valueList;
	}
	
	public static Object convertValueByType(String valueRaw, Class<?> propertyType) {
		Object value = null;
		try {
			if (propertyType == Integer.class) {
				value = Integer.parseInt(valueRaw);
			} else if (propertyType == Long.class) {
				value = Long.parseLong(valueRaw);
			} else if (propertyType == Float.class) {
				value = Float.parseFloat(valueRaw);
			} else if (propertyType == Double.class) {
				value = Double.parseDouble(valueRaw);
			} else if (propertyType == Boolean.class) {
				value = Boolean.parseBoolean(valueRaw);
			} else if (propertyType == Date.class) {
				throw new QueryException("Date数据类型暂不支持");
				/*try {
					value = datetimeFormatter.parse(valueRaw);
				} catch (ParseException pe) {
					value = dateFormatter.parse(valueRaw);
				}*/
			} else if (propertyType == String.class) {
				value = "'" + valueRaw + "'";
			} else {
				throw new QueryException("不支持的数据类型");
			}
			return value;
		} catch (QueryException qe) {
			throw qe;
		} catch (Exception e) {
			throw new QueryException("类型转换失败：" + e.getMessage(), e);
		}
	}
	
	public static String formateList(List<Object> objs) {
		String value = "(";
		for (int i = 0; objs != null && i < objs.size(); i++) {
			if (i == objs.size() - 1) {
				value += objs.get(i) + ")";
			} else {
				value += objs.get(i) + ",";
			}
		}
		if (objs == null || objs.size() == 0) {
			value += ")";
		}
		return value;
	}

	public String getCorpName() {
		return corpName;
	}

	public void setCorpName(String corpName) {
		this.corpName = corpName;
	}

	public void setStartRow(Integer startRow) {
		this.startRow = startRow;
	}

	public void setStartRows(Integer startRows) {
		this.startRows = startRows;
	}
	
	public void setEndRow(Integer endRow) {
		this.endRow = endRow;
	}
	/*
	 * 微信公众号清楚缓存使用
	 */
	public void interfaceCreateData(String createdBy, String lastUpdatedBy, String corpid) {
		this.created = DateUtil.getYY_MM_DDHHmmss(new Date());
		this.lastUpdated = this.created;
		this.createdBy = createdBy;
		this.lastUpdatedBy = lastUpdatedBy;
		this.corpid = corpid;
		this.usercorpid = corpid;
	}
}
