package com.hand.core.mybatis.interceptor;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.ibatis.executor.parameter.ParameterHandler;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.reflection.DefaultReflectorFactory;
import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.reflection.ReflectorFactory;
import org.apache.ibatis.reflection.factory.DefaultObjectFactory;
import org.apache.ibatis.reflection.factory.ObjectFactory;
import org.apache.ibatis.reflection.wrapper.DefaultObjectWrapperFactory;
import org.apache.ibatis.reflection.wrapper.ObjectWrapperFactory;
import org.apache.ibatis.scripting.defaults.DefaultParameterHandler;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.core.basic.query.Filter;
import com.hand.core.basic.query.QueryException;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.basic.query.Sorter;
import com.hand.core.util.UserUtil;

/**
 * 通过拦截<code>StatementHandler</code>的<code>prepare</code>方法，重写sql语句实现物理分页。
 * 老规矩，签名里要拦截的类型只能是接口。
 * 
 * @author Ashen
 * 
 */
@Intercepts({@Signature(type = StatementHandler.class, method = "prepare", args = {Connection.class, Integer.class})})
public class MybatisMySqlInterceptor implements Interceptor {
	
	private static final SimpleDateFormat datetimeFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private static final SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");
    
    private static final ObjectFactory DEFAULT_OBJECT_FACTORY = new DefaultObjectFactory();
    private static final ObjectWrapperFactory DEFAULT_OBJECT_WRAPPER_FACTORY = new DefaultObjectWrapperFactory();
    private static final ReflectorFactory DEFAULT_REFLECTOR_FACTORY = new DefaultReflectorFactory();
    
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
    public Object intercept(Invocation invocation) throws Throwable {
        StatementHandler statementHandler = (StatementHandler) invocation.getTarget();
        MetaObject metaStatementHandler = MetaObject.forObject(statementHandler, DEFAULT_OBJECT_FACTORY, DEFAULT_OBJECT_WRAPPER_FACTORY, DEFAULT_REFLECTOR_FACTORY);
        // 分离代理对象链(由于目标类可能被多个拦截器拦截，从而形成多次代理，通过下面的两次循环可以分离出最原始的的目标类)
        while (metaStatementHandler.hasGetter("h")) {
            Object object = metaStatementHandler.getValue("h");
            metaStatementHandler = MetaObject.forObject(object, DEFAULT_OBJECT_FACTORY, DEFAULT_OBJECT_WRAPPER_FACTORY, DEFAULT_REFLECTOR_FACTORY);
        }
        // 分离最后一个代理对象的目标类
        while (metaStatementHandler.hasGetter("target")) {
            Object object = metaStatementHandler.getValue("target");
            metaStatementHandler = MetaObject.forObject(object, DEFAULT_OBJECT_FACTORY, DEFAULT_OBJECT_WRAPPER_FACTORY, DEFAULT_REFLECTOR_FACTORY);
        }

        MappedStatement mappedStatement = (MappedStatement) metaStatementHandler.getValue("delegate.mappedStatement");
        
        if (mappedStatement.getId().matches(".*Page$")) {
            BoundSql boundSql = (BoundSql) metaStatementHandler.getValue("delegate.boundSql");
            Object parameterObject = boundSql.getParameterObject();
            if (parameterObject == null) {
                throw new NullPointerException("parameterObject is null!");
            } else {
            	BasicModel basicModel = (BasicModel) boundSql.getParameterObject();
                String sql = boundSql.getSql();
                String countSql = new String(sql);
                // 重写查询sql
                /******** 记录计数临时解决方案 ****/
                if(basicModel.getOnlyCountFlag()){
                	 sql = buildCountSql(sql, basicModel);//该标记表明此次查询仅仅是为了获取记录总数，因此拼接count语句，具体逻辑查看Service，
                	 /******** 记录计数临时解决方案 ****/
                }else{
                	 // 重写查询sql
                    sql = buildQuerySql(sql, basicModel);
                    if(basicModel.getPageFlag()){
                    	sql = buildPageSql(sql, basicModel);
                    }
                }
                //重写分页
                String pageSql = sql;
                metaStatementHandler.setValue("delegate.boundSql.sql", pageSql);
                // 采用物理分页后，就不需要mybatis的内存分页了，所以重置下面的两个参数
                metaStatementHandler.setValue("delegate.rowBounds.offset", RowBounds.NO_ROW_OFFSET);
                metaStatementHandler.setValue("delegate.rowBounds.limit", RowBounds.NO_ROW_LIMIT);
                Connection connection = (Connection) invocation.getArgs()[0];
                // 重设分页参数里的总页数等
                if(basicModel.getTotalFlag()){
                    setPageParameter(countSql, connection, mappedStatement, boundSql, basicModel);
                }
            }
        }
        
        if (mappedStatement.getId().matches(".*countByExample$")) {
       	   //mappedStatement.
           String methodPath = mappedStatement.getId();
	       	int endIndex = methodPath.lastIndexOf('.');
	       	methodPath = methodPath.substring(0, endIndex+1) + "queryByExamplePage";
	       	String sql = mappedStatement.getConfiguration().getMappedStatement(methodPath).getBoundSql(null).getSql();//仅能获取定义的静态sql,所以有时会报错
	       	//System.err.println(sqlCount);
	       	
	           BoundSql boundSql = (BoundSql) metaStatementHandler.getValue("delegate.boundSql");
	           Object parameterObject = boundSql.getParameterObject();
	           if (parameterObject == null) {
	               throw new NullPointerException("parameterObject is null!");
	           } else {
	           	BasicModel basicModel = (BasicModel)parameterObject;
	               
	               // 重写查询sql
	               sql = buildCountSql(sql, basicModel);
	               metaStatementHandler.setValue("delegate.boundSql.sql", sql);
	               // 采用物理分页后，就不需要mybatis的内存分页了，所以重置下面的两个参数
	               metaStatementHandler.setValue("delegate.rowBounds.offset", RowBounds.NO_ROW_OFFSET);
	               metaStatementHandler.setValue("delegate.rowBounds.limit", RowBounds.NO_ROW_LIMIT);
	           }
	    }
        if (mappedStatement.getId().matches(".queryAll$")) {
            BoundSql boundSql = (BoundSql) metaStatementHandler.getValue("delegate.boundSql");
            Object parameterObject = boundSql.getParameterObject();
            if (parameterObject == null) {
                throw new NullPointerException("parameterObject is null!");
            } else {
            	BasicModel basicModel = (BasicModel) parameterObject;
                String sql = boundSql.getSql();
                // 重写查询sql
                metaStatementHandler.setValue("delegate.boundSql.sql", sql);
                // 采用物理分页后，就不需要mybatis的内存分页了，所以重置下面的两个参数
                metaStatementHandler.setValue("delegate.rowBounds.offset", RowBounds.NO_ROW_OFFSET);
                metaStatementHandler.setValue("delegate.rowBounds.limit", RowBounds.NO_ROW_LIMIT);
            }
        }
        
        // 只重写需要分页的sql语句。通过MappedStatement的ID匹配，默认重写以Page结尾的MappedStatement的sql
        if (mappedStatement.getId().matches(".*Update$") || mappedStatement.getId().matches(".*update$")) {
            BoundSql boundSql = (BoundSql) metaStatementHandler.getValue("delegate.boundSql");
            Object parameterObject = boundSql.getParameterObject();
            if (parameterObject == null) {
                throw new NullPointerException("parameterObject is null!");
            } else {
            	BasicModel basicModel = (BasicModel) boundSql.getParameterObject();
                String sql = boundSql.getSql();
                // 重写sql
                String updateSql = buildUpdateSql(sql, basicModel);
                metaStatementHandler.setValue("delegate.boundSql.sql", updateSql);
            }
        }

        if (mappedStatement.getId().matches(".*Insert$") || mappedStatement.getId().matches(".*insert$")) {
            BoundSql boundSql = (BoundSql) metaStatementHandler.getValue("delegate.boundSql");
            Object parameterObject = boundSql.getParameterObject();
            if (parameterObject == null) {
                throw new NullPointerException("parameterObject is null!");
            } else {
            	BasicModel basicModel = (BasicModel) boundSql.getParameterObject();
                String sql = boundSql.getSql();
                // 重写sql
                String InsertSql = buildInsertSql(sql, basicModel);
                metaStatementHandler.setValue("delegate.boundSql.sql", InsertSql);
            }
        }
        // 将执行权交给下一个拦截器
        return invocation.proceed();
    }
    
