package com.hand.core.util;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.hand.base.basic.model.BasicModel;

public class StringRegularUtils {
	
//	@Autowired
//	private JdbcTemplate						jdbcTemplate;

	public static String buildSecuritySqlNew(String sourceSql,BasicModel qps) throws Exception {
		StringBuffer sbf = new StringBuffer();
		if (qps.getOauth() == null || "".equals(qps.getOauth())) {
			return null;
		} else if ("MY".equalsIgnoreCase(qps.getOauth())) {
//			sbf.append("and createdBy = '" + qps.getCreatedId() + "'");
			sbf.append(" and " + getTableFieldNameByAliasName(sourceSql,"createdBy") + " = '" + qps.getCreatedId() + "'");
		}  else if ("ALL".equals(qps.getOauth())) {
			return null;
		} else if ("MY_ORG".equalsIgnoreCase(qps.getOauth())) {//我的组织，包括子组织
			String fieldName = getTableFieldNameByAliasName(sourceSql,"orgId");
			sbf.append(" and ("+fieldName+" = '" + UserUtil.getUser(null).getOrgId()
					+ "' or EXISTS (select 1 FROM LNK_PARTY_REL COMPA1 WHERE "+fieldName+" = COMPA1.SUB_PARTY_ID AND COMPA1.PARTY_ID = '"
					+ UserUtil.getUser(null).getOrgId() + "' AND COMPA1.DATA_TYPE = 'ORG'))");
		} else if ("MY_POSTN".equalsIgnoreCase(qps.getOauth())) {//我的职位，包括子职位
			String fieldName = getTableFieldNameByAliasName(sourceSql,"postnId");
			sbf.append(" and ("+fieldName+" = '" + UserUtil.getUser(null).getPostnId()
					+ "' or EXISTS (select 1 FROM LNK_PARTY_REL COMPA1 WHERE "+fieldName+" = COMPA1.SUB_PARTY_ID AND COMPA1.PARTY_ID = '"
					+ UserUtil.getUser(null).getPostnId() + "' AND COMPA1.DATA_TYPE = 'POSTN'))");
		} /*else if (qps.getOauth().startsWith("OTHER_")) {
			String menuId = qps.getOauth().substring(6);
			String sql = querySecuritySql(menuId);
			if (sql == null || "".equals(sql)) {
				throw new ParseException("查询安全性逻辑失败！", 0);
			}
			sql = sql.replace("#{curentLoginOrgId}", "'" + UserUtil.getUser(null).getOrgId() + "'");
			sql = sql.replace("#{curentLoginPostnId}", "'" + UserUtil.getUser(null).getPostnId() + "'");
			sql = sql.replace("#{curentLoginId}", "'" + UserUtil.getUser(null).getId() + "'");
			return sql;
		}*/
		return sbf.toString();
	}
	/*
	public String querySecuritySql(String menuId) {
		if (menuId == null || "".equals(menuId))
			return null;
		String sql = "SELECT OAUTH_SQL AS result FROM LNK_MENU WHERE ROW_ID = '" + menuId + "'";
		String oauthSql = (String) jdbcTemplate.queryForObject(sql, String.class);
		return oauthSql;
	}
	
	public String buildOtherSecuritySql(BasicModel qps) throws Exception {
		if (null != qps.getOauth()){
			if (qps.getOauth().startsWith("OTHER_") || qps.getOauth().startsWith("other_")) {
				String menuId = qps.getOauth().substring(6);
				String sql = querySecuritySql(menuId);
				if (sql == null || "".equals(sql)) {
					throw new ParseException("查询安全性逻辑失败！", 0);
				}
				sql = sql.replace("#{curentLoginOrgId}", "'" + UserUtil.getUser(null).getOrgId() + "'");
				sql = sql.replace("#{curentLoginPostnId}", "'" + UserUtil.getUser(null).getPostnId() + "'");
				sql = sql.replace("#{curentLoginId}", "'" + UserUtil.getUser(null).getId() + "'");
				return sql;
			}else{
				return "";
			}
		}else{
			return null;
		}
	}
	*/
	public static String getTableFieldNameByAliasName(String sourceSql,String fieldAliasName){
		//声明排序语句result
		String result = "";
		//声明处理后的返回结果字符串
		String tableFieldName = "";
		//根据别名去源sql中查找是否有对应的[表别名.字段名]
		Pattern pattern = Pattern.compile("((?<=,)|(?<=(select)))\\s{0,}(\\s{0,}(/\\*.*?\\*/|--\\s+)\\s{0,}){0,}\\s{0,}([\\w\\S]*(\\.)[\\w\\S]*)\\s+(as\\s+)?("+fieldAliasName+")\\s{0,}(\\s{0,}(/\\*.*?\\*/|--\\s+)\\s{0,}){0,}\\s{0,}((?=,)|(?=(from)))",Pattern.CASE_INSENSITIVE);
		Matcher match = pattern.matcher(sourceSql);
		while(match.find()){
			result = match.group();
		}
		if(!"".equals(result) && result != null){
			//取出[表别名.字段名]
			Pattern tableFieldPattern = Pattern.compile("([\\w]*(\\.)(`){0,1}[\\w]*)(`){0,1}",Pattern.CASE_INSENSITIVE);
			Matcher tableFieldMatch = tableFieldPattern.matcher(result);
			while(tableFieldMatch.find()){
				tableFieldName = tableFieldMatch.group();
			}
		}
		tableFieldName = tableFieldName.trim();
		return tableFieldName;
	}
	
