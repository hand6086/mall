package com.hand.core.modules.export;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.hand.core.basic.query.ExportColumn;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.modules.export.exception.WriteExportFileException;
import com.hand.core.util.AppConstants;

public class ExportWriter {
	private static final Logger	logger				= LogManager.getLogger(ExportWriter.class);
	private String				filePath;
	private String				urlPath;
	private QueryParams			qps;
	private FileWriter			fileWriter;
	// 导出文件时，每批读取数据数
	public static final Integer	DEFAULT_BATCH_SIZE	= 1000;
	
	/**
	 * 构造函数
	 * 
	 * @param qps
	 */
	public ExportWriter(QueryParams qps, FileWriter fileWriter) {
		//qps.setRows(DEFAULT_BATCH_SIZE);
		qps.setPage(1);
		qps.setTotalFlag(true);
		qps.setPageFlag(true);
		this.qps = qps;
		this.fileWriter = fileWriter;
		initPath();
	}
	
	public void wirteData(List<?> list) throws IllegalAccessException, InvocationTargetException, NoSuchMethodException,
			WriteExportFileException, IOException {
		if (qps.getPage() == 1) {
			// 创建导出文件
			File exportFile = new File(filePath);
			exportFile.getParentFile().mkdirs();
			exportFile.createNewFile();
			fileWriter.startWrite(exportFile);
			fileWriter.writeHeader(qps.getExportColumns());
		}
		fileWriter.wirteContent(list);
		if (qps.getEndRow() >= qps.getTotal()) { 
			qps.stopExport = true;
			fileWriter.stopWrite();
		}
		qps.setPage(qps.getPage() + 1);
		qps.setTotalFlag(false);
	}
	
	public void wirteData1(List<?> list) throws IllegalAccessException, InvocationTargetException, NoSuchMethodException,
		WriteExportFileException, IOException {
	if (qps.getPage() == 1) {
		// 创建导出文件
		File exportFile = new File(filePath);
		exportFile.getParentFile().mkdirs();
		exportFile.createNewFile();
		fileWriter.startWrite(exportFile);
		
		List<ExportColumn> columns = new ArrayList<ExportColumn>();
		ExportColumn orderNum = new ExportColumn();
		orderNum.setTitle("订单编号");
		orderNum.setField("orderNum");
		orderNum.setOrder(1);
		ExportColumn customerName = new ExportColumn();
		customerName.setTitle("消费者名称");
		customerName.setField("customerName");
		customerName.setOrder(2);
		ExportColumn contact = new ExportColumn();
		contact.setTitle("收货人");
		contact.setField("contact");
		contact.setOrder(3);
		ExportColumn attrib01 = new ExportColumn();
		attrib01.setTitle("收货地址");
		attrib01.setField("attrib01");
		attrib01.setOrder(4);
		ExportColumn contactPhone = new ExportColumn();
		contactPhone.setTitle("联系电话");
		contactPhone.setField("contactPhone");
		contactPhone.setOrder(5);
		ExportColumn created = new ExportColumn();
		created.setTitle("下单时间");
		created.setField("created");
		created.setOrder(6);
		ExportColumn attrib47 = new ExportColumn();
		attrib47.setTitle("买家留言");
		attrib47.setField("attrib47");
		attrib47.setOrder(7);
		ExportColumn logisticsCompany = new ExportColumn();
		logisticsCompany.setTitle("物流公司");
		logisticsCompany.setField("logisticsCompany");
		logisticsCompany.setOrder(8);
		ExportColumn logisticsOddNumber = new ExportColumn();
		logisticsOddNumber.setTitle("物流单号");
		logisticsOddNumber.setField("logisticsOddNumber");
		logisticsOddNumber.setOrder(9);
		ExportColumn shippingTime = new ExportColumn();
		shippingTime.setTitle("发运时间");
		shippingTime.setField("shippingTime");
		shippingTime.setOrder(10);
		columns.add(orderNum);
		columns.add(customerName);
		columns.add(contact);
		columns.add(attrib01);
		columns.add(contactPhone);
		columns.add(created);
		columns.add(attrib47);
		columns.add(logisticsCompany);
		columns.add(logisticsOddNumber);
		columns.add(shippingTime);
		
		fileWriter.writeHeader(columns);
	}
	fileWriter.wirteContent(list);
	if (qps.getEndRow() >= qps.getTotal()) { 
		qps.stopExport = true;
		fileWriter.stopWrite();
	}
	qps.setPage(qps.getPage() + 1);
	qps.setTotalFlag(false);
	}
	
	public String getFilePath() {
		return filePath;
	}
	
	public void initPath() {
		SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat datetimeFormatter = new SimpleDateFormat("yyyyMMddHHmmsss");
		String relatePath = "/export/" + dateFormatter.format(new Date()) + "/" + qps.getFileName()
				+ datetimeFormatter.format(new Date()) + "_" + FileIndexGenarate.getFileIndex(new Date()) + ".csv";
		setFilePath(AppConstants.temporaryIOFileDir + relatePath);
		setUrlPath(AppConstants.temporaryIOUrlDir + relatePath);
		logger.debug("导出文件路径为：" + relatePath);
	}
	
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	
	public QueryParams getQps() {
		return qps;
	}
	
	public void setQps(QueryParams qps) {
		this.qps = qps;
	}
	
	public String getUrlPath() {
		return urlPath;
	}
	
	public void setUrlPath(String urlPath) {
		this.urlPath = urlPath;
	}
}
