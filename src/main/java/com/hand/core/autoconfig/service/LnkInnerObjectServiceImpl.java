package com.hand.core.autoconfig.service;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.core.autoconfig.dao.mybatis.mapper.LnkInnerFieldMapper;
import com.hand.core.autoconfig.dao.mybatis.mapper.LnkInnerLinkMapper;
import com.hand.core.autoconfig.dao.mybatis.mapper.LnkInnerObjectMapper;
import com.hand.core.autoconfig.dao.mybatis.mapper.LnkInnerWhereMapper;
import com.hand.core.autoconfig.model.LnkInnerField;
import com.hand.core.autoconfig.model.LnkInnerLink;
import com.hand.core.autoconfig.model.LnkInnerObject;
import com.hand.core.autoconfig.model.LnkInnerWhere;
import com.hand.core.modules.BatchExportFileWriter;
import com.hand.core.util.StringUtils;

@Service
public class LnkInnerObjectServiceImpl extends BasicServiceImpl<LnkInnerObject>implements LnkInnerObjectService {
	@Resource
	private LnkInnerObjectMapper	lnkInnerObjectMapper;
	@Resource
	private LnkInnerFieldMapper		lnkInnerFieldMapper;
	@Resource
	private LnkInnerLinkMapper		lnkInnerLinkMapper;
	@Resource
	private LnkInnerWhereMapper		lnkInnerWhereMapper;
	@Resource
	private KeyGenerateService		keyGenerateService;
	private static final Logger		logger	= LogManager.getLogger(LnkInnerObjectServiceImpl.class);
	
	@Override
	public BasicMapper<LnkInnerObject> getBasicMapper() {
		return lnkInnerObjectMapper;
	}
	