	public static String getQpsSortTableFieldNameByAliasName(String sourceSql,String qpsOrderBy){
		String result = "";
		//String tableFieldName = "";
		String[] singleOrderBy = qpsOrderBy.split(",");
		Pattern sortPat = Pattern.compile("(?<=\\s)(asc|desc)(?!\\w)",Pattern.CASE_INSENSITIVE);
		Matcher sortMatcher = sortPat.matcher(singleOrderBy[0]);//仅取第一个排序字段，因为mysql如果不做联合索引并且排序顺序按照联合索引的顺序，则会大大降低排序效率
		String sortStr = new String("");
		StringBuffer aliasNameBuf = new StringBuffer("");
		if(sortMatcher.find()){
			sortStr = sortMatcher.group();
			sortMatcher.appendReplacement(aliasNameBuf, "");
		}
		String aliasName = sortMatcher.appendTail(aliasNameBuf).toString().trim();
		String newFiledName = getTableFieldNameByAliasName(sourceSql, aliasName);
		if("".equals(newFiledName) || null == newFiledName){
			result = "notTransOrderSql";
		}
		String tableNickName = newFiledName.substring(0, newFiledName.indexOf(".")+1);

		Pattern tableFieldPattern = Pattern.compile("([\\w]*(\\.)(`){0,1}[\\w]*)(`){0,1}",Pattern.CASE_INSENSITIVE);
		Matcher match = tableFieldPattern.matcher(newFiledName);
		while(match.find()){
			result = newFiledName + " " + sortStr + " ," + tableNickName + "row_id " + sortStr;
		}
		return result;
	}
	
