package com.hand.core.autoconfig.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.hand.core.autoconfig.model.LnkInnerField;
import com.hand.core.autoconfig.model.LnkInnerObject;

public class AutoLoadProject {
	private static final Logger logger = LogManager.getLogger(AutoLoadProject.class);
	
	public static void main(String[] args) throws Exception {
		ReadAllJSPFileAndGetModel();
		// testsql();
	}
	
	private static void testsql() throws DocumentException {
		Init();// 初始化
		String path = "C:/app/workspace/java/link-crm/src/main/java/com/hand/base/common/dao/mybatis/sqlMap/AnnounceMapper.xml";
		String temp = getsqlFromMapperId(path, "queryAllAnnounceListPage");
		// System.out.println(temp);
		// System.out.println("-----------------------start--------------------------");
		ParseSQL(temp);// 分析sql文件
	}
	
	public static Map<String, String>	basemodelinfo;
	public static Map<String, Object>	modelInfo;
	public static Map<String, Object>	jspModelInfo;
	public static Map<String, String>	jspModelKeyword;
	public static String				Folder;
	public static String				jspfile;
	public static List<LnkInnerField>	finalLF;
	public static List<LnkInnerObject>	finalHeader;
	public static Map<String, String>	sql_tbmap;		// sql解析过程中分析表关系
	public static Map<String, String>	sql_field;
	public static Map<String, String>	sql_fieldlov;
	public static Map<String, String>	sql_where;
	
	public String GetOneWhere(String tbalias, Boolean Last) {
		String temp = "";
		if (Last) {
			Iterator it = sql_where.entrySet().iterator();
			while (it.hasNext()) {
				Map.Entry entry = (Map.Entry) it.next();
				Object key = entry.getKey();
				Object value = entry.getValue();
				String TableName = key.toString();
				String TableVaue = value.toString();
				temp += (TableVaue + " AND ");
			}
			temp = temp.replaceAll("\\s+AND\\s+$", "");
			return temp;
		} else {
			Iterator it = sql_where.entrySet().iterator();
			while (it.hasNext()) {
				Map.Entry entry = (Map.Entry) it.next();
				Object key = entry.getKey();
				Object value = entry.getValue();
				String TableName = key.toString();
				String TableVaue = value.toString();
				Pattern p1 = Pattern.compile("[^a-zA-Z]+" + tbalias + ".",
						Pattern.CASE_INSENSITIVE | Pattern.MULTILINE);
				Matcher m1 = p1.matcher(TableVaue);
				if (m1.find()) {
					sql_where.remove(TableName);
					return TableVaue;
				}
			}
			it = sql_where.entrySet().iterator();
			if (it.hasNext()) {
				Map.Entry entry = (Map.Entry) it.next();
				Object key = entry.getKey();
				Object value = entry.getValue();
				String TableName = key.toString();
				String TableVaue = value.toString();
				sql_where.remove(TableName);
				return TableVaue;
			}
		}
		return temp;
	}
	
	private static void AddToSqlField(String a, String b) {
		// //System.out.println("a is:" + a);
		// //System.out.println("b is:" + b);
		a = a.trim();
		b = b.trim();
		if (b.contains("(") || b.contains(")") || b.contains("'")) {
			b = "";
		}
		Pattern p1 = Pattern.compile("[\\s\\S]*[\\s]+([\\S]+)", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE);
		Matcher m1 = p1.matcher(a);
		boolean fund = m1.find();
		if (fund) {
			if (m1.groupCount() > 0) {
				a = m1.group(1);
			}
		}
		sql_field.put(a.toUpperCase(), b.toUpperCase());
	}
	