	public String newQueryTable(LnkInnerObject record) throws Exception {
		Map<String, String> systemField = new HashMap<String, String>();
		systemField.put("id", "");
		systemField.put("created", "");
		systemField.put("created_by", "");
		systemField.put("last_upd", "");
		systemField.put("last_upd_by", "");
		systemField.put("orgId", "");
		systemField.put("postnId", "");
		String OutMsg = "";
		List<LnkInnerObject> headers = lnkInnerObjectMapper.queryByInner(record);
		for (LnkInnerObject header : headers) {
			Map<String, String> lineField = new HashMap<String, String>();
			OutMsg += "SELECT " + System.getProperty("line.separator");
			OutMsg += "\t " + FormatStringToLength("T1.ROW_ID") + " as " + FormatStringToLength("id") + "/*记录ID*/"
					+ System.getProperty("line.separator");
			OutMsg += "\t," + FormatStringToLength("T1.CREATED") + " as " + FormatStringToLength("created") + "/*创建时间*/"
					+ System.getProperty("line.separator");
			OutMsg += "\t," + FormatStringToLength("T1.CREATED_BY") + " as " + FormatStringToLength("createdBy")
					+ "/*创建者ID*/" + System.getProperty("line.separator");
			OutMsg += "\t," + FormatStringToLength("TO_CHAR(T1.LAST_UPD, 'yyyy-mm-dd hh24:mi:ss')") + " as "
					+ FormatStringToLength("lastUpdated") + "/*最后更新时间*/" + System.getProperty("line.separator");
			OutMsg += "\t," + FormatStringToLength("T1.LAST_UPD_BY") + " as " + FormatStringToLength("lastUpdatedBy")
					+ "/*最后更新者ID*/" + System.getProperty("line.separator");
			OutMsg += "\t," + FormatStringToLength("T1.ORG_ID") + " as " + FormatStringToLength("orgId") + "/*组织ID*/"
					+ System.getProperty("line.separator");
			OutMsg += "\t," + FormatStringToLength("T1.POSTN_ID") + " as " + FormatStringToLength("postnId")
					+ "/*职位ID*/" + System.getProperty("line.separator");
			
			LnkInnerLink linkExample = new LnkInnerLink();
			linkExample.setParentid(record.getId());
			linkExample.setAttr02("Y");
			
			LnkInnerField fieldExample = new LnkInnerField();
			fieldExample.setParentid(record.getId());
			fieldExample.setAttr02("Y");
			
			LnkInnerWhere whereExample = new LnkInnerWhere();
			whereExample.setParentid(record.getId());
			
			String LinkString = "\tFROM\t " + FormatStringToLength(header.getBasetable()) + " "
					+ header.getBasetablealais() + System.getProperty("line.separator");
			String whereString = "\t\tWHERE 1=1" + System.getProperty("line.separator");
			List<LnkInnerLink> links = lnkInnerLinkMapper.queryByInner(linkExample);// query link
			List<LnkInnerField> fields = lnkInnerFieldMapper.queryByInner(fieldExample);// query Field
			List<LnkInnerWhere> wheres = lnkInnerWhereMapper.queryByInner(whereExample);
			/* 处理基表的字段 */
			for (LnkInnerField field : fields) {
				if (field.getActiveflag() == null || "N".equals(field.getActiveflag())) {
					continue;
				}
				if (field.getJoinname() != null && !"".equals(field.getJoinname())) {
					continue;
				}
				if (systemField.containsKey(field.getName())) {
					continue;
				}
				if (lineField.containsKey(field.getName())) {
					continue;
				}
				OutMsg += "\t," + FormatStringToLength("T1." + field.getColumnname()) + " as "
						+ FormatStringToLength(field.getName()) + "/*" + field.getDisplayname() + "*/"
						+ System.getProperty("line.separator");
				lineField.put(field.getName(), "");
			}
			for (LnkInnerLink link : links) {
				String linkname = link.getName();
				if (link.getAttr02() == null || "N".equals(link.getAttr02())) {
					continue;
				}
				LinkString += "\t\t," + FormatStringToLength(link.getTablename()) + " " + link.getAttr01()
						+ System.getProperty("line.separator");
				whereString += "\t\tAND (" + link.getLinkcoms() + ")" + System.getProperty("line.separator");
				for (LnkInnerField field : fields) {
					String fieldlinname = field.getJoinname();
					if (field.getActiveflag() == null || "N".equals(field.getActiveflag())) {
						continue;
					}
					if (!linkname.equals(fieldlinname) || fieldlinname == null || fieldlinname == "") {
						continue;
					}
					if (systemField.containsKey(field.getName())) {
						continue;
					}
					if (lineField.containsKey(field.getName())) {
						continue;
					}
					OutMsg += "\t," + FormatStringToLength(link.getAttr01() + "." + field.getColumnname()) + " as "
							+ FormatStringToLength(field.getName()) + "/*" + field.getDisplayname() + "*/"
							+ System.getProperty("line.separator");
					lineField.put(field.getName(), "");
				}
			}
			
			for(LnkInnerWhere where : wheres){
				String whereComs = where.getLinkcoms();
				if(!StringUtils.isBlank(whereComs) && "Y".equals(where.getAttr02())){
					if(whereComs.trim().startsWith("<") || whereComs.trim().toUpperCase().startsWith("AND ")){
						whereString += "\t\t" + where.getLinkcoms() + "" + System.getProperty("line.separator");
					}else{
						whereString += "\t\tAND " + where.getLinkcoms() + "" + System.getProperty("line.separator");
					}
				}
				
			}
			OutMsg += LinkString + System.getProperty("line.separator") + whereString
					+ System.getProperty("line.separator");
		}
		return OutMsg;
	}
	/**
	 * 生成oracle建表语句
	 */
	public String newTable(LnkInnerObject record) throws Exception {
		Map<String, String> systemField = new HashMap<String, String>();
		systemField.put("ROW_ID", "");
		systemField.put("CREATED", "");
		systemField.put("CREATED_BY", "");
		systemField.put("LAST_UPD", "");
		systemField.put("LAST_UPD_BY", "");
		systemField.put("CORP_ID", "");
		systemField.put("ORG_ID", "");
		systemField.put("POSTN_ID", "");
		String OutMsg = "";
		LnkInnerObject qps = new LnkInnerObject();
		qps.setId(record.getId());
		qps.setAttr02("Y");
		List<LnkInnerObject> headers = lnkInnerObjectMapper.queryByInner(qps);
		for (LnkInnerObject header : headers) {
			Map<String, String> lineField = new HashMap<String, String>();
			OutMsg += "--DROP TABLE " + header.getBasetable() + ";" + System.getProperty("line.separator");
			OutMsg += "CREATE TABLE " + header.getBasetable() + " (" + System.getProperty("line.separator");
			OutMsg += "\t " + FormatStringToLength("ROW_ID") + " "
					+ FormatStringToLength30("VARCHAR2(30 CHAR) NOT NULL") + "/*记录ID*/"
					+ System.getProperty("line.separator");
			OutMsg += "\t," + FormatStringToLength("CREATED") + " "
					+ FormatStringToLength30("DATE DEFAULT SYSDATE NOT NULL") + "/*创建时间*/"
					+ System.getProperty("line.separator");
			OutMsg += "\t," + FormatStringToLength("CREATED_BY") + " "
					+ FormatStringToLength30("VARCHAR2(30 CHAR) NOT NULL") + "/*创建者*/"
					+ System.getProperty("line.separator");
			OutMsg += "\t," + FormatStringToLength("LAST_UPD") + " "
					+ FormatStringToLength30("DATE DEFAULT SYSDATE NOT NULL") + "/*最后更新时间*/"
					+ System.getProperty("line.separator");
			OutMsg += "\t," + FormatStringToLength("LAST_UPD_BY") + " "
					+ FormatStringToLength30("VARCHAR2(30 CHAR) NOT NULL") + "/*最后更新者*/"
					+ System.getProperty("line.separator");
			OutMsg += "\t," + FormatStringToLength("CORP_ID") + " " + FormatStringToLength30("VARCHAR2(5)")
					+ "/*公司账套ID*/" + System.getProperty("line.separator");
			OutMsg += "\t," + FormatStringToLength("ORG_ID") + " " + FormatStringToLength30("VARCHAR2(30)") + "/*组织ID*/"
					+ System.getProperty("line.separator");
			OutMsg += "\t," + FormatStringToLength("POSTN_ID") + " " + FormatStringToLength30("VARCHAR2(30)")
					+ "/*职位ID*/" + System.getProperty("line.separator");
			String commentString = "";
			commentString += "comment on column " + header.getBasetable() + ".ROW_ID is '记录的主键';"
					+ System.getProperty("line.separator");
			commentString += "comment on column " + header.getBasetable() + ".CREATED is '创建时间';"
					+ System.getProperty("line.separator");
			commentString += "comment on column " + header.getBasetable() + ".CREATED_BY is '创建者';"
					+ System.getProperty("line.separator");
			commentString += "comment on column " + header.getBasetable() + ".LAST_UPD is '最后更新时间';"
					+ System.getProperty("line.separator");
			commentString += "comment on column " + header.getBasetable() + ".LAST_UPD_BY is '最后更新者';"
					+ System.getProperty("line.separator");
			commentString += "comment on column " + header.getBasetable() + ".CORP_ID is '公司账套ID';"
					+ System.getProperty("line.separator");
			commentString += "comment on column " + header.getBasetable() + ".ORG_ID is '组织ID';"
					+ System.getProperty("line.separator");
			commentString += "comment on column " + header.getBasetable() + ".POSTN_ID is '职位ID';"
					+ System.getProperty("line.separator");
			String IndexString = "CREATE UNIQUE INDEX " + header.getBasetable() + "_PK ON " + header.getBasetable()
					+ " (ROW_ID);" + System.getProperty("line.separator");
			int indexcountU = 1;
			int indexcountN = 1;
			String ModifyString = "/* 以下脚本为在现有表中修改字段的脚本，请在plsql developer的命令行中执行*/"
					+ System.getProperty("line.separator") + "/*" + System.getProperty("line.separator");
			String AddcolString = "/* 以下脚本为在现有表中增加字段的脚本，请在plsql developer的命令行中执行*/"
					+ System.getProperty("line.separator") + "/*" + System.getProperty("line.separator");
			AddcolString += "alter table " + header.getBasetable() + " add " + FormatStringToLength("CORP_ID") + " "
					+ FormatStringToLength30("VARCHAR2(5);") + "/*公司账套ID*/" + System.getProperty("line.separator");
			AddcolString += "alter table " + header.getBasetable() + " add " + FormatStringToLength("ORG_ID") + " "
					+ FormatStringToLength30("VARCHAR2(30);") + "/*组织ID*/" + System.getProperty("line.separator");
			AddcolString += "alter table " + header.getBasetable() + " add " + FormatStringToLength("POSTN_ID") + " "
					+ FormatStringToLength30("VARCHAR2(30);") + "/*职位ID*/" + System.getProperty("line.separator");
			ModifyString += "alter table " + header.getBasetable() + " modify " + FormatStringToLength("CORP_ID") + " "
					+ FormatStringToLength30("VARCHAR2(5);") + "/*公司账套ID*/" + System.getProperty("line.separator");
			ModifyString += "alter table " + header.getBasetable() + " modify " + FormatStringToLength("ORG_ID") + " "
					+ FormatStringToLength30("VARCHAR2(30);") + "/*组织ID*/" + System.getProperty("line.separator");
			ModifyString += "alter table " + header.getBasetable() + " modify " + FormatStringToLength("POSTN_ID") + " "
					+ FormatStringToLength30("VARCHAR2(30);") + "/*职位ID*/" + System.getProperty("line.separator");
			LnkInnerField qps1 = new LnkInnerField();
			qps1.setParentid(record.getId());
			List<LnkInnerField> fields = lnkInnerFieldMapper.queryByInner(qps1);
			for (LnkInnerField field : fields) {
				String name = field.getName();
				if (field.getActiveflag() == null || "N".equals(field.getActiveflag())) {
					logger.info("field.getActiveflag() is:");
					logger.info(field.getActiveflag());
					continue;
				}
				if ("Y".equals(field.getCalc())) {
					logger.info("field.getCalc() is:");
					logger.info(field.getActiveflag());
					continue;
				}
				if (field.getJoinname() != null && !"".equals(field.getJoinname())) {
					logger.info("field.getJoinname() is:");
					logger.info(field.getJoinname());
					continue;
				}
				if(field.getColumnname() == null || "".equals(field.getColumnname())){
					logger.info("getColumnname field is blank!");
					logger.info(field.getDisplayname());
					continue;
				}
				if (systemField.containsKey(field.getColumnname())) {
					logger.info("getColumnname is system field:");
					logger.info(field.getColumnname());
					continue;
				}
				if (lineField.containsKey(field.getColumnname())) {
					logger.info("getColumnname field is aleady exists!");
					logger.info(field.getColumnname());
					continue;
				}
				
				String FieldType = "";
				if ("VARCHAR2".equals(field.getColumntype())) {
					FieldType = "VARCHAR2(" + field.getColumnlength() + ")";
				} else if ("NUMBER".equals(field.getColumntype())) {
					FieldType = "NUMBER(22,7)";
				} else if ("DATE".equals(field.getColumntype())) {
					FieldType = "DATE";
				} else if ("CLOB".equals(field.getColumntype())) {
					FieldType = "CLOB";
				} else if ("CHAR".equals(field.getColumntype())) {
					FieldType = "CHAR(" + field.getColumnlength() + ")";
				}
				OutMsg += "\t," + FormatStringToLength(field.getColumnname()) + " " + FormatStringToLength30(FieldType)
						+ "/*" + field.getDisplayname() + "*/" + System.getProperty("line.separator");
				commentString += "comment on column " + header.getBasetable() + "." + field.getColumnname() + " is '"
						+ field.getDisplayname() + "';" + System.getProperty("line.separator");
				lineField.put(field.getColumnname(), "");
				if ("Normal".equals(field.getIndextype())) {
					IndexString += "CREATE INDEX " + header.getBasetable() + "_N" + indexcountN + " ON "
							+ header.getBasetable() + " (" + field.getColumnname() + ");"
							+ System.getProperty("line.separator");
					indexcountN++;
				} else if ("Unique".equals(field.getIndextype())) {
					IndexString += "CREATE UNIQUE INDEX " + header.getBasetable() + "_U" + indexcountU + " ON "
							+ header.getBasetable() + " (" + field.getColumnname() + ");"
							+ System.getProperty("line.separator");
					indexcountU++;
				}
				AddcolString += "alter table " + header.getBasetable() + " add "
						+ FormatStringToLength(field.getColumnname()) + " " + FormatStringToLength30(FieldType + ";")
						+ "/*" + field.getDisplayname() + "*/" + System.getProperty("line.separator");
				ModifyString += "alter table " + header.getBasetable() + " modify "
						+ FormatStringToLength(field.getColumnname()) + " " + FormatStringToLength30(FieldType + ";")
						+ "/*" + field.getDisplayname() + "*/" + System.getProperty("line.separator");
			}
			OutMsg += ")" + System.getProperty("line.separator") + System.getProperty("line.separator");
			OutMsg += commentString + System.getProperty("line.separator") + System.getProperty("line.separator");
			OutMsg += IndexString + System.getProperty("line.separator") + System.getProperty("line.separator")
					+ AddcolString + "*/" + System.getProperty("line.separator");
			OutMsg += ModifyString + "*/" + System.getProperty("line.separator");
		}
		return OutMsg;
	}
	/**
	 * 
	 *<p>获取service接口文件内容并替换关键字符串</p>
	 * @author yrf
	 * @param Namespace
	 * @param objName
	 * @param FolderName
	 * @return
	 */
	private String GetServiceString(String Namespace, String objName, String FolderName) {
		objName = toUpperCaseFirstOne(objName);
		String LobjName = toLowerCaseFirstOne(objName);
		BatchExportFileWriter writer = null;
		writer = new BatchExportFileWriter();
		String OutString = writer.gettemplateContent("service");
		OutString = OutString.replace("&package&", Namespace);
		OutString = OutString.replace("&objectname&", objName);
		OutString = OutString.replace("&LFobjectname&", LobjName);
		OutString = OutString.replace("&FolderName&", FolderName);
		return OutString;
	}
	/**
	 * 
	 *<p>获取service实现类文件内容并替换关键字符串</p>
	 * @author yrf
	 * @param Namespace
	 * @param objName
	 * @param FolderName
	 * @return
	 */
	private String GetServiceImplString(String Namespace, String objName, String FolderName) {
		objName = toUpperCaseFirstOne(objName);
		String LobjName = toLowerCaseFirstOne(objName);
		BatchExportFileWriter writer = null;
		writer = new BatchExportFileWriter();
		String OutString = writer.gettemplateContent("serviceimpl");
		OutString = OutString.replace("&package&", Namespace);
		OutString = OutString.replace("&objectname&", objName);
		OutString = OutString.replace("&LFobjectname&", LobjName);
		OutString = OutString.replace("&FolderName&", FolderName);
		return OutString;
	}
	
	/**
	 * 
	 *<p>获取java mapper class模板文件并替换字符串</p>
	 * @param Namespace
	 * @param objName
	 * @param FolderName
	 * @return
	 */
	private String GetMapperString(String Namespace, String objName, String FolderName) {
		objName = toUpperCaseFirstOne(objName);
		String LobjName = toLowerCaseFirstOne(objName);
		BatchExportFileWriter writer = null;
		writer = new BatchExportFileWriter();
		String OutString = writer.gettemplateContent("mapper");
		OutString = OutString.replace("&package&", Namespace);
		OutString = OutString.replace("&objectname&", objName);
		OutString = OutString.replace("&LFobjectname&", LobjName);
		OutString = OutString.replace("&FolderName&", FolderName);
		return OutString;
	}
	
