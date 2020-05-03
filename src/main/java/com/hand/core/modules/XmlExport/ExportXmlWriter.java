package com.hand.core.modules.XmlExport;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.XMLWriter;

import com.hand.core.basic.query.QueryParams;
import com.hand.core.modules.export.FileIndexGenarate;
import com.hand.core.util.AppConstants;

public class ExportXmlWriter {
	private static final Logger	logger = LogManager.getLogger(ExportXmlWriter.class);
	private String				filePath;
	private String				urlPath;
	private QueryParams			qps;
	// 导出文件时，每批读取数据数
	public static final Integer	DEFAULT_BATCH_SIZE	= 1000;
	
	/**
	 * 构造函数
	 * 
	 * @param qps
	 */
	public ExportXmlWriter(QueryParams qps) {
		qps.setRows(DEFAULT_BATCH_SIZE);
		qps.setPage(1);
		this.qps = qps;
		initPath();
	}
	
	public void write(Document document) throws IOException {
		
		File exportFile = new File(filePath);
		exportFile.getParentFile().mkdirs();
		exportFile.createNewFile();
		
		OutputFormat format = null;
		XMLWriter xmlWriter = null;
		if(qps.getPage() == 1){
			// 创建输出格式(OutputFormat对象)
	        format = OutputFormat.createPrettyPrint();
	        //创建XMLWriter对象
	        xmlWriter = new XMLWriter(new FileOutputStream(filePath), format);
		}
        //生成XML文件
        xmlWriter.write(document);  
        if (qps.getEndRow() >= qps.getTotal()) {
	        qps.stopExport = true;
	        //关闭XMLWriter对象
	        xmlWriter.close();  
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
				+ datetimeFormatter.format(new Date()) + "_" + FileIndexGenarate.getFileIndex(new Date()) + ".xml";
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
