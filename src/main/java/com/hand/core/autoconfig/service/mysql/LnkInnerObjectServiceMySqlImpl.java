package com.hand.core.autoconfig.service.mysql;

import java.util.HashMap;
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
import com.hand.core.autoconfig.service.LnkInnerObjectService;

@Service
public class LnkInnerObjectServiceMySqlImpl extends BasicServiceImpl<LnkInnerObject>implements LnkInnerObjectService {
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
	
	@Resource(name="lnkInnerObjectService")
	private LnkInnerObjectService	service;
	
	private static final Logger		logger	= LogManager.getLogger(LnkInnerObjectServiceMySqlImpl.class);
	
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

			OutMsg += "\t," + FormatStringToLength("DATE_FORMAT(T1.LAST_UPD, '%Y-%m-%d %H:%k:%S')") + " as "
					+ FormatStringToLength("lastUpdated") + "/*最后更新时间*/" + System.getProperty("line.separator");
			OutMsg += "\t," + FormatStringToLength("T1.LAST_UPD_BY") + " as " + FormatStringToLength("lastUpdatedBy")
					+ "/*最后更新者ID*/" + System.getProperty("line.separator");
			OutMsg += "\t," + FormatStringToLength("T1.ORG_ID") + " as " + FormatStringToLength("orgId") + "/*组织ID*/"
					+ System.getProperty("line.separator");
			OutMsg += "\t," + FormatStringToLength("T1.POSTN_ID") + " as " + FormatStringToLength("postnId")
					+ "/*职位ID*/" + System.getProperty("line.separator");
			LnkInnerLink qps = new LnkInnerLink();
			qps.setParentid(record.getId());
			qps.setAttr02("Y");
			LnkInnerField qps1 = new LnkInnerField();
			qps1.setParentid(record.getId());
			qps1.setAttr02("Y");
			String LinkString = "\tFROM\t " + FormatStringToLength(header.getBasetable()) + " "
					+ header.getBasetablealais() + System.getProperty("line.separator");
			String whereString = "\t\tWHERE 1=1" + System.getProperty("line.separator");
			List<LnkInnerLink> links = lnkInnerLinkMapper.queryByInner(qps);// query
																			// link
			List<LnkInnerField> fields = lnkInnerFieldMapper.queryByInner(qps1);// query
																				// Field
			/* 处理基表的字段 */
			for (LnkInnerField field : fields) {
				if (field.getActiveflag() == null || "N".equals(field.getActiveflag())) {
					continue;
				}
				if (field.getJoinname() != null && !"".equals(field.getJoinname())) {
					continue;
				}
				if(field.getColumnname() == null || "".equals(field.getColumnname())){
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
			OutMsg += LinkString + System.getProperty("line.separator") + whereString
					+ System.getProperty("line.separator");
		}
		return OutMsg;
	}
	
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
			OutMsg += "-- DROP TABLE  IF EXISTS `" + header.getBasetable() + "`;" + System.getProperty("line.separator");
			OutMsg += "CREATE TABLE `" + header.getBasetable() + "` (" + System.getProperty("line.separator");
			OutMsg += "\t " + FormatStringToLength("`ROW_ID`") + " "
					+ FormatStringToLength30("VARCHAR(30) NOT NULL") + "/*记录ID*/"
					+ System.getProperty("line.separator");
			OutMsg += "\t," + FormatStringToLength("`CREATED`") + " "
					+ FormatStringToLength30("DATETIME DEFAULT NOW() NOT NULL") + "/*创建时间*/"
					+ System.getProperty("line.separator");
			OutMsg += "\t," + FormatStringToLength("`CREATED_BY`") + " "
					+ FormatStringToLength30("VARCHAR(30) NOT NULL") + "/*创建者*/"
					+ System.getProperty("line.separator");
			OutMsg += "\t," + FormatStringToLength("`LAST_UPD`") + " "
					+ FormatStringToLength30("DATETIME DEFAULT NOW() NOT NULL") + "/*最后更新时间*/"
					+ System.getProperty("line.separator");
			OutMsg += "\t," + FormatStringToLength("`LAST_UPD_BY`") + " "
					+ FormatStringToLength30("VARCHAR(30) NOT NULL") + "/*最后更新者*/"
					+ System.getProperty("line.separator");
			OutMsg += "\t," + FormatStringToLength("`CORP_ID`") + " " + FormatStringToLength30("VARCHAR(5)")
					+ "/*公司账套ID*/" + System.getProperty("line.separator");
			OutMsg += "\t," + FormatStringToLength("`ORG_ID`") + " " + FormatStringToLength30("VARCHAR(30)") + "/*组织ID*/"
					+ System.getProperty("line.separator");
			OutMsg += "\t," + FormatStringToLength("`POSTN_ID`") + " " + FormatStringToLength30("VARCHAR(30)")
					+ "/*职位ID*/" + System.getProperty("line.separator");
			String IndexString = "ALTER TABLE `" + header.getBasetable() + "` ADD PRIMARY KEY (`ROW_ID`);" + System.getProperty("line.separator");
			int indexcountU = 1;
			int indexcountN = 1;
			String ModifyString = "/* 以下脚本为在现有表中修改字段的脚本，请在MySQL的命令行中执行*/"
					+ System.getProperty("line.separator") + "/*" + System.getProperty("line.separator");
			String AddcolString = "/* 以下脚本为在现有表中增加字段的脚本，请在MySQL的命令行中执行*/"
					+ System.getProperty("line.separator") + "/*" + System.getProperty("line.separator");
			AddcolString += "alter table `" + header.getBasetable() + "` add column " + FormatStringToLength("`CORP_ID`") + " "
					+ FormatStringToLength30("VARCHAR2(5);") + "/*公司账套ID*/" + System.getProperty("line.separator");
			AddcolString += "alter table `" + header.getBasetable() + "` add column " + FormatStringToLength("`ORG_ID`") + " "
					+ FormatStringToLength30("VARCHAR2(30);") + "/*组织ID*/" + System.getProperty("line.separator");
			AddcolString += "alter table `" + header.getBasetable() + "` add column " + FormatStringToLength("`POSTN_ID`") + " "
					+ FormatStringToLength30("VARCHAR2(30);") + "/*职位ID*/" + System.getProperty("line.separator");
			ModifyString += "alter table `" + header.getBasetable() + "` change column " + FormatStringToLength("`CORP_ID`") + " "+FormatStringToLength("`CORP_ID`")+" "
					+ FormatStringToLength30("VARCHAR2(5);") + "/*公司账套ID*/" + System.getProperty("line.separator");
			ModifyString += "alter table `" + header.getBasetable() + "` change column " + FormatStringToLength("`ORG_ID`") + " " + FormatStringToLength("`ORG_ID`") +" "
					+ FormatStringToLength30("VARCHAR2(30);") + "/*组织ID*/" + System.getProperty("line.separator");
			ModifyString += "alter table `" + header.getBasetable() + "` change column " + FormatStringToLength("`POSTN_ID`") + " " + FormatStringToLength("`POSTN_ID`")+" "
					+ FormatStringToLength30("VARCHAR2(30);") + "/*职位ID*/" + System.getProperty("line.separator");
			LnkInnerField qps1 = new LnkInnerField();
			qps1.setParentid(record.getId());
			List<LnkInnerField> fields = lnkInnerFieldMapper.queryByInner(qps1);
			for (LnkInnerField field : fields) {
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
					FieldType = "VARCHAR(" + field.getColumnlength() + ")";
				} else if ("NUMBER".equals(field.getColumntype())) {
					FieldType = "FLOAT(22,7)";
				} else if ("DATE".equals(field.getColumntype())) {
					FieldType = "DATETIME";
				} else if ("CLOB".equals(field.getColumntype())) {
					FieldType = "TEXT";
				} else if ("CHAR".equals(field.getColumntype())) {
					FieldType = "CHAR(" + field.getColumnlength() + ")";
				}
				OutMsg += "\t," + FormatStringToLength("`"+field.getColumnname()+"`") + " " +FieldType
						+" COMMENT '"+ field.getDisplayname()+"' "
						+ "/*" + field.getDisplayname() + "*/" + System.getProperty("line.separator");
				lineField.put(field.getColumnname(), "");
				if ("Normal".equals(field.getIndextype())) {
					/*IndexString += "CREATE INDEX " + header.getBasetable() + "_N" + indexcountN + " ON "
							+ header.getBasetable() + " (" + field.getColumnname() + ");"
							+ System.getProperty("line.separator");*/
					
					IndexString += "ALTER TABLE `" + header.getBasetable() + "` ADD INDEX `"+header.getBasetable() + "_N" + indexcountN 
							+"` (`" + field.getColumnname() + "`);"
							+ System.getProperty("line.separator");
					indexcountN++;
				} else if ("Unique".equals(field.getIndextype())) {
					IndexString += "ALTER TABLE "+header.getBasetable()+ "ADD UNIQUE INDEX `" + header.getBasetable() + "_U" + indexcountU
							+ "` (`" + field.getColumnname() + "`);"
							+ System.getProperty("line.separator");
					indexcountU++;
				}
				AddcolString += "alter table `" + header.getBasetable() + "` add column "
						+ FormatStringToLength("`"+field.getColumnname()+"`") +FormatStringToLength30(FieldType + ";")
						+ "/*" + field.getDisplayname() + "*/" + System.getProperty("line.separator");
				ModifyString += "alter table `" + header.getBasetable() + "` change column "
						+ FormatStringToLength("`"+field.getColumnname()+"`") + FormatStringToLength("`"+field.getColumnname()+"`")+FormatStringToLength30(FieldType + ";")
						+ "/*" + field.getDisplayname() + "*/" + System.getProperty("line.separator");
			}
			OutMsg += ");" + System.getProperty("line.separator") + System.getProperty("line.separator");
			//OutMsg += commentString + System.getProperty("line.separator") + System.getProperty("line.separator");
			OutMsg += IndexString + System.getProperty("line.separator") + System.getProperty("line.separator")
					+ AddcolString + "*/" + System.getProperty("line.separator");
			OutMsg += ModifyString + "*/" + System.getProperty("line.separator");
		}
		return OutMsg;
	}
	/**
	 * 
	 *<p>格式化字符串，null返回"" ; 长度不足20用空格补偿</p>
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
	 *<p>格式化字符串，null返回"" ; 长度不足34用空格补偿</p>
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
		
	public Map<String, String> newObjectFile(LnkInnerObject record) throws Exception {
		return service.newObjectFile(record);
	}
	
	public String Check(LnkInnerObject record) throws Exception {
		return service.Check(record);
	}
	
	public void DeepCopy(LnkInnerObject record) throws Exception {
		service.DeepCopy(record);
	}
	
	public Map<String, String> newAppFile(LnkInnerObject record) throws Exception {
		return service.newAppFile(record);
	}
	
	public void getmodelinfo(LnkInnerObject record) throws Exception {
		service.getmodelinfo(record);
	}
	
	public void updatemodelinfo(LnkInnerObject record) throws Exception {
		service.updatemodelinfo(record);
	}

	@Override
	public LnkInnerObject getFullLnkInnerObjectById(LnkInnerObject record) throws Exception {
		return service.getFullLnkInnerObjectById(record);
	}

	@Override
	public String test(LnkInnerObject record) throws Exception {
		// TODO Auto-generated method stub
		return service.test(record);
	}

}