	/**
	 * 
	 *<p>获取crm Controller文件模板内容并替换关键字符串</p>
	 * @author yrf
	 * @param Namespace
	 * @param objName
	 * @param FolderName
	 * @return
	 */
	private String GetControllerString(String Namespace, String objName, String FolderName) {
		objName = toUpperCaseFirstOne(objName);
		String LobjName = toLowerCaseFirstOne(objName);
		BatchExportFileWriter writer = null;
		writer = new BatchExportFileWriter();
		String OutString = writer.gettemplateContent("controller");
		OutString = OutString.replace("&package&", Namespace);
		OutString = OutString.replace("&objectname&", objName);
		OutString = OutString.replace("&LFobjectname&", LobjName);
		OutString = OutString.replace("&FolderName&", FolderName);
		return OutString;
	}
	/**
	 * 
	 *<p>获取model文件模板并替换关键字符串</p>
	 * @param Namespace
	 * @param objName
	 * @param FolderName
	 * @return
	 */
	private String GetModelString(String Namespace, String objName, String FolderName) {
		objName = toUpperCaseFirstOne(objName);
		String LobjName = toLowerCaseFirstOne(objName);
		BatchExportFileWriter writer = null;
		writer = new BatchExportFileWriter();
		String OutString = writer.gettemplateContent("model");
		OutString = OutString.replace("&package&", Namespace);
		OutString = OutString.replace("&objectname&", objName);
		OutString = OutString.replace("&LFobjectname&", LobjName);
		OutString = OutString.replace("&FolderName&", FolderName);
		return OutString;
	}
	/**
	 * 
	 *<p>获取sql的xml映射文件模板并替换关键字符串</p>
	 * @author yrf
	 * @param Namespace
	 * @param objName
	 * @param FolderName
	 * @return
	 */
	private String GetmapperxmlString(String Namespace, String objName, String FolderName) {
		objName = toUpperCaseFirstOne(objName);
		String LobjName = toLowerCaseFirstOne(objName);
		BatchExportFileWriter writer = null;
		writer = new BatchExportFileWriter();
		String OutString = writer.gettemplateContent("mapperxml");
		OutString = OutString.replace("&package&", Namespace);
		OutString = OutString.replace("&objectname&", objName);
		OutString = OutString.replace("&LFobjectname&", LobjName);
		OutString = OutString.replace("&FolderName&", FolderName);
		return OutString;
	}
	/**
	 * 
	 *<p>获取jsp模板内容，并替换其中对象名称等信息</p>
	 * @param Namespace
	 * @param objName
	 * @param FolderName
	 * @return
	 */
	private String GetjspString(String Namespace, String objName, String FolderName) {
		objName = toUpperCaseFirstOne(objName);
		String LobjName = toLowerCaseFirstOne(objName);
		BatchExportFileWriter writer = null;
		writer = new BatchExportFileWriter();
		String OutString = writer.gettemplateContent("jsp");
		OutString = OutString.replace("&package&", Namespace);
		OutString = OutString.replace("&objectname&", objName);
		OutString = OutString.replace("&LFobjectname&", LobjName);
		OutString = OutString.replace("&FolderName&", FolderName);
		return OutString;
	}
	/**
	 * 
	 *<p>获取other文件模板内容并替换关键字符串</p>
	 * @param Namespace
	 * @param objName
	 * @param FolderName
	 * @return
	 */
	private String GetotherString(String Namespace, String objName, String FolderName) {
		objName = toUpperCaseFirstOne(objName);
		String LobjName = toLowerCaseFirstOne(objName);
		BatchExportFileWriter writer = null;
		writer = new BatchExportFileWriter();
		String OutString = writer.gettemplateContent("other");
		OutString = OutString.replace("&package&", Namespace);
		OutString = OutString.replace("&objectname&", objName);
		OutString = OutString.replace("&LFobjectname&", LobjName);
		OutString = OutString.replace("&FolderName&", FolderName);
		return OutString;
	}
	
	/**
	 * 
	 *<p>替换传入字符串的关键词为目标字符串</p>
	 * @param OutString 被替换字符串
	 * @param Namespace
	 * @param objName
	 * @param FolderName
	 * @return
	 */
	private String PublicReplace(String OutString, String Namespace, String objName, String FolderName) {
		objName = toUpperCaseFirstOne(objName);
		String LobjName = toLowerCaseFirstOne(objName);
		OutString = OutString.replace("&package&", Namespace);
		OutString = OutString.replace("&objectname&", objName);
		OutString = OutString.replace("&LFobjectname&", LobjName);
		OutString = OutString.replace("&FolderName&", FolderName);
		return OutString;
	}
	
	/**
	 * 
	 *<p>根据传入文件名称获取模板内容并替换关键字符串</p>
	 * @param filename
	 * @param Namespace
	 * @param objName
	 * @param FolderName
	 * @param DisplayObjectName
	 * @return
	 */
	private String GetPublicReplaceFile(String filename, String Namespace, String objName, String FolderName,
			String DisplayObjectName) {
		BatchExportFileWriter writer = null;
		writer = new BatchExportFileWriter();
		String OutString = writer.gettemplateContent(filename);
		OutString = PublicReplace(OutString, Namespace, objName, FolderName);
		OutString = OutString.replace("&DisplayObjectName&", DisplayObjectName);
		return OutString;
	}
	
	// 首字母转小写
	private static String toLowerCaseFirstOne(String s) {
		if(s==null || s.length()==0){
			return s;
		}
		if (Character.isLowerCase(s.charAt(0)))
			return s;
		else
			return (new StringBuilder()).append(Character.toLowerCase(s.charAt(0))).append(s.substring(1)).toString();
	}
	
	/**
	 * 
	 *<p>首字母转大写</p>
	 * @param s
	 * @return
	 */
	private static String toUpperCaseFirstOne(String s) {
		if(s==null || s.length()==0){
			return s;
		}
		if (Character.isUpperCase(s.charAt(0)))
			return s;
		else
			return (new StringBuilder()).append(Character.toUpperCase(s.charAt(0))).append(s.substring(1)).toString();
	}
	
	/**
	 * 
	 *<p>格式化字符串，null返回""; 长度不足20空格补偿</p>
	 * @param s
	 * @return
	 */
	private String FormatStringToLength(String s) {
		if (s == null) {
			return "";
		}
		while (s.length() < 20) {
			s += " ";
		}
		return s;
	}
	
	/**
	 * 
	 *<p>格式化字符串，null返回""; 长度不足34空格补偿</p>
	 * @param s
	 * @return
	 */
	private String FormatStringToLength30(String s) {
		if (s == null) {
			return "";
		}
		while (s.length() < 34) {
			s += " ";
		}
		return s;
	}
	
	/**
	 * 
	 *<p>根据field对象生成移动端页面html对应字段代码</p>
	 * @author yrf
	 * @param objname
	 * @param field
	 * @return
	 */
	private String GetAppHtmlInfo(String objname, LnkInnerField field) {
		String tmp = "";
		String lov = field.getLovtype();
		String cfield = field.getName();
		objname = toLowerCaseFirstOne(objname);
		String uireq = field.getUirequired();
		String uireadonly = field.getUireadonly();
		String DisplayName = field.getDisplayname();
		String appUIType = field.getAttr04();
		String readOnlyCondition = "";
		if(!StringUtils.isBlank(field.getAttr07())){//app页面条件只读表达式
			readOnlyCondition = "ng-readonly=\""+field.getAttr07()+"\" ";
		}
		if("Y".equals(field.getAttr08()) && !StringUtils.isBlank(field.getAttr09())){
			//多语言标记为Y，且多语言表达式不为空
			DisplayName = field.getAttr09();
		}
		if ("".equals(lov) || lov == null) {
			String placeholder = "Y".equals(uireadonly) || !"Y".equals(field.getAttr05()) ? "" : "请输入[DisplayName]";
			String closeicon = "Y".equals(field.getAttr06()) ? "closeicon" : "";
			if ("text".equals(appUIType)) {
				tmp = "<ons-list-item><mytitle [required]>[DisplayName]</mytitle><input placeholder='"+placeholder+"' type='text' "+closeicon+" class='text-input text-input--transparent' ng-model='[objname]Item.[field]' [readonly]></ons-list-item>"
						+ System.getProperty("line.separator");
			} else if ("email".equals(appUIType)) {
				tmp = "<ons-list-item><mytitle [required]>[DisplayName]</mytitle><input placeholder='"+placeholder+"' type='email' "+closeicon+" class='text-input text-input--transparent' ng-model='[objname]Item.[field]' [readonly]></ons-list-item>"
						+ System.getProperty("line.separator");
			} else if ("tel".equals(appUIType)) {
				tmp = "<ons-list-item><mytitle [required]>[DisplayName]</mytitle><input placeholder='"+placeholder+"' type='tel' "+closeicon+" class='text-input text-input--transparent' ng-model='[objname]Item.[field]' [readonly]></ons-list-item>"
						+ System.getProperty("line.separator");
			} else if ("number".equals(appUIType)) {
				tmp = "<ons-list-item><mytitle [required]>[DisplayName]</mytitle><input placeholder='"+placeholder+"' type='number' "+closeicon+" class='text-input text-input--transparent' ng-model='[objname]Item.[field]' [readonly]></ons-list-item>"
						+ System.getProperty("line.separator");
			} else if ("datetime".equals(appUIType)) {
				tmp = "<ons-list-item><mytitle [required]>[DisplayName]</mytitle><input placeholder='"+placeholder+"' xday type='text' "+closeicon+" class='text-input text-input--transparent' ng-model='[objname]Item.[field]' readonly ng-showdatepicker='datetime'></ons-list-item>"
						+ System.getProperty("line.separator");
			} else if ("date".equals(appUIType)) {
				tmp = "<ons-list-item><mytitle [required]>[DisplayName]</mytitle><input placeholder='"+placeholder+"' xday type='text' "+closeicon+" class='text-input text-input--transparent' ng-model='[objname]Item.[field]' readonly ng-showdatepicker='date'></ons-list-item>"
						+ System.getProperty("line.separator");
			} else if ("checkbox".equals(appUIType)) {
				tmp = "<ons-list-item><mytitle [required]>[DisplayName]</mytitle><label class='switch' style='margin-right: 20px !important;'><input type='checkbox' class='switch__input' ng-model='[objname]Item.[field]'  ng-true-value=\"'Y'\" ng-false-value=\"'N'\">";
				tmp += "<div class='switch__toggle'> <span style='color: white;margin-left: 8px;position: absolute;margin-top: -9px;' ng-show=\"[objname]Item.[field]=='Y'\">Y ";
				tmp += "</span> <span style='color: #f3f3f3;margin-left: 24px;position: absolute;margin-top: -9px;' ng-show=\"[objname]Item.[field]=='N'|| [objname]Item.[field]==null'\">N </span></div></label>";
				tmp += "</ons-list-item>" + System.getProperty("line.separator");
			} else if ("textarea".equals(appUIType)) {
				tmp = "<ons-list-item><mytitle [required]>[DisplayName]</mytitle>";
				tmp += "<textarea placeholder='"+placeholder+"' class='textarea textarea--transparent' "+closeicon+"  ng-model='[objname]Item.[field]' rows='2'  >  </textarea></ons-list-item>"
						+ System.getProperty("line.separator");
			}
		} else {
			uireadonly = "Y";
			if (appUIType == null || "".equals(appUIType)) {
				appUIType = "text";
			}
			tmp += "<ons-list-item modifier='chevron' ng-click=\"!ItemPageIsReadOnly&&lovPick(\'lov\',[objname]ItemNavigator,lov.[lov],\'[DisplayName]\',\'[objname]Item.[field]\',null,true)\">"
					+ System.getProperty("line.separator");
			tmp += "<mytitle required>[DisplayName]</mytitle>" + System.getProperty("line.separator");
			tmp += "<input type='text' [required] placeholder='' class='text-input text-input--transparent' lov='[lov]'    ng-model='[objname]Item.[field]' [readonly]>"
					+ System.getProperty("line.separator");
			tmp += "</ons-list-item>" + System.getProperty("line.separator");
			tmp = tmp.replace("[lov]", lov);
		}
		if ("Y".equals(uireq)) {
			tmp = tmp.replace("[required]", "required");
		} else {
			tmp = tmp.replace("[required]", "");
		}
		if ("Y".equals(uireadonly)) {
			tmp = tmp.replace("[readonly]", "readonly");
		} else {
			tmp = tmp.replace("[readonly]", readOnlyCondition);
		}
		tmp = tmp.replace("[DisplayName]", DisplayName);
		tmp = tmp.replace("[field]", cfield);
		tmp = tmp.replace("[objname]", objname);
		return tmp;
	}
	