	public static Map<String,Object> transformConditionClauseByAliasName(String sourceSql,String qpsConditionClause){
		Map<String,Object> result = new HashMap<String,Object>();
		String allTransFlag = "true";//是否还含有未转换的条件语句
		String transConditionClause = "";//已转换的条件语句
		String notTtransConditionClause = "";//未转换的条件语句
		if(!"".equals(qpsConditionClause) && null != qpsConditionClause){
			//首先转换 Filter.OP_IS_NULL 和 Filter.OP_NOT_NULL 条件 
			//目前有一个问题,如果对应的变量还有相关or条件，暂时无法转换，格式 类似 "and acctLevel IS NULL or acctLevel = '' or acctLevel = '123'"的条件语句
			//筛选符合条件的语句
			Pattern pattern = Pattern.compile("\\s{0,}(and)\\s{1,}([\\w]*)\\s{1,}(IS)(\\s{1,}(not)){0,1}\\s{1,}(NULL)\\s{1,}((or)|(and))\\s{1,}([\\w]*)\\s{1,}((=)|(!=))\\s{1,}(('')|('[\\w]*'))(?=(\\s{0,})$|(\\s{1,}(and)))", Pattern.CASE_INSENSITIVE);
			Matcher match = pattern.matcher(qpsConditionClause);
			String matchMultiString = "";
			String aliasTempStr = "";
			String multiTransResult = "";
			while(match.find()){
				matchMultiString = match.group();
				aliasTempStr = matchMultiString;
				//去掉其它字符，只留下别名
				aliasTempStr = aliasTempStr.replaceAll("(?i)((and)|(or)|(=)|(!=)|(is)|(not)|(null)|('')|('[\\w]*'))", "");
				Pattern aliasPattern = Pattern.compile("([\\w]{1,})", Pattern.CASE_INSENSITIVE);
				Matcher aliasMatch = aliasPattern.matcher(aliasTempStr);
				String tableFieldName = "";
				boolean flag = true;
				while(aliasMatch.find()){
					//通过每一个别名去远sql中查找是否有对应的表字段
					tableFieldName = getTableFieldNameByAliasName(sourceSql,aliasMatch.group().trim());
					if("".equals(tableFieldName) || null == tableFieldName){
						//如果有一个找不到 标识返回false
						flag = false;
					}else{
						//如果找到，现将员条件语句中的别名替换掉 保存到变量 multiTransResult 中
						multiTransResult = matchMultiString.replace(aliasMatch.group().trim(), tableFieldName);
					}
				}
				//判断是否所有别名字段都已转换，如果都已经转换，则将条件语句中的相关信息去掉，并将转换后的语句放入已转换 transConditionClause 变量中
				if(flag){
					qpsConditionClause = qpsConditionClause.replace(matchMultiString.trim(), "");
					transConditionClause = transConditionClause + " " + multiTransResult + " ";
				}
			}
			//Filter.OP_IS_NULL 和 Filter.OP_NOT_NULL 条件 转换结束
			
			//开始转换其它条件
			String blank = qpsConditionClause.substring(0, 1);
			if(!" ".equals(blank)){
				qpsConditionClause = " " + qpsConditionClause;
			}
//			String[] conditionSplit = qpsConditionClause.split("(//s{1,}and//s{1,}|//s{1,}AND//s{1,})");//拆分条件语句
			String[] conditionSplit = qpsConditionClause.split("(\\s{1,}?(and)\\s{1,}?)|(//s{1,}?(AND)//s{1,}?)");//拆分条件语句
			String tableFieldName= "";//得到的[表别名。字段名]
			String transClause = "";//转换后的一条条件语句
			for(int i=0;i<conditionSplit.length;i++){
				conditionSplit[i] = conditionSplit[i].trim();
//				if(conditionSplit[i].indexOf("(") != -1 || conditionSplit[i].indexOf(")") != -1){
//					allTransFlag = "false";
//					notTtransConditionClause = notTtransConditionClause + " and " + conditionSplit[i];
//					conditionSplit[i] = "";
//				}
				if(conditionSplit[i].indexOf("(") != -1 || conditionSplit[i].indexOf(")") != -1){//如果条件语句中有带括号的表达式,判断是否为like模糊查询
					String likeCondition = "";//得到的like条件
//					Pattern likePattern = Pattern.compile("(LIKE concat\\('%',\\s?'([^']*[^'])',\\s?'%'\\))",Pattern.CASE_INSENSITIVE);
					Pattern likePattern = Pattern.compile("(like concat\\('%',\\s{0,}'([^'].*[^'])'\\s{0,},\\s{0,}'%'\\))",Pattern.CASE_INSENSITIVE);//判断是否为like模糊查询，并且模糊查询的内容不能以'开头
					Matcher likeMatch = likePattern.matcher(conditionSplit[i]);
					while(likeMatch.find()){
						likeCondition = likeMatch.group();
					}
					if(likeCondition != null && !"".equals(likeCondition)){
						String likeAliasName = conditionSplit[i].replace(likeCondition, "").trim();
						String likeTableFieldName = getTableFieldNameByAliasName(sourceSql,likeAliasName);//根据别名得到的模糊查询的表字段名
						if(!"".equals(likeTableFieldName) && null != likeTableFieldName){
							transClause = conditionSplit[i].replace(likeAliasName, likeTableFieldName);
							transConditionClause = transConditionClause + " and " + transClause;
						}else{
							allTransFlag = "false";
							notTtransConditionClause = notTtransConditionClause + " and " + conditionSplit[i];
						}
					}else{
						allTransFlag = "false";
						notTtransConditionClause = notTtransConditionClause + " and " + conditionSplit[i];
						conditionSplit[i] = "";
					}
						
				}else if (!"".equals(conditionSplit[i]) && null != conditionSplit[i]){//如果查询语句不包含带有括号的表达式并且不为空
					String[] aliasNameSplit = conditionSplit[i].split("(=)|(<>)|(!=)|(>)|(<)|(>=)|(<=)|(like)");
	//				aliasNameSplit[0] = aliasNameSplit[0].replace("and", "");
					tableFieldName = getTableFieldNameByAliasName(sourceSql,aliasNameSplit[0].trim());
					if(!"".equals(tableFieldName) && null != tableFieldName){
						transClause = conditionSplit[i].replace(aliasNameSplit[0].trim(), tableFieldName);
						transConditionClause = transConditionClause + " and " + transClause;
					}else{
						allTransFlag = "false";
						notTtransConditionClause = notTtransConditionClause + " and " + conditionSplit[i];
					}
				}
			}
		}
		result.put("allTransFlag", allTransFlag);
		result.put("transConditionClause", transConditionClause);
		result.put("notTransConditionClause", notTtransConditionClause);
		return result;
	}
	
	public static String getQpsStayFields(BasicModel qps){
		String fields = qps.getStayFields().trim();
		if(fields.endsWith(",")){
			 Pattern pattern = Pattern.compile("^,+|,+$");
		     Matcher matcher = pattern.matcher(fields);
		     fields = matcher.replaceAll("");
		}
		return fields + " ";
		
	}
}