    /**
     * 构建查询语句
     * @param sql
     * @param page
     * @return
     * @throws Exception 
     */
    private String buildQuerySql(String sql, BasicModel qps) throws Exception {
    	StringBuilder pageSql = new StringBuilder();
    	pageSql.append("select temp.* from ( ");
        pageSql.append(sql);
        pageSql.append(" ) temp where 1=1 ");
        /** 查询筛选临时解决方案 */
        if(qps.getConditionSql() !=null && !qps.getConditionSql().isEmpty()){
        	pageSql.append(qps.getConditionSql());
        }
        /** 查询筛选临时解决方案 */
        
        //安全性菜单
  		String securySql = buildSecuritySql(qps);
  		if (securySql != null && !securySql.isEmpty()) {
  			pageSql.append(securySql);
  		}
        
        return pageSql.toString();
	}

    /**
     * 构建更新语句，修改默认的字段
     * @param sql
     * @param basicModel
     * @return
     */
	private String buildUpdateSql(String sql, BasicModel basicModel)  throws ParseException{
    	if (basicModel != null) {
        	StringBuilder pageSql = new StringBuilder();
        	Integer num = sql.toUpperCase().indexOf("SET");
        	if(num > 0){
        		try{
    				basicModel.installCreateUpdateData();
				}catch(Exception e){
					if(basicModel.getAnonymousFlag() == null || "N".equals(basicModel.getAnonymousFlag().toUpperCase())){
						throw new ParseException("非匿名用户，获取用户信息失败！", 0);
					}
					basicModel.installAnonymousCreateUpdateData();
				}
        		String preSql = sql.substring(0, num+3);
        		String endSql = sql.substring(num+3, sql.length());
        		pageSql.append(preSql);
        		/*pageSql.append(" LAST_UPD=TO_DATE('"+basicModel.getLastUpdated()+"','yyyy-MM-dd HH24:MI:ss'),");
        		pageSql.append(" LAST_UPD_BY='"+basicModel.getLastUpdatedBy()+"',");*/
        		
        		pageSql.append(" LAST_UPD=now(),");
        		pageSql.append(" LAST_UPD_BY='"+basicModel.getLastUpdatedBy()+"',");
        		
        		pageSql.append(endSql);
            	return pageSql.toString();
        	}
        }
    	return sql;
	}
    