	public Map<String, String> newObjectFile(LnkInnerObject record) throws Exception {
		Map<String, String> result = new HashMap<String, String>();
		String sqlMapxml = "";
		String sqlMapper = "";
		String ModelString = "";
		String servicejava = "";
		String serviceImpjava = "";
		String Controllerjava = "";
		String Jspfile = "";
		Map<String, String> systemField = new HashMap<String, String>(); /* * 保存必有的列名* 生成sql时防止重复生成*/
		systemField.put("id", "");
		systemField.put("created", "");
		systemField.put("createdBy", "");
		systemField.put("lastUpdated", "");
		systemField.put("lastUpdatedBy", "");
		systemField.put("corpid", "");
		systemField.put("orgId", "");
		systemField.put("postnId", "");
		List<LnkInnerObject> headers = lnkInnerObjectMapper.queryByInner(record);
		for (LnkInnerObject header : headers) {
			String modelName = toUpperCaseFirstOne(header.getName());
			String namespace = header.getAttr04().toLowerCase();//crm包名
			String FolderName = header.getAttr03().toLowerCase();//文件夹名称
			
			String DisplayObjectName = header.getAttr01().toLowerCase();//显示名称
			Map<String, String> lineField = new HashMap<String, String>();/*保存已生成sql的列名，生成sql时防止重复生成*/
			Map<String, String> replaceMap = new HashMap<String, String>();
			String selectallsql = "";
			String fromTableSql = "";
			String whereAllSql = "";
			String orderbysqll = "";
			String otherTxt = "";
			String insertintosql = "INSERT INTO " + header.getBasetable() + "(" + System.getProperty("line.separator");
			insertintosql += "\t\t " + FormatStringToLength("ROW_ID") + "/*记录ID*/"
					+ System.getProperty("line.separator");
			String updatesql = "UPDATE " + header.getBasetable() + " SET" + System.getProperty("line.separator");
			String deletefromsql = "";
			String updatemiddle = "";
			String insertFeld = "";
			String insertValue = System.getProperty("line.separator") + "\t\t " + FormatStringToLength("#{id}")
					+ "/*记录ID*/" + System.getProperty("line.separator");
			String where2 = "";
			
			deletefromsql = "DELETE FROM " + header.getBasetable() + " WHERE ROW_ID=#{id}";
			selectallsql = System.getProperty("line.separator");
			selectallsql += "\t\t " + FormatStringToLength("T1.ROW_ID") + " as " + FormatStringToLength("id")
					+ "/*记录编号*/" + System.getProperty("line.separator");
			selectallsql += "\t\t," + FormatStringToLength("T1.CREATED") + " as "
					+ FormatStringToLength("created") + "/*创建时间*/" + System.getProperty("line.separator");
			selectallsql += "\t\t," + FormatStringToLength("T1.CREATED_BY") + " as " + FormatStringToLength("createdBy")
					+ "/*创建者ID*/" + System.getProperty("line.separator");
			selectallsql += "\t\t," + FormatStringToLength("TO_CHAR(T1.LAST_UPD, 'yyyy-mm-dd hh24:mi:ss')") + " as "
					+ FormatStringToLength("lastUpdated") + "/*最后更新时间*/" + System.getProperty("line.separator");
			selectallsql += "\t\t," + FormatStringToLength("T1.LAST_UPD_BY") + " as "
					+ FormatStringToLength("lastUpdatedBy") + "/*最后更新者ID*/" + System.getProperty("line.separator");
			selectallsql += "\t\t," + FormatStringToLength("T1.CORP_ID") + " as " + FormatStringToLength("corpid")
					+ "/*公司账套*/" + System.getProperty("line.separator");
			selectallsql += "\t\t," + FormatStringToLength("T1.ORG_ID") + " as " + FormatStringToLength("orgId")
					+ "/*组织ID*/" + System.getProperty("line.separator");
			selectallsql += "\t\t," + FormatStringToLength("T1.POSTN_ID") + " as " + FormatStringToLength("postnId")
					+ "/*职位ID*/" + System.getProperty("line.separator");
			
			/* 处理各种文件头 */
			sqlMapper = GetMapperString(namespace, modelName, FolderName);
			servicejava = GetServiceString(namespace, modelName, FolderName);
			serviceImpjava = GetServiceImplString(namespace, modelName, FolderName);
			Controllerjava = GetControllerString(namespace, modelName, FolderName);
			sqlMapxml = GetmapperxmlString(namespace, modelName, FolderName);
			ModelString = GetModelString(namespace, modelName, FolderName);
			Jspfile = this.genJspListContent(header);
			otherTxt = GetotherString(namespace, modelName, FolderName);
			
			LnkInnerLink linkExample = new LnkInnerLink();
			linkExample.setParentid(record.getId());
			linkExample.setAttr02("Y");//有效关联表
			linkExample.setPageFlag(false);
			LnkInnerField fieldExample = new LnkInnerField();
			fieldExample.setParentid(record.getId());
			fieldExample.setAttr02("Y");//有效字段
			fieldExample.setPageFlag(false);
			String LinkString = "FROM " + header.getBasetable() + " " + header.getBasetablealais()
					+ System.getProperty("line.separator");
			String whereString = "\tWHERE 1=1" + System.getProperty("line.separator");
			List<LnkInnerField> fields = lnkInnerFieldMapper.queryByInner(fieldExample);// query
			List<LnkInnerLink> links = lnkInnerLinkMapper.queryByInner(linkExample);// query
			header.setFieldList(fields);
			header.setLinkList(links);
			header.setFullObjFlag(true);
			/* 处理基表的字段 */
			String modelFields = "";
			String modelFields2 = "";
			int fieldcount = 0;
			for (LnkInnerField field : fields) {
				if (field.getActiveflag() == null || "N".equals(field.getActiveflag())) {
					continue;
				}
				/* 处理model字段 */
				String lov = field.getLovtype();
				String cfield = field.getName();
				String UFfield = toUpperCaseFirstOne(cfield);
				String fieldtype = field.getFieldtype();
				if ("".equals(lov) || lov == null) {
					modelFields += "\tprivate " + fieldtype + " " + FormatStringToLength(cfield + ";") + "\t/*"
							+ field.getDisplayname() + "*/" + System.getProperty("line.separator");
				} else {
					modelFields += "\tprivate " + fieldtype + " " + FormatStringToLength(cfield + ";") + "\t/*"
							+ field.getDisplayname() + ",值列表类型: " + lov + " */" + System.getProperty("line.separator");
				}
				modelFields2 += "\tpublic " + fieldtype + " get" + UFfield + "() {"
						+ System.getProperty("line.separator");
				modelFields2 += "\t\treturn " + cfield + ";" + System.getProperty("line.separator");
				modelFields2 += "\t}" + System.getProperty("line.separator");
				modelFields2 += "\tpublic void set" + UFfield + "(" + fieldtype + " " + cfield + ") {"
						+ System.getProperty("line.separator");
				modelFields2 += "\t\tthis." + cfield + " = " + cfield + ";" + System.getProperty("line.separator");
				modelFields2 += "\t}" + System.getProperty("line.separator") + System.getProperty("line.separator");
				if (field.getJoinname() != null && !"".equals(field.getJoinname())) {
					continue;
				}
				if (systemField.containsKey(field.getName())) {
					continue;
				}
				if (lineField.containsKey(field.getName())) {
					continue;
				}
				fieldcount++;
				/* 处理insert 和update */
				String scol = "";
				String scol2 = "";
				// scol = "T1." + field.getColumnname();
				// scol2 = "#{" + cfield + "}";
				if ("".equals(lov) || lov == null) {
					scol = "T1." + field.getColumnname();
					scol2 = "#{" + cfield + "}";
				} else {
					scol = "T1." + field.getColumnname();
					scol2 = "GET_LOV_VAL(#{usercorpid},'" + lov + "',#{" + cfield + "})";
				}
				if (fieldcount == 1) {
					updatemiddle += "\t\t " + FormatStringToLength(field.getColumnname()) + "="
							+ FormatStringToLength(scol2) + "/*" + field.getDisplayname() + "*/"
							+ System.getProperty("line.separator");
				} else {
					updatemiddle += "\t\t," + FormatStringToLength(field.getColumnname()) + "="
							+ FormatStringToLength(scol2) + "/*" + field.getDisplayname() + "*/"
							+ System.getProperty("line.separator");
				}
				insertFeld += "\t\t," + FormatStringToLength(field.getColumnname()) + "/*" + field.getDisplayname()
						+ "*/" + System.getProperty("line.separator");
				insertValue += "\t\t," + FormatStringToLength(scol2) + "/*" + field.getDisplayname() + "*/"
						+ System.getProperty("line.separator");
				selectallsql += "\t\t," + FormatStringToLength(scol) + " as " + FormatStringToLength(field.getName())
						+ "/*" + field.getDisplayname() + "*/" + System.getProperty("line.separator");
				/** 暂时不用生成<if test/> **/
				/*
				 * where2 += "\t\t<if test=\"" + cfield + " != null and " +
				 * cfield + " != '' \">" + System.getProperty("line.separator");
				 * where2 += "\t\t\tand T1." + field.getColumnname() + scol2 +
				 * System.getProperty("line.separator"); where2 += "\t\t</if>" +
				 * System.getProperty("line.separator");
				 */
				lineField.put(field.getName(), "");
			}
			for (LnkInnerLink link : links) {
				String linkname = link.getName();
				if (link.getAttr02() == null || "N".equals(link.getAttr02())) {
					continue;
				}
				LinkString += "\t\t," + link.getTablename() + " " + link.getAttr01()
						+ System.getProperty("line.separator");
				whereString += "\t\tAND (" + link.getLinkcoms() + ")" + System.getProperty("line.separator");
				for (LnkInnerField field : fields) {
					String fieldlinname = field.getJoinname();
					if (field.getActiveflag() == null || "N".equals(field.getActiveflag())) {
						continue;
					}
					if (!linkname.equals(fieldlinname) || fieldlinname == null || fieldlinname == "") {
						continue;
					}
					if (systemField.containsKey(field.getName())) {
						continue;
					}
					if (lineField.containsKey(field.getName())) {
						continue;
					}
					String lov = field.getLovtype();
					String cfield = field.getName();
					String scol = "";
					String scol2 = "";
					// scol = link.getAttr01() + "." + field.getColumnname();
					// scol2 = "#{" + cfield + "}";
					if ("".equals(lov) || lov == null) {
						scol = link.getAttr01() + "." + field.getColumnname();
						scol2 = "#{" + cfield + "}";
					} else {
						scol = link.getAttr01() + "." + field.getColumnname();
						scol2 = "GET_LOV_VAL(#{usercorpid},'" + lov + "',#{" + cfield + "})";
					}
					selectallsql += "\t\t," + FormatStringToLength(scol) + " as "
							+ FormatStringToLength(field.getName()) + "/*" + field.getDisplayname() + "*/"
							+ System.getProperty("line.separator");
					/*
					 * where2 += "\t\t<if test=\"" + cfield + " != null and " +
					 * cfield + " != '' \">" +
					 * System.getProperty("line.separator"); where2 +=
					 * "\t\t\tand T1." + field.getColumnname() + scol2 +
					 * System.getProperty("line.separator"); where2 +=
					 * "\t\t</if>" + System.getProperty("line.separator");
					 */
					lineField.put(field.getName(), "");
				}
			}
			LnkInnerWhere whereExample = new LnkInnerWhere();
			whereExample.setParentid(record.getId());
			List<LnkInnerWhere> wheres = lnkInnerWhereMapper.queryByInner(whereExample);
			for(LnkInnerWhere where : wheres){
				String whereComs = where.getLinkcoms();
				if(!StringUtils.isBlank(whereComs) && "Y".equals(where.getAttr02())){
					if(whereComs.trim().startsWith("<") || whereComs.trim().toUpperCase().startsWith("AND ")){
						whereString += "\t\t" + where.getLinkcoms() + "" + System.getProperty("line.separator");
					}else{
						whereString += "\t\tAND " + where.getLinkcoms() + "" + System.getProperty("line.separator");
					}
				}
				
			}
			insertintosql += insertFeld + "\t\t) values (" + System.getProperty("line.separator") + insertValue
					+ "\t\t)";
			updatesql += updatemiddle + "\t\tWHERE ROW_ID=#{id}";
			fromTableSql = LinkString + whereString + System.getProperty("line.separator");
			replaceMap.put("selectallsql", selectallsql);
			replaceMap.put("fromTableSql", fromTableSql);
			replaceMap.put("whereAllSql", whereAllSql + System.getProperty("line.separator") + where2);
			replaceMap.put("orderbysqll", orderbysqll);
			replaceMap.put("insertintosql", insertintosql);
			replaceMap.put("updatesql", updatesql);
			replaceMap.put("deletefromsql", deletefromsql);
			Iterator it = replaceMap.entrySet().iterator();
			while (it.hasNext()) { //把动态生成内容替换掉模板串模板字符串
				Map.Entry entry = (Map.Entry) it.next();
				Object key = entry.getKey();
				Object value = entry.getValue();
				String Name = key.toString();
				String txt = value.toString();
				sqlMapxml = sqlMapxml.replace("&" + Name + "&", txt);
			}
			
			ModelString = ModelString.replace("&modelFields&", modelFields + System.getProperty("line.separator")
					+ System.getProperty("line.separator") + modelFields2);
			
			String LFmodelName = toLowerCaseFirstOne(modelName);
			String UFmodelName = toUpperCaseFirstOne(modelName);
			result.put("crm." + FolderName + ".dao.mybatis.sqlMap." + UFmodelName + "Mapper_xml", sqlMapxml);
			result.put("crm." + FolderName + ".dao.mybatis.mapper." + UFmodelName + "Mapper_java", sqlMapper);
			result.put("crm." + FolderName + ".model." + UFmodelName + "_java", ModelString);
			result.put("crm." + FolderName + ".service." + UFmodelName + "Service_java", servicejava);
			result.put("crm." + FolderName + ".service." + UFmodelName + "ServiceImpl_java", serviceImpjava);
			result.put("crm." + FolderName + ".controller." + UFmodelName + "Controller_java", Controllerjava);
			result.put("crm." + "portal." + LFmodelName + "List_jsp", Jspfile);
			result.put("crm." + "otherTXT" + (int) (Math.random() * 100) + "_txt", otherTxt);
		}
		return result;
	}
	