	public static void ParseSQL(String sql) {
		// System.out.println(sql);
		String regex = "(?i)<if[\\s\\S]*?</if>";
		sql = sql.replaceAll(regex, "");
		sql = sql.replaceAll("/\\*[\\s\\S]*?\\*/", "");
		sql = sql.replaceAll("--[\\s\\S]*?\n", "");
		sql = sql.replaceAll("(?m)^\\s*$" + System.lineSeparator(), "");
		sql = sql.replaceAll("(?i)select", "SELECT");
		sql = sql.replaceAll("(?i)from", "FROM");
		sql = sql.replaceAll("(?i)where", "WHERE");
		sql = sql.replaceAll("(?i)order by", "ORDER BY");
		sql = sql.replaceAll("(?i)to_char\\(", "TO_CHAR(");
		sql = sql.replaceAll("(?i)get_lov_name\\(", "GET_LOV_NAME(");
		// System.out.println(sql);
		String selectString = "";
		String fromString = "";
		String whereString = "";
		String orderString = "";
		Pattern p1 = Pattern.compile("SELECT([\\s\\S]*)FROM([\\s\\S]*?)WHERE([\\s\\S]*)",
				Pattern.CASE_INSENSITIVE | Pattern.MULTILINE);
		Matcher m1 = p1.matcher(sql);
		boolean fund = m1.find();
		if (fund) {
			if (m1.groupCount() > 2) {
				selectString = m1.group(1).trim() + ",";
				fromString = m1.group(2);
				whereString = m1.group(3);
				whereString = whereString.replaceAll("1[\\s]*=[\\s]*1", "");
				Pattern p2 = Pattern.compile("ORDER BY ([\\s\\S]+)", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE);
				Matcher m2 = p2.matcher(whereString);
				while (m2.find()) {
					if (m2.groupCount() > 0) {
						orderString = m2.group(1);
						// System.out.println(orderString);
					}
				}
				whereString = whereString.replaceAll("(?i)ORDER BY[\\s\\S]*", "");
			}
		}
		if (!fund) {
			p1 = Pattern.compile("SELECT([\\s\\S]*)FROM([\\s\\S]*)", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE);
			m1 = p1.matcher(sql);
			if (m1.find() && m1.groupCount() > 1) {
				selectString = m1.group(1).trim() + ",";
				fromString = m1.group(2);
				whereString = "";
				whereString = whereString.replaceAll("1[\\s]*=[\\s]*1", "");
				Pattern p2 = Pattern.compile("ORDER BY ([\\s\\S]+)", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE);
				Matcher m2 = p2.matcher(fromString);
				if (m2.find()) {
					if (m2.groupCount() > 0) {
						orderString = m2.group(1);
						// System.out.println(orderString);
					}
					fromString = fromString.replaceAll("(?i)ORDER BY[\\s\\S]*", "");
				}
			}
		}
		// 先按照正则提取的方式进行提取。
		String col = "";
		String field = "";
		String lov = "";
		String coltb = "";
		String f1 = selectString;
		// //System.out.println("===================================211111");
		// //System.out.println(f1);
		if (f1.toUpperCase().contains("TO_CHAR")) {
			Pattern p2 = Pattern.compile("TO_CHAR[\\s]*\\(([\\s\\S]*?),[\\s\\S]*?\\)([\\s\\S]*?\\s*?[\\S]*?)[,|$]",
					Pattern.CASE_INSENSITIVE | Pattern.MULTILINE);
			Matcher m2 = p2.matcher(f1);
			while (m2.find()) {
				if (m2.groupCount() > 1) {
					String temp1 = m2.group(1);
					String temp2 = m2.group(2);
					String temp3 = temp2.replaceAll("(?i)[\\s]*as[\\s]+", "");
					if (temp1.contains(".")) {
						coltb = temp1.substring(0, temp1.indexOf("."));
						col = temp1.substring(temp1.indexOf("."), temp1.length());
					} else {
						coltb = "T1";
						col = temp1;
					}
					field = temp3;
					if (!"".equals(field) && !"".equals(col)) {
						AddToSqlField(field.trim().toUpperCase(),
								coltb.trim().toUpperCase() + col.trim().toUpperCase());
					}
				}
			}
			f1 = f1.replaceAll("(?i)TO_CHAR[\\s]*\\(([\\s\\S]*?),[\\s\\S]*?\\)([\\s\\S]*?\\s*?[\\S]*?)[,|$]", "");
		}
		// //System.out.println("===================================2111112");
		// //System.out.println(f1);
		if (f1.toUpperCase().contains("GET_LOV_NAME")) {
			Pattern p2 = Pattern.compile(
					"GET_LOV_NAME[\\s]*\\([\\s\\S]*?,([\\s\\S]*?),([\\s\\S]*?)\\)([\\s\\S]*?\\s*?[\\S]*?)[,|$]",
					Pattern.CASE_INSENSITIVE | Pattern.MULTILINE);
			Matcher m2 = p2.matcher(f1);
			while (m2.find()) {
				if (m2.groupCount() > 1) {
					String temp1 = m2.group(1);
					String temp2 = m2.group(2);
					String temp3 = m2.group(3);
					temp3 = temp3.replaceAll("(?i)[\\s]*as[\\s]+", "");
					if (temp2.contains(".")) {
						coltb = temp2.substring(0, temp2.indexOf("."));
						col = temp2.substring(temp2.indexOf("."), temp2.length());
					} else {
						coltb = "T1.";
						col = temp2;
					}
					field = temp3;
					lov = temp1;
					AddToSqlField(field.trim().toUpperCase(), coltb.trim().toUpperCase() + col.trim().toUpperCase());
					if (!"".equals(lov)) {
						sql_fieldlov.put(field.trim().toUpperCase(), lov.trim().replace("'", ""));
					}
				}
			}
		}
		f1 = f1.replaceAll(
				"(?i)GET_LOV_NAME[\\s]*\\([\\s\\S]*?,([\\s\\S]*?),([\\s\\S]*?)\\)([\\s\\S]*?\\s*?[\\S]*?)[,|$]", "");
		Pattern p2 = Pattern.compile("[\\s]*([\\S]*?)[\\s]+([\\s\\S]*?)[,|$]");
		Matcher m2 = p2.matcher(f1);
		while (m2.find()) {
			if (m2.groupCount() > 1) {
				String temp2 = m2.group(1);
				String temp3 = m2.group(2).replaceAll("(?i)[\\s]*as[\\s]+", "");
				if (temp2.contains(".")) {
					coltb = temp2.substring(0, temp2.indexOf("."));
					col = temp2.substring(temp2.indexOf("."), temp2.length());
				} else {
					coltb = "T1";
					col = temp2;
				}
				field = temp3;
				AddToSqlField(field.trim().toUpperCase(), coltb.trim().toUpperCase() + col.trim().toUpperCase());
			}
		}
		p2 = Pattern.compile("[\\s]*([\\S]*?)[\\s]*?[,|$]");
		m2 = p2.matcher(f1);
		while (m2.find()) {
			if (m2.groupCount() > 0) {
				String temp2 = m2.group(1);
				if (temp2.contains(".")) {
					coltb = temp2.substring(0, temp2.indexOf("."));
					col = temp2.substring(temp2.indexOf("."), temp2.length());
				} else {
					coltb = "T1";
					col = temp2;
				}
				field = col;
				if (!sql_field.containsKey(field.trim().toUpperCase())) {
					AddToSqlField(field.trim().toUpperCase(), coltb.trim().toUpperCase() + col.trim().toUpperCase());
				}
			}
		}
		p2 = Pattern.compile("[\\s]*([\\S]+)[\\s]+([\\S]*?)[,|\\s]");
		m2 = p2.matcher(fromString);
		while (m2.find()) {
			if (m2.groupCount() > 1) {
				// System.out.println(m2.group(0));
				String temp2 = m2.group(1);
				String temp3 = m2.group(2);
				if ("".equals(temp3)) {
					temp3 = "T1";
				}
				sql_tbmap.put(temp3.trim().toUpperCase(), temp2.trim().toUpperCase());
			}
		}
		p2 = Pattern.compile("[\\s]*([\\s\\S]*?) and", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE);
		m2 = p2.matcher(whereString + " and");
		while (m2.find()) {
			if (m2.groupCount() > 0) {
				String temp2 = m2.group(1);
				sql_where.put(temp2.trim(), temp2.trim());
			}
		}
		Iterator it = sql_tbmap.entrySet().iterator();
		while (it.hasNext()) {
			Map.Entry entry = (Map.Entry) it.next();
			Object key = entry.getKey();
			Object value = entry.getValue();
			String TableName = key.toString();
			String TableVaue = value.toString();
			// System.out.println(TableName + "---" + TableVaue);
		}
		// System.out.println("end sql_tbmap");
		it = sql_field.entrySet().iterator();
		while (it.hasNext()) {
			Map.Entry entry = (Map.Entry) it.next();
			Object key = entry.getKey();
			Object value = entry.getValue();
			String TableName = key.toString();
			String TableVaue = value.toString();
			// System.out.println(TableName + "---" + TableVaue);
		}
		// System.out.println("end sql_field");
		it = sql_fieldlov.entrySet().iterator();
		while (it.hasNext()) {
			Map.Entry entry = (Map.Entry) it.next();
			Object key = entry.getKey();
			Object value = entry.getValue();
			String TableName = key.toString();
			String TableVaue = value.toString();
			// System.out.println(TableName + "---" + TableVaue);
		}
		// System.out.println("end sql_fieldlov");
		it = sql_where.entrySet().iterator();
		while (it.hasNext()) {
			Map.Entry entry = (Map.Entry) it.next();
			Object key = entry.getKey();
			Object value = entry.getValue();
			String TableName = key.toString();
			String TableVaue = value.toString();
			// System.out.println(TableName + "---" + TableVaue);
		}
		// System.out.println("end sql_where");
		// System.out.println(whereString);
	}
	