	/**
	 * 构建新增语句、为默认字段赋值
	 * @param sql
	 * @param basicModel
	 * @return
	 * @throws ParseException 
	 */
    private String buildInsertSql(String sql, BasicModel basicModel) throws ParseException {
    	if (basicModel != null) {
        	StringBuilder pageSql = new StringBuilder();
        	Integer firstNum = sql.indexOf("(");
        	if(firstNum >= 0){
        		String firstSql = sql.substring(0, firstNum+1);
        		String endSql = sql.substring(firstNum+1);
        		Integer secondNum = endSql.toUpperCase().indexOf("VALUES");
        		if(secondNum >=0){
        			String secondSql = endSql.substring(0,secondNum+6);
        			endSql = endSql.substring(secondNum+6);
        			Integer thirdNum = endSql.indexOf("(");
        			if(thirdNum >= 0){
        				try{
            				basicModel.installCreateUpdateData();
        				}catch(Exception e){
        					if(basicModel.getAnonymousFlag() == null || "N".equals(basicModel.getAnonymousFlag().toUpperCase())){
        						throw new ParseException("非匿名用户，获取用户信息失败！", thirdNum);
        					}
        					basicModel.installAnonymousCreateUpdateData();
        				}
            			String thirdSql = endSql.substring(0, thirdNum+1);
            			String forthSql = endSql.substring(thirdNum+1);
            			pageSql.append(firstSql);
            			pageSql.append("CORP_ID,CREATED,CREATED_BY,LAST_UPD,LAST_UPD_BY,");
            			pageSql.append(secondSql);
            			pageSql.append(thirdSql);
            			/*pageSql.append("'"+basicModel.getCorpid()+"',"+"TO_DATE('"+basicModel.getCreated()+"','yyyy-MM-dd HH24:MI:ss'),'"+basicModel.getCreatedBy()+"',");
            			pageSql.append("TO_DATE('"+basicModel.getLastUpdated()+"','yyyy-MM-dd HH24:MI:ss'),'"+basicModel.getLastUpdatedBy()+"',");*/
            			
            			pageSql.append("'"+basicModel.getCorpid()+"',"+"now(),'"+basicModel.getCreatedBy()+"',");
            			pageSql.append("now(),'"+basicModel.getLastUpdatedBy()+"',");
            			
            			
            			pageSql.append(forthSql);
            			return pageSql.toString();
        			}
        		}
        	}
        }
    	return sql;
	}
    