	public String Check(LnkInnerObject record) throws Exception {
		return "test";
	}
	
	public void DeepCopy(LnkInnerObject record) throws Exception {
		System.out.println("start deep copy");
		System.out.println(record.getId());
		List<LnkInnerObject> headers = lnkInnerObjectMapper.queryByInner(record);
		for (LnkInnerObject header : headers) {
			System.out.println("found");
			String headerId = keyGenerateService.keyGenerate();
			header.setId(headerId);
			lnkInnerObjectMapper.insert(header);
			System.out.println("inserted");
			LnkInnerLink qps1 = new LnkInnerLink();
			qps1.setParentid(record.getId());
			LnkInnerField qps2 = new LnkInnerField();
			qps2.setParentid(record.getId());
			LnkInnerWhere qps3 = new LnkInnerWhere();
			qps3.setParentid(record.getId());
			List<LnkInnerLink> links = lnkInnerLinkMapper.queryByInner(qps1);
			List<LnkInnerField> fields = lnkInnerFieldMapper.queryByInner(qps2);
			List<LnkInnerWhere> wheres = lnkInnerWhereMapper.queryByInner(qps3);
			for (LnkInnerField field : fields) {
				field.setId(keyGenerateService.keyGenerate());
				field.setParentid(headerId);
				lnkInnerFieldMapper.insert(field);
			}
			for (LnkInnerLink link : links) {
				link.setId(keyGenerateService.keyGenerate());
				link.setParentid(headerId);
				lnkInnerLinkMapper.insert(link);
			}
			for (LnkInnerWhere where : wheres) {
				where.setId(keyGenerateService.keyGenerate());
				where.setParentid(headerId);
				lnkInnerWhereMapper.insert(where);
			}
		}
	}
	
	public void getmodelinfo(LnkInnerObject record) throws Exception {
		AutoLoadProject ap = new AutoLoadProject();
		ap.ReadAllJSPFileAndGetModel();
		List<LnkInnerObject> headers = ap.finalHeader;
		for (LnkInnerObject row : headers) {
			String id = keyGenerateService.keyGenerate();
			row.setId(id);
			lnkInnerObjectMapper.insert(row);
			// if (1 == 1) {
			// continue;
			// }
			// String Key = row.getAttr06() + "," + row.getAttr08();
			// List<LnkInnerField> fields = (List<LnkInnerField>)
			// ap.jspModelInfo.get(Key);
			// for (int i = 0; i < fields.size(); i++) {
			// LnkInnerField record1 = fields.get(i);
			// record1.setId(keyGenerateService.keyGenerate());
			// record1.setParentid(id);
			// lnkInnerFieldMapper.LnkInnerFieldInsert(record1);
			// }
		}
	}
	