	public static void Init() {
		basemodelinfo = new HashMap<String, String>();
		jspModelKeyword = new HashMap<String, String>();
		modelInfo = new HashMap<String, Object>();
		jspModelInfo = new HashMap<String, Object>();
		Folder = "C://app/workspace/java/link-crm/src/main/java/com/hand/";
		jspfile = "C://app/workspace/java/link-crm/src/main/webapp/portal/";
		finalLF = new ArrayList<LnkInnerField>();
		finalHeader = new ArrayList<LnkInnerObject>();
		sql_tbmap = new HashMap<String, String>();
		sql_field = new HashMap<String, String>();
		sql_fieldlov = new HashMap<String, String>();
		sql_where = new HashMap<String, String>();
	}
	
	private static void printHeader() {
		System.out.println("=============About finalHeader===============");
		for (LnkInnerObject row : finalHeader) {
			if (!"".equals(row.getAttr07()) && row.getAttr07() != null) {
				// continue;
			}
			Field[] fields = row.getClass().getDeclaredFields();
			for (Field f : fields) {
				f.setAccessible(true);
			}
			// 输出finalHeader的所有属性
			// //System.out.println("=============About
			// finalHeader===============");
			for (Field f : fields) {
				String field = f.toString().substring(f.toString().lastIndexOf(".") + 1); // 取出属性名称
				try {
					System.out.println("finalHeader." + field + " --> " + f.get(row));
				} catch (IllegalArgumentException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		// opty-prod-table
	}
	
	public static void ReadAllJSPFileAndGetModel() throws DocumentException {
		Init();
		// jspfile =
		// "C://app/workspace/java/link-crm/src/main/webapp/portal/opty/";
		List<String> lstFileNames = getListFiles(jspfile, "jsp", true);
		for (int i = 0; i < lstFileNames.size(); i++) {
			String temp = lstFileNames.get(i);
			// //System.out.println(temp);
			// if (!temp.contains("optyDetail.jsp")) {
			// continue;
			// }
			String Content = readFileByLines(temp);
			if (Content.contains("hdatagrid")) {
				Map<String, String> tableinfo = new HashMap<String, String>();
				Map<String, String> tableinfoKey = new HashMap<String, String>();
				tableinfo = gertable(Content);
				tableinfoKey = gettableKeyword(Content);
				Iterator it = tableinfo.entrySet().iterator();
				while (it.hasNext()) {
					Map.Entry entry = (Map.Entry) it.next();
					Object key = entry.getKey();
					Object value = entry.getValue();
					String TableName = key.toString();
					String TableVaue = value.toString();
					logger.info("we get table:" + temp + "," + TableName);
					List<LnkInnerField> rows = gerFieldInfo(TableVaue);
					jspModelInfo.put(temp + "," + TableName, rows);
					if (tableinfoKey.containsKey(TableName)) {
						jspModelKeyword.put(temp + "," + TableName, tableinfoKey.get(TableName));
						LnkInnerObject headerrows = new LnkInnerObject();
						headerrows.setAttr06(temp);// jsp路径
						headerrows.setAttr08(TableName);// jsp table
						headerrows.setAttr09(tableinfoKey.get(TableName));
						finalHeader.add(headerrows);
					} else {
						LnkInnerObject headerrows = new LnkInnerObject();
						headerrows.setAttr06(temp);// jsp路径
						headerrows.setAttr08(TableName);// jsp table
						headerrows.setAttr09("");// key
													// info
						finalHeader.add(headerrows);
					}
					// tn++;
				}
				logger.info("start out put for tableinfoKey" + temp);
				it = tableinfoKey.entrySet().iterator();
				while (it.hasNext()) {
					Map.Entry entry = (Map.Entry) it.next();
					Object key = entry.getKey();
					Object value = entry.getValue();
					String TableName = key.toString();
					String TableVaue = value.toString();
					logger.info(TableName + "---" + TableVaue);
				}
				logger.info("end out put for tableinfoKey");
			}
		}
		// if (1 == 1) {
		// return;
		// }
		// System.out.println("分析内容。获取更多信息。");
		// 分析内容。获取更多信息。
		// printHeader();
		for (LnkInnerObject row : finalHeader) {
			String Keyword = row.getAttr09();
			if (Keyword == null || !Keyword.contains("/")) {
				// //System.out.println("continue");
				continue;
			}
			// if (!"attachment-table".equals(row.getAttr08())) {
			// continue;
			// }
			// System.out.println(row.getAttr06());
			// String model = GetModelFrompath(modelpath);
			int kn = Keyword.indexOf("/");
			String key1 = Keyword.substring(0, kn);
			String key2 = Keyword.substring(Keyword.indexOf("/"), Keyword.length());
			lstFileNames = getListFiles(Folder, "java", true);
			for (int i = 0; i < lstFileNames.size(); i++) {
				String temp = lstFileNames.get(i);
				// if (!temp.contains("LnkInnerFieldController.java")) {
				// continue;
				// }
				String Content = readFileByLines(temp).replace("<Filter>", "");
				if (Content.contains("@Controller")) {
					// System.out.println("to here");
					if (Content.contains("portal/" + key1 + "\")")) {
						// System.out.println("to here2");
						String outModel = "";
						String servicealias = "";
						String servicemethod = "";
						String service = "";
						String ControllerFilePath = temp;
						if (Content.contains(key2)) {
							// System.out.println("to here3");
							// System.out.println(key2);
							// System.out.println(temp);
							// System.out.println(Content);
							Pattern p1 = Pattern.compile(
									"@RequestMapping\\([\\s\\S]*?\"" + key2
											+ "\"[\\s\\S]*?List<([\\S]*?)>[\\s\\S]*?=[\\s]*?([\\S]*?)\\.([\\S]*?\\(qps\\));[\\s\\S]*?return",
									Pattern.MULTILINE);
							Matcher m1 = p1.matcher(Content);
							boolean find = m1.find();
							if (!find) {
								// System.out.println("to here4---1");
								// System.out.println(key2);
								Pattern p2 = Pattern.compile(
										"@RequestMapping\\([\\s\\S]*?\"" + key2
												+ "/[\\s\\S]*?List<([\\S]*?)>[\\s\\S]*?=[\\s]*?([\\S]*?)\\.([\\S]*?\\(qps\\));[\\s\\S]*?return",
										Pattern.MULTILINE);
								m1 = p2.matcher(Content);
								find = m1.find();
								if (!find) {
									// System.out.println("to here4---2");
									// System.out.println(key2);
									p2 = Pattern.compile(
											"@RequestMapping\\([\\s\\S]*?\"" + key2
													+ "\"[\\s\\S]*?List<([\\S]*?)>[\\s\\S]*?=[\\s]*?([\\S]*?)\\.([\\S]*?\\(record\\));[\\s\\S]*?return",
											Pattern.MULTILINE);
									m1 = p2.matcher(Content);
									find = m1.find();
									if (!find) {
										// System.out.println("to here4---3");
										// System.out.println(key2);
										p2 = Pattern.compile(
												"@RequestMapping\\([\\s\\S]*?\"" + key2
														+ "/[\\s\\S]*?List<([\\S]*?)>[\\s\\S]*?=[\\s]*?([\\S]*?)\\.([\\S]*?\\(record\\));[\\s\\S]*?return",
												Pattern.MULTILINE);
										m1 = p2.matcher(Content);
										find = m1.find();
									}
								}
							}
							if (find) {
								// System.out.println("to here4");
								if (m1.groupCount() > 2) {
									outModel = m1.group(1);
									servicealias = m1.group(2);
									servicemethod = m1.group(3);
									servicemethod = servicemethod.replaceAll("\\([\\s\\S]*?\\)", "");
									// System.out.println("get fuck var");
									// System.out.println(outModel);
									// System.out.println(servicealias);
									// System.out.println(servicemethod);
									if ("getBasicService()".equals(servicealias)) {
										Pattern p3 = Pattern.compile(
												"public[\\s]+BasicService[\\s]*?<([\\s\\S]*?)>[\\s]+getBasicService[\\s\\S]*?return[\\s]+([\\S]*?)[\\s]*;",
												Pattern.MULTILINE);
										Matcher m3 = p3.matcher(Content);
										if (m3.find()) {
											// //System.out.println("to
											// here63");
											if (m3.groupCount() > 0) {
												outModel = m3.group(1).trim();
												servicealias = m3.group(2).trim();
												// servicemethod = key2;
												Pattern p4 = Pattern.compile(
														"private[\\s]*?([\\S]*?)[\\s]*?" + servicealias + "[\\s]*?;",
														Pattern.CASE_INSENSITIVE | Pattern.MULTILINE);
												Matcher m4 = p4.matcher(Content);
												if (m4.find()) {
													// //System.out.println("to
													// here7");
													if (m4.groupCount() > 0) {
														service = m4.group(1);
													}
												}
											}
										}
									} else {
										Pattern p2 = Pattern.compile(
												"private[\\s]*?([\\S]*?)[\\s]*?" + servicealias + "[\\s]*?;",
												Pattern.CASE_INSENSITIVE | Pattern.MULTILINE);
										Matcher m2 = p2.matcher(Content);
										if (m2.find()) {
											if (m2.groupCount() > 0) {
												service = m2.group(1);
											}
										}
									}
								}
							}
						} // end key2
						if ("".equals(outModel) && Content.contains("BasicController")) {
							// //System.out.println("to here5");
							Pattern p1 = Pattern.compile(
									"public[\\s]+BasicService[\\s]*?<([\\s\\S]*?)>[\\s]+getBasicService[\\s\\S]*?return[\\s]+([\\S]*?)[\\s]*;",
									Pattern.MULTILINE);
							Matcher m1 = p1.matcher(Content);
							if (m1.find()) {
								// //System.out.println("to here6");
								if (m1.groupCount() > 0) {
									outModel = m1.group(1).trim();
									servicealias = m1.group(2).trim();
									servicemethod = key2;
									Pattern p2 = Pattern.compile(
											"private[\\s]*?([\\S]*?)[\\s]*?" + servicealias + "[\\s]*?;",
											Pattern.CASE_INSENSITIVE | Pattern.MULTILINE);
									Matcher m2 = p2.matcher(Content);
									if (m2.find()) {
										// //System.out.println("to here7");
										if (m2.groupCount() > 0) {
											service = m2.group(1);
										}
									}
								}
							}
						}
						row.setName(outModel);
						row.setAttr05(getModelPathFrommodelName(outModel));
						row.setBasetablealais("T1");
						row.setNewflag("Y");
						row.setUpdateflag("Y");
						row.setDeleteflag("Y");
						row.setQueryflag("Y");
						row.setOrderbyfield("T1.CREATED DESC");
						row.setAttr04("com.hand.portal");
						row.setActiveflag("Y");
						row.setAttr11(service);
						servicemethod = servicemethod.replace("/", "");
						row.setAttr12(servicemethod);
						Map<String, String> xmlInfo = GetsqlFromServiceAndmethod(service, servicemethod);
						row.setAttr13(xmlInfo.get("serviceimpl"));
						row.setAttr14(xmlInfo.get("MapperName"));
						row.setAttr15(xmlInfo.get("MapperId"));
						row.setAttr07(xmlInfo.get("MappperXMLPath"));
						row.setAttr17(ControllerFilePath);
						TempInsertTable = "";
						String sql = getsqlFromMapperId(row.getAttr07(), row.getAttr15());
						row.setBasetable(TempInsertTable);
						break;
					}
				}
			}
		}
		// printHeader();
	}
	
	private static String TempInsertTable;
	
	private static String getsqlFromMapperId(String path, String mapperid) throws DocumentException {
		if (path == null || "".equals(path)) {
			return "";
		}
		if (mapperid == null || "".equals(mapperid)) {
			return "";
		}
		Map<String, String> sqlinfo = new HashMap<String, String>();
		String sql = "";
		TempInsertTable = "";
		SAXReader reader = new SAXReader();
		File file = new File(path);
		Document document = reader.read(file);
		Element root = document.getRootElement();
		List<Element> childElements = root.elements();
		for (Element child : childElements) {
			String Id = child.attributeValue("id");
			String Value = child.getText() + System.getProperty("line.separator");
			List<Element> elementList = child.elements();
			for (Element ele : elementList) {
				Value += ele.asXML() + System.getProperty("line.separator");
			}
			sqlinfo.put(Id, Value);
			// System.out.println(Id);
			// System.out.println(Value);
			if (Id.contains("Insert") || Id.contains("insert")) {
				// //System.out.println("-------------------------------------------------------------");
				Pattern p1 = Pattern.compile("INSERT[\\s]+INTO[\\s]+([\\S]*?)[\\s]+",
						Pattern.CASE_INSENSITIVE | Pattern.MULTILINE);
				Matcher m1 = p1.matcher(Value);
				if (m1.find()) {
					// //System.out.println("fond" + m1.group(0));
					if (m1.groupCount() > 0) {
						TempInsertTable = m1.group(1);
						TempInsertTable = TempInsertTable.replaceAll("\\([\\s\\S]*", "");
						// System.out.println("table: " + TempInsertTable);
					}
				}
			}
		}
		Iterator it = sqlinfo.entrySet().iterator();
		while (it.hasNext()) {
			Map.Entry entry = (Map.Entry) it.next();
			Object key = entry.getKey();
			Object value = entry.getValue();
			String Name = key.toString();
			String txt = value.toString();
			if (Name.equals(mapperid)) {
				if (txt.contains("include")) {
					Pattern p2 = Pattern.compile("<include refid=\"([\\S]*?)\"/>",
							Pattern.CASE_INSENSITIVE | Pattern.MULTILINE);
					Matcher m2 = p2.matcher(txt);
					while (m2.find()) {
						if (m2.groupCount() > 0) {
							String tmpid = m2.group(1);
							txt = txt.replace("<include refid=\"" + tmpid + "\"/>", sqlinfo.get(tmpid));
						}
					}
					sql = txt;
				}
				sql = txt;
			}
		}
		return sql;
	}
	
	private static Map<String, String> GetsqlFromServiceAndmethod(String service, String servicemethod) {
		Map<String, String> xmlInfo = new HashMap<String, String>();
		String serviceimpl = "";
		String MapperAlias = "";
		String MapperId = "";
		String MapperName = "";
		String MappperXMLPath = "";
		String BasePath = "";
		// System.out.println("find xml");
		List<String> lstFileNames = getListFiles(Folder, "java", true);
		for (int i = 0; i < lstFileNames.size(); i++) {
			String temp = lstFileNames.get(i);
			String temp1 = temp.replace("\\", "/");
			if (temp1.contains("/" + service + "Impl.java")) {
				serviceimpl = temp;
				BasePath = temp1.replace("/service/" + service + "Impl.java", "") + "/";
			}
			if (temp1.contains("/" + service + "Imp.java")) {
				serviceimpl = temp;
				BasePath = temp1.replace("/service/" + service + "Imp.java", "") + "/";
			}
		}
		// System.out.println(serviceimpl);
		// System.out.println(BasePath);
		// System.out.println(serviceimpl);
		if (!"".equals(serviceimpl)) {// foundImplFile
			String Content = readFileByLines(serviceimpl);
			Pattern p1 = Pattern.compile(servicemethod + "[\\s\\S]*?return[\\s]*([\\S]*?)\\.([\\S]*?)\\([\\S\\s]*?\\);",
					Pattern.MULTILINE);
			Matcher m1 = p1.matcher(Content);
			while (m1.find()) {
				if (m1.groupCount() > 1) {
					MapperAlias = m1.group(1);
					MapperId = m1.group(2);
				}
			}
			Pattern p2 = Pattern.compile("private[\\s]*?([\\S]*?)[\\s]*?" + MapperAlias + "[\\s]*?;",
					Pattern.MULTILINE);
			Matcher m2 = p2.matcher(Content);
			while (m2.find()) {
				if (m2.groupCount() > 0) {
					MapperName = m2.group(1);
				}
			}
			if ("".equals(MapperName) && Content.contains("extends BasicServiceImpl")) {
				String Mapperalias = "";
				// System.out.println("to here15");
				p1 = Pattern.compile(
						"public[\\s]+BasicMapper[\\s]*?<([\\s\\S]*?)>[\\s]+getBasicMapper[\\s\\S]*?return[\\s]+([\\S]*?)[\\s]*;",
						Pattern.MULTILINE);
				m1 = p1.matcher(Content);
				if (m1.find()) {
					// //System.out.println("to here6");
					if (m1.groupCount() > 0) {
						// outModel = m1.group(1).trim();
						Mapperalias = m1.group(2).trim();
						// servicemethod = key2;
						p2 = Pattern.compile("private[\\s]*?([\\S]*?)[\\s]*?" + Mapperalias + "[\\s]*?;",
								Pattern.CASE_INSENSITIVE | Pattern.MULTILINE);
						m2 = p2.matcher(Content);
						if (m2.find()) {
							// //System.out.println("to here7");
							if (m2.groupCount() > 0) {
								MapperName = m2.group(1);
								MapperId = servicemethod;
							}
						}
					}
				}
			}
			if ("".equals(MapperName)) {
				p1 = Pattern.compile(
						servicemethod + "[\\s\\S]*?[\\s]*([\\S]*?)\\.([\\S]*?)\\([\\S\\s]*?\\);[\\S\\s]*?return",
						Pattern.MULTILINE);
				m1 = p1.matcher(Content);
				while (m1.find()) {
					if (m1.groupCount() > 1) {
						MapperAlias = m1.group(1).trim();
						MapperId = m1.group(2);
					}
				}
				if (MapperAlias.contains("=")) {
					MapperAlias = MapperAlias.replaceAll("[\\s\\S]*?=", "");
				}
				p2 = Pattern.compile("private[\\s]*?([\\S]*?)[\\s]*?" + MapperAlias + "[\\s]*?;", Pattern.MULTILINE);
				m2 = p2.matcher(Content);
				while (m2.find()) {
					if (m2.groupCount() > 0) {
						MapperName = m2.group(1);
					}
				}
			}
		}
		// System.out.println("mapper info is:");
		// System.out.println(MapperAlias);
		// System.out.println(MapperName);
		// System.out.println(MapperId);
		if (!"".equals(MapperName) && !"".equals(MapperId)) {
			// BasePath
			// lstFileNames = getListFiles(Folder, "xml", true);
			lstFileNames = getListFiles(BasePath, "xml", true);
			for (int i = 0; i < lstFileNames.size(); i++) {
				String temp = lstFileNames.get(i);
				if (temp.contains("MySql")) {
					continue;
				}
				String Content1 = readFileByLines(temp);
				if (Content1.contains(MapperName) && Content1.contains(MapperId)) {
					MappperXMLPath = temp;
				}
			}
		}
		xmlInfo.put("serviceimpl", serviceimpl);
		xmlInfo.put("MapperAlias", MapperAlias);
		xmlInfo.put("MapperId", MapperId);
		xmlInfo.put("MapperName", MapperName);
		xmlInfo.put("MappperXMLPath", MappperXMLPath);
		return xmlInfo;
	}
	
	private static String getModelPathFrommodelName(String ModelName) {
		String out = "";
		List<String> lstFileNames = getListFiles(Folder, "java", true);
		for (int i = 0; i < lstFileNames.size(); i++) {
			String temp = lstFileNames.get(i);
			String temp1 = temp.replace("\\", "/");
			if (temp1.contains("/" + ModelName + ".java")) {
				out = temp;
			}
		}
		return out;
	}
	
	public static void getAllModelInfoToTable() {
		GetAllModel(Folder);
	}
	
	/**
	 * 通过传入的各配置文件路径，解析出最终的内容。
	 */
	public static void GetJspAllFileInfo(String modelFilesp, String jspFilesp, String jspTablesp, String xmlfilesp,
			String xmlMapperId) throws DocumentException {
		Init();// 初始化
		List<String> lstFileNames = getListFiles(Folder, "java", true);
		for (int i = 0; i < lstFileNames.size(); i++) {
			String temp = lstFileNames.get(i);
			if (temp.contains("BasicModel.java")) {
				List<LnkInnerField> tf = getallField(temp);
				for (int k = 0; k < tf.size(); k++) {
					basemodelinfo.put(tf.get(k).getName(), tf.get(k).getFieldtype());// 获得basemodel的信息
				}
			}
		}
		GetOneJspFileInfo(jspFilesp);// 获得jsp文件的字段信息
		GetOneModel(modelFilesp);// 获得model的信息
		String temp = getsqlFromMapperId(xmlfilesp, xmlMapperId);
		ParseSQL(temp);// 分析sql文件
		Iterator it = modelInfo.entrySet().iterator();// 针对model的信息和jsp的信息进行融合。得到最终的信息。
														// 以下对象实际上应该只会返回一条记录
		if (it.hasNext()) {
			Map.Entry entry = (Map.Entry) it.next();
			Object key = entry.getKey();
			Object value = entry.getValue();
			List<LnkInnerField> lf = (List<LnkInnerField>) value;
			Iterator it1 = jspModelInfo.entrySet().iterator();
			boolean fund = false;
			while (it1.hasNext()) {
				Map.Entry entry1 = (Map.Entry) it1.next();
				Object key1 = entry1.getKey();
				Object value1 = entry1.getValue();
				List<LnkInnerField> lf2 = (List<LnkInnerField>) value1;
				if ((jspFilesp + "," + jspTablesp).equals(key1.toString())) {
					MergeFinalField(lf, lf2);
					fund = true;
					System.out.println("mergeFinalField");
				}
			}
		}
		// finalLF
		// 读写xml的配置，获得更多信息和link关系。
	}
	
	private static void MergeFinalField(List<LnkInnerField> lf, List<LnkInnerField> lf2) {
		for (int i = 0; i < lf.size(); i++) {// 针对model的字段。
			LnkInnerField row1 = lf.get(i);
			// LnkInnerField row = new LnkInnerField();
			String fname = row1.getName();
			// System.out.println(fname);
			boolean fund = false;
			for (int j = 0; j < lf2.size(); j++) {
				LnkInnerField row2 = lf2.get(j);
				String lname = row2.getName();
				if (lname == null) {
					continue;
				}
				if (fname.equals(lname)) {
					// System.out.println(row2.getDisplayname());
					row2.setFieldtype(row1.getFieldtype());
					if (sql_field.containsKey(lname.toUpperCase())) {
						String col = sql_field.get(lname.toUpperCase());
						String coltb = "";
						String coln = "";
						if (col.contains(".")) {
							coltb = col.substring(0, col.indexOf(".")).replace(".", "");
							coln = col.substring(col.indexOf("."), col.length()).replace(".", "");
							row2.setColumnname(coln);
							if ("T1".equals(coltb)) {
								row2.setJoinname("");
							} else {
								row2.setJoinname(coltb + "_" + sql_tbmap.get(coltb));
							}
						} else {
							row2.setColumnname(col);
							row2.setJoinname("");
						}
					}
					fund = true;
					finalLF.add(row2);
				}
			}
			if (!fund) {
				finalLF.add(row1);
			}
		}
		Iterator it = basemodelinfo.entrySet().iterator();
		while (it.hasNext()) {
			Map.Entry entry = (Map.Entry) it.next();
			Object key = entry.getKey();
			Object value = entry.getValue();
			String fname = key.toString();
			for (int j = 0; j < lf2.size(); j++) {
				LnkInnerField row2 = lf2.get(j);
				String lname = row2.getName();
				if (lname == null) {
					continue;
				}
				if (fname.equals(lname)) {
					row2.setFieldtype(value.toString());
					if (sql_field.containsKey(lname.toUpperCase())) {
						String col = sql_field.get(lname.toUpperCase());
						String coltb = "";
						String coln = "";
						if (col.contains(".")) {
							coltb = col.substring(0, col.indexOf(".")).replace(".", "");
							coln = col.substring(col.indexOf("."), col.length()).replace(".", "");
							row2.setColumnname(coln);
							if ("T1".equals(coltb)) {
								row2.setJoinname("");
							} else {
								row2.setJoinname(coltb + "_" + sql_tbmap.get(coltb));
							}
						} else {
							row2.setColumnname(col);
							row2.setJoinname("");
						}
					}
					finalLF.add(row2);
				}
			}
		}
	}
	
	private static int Mappingeach(List<LnkInnerField> lf, List<LnkInnerField> lf2) {
		Boolean isMapping = true;
		int n = 0;
		for (int i = 0; i < lf2.size(); i++) {
			Boolean childmap = false;
			String fieldname = lf2.get(i).getName();
			if (basemodelinfo.containsKey(fieldname)) {
				n++;
				childmap = true;
			} else {
				for (int k = 0; k < lf.size(); k++) {
					String fieldname2 = lf.get(k).getName();
					if (fieldname2.equals(fieldname)) {
						n++;
						childmap = true;
					}
				}
			}
			if (!childmap) {
				isMapping = false;
			}
		}
		// ////////System.out.println("mapping count" + n);
		// ////////System.out.println("isMapping is" + isMapping);
		return n;
	}
	
	public static String GetModelFrompath(String path) {
		// //////System.out.println(path);
		String model = "";
		path = path.replace("\\", "/");
		Pattern p1 = Pattern.compile("model/([\\S]*?).java", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE);
		Matcher m1 = p1.matcher(path);
		while (m1.find()) {
			if (m1.groupCount() > 0) {
				model = m1.group(1);
			}
		}
		// //////System.out.println("model is:" + model);
		return model;
	}
	
	private static Boolean CheckMappingFiel(String jspFilename, String Keyword, String modelpath) {
		Boolean isCheckMapping = false;
		return isCheckMapping;
	}
	
	private static void printjspTable() {
		Iterator it = jspModelInfo.entrySet().iterator();
		while (it.hasNext()) {
			Map.Entry entry = (Map.Entry) it.next();
			Object key = entry.getKey();
			Object value = entry.getValue();
			String TableName = key.toString();
			// System.out.println(TableName);
		}
		// System.out.println("--------------end----------------");
	}
	
	private static void printModel() {
		Iterator it = modelInfo.entrySet().iterator();
		while (it.hasNext()) {
			Map.Entry entry = (Map.Entry) it.next();
			Object key = entry.getKey();
			Object value = entry.getValue();
			String TableName = key.toString();
			String model = GetModelFrompath(TableName);
			// System.out.println(TableName + "," + model);
		}
		// System.out.println("--------------end----------------");
	}
	
	private static void MappingAndMergeField() {
		Iterator it1 = jspModelInfo.entrySet().iterator();
		List<LnkInnerField> last = null;
		String lastTableName = "";
		int sn = 0;
		while (it1.hasNext()) {
			Map.Entry entry1 = (Map.Entry) it1.next();
			Object key1 = entry1.getKey();
			Object value1 = entry1.getValue();
			String TableName1 = key1.toString();
			Iterator it = modelInfo.entrySet().iterator();
			while (it.hasNext()) {
				Map.Entry entry = (Map.Entry) it.next();
				Object key = entry.getKey();
				Object value = entry.getValue();
				String TableName = key.toString();
				Boolean isCheckMapping = CheckMappingFiel(TableName1, jspModelKeyword.get(TableName1), TableName);
				if (isCheckMapping) {
					// System.out.println("------------------------------");
					// System.out.println(TableName1);
					// System.out.println(jspModelKeyword.get(TableName1));
					// System.out.println(TableName);
					// System.out.println("--------------end----------------");
					break;
				}
			}
		}
	}
	
	private static void GetOneJspFileInfo(String path) {
		String temp = path;
		String Content = readFileByLines(temp);
		if (Content.contains("hdatagrid")) {
			Map<String, String> tableinfo = new HashMap<String, String>();
			Map<String, String> tableinfoKey = new HashMap<String, String>();
			tableinfo = gertable(Content);
			tableinfoKey = gettableKeyword(Content);
			Iterator it = tableinfo.entrySet().iterator();
			while (it.hasNext()) {
				Map.Entry entry = (Map.Entry) it.next();
				Object key = entry.getKey();
				Object value = entry.getValue();
				String TableName = key.toString();
				String TableVaue = value.toString();
				List<LnkInnerField> rows = gerFieldInfo(TableVaue);
				jspModelInfo.put(temp + "," + TableName, rows);
				if (tableinfoKey.containsKey(TableName)) {
					jspModelKeyword.put(temp + "," + TableName, tableinfoKey.get(TableName));
				}
			}
		}
	}
	
	private static void GetAllJspFileInfo(String path) {
	}
	
	private static List<LnkInnerField> GetALlJSpFiled(String Filename) {
		List<LnkInnerField> rows = new ArrayList<LnkInnerField>();
		return rows;
	}
	
	public static List<String> getListFiles(String path, String suffix, boolean isdepth) {
		List<String> lstFileNames = new ArrayList<String>();
		File file = new File(path);
		return listFile(lstFileNames, file, suffix, isdepth);
	}
	
	private static List<String> listFile(List<String> lstFileNames, File f, String suffix, boolean isdepth) {
		// 若是目录, 采用递归的方法遍历子目录
		if (f.isDirectory()) {
			File[] t = f.listFiles();
			for (int i = 0; i < t.length; i++) {
				if (isdepth || t[i].isFile()) {
					listFile(lstFileNames, t[i], suffix, isdepth);
				}
			}
		} else {
			String filePath = f.getAbsolutePath();
			if (!suffix.equals("")) {
				int begIndex = filePath.lastIndexOf("."); // 最后一个.(即后缀名前面的.)的索引
				String tempsuffix = "";
				if (begIndex != -1) {
					tempsuffix = filePath.substring(begIndex + 1, filePath.length());
					if (tempsuffix.equals(suffix)) {
						lstFileNames.add(filePath);
					}
				}
			} else {
				lstFileNames.add(filePath);
			}
		}
		return lstFileNames;
	}
	
	private static void GetOneModel(String Folder) {
		String temp = Folder;
		String Content = readFileByLines(temp);
		if (Content.contains("extends BasicModel")) {
			modelInfo.put(temp, getallField(temp));
			// //////////System.out.println(temp);
		}
	}
	
	private static void GetAllModel(String Folder) {
		List<String> lstFileNames = getListFiles(Folder, "java", true);
		for (int i = 0; i < lstFileNames.size(); i++) {
			String temp = lstFileNames.get(i);
			if (temp.contains("BasicModel.java")) {
				List<LnkInnerField> tf = getallField(temp);
				for (int k = 0; k < tf.size(); k++) {
					basemodelinfo.put(tf.get(k).getName(), tf.get(k).getFieldtype());
				}
			} else {
				String Content = readFileByLines(temp);
				if (Content.contains("extends BasicModel")) {
					modelInfo.put(temp, getallField(temp));
					// //////////System.out.println(temp);
				}
			}
		}
	}
	
	private static List<LnkInnerField> getallField(String Filename) {
		List<LnkInnerField> rows = new ArrayList<LnkInnerField>();
		String Content = readFileByLines(Filename);
		Pattern p1 = Pattern.compile("private\\s*([\\S]*)\\s*([\\S]*)\\s*;",
				Pattern.CASE_INSENSITIVE | Pattern.MULTILINE);
		Matcher m1 = p1.matcher(Content);
		while (m1.find()) {
			if (m1.groupCount() > 1) {
				LnkInnerField field = new LnkInnerField();
				field.setName(m1.group(2));
				field.setFieldtype(m1.group(1));
				rows.add(field);
			}
		}
		return rows;
	}
	
	private static List<LnkInnerField> gerFieldInfo(String txt) {
		Map<String, String> keyfiltermap = new HashMap<String, String>();
		Pattern p0 = Pattern.compile("data-filter-filed=\"([\\S]*)\"", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE);
		Matcher m0 = p0.matcher(txt);
		while (m0.find()) {
			keyfiltermap.put(m0.group(1), "");
		}
		List<LnkInnerField> rows = new ArrayList<LnkInnerField>();
		Pattern p1 = Pattern.compile("<th[^>]*field=\"([\\S]*)\"[^>]*?>([\\s\\S]*?)</th>",
				Pattern.CASE_INSENSITIVE | Pattern.MULTILINE);
		Matcher m1 = p1.matcher(txt);
		while (m1.find()) {
			String fileth = m1.group(0).toLowerCase();
			String filethold = m1.group(0);
			if (m1.groupCount() > 1) {
				LnkInnerField field = new LnkInnerField();
				String thisFieldName = m1.group(1);
				field.setName(m1.group(1));
				field.setDisplayname(m1.group(2));
				if (fileth.contains("textbox")) {
					field.setUitype("textbox");
				} else if (fileth.contains("combobox")) {
					field.setUitype("combobox");
					Pattern p2 = Pattern.compile("url:'/action/portal/basic/list/([\\S]*?)'",
							Pattern.CASE_INSENSITIVE | Pattern.MULTILINE);
					Matcher m2 = p2.matcher(filethold);
					while (m2.find()) {
						String lovType = m2.group(1);
						field.setLovtype(lovType);
					}
				} else if (fileth.contains("validatebox")) {
					field.setUitype("validatebox");
				} else if (fileth.contains("checkbox")) {
					field.setUitype("checkbox");
				} else if (fileth.contains("'datebox'")) {
					field.setUitype("datebox");
				} else if (fileth.contains("datetimebox")) {
					field.setUitype("datetimebox");
				} else {
					field.setUitype("validatebox");
				}
				if (fileth.contains("required:true")) {
					field.setUirequired("Y");
				} else {
					field.setUirequired("N");
				}
				if (fileth.contains("hiden")) {
					field.setAttr01("Y");
				} else {
					field.setAttr01("N");
				}
				if (fileth.contains("defaultSearch=\"true\"")) {
					field.setQueryflag("Y");
				} else {
					field.setAttr01("N");
				}
				if (keyfiltermap.containsKey(thisFieldName)) {
					field.setAttr03("Y");
				}
				field.setQueryflag("Y");
				field.setOrderflag("Y");
				field.setActiveflag("Y");
				field.setUpdateflag("Y");
				field.setAttr02("Y");
				field.setInsertflag("Y");
				field.setCalcflag("N");
				field.setUireadonly("N");
				rows.add(field);
			}
		}
		if (rows.size() > 0) {
			return rows;
		} else {
			// //////System.out.println("字段太少，不可参照");
			return new ArrayList<LnkInnerField>();
		}
	}
	
	private static Map<String, String> gertable(String txt) {
		Map<String, String> tableinfo = new HashMap<String, String>();
		Pattern p1 = Pattern.compile("<table[^>]*id=\"([\\S]*)\"[^>]*?>([\\s\\S]*?)</table>",
				Pattern.CASE_INSENSITIVE | Pattern.MULTILINE);
		Matcher m1 = p1.matcher(txt);
		while (m1.find()) {
			if (m1.groupCount() > 1) {
				tableinfo.put(m1.group(1), m1.group(2));
			}
		}
		return tableinfo;
	}
	
	private static Map<String, String> gettableKeyword(String txt) {
		txt = txt.replace("${AppContext.ctxPath}", "");
		Map<String, String> tableinfo = new HashMap<String, String>();
		Pattern p1 = Pattern.compile("\\$([\\S]+?)[\\s]*?=[\\s]*?\\$\\('#([\\S]+?)'\\)[\\s]*?;",
				Pattern.CASE_INSENSITIVE | Pattern.MULTILINE);
		// //System.out.println(txt);
		Matcher m1 = p1.matcher(txt);
		while (m1.find()) {
			if (m1.groupCount() > 1) {
				String SName = m1.group(1).trim();
				String SId = m1.group(2).trim();
				Pattern p2 = Pattern.compile(
						SName + "[\\s]*?.hdatagrid\\(\\{[\\s\\S]*?url[\\s]*?:[\\s]?['|\"]/action/portal/([\\S]*?)['|\"]",
						Pattern.CASE_INSENSITIVE | Pattern.MULTILINE);
				Matcher m2 = p2.matcher(txt);
				if (m2.find()) {
					// System.out.println(m2.group(0));
					if (m2.groupCount() > 0) {
						String Tmp = m2.group(1).trim();
						Tmp = Tmp.replaceAll("/$", "");
						tableinfo.put(SId, Tmp);
					}
				}
			}
		}
		if (tableinfo.size() == 0) {
			p1 = Pattern.compile(
					"\\$([\\S]+?)[\\s]*?.hdatagrid[\\s\\S]*?url[\\s]*?:[\\s]?['|\"]/action/portal/([\\S]*?)['|\"]",
					Pattern.MULTILINE);
			m1 = p1.matcher(txt);
			while (m1.find()) {
				if (m1.groupCount() > 1) {
					String SName = m1.group(1).trim();
					SName = SName.replace("#", "");
					SName = SName.replace("'", "");
					SName = SName.replace("(", "");
					SName = SName.replace(")", "");
					String SId = m1.group(2).trim();
					tableinfo.put(SName, SId);
				}
			}
		}
		return tableinfo;
	}
	
	public static String readFileByLines(String fileName) {
		File f = new File(fileName);
		if (!f.exists()) {
			return "";
		}
		String FileContent = "";
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(fileName);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		InputStreamReader isr = null;
		try {
			isr = new InputStreamReader(fis, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		BufferedReader br = new BufferedReader(isr);
		String line = null;
		try {
			while ((line = br.readLine()) != null) {
				FileContent += line;
				FileContent += "\r\n"; // 补上换行符
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Map<String, String> patterns = new HashMap<String, String>();
		patterns.put("([^:])\\/\\/.*", "$1");// 匹配在非冒号后面的注释，此时就不到再遇到http://
		patterns.put("\\s+\\/\\/.*", "");// 匹配“//”前是空白符的注释
		patterns.put("^\\/\\/.*", "");
		patterns.put("^\\/\\*\\*.*\\*\\/$", "");
		patterns.put("\\/\\*.*\\*\\/", "");
		patterns.put("/\\*(\\s*\\*\\s*.*\\s*?)*\\*\\/", "");
		// patterns.put("/\\*(\\s*\\*?\\s*.*\\s*?)*", "");
		Iterator<String> keys = patterns.keySet().iterator();
		String key = null, value = "";
		while (keys.hasNext()) {
			// 经过多次替换
			key = keys.next();
			value = patterns.get(key);
			FileContent = replaceAll(FileContent, key, value);
		}
		FileContent = FileContent.replaceAll("/\\*[\\s\\S]*?\\*/", "");
		// FileContent = FileContent.replaceAll("//[\\s\\S]*?$", "");
		return FileContent;
	}
	
	public static String replaceAll(String fileContent, String patternString, String replace) {
		String str = "";
		Matcher m = null;
		Pattern p = null;
		try {
			p = Pattern.compile(patternString);
			m = p.matcher(fileContent);
			str = m.replaceAll(replace);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			m = null;
			p = null;
		}
		// 获得匹配器对象
		return str;
	}
}