    /**
     * 构建
     * @param sql
     * @param page
     * @return
     * @throws Exception
     */
    private String buildPageSql(String sql, BasicModel page) throws Exception {
        if (page != null) {
        	StringBuilder pageSql = new StringBuilder();
        	pageSql = buildPageSqlForMySql(sql, page);
        	return pageSql.toString();
        } else {
        	return sql;
        }
    }


    /**
     * 参考hibernate的实现完成Mysql的分页
     * @param sql
     * @param page
     * @return String
     * @throws Exception 
     */
    public StringBuilder buildPageSqlForMySql(String sql, BasicModel qps) throws Exception {
        StringBuilder pageSql = new StringBuilder(100);
        String startrow = String.valueOf(qps.getStartRow() - 1);
        String queryrow = String.valueOf(qps.getRows());
        pageSql.append(sql);
        pageSql.append(" limit ");
        pageSql.append(startrow).append(", ").append(queryrow);
        return pageSql;
    }

    /**
     * 校验查询条件中是否存在order By
     * @param sql
     * @return
     */
    private boolean checkExistOrder(String sql) {
      String SQL = sql.toUpperCase();
      int len = SQL.lastIndexOf("ORDER ");
      if(len != -1){
    	  return !SQL.substring(len).contains(")");
      }
    	
	 /* Pattern pattern = Pattern.compile(".*\\s+ORDER\\s*BY\\s+.)*",Pattern.CASE_INSENSITIVE | Pattern.DOTALL);
	  Matcher matcher = pattern.matcher(sql);*/
	  return false;
	}

    /**
	 * 拼接安全性sql
	 * 
	 * @param qps
	 * @return
	 * @throws Exception
	 */
	private String buildSecuritySql(BasicModel qps) throws Exception {
		StringBuffer sbf = new StringBuffer();
		if (qps.getOauth() == null || "".equals(qps.getOauth())) {
			return null;
		} else if ("MY".equalsIgnoreCase(qps.getOauth())) {
			sbf.append("and temp.postnId = '" + UserUtil.getUser(null).getPostnId() + "'");
			// sbf.append("and createdBy = '" + UserUtil.getUser(null).getId() + "'");
		} else if ("MY_POSTN".equalsIgnoreCase(qps.getOauth())) {
			// 大数据项目职位的安全性不包含自己本身
			/*sbf.append("and (temp.postnId = '" + UserUtil.getUser(null).getPostnId()
					+ "' or EXISTS (select 1 FROM LNK_PARTY_REL COMPA1 WHERE temp.postnId = COMPA1.SUB_PARTY_ID AND COMPA1.PARTY_ID = '"
					+ UserUtil.getUser(null).getPostnId() + "' AND COMPA1.DATA_TYPE = 'POSTN'))");*/
			
			sbf.append("and (EXISTS (select 1 FROM LNK_PARTY_REL COMPA1 WHERE temp.postnId = COMPA1.SUB_PARTY_ID AND COMPA1.PARTY_ID = '"
					+ UserUtil.getUser(null).getPostnId() + "' AND COMPA1.DATA_TYPE = 'POSTN' AND COMPA1.SUB_PARTY_ID != '" + UserUtil.getUser(null).getPostnId() + "'))");
			
		} else if ("MY_POSTN_AND_MY".equalsIgnoreCase(qps.getOauth())) {
			//包含自己本身的职位安全性
			sbf.append("and (temp.postnId = '" + UserUtil.getUser(null).getPostnId()
					+ "' or EXISTS (select 1 FROM LNK_PARTY_REL COMPA1 WHERE temp.postnId = COMPA1.SUB_PARTY_ID AND COMPA1.PARTY_ID = '"
					+ UserUtil.getUser(null).getPostnId() + "' AND COMPA1.DATA_TYPE = 'POSTN'))");
		} else if ("MY_ORG".equalsIgnoreCase(qps.getOauth())) {
			sbf.append("and (temp.orgId = '" + UserUtil.getUser(null).getOrgId()
					+ "' or EXISTS (select 1 FROM LNK_PARTY_REL COMPA1 WHERE temp.orgId = COMPA1.SUB_PARTY_ID AND COMPA1.PARTY_ID = '"
					+ UserUtil.getUser(null).getOrgId() + "' AND COMPA1.DATA_TYPE = 'ORG'))");
		} else if ("ALL".equals(qps.getOauth())) {
			return null;
		} else if (qps.getOauth().startsWith("OTHER_")) {
			String menuId = qps.getOauth().substring(6);
			String sql = querySecuritySql(menuId);
			if (sql == null || "".equals(sql)) {
				throw new ParseException("查询安全性逻辑失败！", 0);
			}
			sql = sql.replace("#{curentLoginOrgId}", "'" + UserUtil.getUser(null).getOrgId() + "'");
			sql = sql.replace("#{curentLoginPostnId}", "'" + UserUtil.getUser(null).getPostnId() + "'");
			sql = sql.replace("#{curentLoginId}", "'" + UserUtil.getUser(null).getId() + "'");
			return sql;
		}
		return sbf.toString();
	}