	public void updatemodelinfo(LnkInnerObject record) throws Exception {
		List<LnkInnerObject> headers = lnkInnerObjectMapper.queryByInner(record);
		for (LnkInnerObject header : headers) {
			if (header.getAttr05() == null || header.getAttr06() == null || header.getAttr08() == null) {
				continue;
			}
			if ("".equals(header.getAttr05()) || "".equals(header.getAttr06()) || "".equals(header.getAttr08())) {
				continue;
			}
			String modelFile = header.getAttr05();
			String jspFile = header.getAttr06();
			String jspTable = header.getAttr08();
			String xmlfile = header.getAttr07();
			String xmlMapperId = header.getAttr15();
			AutoLoadProject ap = new AutoLoadProject();
			ap.GetJspAllFileInfo(modelFile, jspFile, jspTable, xmlfile, xmlMapperId);
			LnkInnerField qps = new LnkInnerField();
			qps.setParentid(header.getId());
			List<LnkInnerField> fields = lnkInnerFieldMapper.queryByInner(qps);
			List<LnkInnerField> fields2 = ap.finalLF;
			for (LnkInnerField fieldi : fields2) {
				Boolean Found = false;
				String fname2 = fieldi.getName();
				for (LnkInnerField field : fields) {
					String fname = field.getName();
					if (fname != null) {
						if (fname2 != null) {
							if (fname.equals(fname2)) {
								fieldi.setId(field.getId());
								fieldi.setParentid(header.getId());
								lnkInnerFieldMapper.update(fieldi);
								Found = true;
							}
						}
					}
				}
				if (!Found) {
					fieldi.setId(keyGenerateService.keyGenerate());
					fieldi.setParentid(header.getId());
					lnkInnerFieldMapper.insert(fieldi);
					;
				}
			}
			LnkInnerLink qps1 = new LnkInnerLink();
			qps1.setParentid(header.getId());
			// sql_tbmap
			List<LnkInnerLink> links = lnkInnerLinkMapper.queryByInner(qps1);
			for (LnkInnerLink link : links) {
				lnkInnerLinkMapper.deleteById(link);// delete all
			}
			Iterator it = ap.sql_tbmap.entrySet().iterator();
			int cnt = ap.sql_tbmap.size();
			int n = 0;
			while (it.hasNext()) {
				Map.Entry entry = (Map.Entry) it.next();
				Object key = entry.getKey();
				Object value = entry.getValue();
				String TableName = key.toString();
				String TableVaue = value.toString();
				String wherestring = "";
				if (n == cnt - 1) {
					wherestring = ap.GetOneWhere(TableName, true);
				} else {
					wherestring = ap.GetOneWhere(TableName, false);
				}
				n++;
				LnkInnerLink link = new LnkInnerLink();
				link.setId(keyGenerateService.keyGenerate());
				link.setParentid(header.getId());
				link.setName(TableName + "_" + TableVaue);
				link.setTablename(TableVaue);
				link.setLinkcoms(wherestring);
				link.setOuterflag("Y");
				link.setAttr01(TableName);
				lnkInnerLinkMapper.insert(link);
			}
		}
	}
	
	/**
	 * 
	 *<p>获取完整对象信息，包括头，字段对象列表、关联表对象列表</p>
	 * @author yrf
	 * @param example
	 * @return
	 * @throws Exception
	 */
	public LnkInnerObject getFullLnkInnerObjectById(LnkInnerObject example) throws Exception{
		if(example == null || StringUtils.isBlank(example.getId())){
			throw new Exception("对象id不能为空");
		}
		LnkInnerObject obj = lnkInnerObjectMapper.queryById(example);
		if(obj == null){
			throw new Exception("查询对象结果为空["+example.getId());
		}
		/** 获取关联表对象信息 */
		LnkInnerLink linkExample = new LnkInnerLink();
		linkExample.setParentid(example.getId());
		linkExample.setPageFlag(false);
		//linkExample.setAttr02("Y");//有效关联表
		List<LnkInnerLink> links = lnkInnerLinkMapper.queryByInner(linkExample);// query
		obj.setLinkList(links);
		
		/** 获取字段信息 */
		LnkInnerField fieldExample = new LnkInnerField();
		fieldExample.setParentid(example.getId());
		fieldExample.setPageFlag(false);
		//fieldExample.setAttr02("Y");//有效字段
		List<LnkInnerField> fields = lnkInnerFieldMapper.queryByInner(fieldExample);// query
		obj.setFieldList(fields);
		
		obj.setFullObjFlag(true);
		return obj;
	}
	
	/**
	 * 
	 *<p>根据模板生成CRM Jsp List 文件内容</p>
	 * @author yrf
	 * @param header
	 * @return
	 * @throws Exception 
	 */
	public String genJspListContent(LnkInnerObject header) throws Exception{
		if(!header.getFullObjFlag()){//当前对象下的字段、关联表信息是否已经设置
			header = getFullLnkInnerObjectById(header);
		}
		String jspFileContentContentContentContent = "";
		String modelName = toUpperCaseFirstOne(header.getName());
		String namespace = header.getAttr04().toLowerCase();//crm包名
		String FolderName = header.getAttr03().toLowerCase();//文件夹名称
		String jspFields = "";
		String jspFastSearch = "";
		String jspKeyScript = "";
		jspFastSearch += "\t<fieldset class=\"x-fieldset\" id=\"keyFilter\">"
				+ System.getProperty("line.separator");
		jspFastSearch += "\t\t<legend class=\"x-fieldset-header\" style=\"width: 95px; margin-bottom: 0px; border: none;\">"
				+ System.getProperty("line.separator");
		jspFastSearch += "\t\t\t<span class=\"x-fieldset-title\">快速筛选</span></legend>"
				+ System.getProperty("line.separator");
		Boolean haveFastSearch = false;
		jspFields += "\t\t\t\t<th field=\"id\" width=\"100px\" >编号</th>" + System.getProperty("line.separator");
		jspFields += "\t\t\t\t<th field=\"created\" width=\"100px\" >创建时间</th>"
				+ System.getProperty("line.separator");
		
		/* 处理各种文件头 */
		jspFileContentContentContentContent = GetjspString(namespace, modelName, FolderName);
		
		List<LnkInnerField> fields = header.getFieldList();
		for (LnkInnerField field : fields) {
			if (field.getActiveflag() == null || "N".equals(field.getActiveflag())) {
				continue;
			}
			/* 处理model字段 */
			String lov = field.getLovtype();//值列表类型
			String fieldName = field.getName();//字段名称
			String displayName = field.getDisplayname();//显示名称
			if("Y".equals(field.getAttr08()) && !StringUtils.isBlank(field.getAttr09())){
				//多语言
				displayName = field.getAttr09();//多语言表达式
			}
			//String UFfield = toUpperCaseFirstOne(fieldName);
			//String fieldtype = field.getFieldtype();//字段类型--java
			String defaultSearch = "false";//默认搜索
			String uiReq = "Y".equals(field.getUirequired()) ? "true" : "false";//页面必填
			String uiType = field.getUitype();//界面类型
			String uiQuery ="Y".equals(field.getUiqueryflag()) ? "false" : "true";//页面可查询
			StringBuffer strb = new StringBuffer();
			strb.append("\t\t\t\t<th field=\"" + fieldName + "\" noSearch=\""+uiQuery+"\" defaultSearch=\""+defaultSearch+"\" " );
			
			if ("Y".equals(field.getUireadonly())){//界面只读	
				if(!StringUtils.isBlank(lov)){
					//值列表不为空
					strb.append("lov=\"" + lov + "\" width=\"100px\" ");
				}
				
			}else{//界面可编辑
				if(!StringUtils.isBlank(lov)){
					//值列表不为空
					strb.append("lov=\"" + lov + "\" width=\"100px\" editor=\"{type:'combobox',options:{valueField:'val',"
							+ System.getProperty("line.separator")
							+ "\t\t\t\ttextField:'name',data:getLovArray('" + lov + "'),editable:false,required:"
							+ uiReq + "}}\" ");
				}else if ("checkbox".equals(uiType)) {
					strb.append(" width=\"60px\" editor=\"{type:'checkbox',options:{on:'Y',off:'N'}}\" ");
				} else if ("datebox".equals(uiType)) {
					strb.append(" width=\"100px\" editor=\"{type:'datebox',options:{showSeconds:false, "+System.getProperty("line.separator")
					+"required:" + uiReq+"}}\" ");
				} else if ("datetimebox".equals(uiType)) {
					strb.append(" width=\"120px\" editor=\"{type:'datetimebox',options:{showSeconds:false, "+System.getProperty("line.separator")
								+"required:" + uiReq+"}}\" ");
				} else if ("validatebox".equals(uiType)) {
					strb.append("  width=\"100px\" editor=\"{type:'validatebox',options:{required:" + uiReq+"}}\" ");
				} else if ("numberbox".equals(uiType)) {
					strb.append(" width=\"100px\" editor=\"{type:'numberbox',options:{required:" + uiReq+ "}}\" "); 
				} else if ("textarea".equals(uiType)) {
					strb.append(" width=\"100px\" editor=\"{type:'textarea',options:{required:" + uiReq+ "}}\" "); 
				} else {
					strb.append(" width=\"100px\" editor=\"{type:'textbox',options:{required:" + uiReq+ "}}\" "); 
				}
			}
			strb.append(" >"+ displayName + "</th>" + System.getProperty("line.separator"));
			jspFields += strb.toString();
			
			if ("Y".equals(field.getAttr03()) && !StringUtils.isBlank(lov)) {// 快速筛选
				haveFastSearch = true;
				jspFastSearch += "";
				jspFastSearch += "\t\t\t\t<div class=\"row keyfilter-border\">"
						+ System.getProperty("line.separator");
				jspFastSearch += "\t\t\t\t\t<ul id=\"" + field.getName()
						+ "Keyfilter\" data-toggle=\"keyfilter\" data-title=\"" + displayName
						+ "\" data-filter-filed=\"" + field.getName() + "\""
						+ System.getProperty("line.separator");
				jspFastSearch += "data-table-Id=\"" + toLowerCaseFirstOne(header.getName()) + "-table\"></ul></div>"
						+ System.getProperty("line.separator");
				jspKeyScript += "\t\t$('#" + field.getName()
						+ "Keyfilter').keyFilter({remoteData:true,filterByValue:true,remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/"
						+ lov + "'});" + System.getProperty("line.separator");
			}
		}
		if (haveFastSearch) {
			jspFastSearch = jspFastSearch + System.getProperty("line.separator") + "</fieldset>"
					+ System.getProperty("line.separator");
		} else {
			jspKeyScript = "";
			jspFastSearch = "";
		}
		jspFileContentContentContentContent = jspFileContentContentContentContent.replace("&jspFields&", jspFields);
		jspFileContentContentContentContent = jspFileContentContentContentContent.replace("&jspKeyScript&", jspKeyScript);
		jspFileContentContentContentContent = jspFileContentContentContentContent.replace("&jspFastSearch&", jspFastSearch);
		
		return jspFileContentContentContentContent;
	}