	/**
     * 拼接条件查询SQL
     * @param qps
     * @return
     * @throws Exception 
     */
    private String buildFilterSql(QueryParams qps) throws Exception{
    	List<Filter> filters = qps.getFilters();
    	StringBuffer sbf = new StringBuffer();
    	if(filters != null){
    		try{
				Iterator<Filter> filterIter = filters.iterator();
				while(filterIter.hasNext()){
					Filter filter = filterIter.next();
					String prop = filter.getProperty();
					String propType = filter.getType();
					String op = filter.getOperator();
					String valueRaw = filter.getValue();
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
						Class<?> propertyType = getFilterType(propType);
						if(op.equalsIgnoreCase(Filter.OP_IN) || op.equalsIgnoreCase(Filter.OP_NOT_IN)|| op.equalsIgnoreCase(Filter.OP_AND_OR)){
							valueList = parseListValue(valueRaw,propertyType);
						}else{	
							value = convertValueByType(valueRaw,propertyType);
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
								nodeSql = nodeSql + " ("+ prop +" != "+ value +" OR "+ prop +" IS NULL)";
							}else if(op.equalsIgnoreCase(Filter.OP_IS_NULL)){
								nodeSql = nodeSql + " "+ prop +" IS NULL";
							}else if(op.equalsIgnoreCase(Filter.OP_NOT_NULL)){
								nodeSql = nodeSql + " "+ prop +" IS NOT NULL";
							}else if(op.equalsIgnoreCase(Filter.OP_LIKE)){
								nodeSql = nodeSql + " "+ prop +" like CONCAT('%',"+ value+",'%')";
							}else if(op.equalsIgnoreCase(Filter.OP_IN)){
								nodeSql = nodeSql + " "+ prop +" in "+ formateList(valueList);
							}else if(op.equalsIgnoreCase(Filter.OP_NOT_IN)){
								nodeSql = nodeSql + " "+ prop +" not in "+ formateList(valueList);
							}else if(op.equalsIgnoreCase(Filter.OP_OR_LIKE)){
								nodeSql = nodeSql + " ( " +buildOrLikeSql(prop,value)+ " ) ";
							}else if(op.equalsIgnoreCase(Filter.OP_AND_OR)){
								nodeSql = nodeSql + " ( " +buildAndOrSql(prop,valueList)+ " ) ";
							}else{
								throw new QueryException("不支持的过滤条件");
							}
							sbf.append(nodeSql);
						}
					}
				}
    		}catch(QueryException e2){
				throw e2;
			}catch(Exception e3){
				throw e3;
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
    private String buildOrLikeSql(String prop, Object value) throws Exception{
    	boolean lessOne = true;		//没有一个条件字段为正，将抛错
		String sql = "";
		Pattern pattern = Pattern.compile("\\[.*\\]");
        Matcher matcher = pattern.matcher(prop);
        if(matcher.find()){
         	String propRaw = matcher.group();
         	propRaw = propRaw.substring(1,propRaw.length()-1);
         	String[] propArray = propRaw.split(",");
         	for(int i = 0; i < propArray.length; i++){
         		String propValueRaw = propArray[i];
         		propValueRaw = propValueRaw.trim();
         		if(i== 0){
         			sql += propValueRaw +" like concat('%', "+ value+", '%'";
         		}else{
         			sql += "or " + propValueRaw +" like concat('%', "+ value+", '%'";
         		}
         		lessOne = false;
         	}
         }
        if(lessOne){
        	throw new BasicServiceException("至少有一个模糊搜索查询条件！");
        }
		return sql;
	}
    
    /**
     * 拼接多条件or
     * @param prop
     * @param value
     * @return
     * @throws Exception
     */
    private String buildAndOrSql(String prop, List<Object> objs) throws Exception{
    	boolean lessOne = true;		//没有一个条件字段为正，将抛错
    	String sql = "(";
    	for(int i=0;objs != null && i<objs.size();i++){
    		if(i==objs.size()-1){
    			sql += prop +" = "+ objs.get(i) + ")";
    		}else{
    			sql += prop +" = "+ objs.get(i) + " or ";
    		}
     		lessOne = false;
    	}
    	if(objs == null || objs.size() == 0){
    		sql += ")";
    	}
    	
        if(lessOne){
        	throw new BasicServiceException("至少有一个And Or搜索查询条件！");
        }
		return sql;
	}

	/**
     * 拼接排序SQL
     * @param qps
     * @return
     */
    private String buildOrderSql(QueryParams qps) {
    	List<Sorter> list = qps.getSorters();
    	StringBuffer sbf = new StringBuffer();
    	if(list != null){
    		for(int i=0;i<list.size();i++){
    			String nodeSql = "";
    			if(sbf.length() != 0){
    				nodeSql = ",";
    			}
    			Sorter sorter = list.get(i);
				String prop = sorter.getProperty();
				String dir = sorter.getDirection();
				if(prop != null && dir!=null && !prop.isEmpty() && !dir.isEmpty()){
					if(dir.equalsIgnoreCase(Sorter.DIR_ASC) || dir.equalsIgnoreCase(Sorter.DIR_DESC)){
						nodeSql = nodeSql + prop + " "+ dir;
					}else{
						throw new QueryException("不支持的排序条件");
					}
					sbf.append(nodeSql);
				}
    		}
    	}
		return sbf.toString();
	}


	/**
     * 从数据库里查询总的记录数并计算总页数，回写进分页参数<code>PageParameter</code>,这样调用者就可用通过 分页参数
     * <code>PageParameter</code>获得相关信息。
     * 
     * @param sql
     * @param connection
     * @param mappedStatement
     * @param boundSql
     * @param page
     */
    private void setPageParameter(String sql, Connection connection, MappedStatement mappedStatement,
            BoundSql boundSql, BasicModel page) {
        // 记录总记录数
        String countSql = "select count(0) as total from (" + sql + ") xxx ";
        PreparedStatement countStmt = null;
        ResultSet rs = null;
        try {
            countStmt = connection.prepareStatement(countSql);
            BoundSql countBS = new BoundSql(mappedStatement.getConfiguration(), countSql,
                    boundSql.getParameterMappings(), boundSql.getParameterObject());
            setParameters(countStmt, mappedStatement, countBS, boundSql.getParameterObject());
            rs = countStmt.executeQuery();
            int totalCount = 0;
            if (rs.next()) {
                totalCount = rs.getInt(1);
            }
            page.setTotal(totalCount);
        } catch (SQLException e) {
        } finally {
            try {
                rs.close();
            } catch (SQLException e) {
            }
            try {
                countStmt.close();
            } catch (SQLException e) {
            }
        }

    }
    /**
	 * 把参数字符串转换成参数列表
	 * @param valueRaw 参数字符串
	 * @param valueType 参数类型
	 * @return
	 */
	public static List<Object> parseListValue(String valueRaw,Class<?> propertyType){
		 List<Object> valueList = new ArrayList<Object>();
         Pattern pattern = Pattern.compile("\\[.*\\]");
         Matcher matcher = pattern.matcher(valueRaw);
         
         if(matcher.find()){
         	String matchValueRaw = matcher.group();
         	matchValueRaw = matchValueRaw.substring(1,matchValueRaw.length()-1);
         	String[] valueRawArray = matchValueRaw.split(",");
         	for(int i = 0; i < valueRawArray.length; i++){
         		String singleValueRaw = valueRawArray[i];
         		singleValueRaw = singleValueRaw.trim();
         		Object value = convertValueByType(singleValueRaw,propertyType);
         		valueList.add(value);
         	}
         }
		 return valueList;
	}
	
	public Class<?> getFilterType(String type){
		if(type.equalsIgnoreCase("string")){
			return String.class;
		}
		return String.class;
	}

	public static Object convertValueByType(String valueRaw,Class<?> propertyType){
		Object value = null;
		try{
			if(propertyType == Integer.class){
				value = Integer.parseInt(valueRaw);
			}else if(propertyType == Long.class){
				value = Long.parseLong(valueRaw);
			}else if(propertyType == Float.class){
				value = Float.parseFloat(valueRaw);
			}else if(propertyType == Double.class){
				value = Double.parseDouble(valueRaw);
			}else if(propertyType == Boolean.class){
				value = Boolean.parseBoolean(valueRaw);
			}else if(propertyType == Date.class){
				try{
					value = datetimeFormatter.parse(valueRaw);
				}catch(ParseException pe){
					value = dateFormatter.parse(valueRaw);
				}
			}else if(propertyType == String.class){
				value = "'"+valueRaw+"'";
			}else{
				throw new QueryException("不支持的数据类型");
			}
			return value;
		}catch(QueryException qe){
			throw qe;
		}catch(Exception e){
			throw new QueryException("类型转换失败："+e.getMessage(),e);
		}
	}
	
    /**
     * 对SQL参数(?)设值
     * 
     * @param ps
     * @param mappedStatement
     * @param boundSql
     * @param parameterObject
     * @throws SQLException
     */
    private void setParameters(PreparedStatement ps, MappedStatement mappedStatement, BoundSql boundSql,
            Object parameterObject) throws SQLException {
        ParameterHandler parameterHandler = new DefaultParameterHandler(mappedStatement, parameterObject, boundSql);
        parameterHandler.setParameters(ps);
    }
    public Object plugin(Object target) {
        // 当目标类是StatementHandler类型时，才包装目标类，否者直接返回目标本身,减少目标被代理的次数
        if (target instanceof StatementHandler) {
            return Plugin.wrap(target, this);
        } else {
            return target;
        }
    }

    public void setProperties(Properties properties) {
    }
    
    public String formateList(List<Object> objs){
    	String value = "(";
    	for(int i=0;objs != null && i<objs.size();i++){
    		if(i==objs.size()-1){
    			value += objs.get(i) + ")";
    		}else{
    			value += objs.get(i) + ",";
    		}
    	}
    	if(objs == null || objs.size() == 0){
    		value += ")";
    	}
    	return value;
    }
    
    public String querySecuritySql(String menuId){
    	if(menuId == null || "".equals(menuId))
    		return null;
    	String sql = "SELECT OAUTH_SQL AS result FROM LNK_MENU WHERE ROW_ID = '"+menuId+"'";
		String oauthSql = (String)jdbcTemplate.queryForObject(sql,String.class);
		return oauthSql;
    }
    
    /**
     * 
     *<p>构建查询数量语句</p>
     * @author yrf
     * @param sql
     * @param qps
     * @return
     * @throws Exception
     */
    private String buildCountSql(String sql, BasicModel qps) throws Exception {
    	StringBuilder pageSql = new StringBuilder();
    	pageSql.append("select count(0) as total from ( ");
        pageSql.append(sql);
        pageSql.append(" ) temp where 1=1 ");
        /** 查询筛选临时解决方案 */
        if(qps.getConditionSql() !=null && !qps.getConditionSql().isEmpty()){
        	pageSql.append(qps.getConditionSql());
        }
        /** 查询筛选临时解决方案 */
        
        /** 系统安全性 */
		String securySql = buildSecuritySql(qps);
		if (securySql != null && !securySql.isEmpty()) {
			pageSql.append(securySql);
		}
		/** 系统安全性 */
		
        return pageSql.toString();
	}

}