	@Override
	public String test(LnkInnerObject record) throws Exception {
		// TODO Auto-generated method stub
		return genJspListContent(record);
	}
	
	public Map<String, String> newAppFile(LnkInnerObject record) throws Exception{

		Map<String, String> result = new HashMap<String, String>();
		String sqlMapxml_m = "";
		String sqlMapper_m = "";
		String ModelString_m = "";
		String servicejava_m = "";
		String serviceImpjava_m = "";
		String Controllerjava_m = "";
		String otherTxt_m = "";
		Map<String, String> systemField = new HashMap<String, String>(); /* * 保存必有的列名* 生成sql时防止重复生成*/
		systemField.put("id", "");
		systemField.put("created", "");
		systemField.put("createdBy", "");
		systemField.put("lastUpdated", "");
		systemField.put("lastUpdatedBy", "");
		systemField.put("corpid", "");
		systemField.put("orgId", "");
		systemField.put("postnId", "");
		List<LnkInnerObject> headers = lnkInnerObjectMapper.queryByInner(record);
		for (LnkInnerObject header : headers) {
			String modelName = toUpperCaseFirstOne(header.getName());
			String namespace = header.getAttr04().toLowerCase();//crm、app包名
			String FolderName = header.getAttr03().toLowerCase();//文件夹名称
			String appPackage = header.getAttr18().toLowerCase();//app包名
			String dataSource = header.getAttr09() == null ? "" : header.getAttr09();//数据源
			String dataSourceUF = toUpperCaseFirstOne(dataSource); //首字母大写的数据源名称
			String dataSourceL = dataSource.toLowerCase();//全小写数据源名称，在路径上为小写
			String DisplayObjectName = header.getAttr01().toLowerCase();//显示名称
			String corpId = header.getAttr10() == null ? "" : header.getAttr10();//公司账套
			
			Map<String, String> lineField = new HashMap<String, String>();/*保存已生成sql的列名，生成sql时防止重复生成*/
			Map<String, String> replaceMap = new HashMap<String, String>();
			String selectallsql = "";
			String fromTableSql = "";
			String whereAllSql = "";
			String orderbysqll = "";
			String htmlField = "";
			String insertintosql = "INSERT INTO " + header.getBasetable() + "(" + System.getProperty("line.separator");
			insertintosql += "\t\t " + FormatStringToLength("ROW_ID") + "/*记录ID*/"
					+ System.getProperty("line.separator");
			String updatesql = "UPDATE " + header.getBasetable() + " SET" + System.getProperty("line.separator");
			String deletefromsql = "";
			String updatemiddle = "";
			String insertField = "";
			String insertValue = System.getProperty("line.separator") + "\t\t " + FormatStringToLength("#{id}")
					+ "/*记录ID*/" + System.getProperty("line.separator");
			String where2 = "";
			
			deletefromsql = "DELETE FROM " + header.getBasetable() + " WHERE ROW_ID=#{id}";
			
			selectallsql = System.getProperty("line.separator");
			selectallsql += "\t\t " + FormatStringToLength("T1.ROW_ID") + " as " + FormatStringToLength("id")
					+ "/*记录编号*/" + System.getProperty("line.separator");
			selectallsql += "\t\t," + FormatStringToLength("T1.CREATED") + " as "
					+ FormatStringToLength("created") + "/*创建时间*/" + System.getProperty("line.separator");
			selectallsql += "\t\t," + FormatStringToLength("T1.CREATED_BY") + " as " + FormatStringToLength("createdBy")
					+ "/*创建者ID*/" + System.getProperty("line.separator");
			selectallsql += "\t\t," + FormatStringToLength("TO_CHAR(T1.LAST_UPD, 'yyyy-mm-dd hh24:mi:ss')") + " as "
					+ FormatStringToLength("lastUpdated") + "/*最后更新时间*/" + System.getProperty("line.separator");
			selectallsql += "\t\t," + FormatStringToLength("T1.LAST_UPD_BY") + " as "
					+ FormatStringToLength("lastUpdatedBy") + "/*最后更新者ID*/" + System.getProperty("line.separator");
			
			//数据源不空则取配置上的公司账套值为corpid默认值
			if(StringUtils.isBlank(dataSource)){
				selectallsql += "\t\t," + FormatStringToLength("T1.CORP_ID") + " as " + FormatStringToLength("corpid")
						+ "/*公司账套*/" + System.getProperty("line.separator");
				selectallsql += "\t\t," + FormatStringToLength("T1.ORG_ID") + " as " + FormatStringToLength("orgId")
						+ "/*组织ID*/" + System.getProperty("line.separator");
				selectallsql += "\t\t," + FormatStringToLength("T1.POSTN_ID") + " as " + FormatStringToLength("postnId")
						+ "/*职位ID*/" + System.getProperty("line.separator");
			}else{
				selectallsql += "\t\t," + FormatStringToLength("'"+corpId+"'") + " as " + FormatStringToLength("corpid")
				+ "/*公司账套*/" + System.getProperty("line.separator");
			}
			
			
			/* 处理各种文件头 */
			otherTxt_m = GetPublicReplaceFile("/mobile/other.txt", appPackage, modelName, FolderName,
					DisplayObjectName);
			sqlMapxml_m = GetPublicReplaceFile("/mobile/templateMapper.xml", appPackage, modelName, FolderName,
					DisplayObjectName);
			
			sqlMapper_m = GetPublicReplaceFile("/mobile/templateMapper.java", appPackage, modelName, FolderName,
					DisplayObjectName);
			ModelString_m = GetPublicReplaceFile("/mobile/template.java", appPackage, modelName, FolderName,
					DisplayObjectName);
			servicejava_m = GetPublicReplaceFile("/mobile/templateService.java", appPackage, modelName, FolderName,
					DisplayObjectName);
			serviceImpjava_m = GetPublicReplaceFile("/mobile/templateServiceImpl.java", appPackage, modelName,
					FolderName, DisplayObjectName);
			Controllerjava_m = GetPublicReplaceFile("/mobile/templateController.java", appPackage, modelName,
					FolderName, DisplayObjectName);
			
			//数据源不为空，则路径加上数据源名称，for App
			if(StringUtils.isBlank(dataSource)){
				sqlMapxml_m = sqlMapxml_m.replace(".&dataSource&.", ".");
				sqlMapper_m = sqlMapper_m.replace(".&dataSource&.", ".");
				serviceImpjava_m = serviceImpjava_m.replace(".&dataSource&.", ".");
			}else{
				sqlMapxml_m = sqlMapxml_m.replace("&dataSource&", dataSourceL);
				sqlMapper_m = sqlMapper_m.replace("&dataSource&", dataSourceL);
				serviceImpjava_m = serviceImpjava_m.replace("&dataSource&", dataSourceL);
			}
			//首字母大写数据源名称拼接到属性名称上
			sqlMapxml_m = sqlMapxml_m.replace("&DataSource&", dataSourceUF);
			sqlMapper_m = sqlMapper_m.replace("&DataSource&", dataSourceUF);
			serviceImpjava_m = serviceImpjava_m.replace("&DataSource&", dataSourceUF);
			
			LnkInnerLink linkExample = new LnkInnerLink();
			linkExample.setParentid(record.getId());
			linkExample.setAttr02("Y");//有效关联表
			linkExample.setPageFlag(false);
			LnkInnerField fieldExample = new LnkInnerField();
			fieldExample.setParentid(record.getId());
			fieldExample.setAttr02("Y");//有效字段
			fieldExample.setPageFlag(false);
			String LinkString = "FROM " + header.getBasetable() + " " + header.getBasetablealais()
					+ System.getProperty("line.separator");
			String whereString = "\tWHERE 1=1" + System.getProperty("line.separator");
			List<LnkInnerField> fields = lnkInnerFieldMapper.queryByInner(fieldExample);// query
			List<LnkInnerLink> links = lnkInnerLinkMapper.queryByInner(linkExample);// query
			header.setFieldList(fields);
			header.setLinkList(links);
			header.setFullObjFlag(true);
			/* 处理基表的字段 */
			String modelFields = "";
			String modelFields2 = "";
			int fieldcount = 0;
			for (LnkInnerField field : fields) {
				if (field.getActiveflag() == null || "N".equals(field.getActiveflag())) {
					continue;
				}
				/* 处理model字段 */
				String lov = field.getLovtype();
				String cfield = field.getName();
				String UFfield = toUpperCaseFirstOne(cfield);
				String fieldtype = field.getFieldtype();
				htmlField += GetAppHtmlInfo(modelName, field) + System.getProperty("line.separator");
				if ("".equals(lov) || lov == null) {
					modelFields += "\tprivate " + fieldtype + " " + FormatStringToLength(cfield + ";") + "\t/*"
							+ field.getDisplayname() + "*/" + System.getProperty("line.separator");
				} else {
					modelFields += "\tprivate " + fieldtype + " " + FormatStringToLength(cfield + ";") + "\t/*"
							+ field.getDisplayname() + ",值列表类型: " + lov + " */" + System.getProperty("line.separator");
				}
				modelFields2 += "\tpublic " + fieldtype + " get" + UFfield + "() {"
						+ System.getProperty("line.separator");
				modelFields2 += "\t\treturn " + cfield + ";" + System.getProperty("line.separator");
				modelFields2 += "\t}" + System.getProperty("line.separator");
				modelFields2 += "\tpublic void set" + UFfield + "(" + fieldtype + " " + cfield + ") {"
						+ System.getProperty("line.separator");
				modelFields2 += "\t\tthis." + cfield + " = " + cfield + ";" + System.getProperty("line.separator");
				modelFields2 += "\t}" + System.getProperty("line.separator") + System.getProperty("line.separator");
				if (field.getJoinname() != null && !"".equals(field.getJoinname())) {
					continue;
				}
				if (systemField.containsKey(field.getName())) {
					continue;
				}
				if (lineField.containsKey(field.getName())) {
					continue;
				}
				fieldcount++;
				/* 处理insert 和update */
				String scol = "";
				String scol2 = "";
				// scol = "T1." + field.getColumnname();
				// scol2 = "#{" + cfield + "}";
				if ("".equals(lov) || lov == null) {
					scol = "T1." + field.getColumnname();
					scol2 = "#{" + cfield + "}";
				} else {
					scol = "T1." + field.getColumnname();
					scol2 = "GET_LOV_VAL(#{usercorpid},'" + lov + "',#{" + cfield + "})";
				}
				if (fieldcount == 1) {
					updatemiddle += "\t\t " + FormatStringToLength(field.getColumnname()) + "="
							+ FormatStringToLength(scol2) + "/*" + field.getDisplayname() + "*/"
							+ System.getProperty("line.separator");
				} else {
					updatemiddle += "\t\t," + FormatStringToLength(field.getColumnname()) + "="
							+ FormatStringToLength(scol2) + "/*" + field.getDisplayname() + "*/"
							+ System.getProperty("line.separator");
				}
				insertField += "\t\t," + FormatStringToLength(field.getColumnname()) + "/*" + field.getDisplayname()
						+ "*/" + System.getProperty("line.separator");
				insertValue += "\t\t," + FormatStringToLength(scol2) + "/*" + field.getDisplayname() + "*/"
						+ System.getProperty("line.separator");
				selectallsql += "\t\t," + FormatStringToLength(scol) + " as " + FormatStringToLength(field.getName())
						+ "/*" + field.getDisplayname() + "*/" + System.getProperty("line.separator");
				/** 暂时不用生成<if test/> **/
				/*
				 * where2 += "\t\t<if test=\"" + cfield + " != null and " +
				 * cfield + " != '' \">" + System.getProperty("line.separator");
				 * where2 += "\t\t\tand T1." + field.getColumnname() + scol2 +
				 * System.getProperty("line.separator"); where2 += "\t\t</if>" +
				 * System.getProperty("line.separator");
				 */
				lineField.put(field.getName(), "");
			}
			for (LnkInnerLink link : links) {
				String linkname = link.getName();
				if (link.getAttr02() == null || "N".equals(link.getAttr02())) { //是否有效
					continue;
				}
				LinkString += "\t\t," + link.getTablename() + " " + link.getAttr01()
						+ System.getProperty("line.separator");
				whereString += "\t\tAND (" + link.getLinkcoms() + ")" + System.getProperty("line.separator");
				for (LnkInnerField field : fields) {
					String fieldlinname = field.getJoinname();
					if (field.getActiveflag() == null || "N".equals(field.getActiveflag())) {
						continue;
					}
					if (!linkname.equals(fieldlinname) || fieldlinname == null || fieldlinname == "") {
						continue;
					}
					if (systemField.containsKey(field.getName())) {
						continue;
					}
					if (lineField.containsKey(field.getName())) {
						continue;
					}
					String lov = field.getLovtype();
					String cfield = field.getName();
					String scol = "";
					String scol2 = "";
					if ("".equals(lov) || lov == null) {
						scol = link.getAttr01() + "." + field.getColumnname();
						scol2 = "#{" + cfield + "}";
					} else {
						scol = link.getAttr01() + "." + field.getColumnname();
						scol2 = "GET_LOV_VAL(#{usercorpid},'" + lov + "',#{" + cfield + "})";
					}
					selectallsql += "\t\t," + FormatStringToLength(scol) + " as "
							+ FormatStringToLength(field.getName()) + "/*" + field.getDisplayname() + "*/"
							+ System.getProperty("line.separator");
					/*
					 * where2 += "\t\t<if test=\"" + cfield + " != null and " +
					 * cfield + " != '' \">" +
					 * System.getProperty("line.separator"); where2 +=
					 * "\t\t\tand T1." + field.getColumnname() + scol2 +
					 * System.getProperty("line.separator"); where2 +=
					 * "\t\t</if>" + System.getProperty("line.separator");
					 */
					lineField.put(field.getName(), "");
				}
			}
			insertintosql += insertField + "\t\t) values (" + System.getProperty("line.separator") + insertValue
					+ "\t\t)";
			updatesql += updatemiddle + "\t\tWHERE ROW_ID=#{id}";
			fromTableSql = LinkString + whereString + System.getProperty("line.separator");
			replaceMap.put("selectallsql", selectallsql);
			replaceMap.put("fromTableSql", fromTableSql);
			replaceMap.put("whereAllSql", whereAllSql + System.getProperty("line.separator") + where2);
			replaceMap.put("orderbysqll", orderbysqll);
			replaceMap.put("insertintosql", insertintosql);
			replaceMap.put("updatesql", updatesql);
			replaceMap.put("deletefromsql", deletefromsql);
			Iterator it = replaceMap.entrySet().iterator();
			while (it.hasNext()) { //把动态生成内容替换掉模板串模板字符串
				Map.Entry entry = (Map.Entry) it.next();
				Object key = entry.getKey();
				Object value = entry.getValue();
				String Name = key.toString();
				String txt = value.toString();
				sqlMapxml_m = sqlMapxml_m.replace("&" + Name + "&", txt);
			}
			
			ModelString_m = ModelString_m.replace("&modelFields&", modelFields + System.getProperty("line.separator")
					+ System.getProperty("line.separator") + modelFields2);
			String LFmodelName = toLowerCaseFirstOne(modelName);
			result.put("app." + FolderName + (int) (Math.random() * 100) + ".other_txt",
					GetPublicReplaceFile("/app/other.txt", namespace, modelName, FolderName, DisplayObjectName));
			result.put("app." + FolderName + "." + LFmodelName + "_css",
					GetPublicReplaceFile("/app/template.css", namespace, modelName, FolderName, DisplayObjectName));
			result.put("app." + FolderName + "." + LFmodelName + "_html",
					GetPublicReplaceFile("/app/template.html", namespace, modelName, FolderName, DisplayObjectName));
			result.put("app." + FolderName + "." + LFmodelName + "Item_html",
					GetPublicReplaceFile("/app/templateItem.html", namespace, modelName, FolderName, DisplayObjectName)
							.replace("&htmlField&", htmlField));
			result.put("app." + FolderName + "." + LFmodelName + "ItemSingle_html",
					GetPublicReplaceFile("/app/templateItemSingle.html", namespace, modelName, FolderName,
							DisplayObjectName).replace("&htmlField&", htmlField));
			result.put("app." + FolderName + "." + LFmodelName + "ItemMain_html",
					GetPublicReplaceFile("/app/templateItemMain.html", namespace, modelName, FolderName,
							DisplayObjectName).replace("&htmlField&", htmlField));
			result.put("app." + FolderName + "." + LFmodelName + "_js",
					GetPublicReplaceFile("/app/template.js", namespace, modelName, FolderName, DisplayObjectName));
			result.put("app." + FolderName + "." + LFmodelName + "Item_js",
					GetPublicReplaceFile("/app/templateItem.js", namespace, modelName, FolderName, DisplayObjectName));
			result.put("mobile." + "otherTXT" + (int) (Math.random() * 100) + "_txt", otherTxt_m);
			if(StringUtils.isBlank(dataSource)){//app端配置，如果指定其他数据源，则多生成一层文件目录
				result.put("mobile." + FolderName + ".dao.mybatis.sqlMap." + modelName + "Mapper_xml", sqlMapxml_m);
				result.put("mobile." + FolderName + ".dao.mybatis.mapper." + modelName + "Mapper_java", sqlMapper_m);
			}else{
				result.put("mobile." + FolderName + ".dao."+dataSourceL+".mybatis.sqlMap." + modelName + "Mapper"+dataSourceUF+"_xml", sqlMapxml_m);
				result.put("mobile." + FolderName + ".dao."+dataSourceL+".mybatis.mapper." + modelName + "Mapper"+dataSourceUF+"_java", sqlMapper_m);
			}
			
			result.put("mobile." + FolderName + ".model." + modelName + "_java", ModelString_m);
			result.put("mobile." + FolderName + ".service." + modelName + "Service_java", servicejava_m);
			result.put("mobile." + FolderName + ".service." + modelName + "ServiceImpl_java", serviceImpjava_m);
			result.put("mobile." + FolderName + ".controller." + modelName + "Controller_java", Controllerjava_m);
		}
		return result;
	
	}
}
