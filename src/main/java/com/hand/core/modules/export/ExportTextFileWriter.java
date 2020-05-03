package com.hand.core.modules.export;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.hand.core.util.AppConstants;

public class ExportTextFileWriter {
	private String	filePath;
	private String	urlPath;
	
	/*
	 * public ExportTextFileWriter( FileWriter fileWriter) {
	 * 
	 * this.fileWriter = fileWriter; initPath(); }
	 */
	public String getUrlPath() {
		return urlPath;
	}
	
	public void setUrlPath(String urlPath) {
		this.urlPath = urlPath;
	}
	
	public String getFilePath() {
		return filePath;
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
	}
	
	public void initPath() {
		SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat datetimeFormatter = new SimpleDateFormat("yyyyMMddHHmmsss");
		String temppath = "/export/" + dateFormatter.format(new Date()) + "/";
		String relatePath = temppath + datetimeFormatter.format(new Date()) + "_"
				+ FileIndexGenarate.getFileIndex(new Date()) + "_" + (int) (Math.random() * 100) + ".txt";
		File file = new File(AppConstants.temporaryIOFileDir + temppath);
		if (!file.exists() && !file.isDirectory()) {
			file.mkdirs();
		}
		setFilePath(AppConstants.temporaryIOFileDir + relatePath);
		setUrlPath(AppConstants.temporaryIOUrlDir + relatePath);
	}
	
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	/**
	 * 
	 *<p>FileOutputStream写入到文件，转为UTF-8</p>
	 * @param txt
	 */
	public void writeText2(String txt) {
		initPath();
		OutputStreamWriter osw = null;
		try {
			osw = new OutputStreamWriter(new FileOutputStream(filePath, true), "UTF-8");
			osw.write(txt);
			osw.flush();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			try {
				if(osw != null){
					osw.close();
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		osw = null;
	}
	
	/**
	 * 
	 *<p>FileWriter</p>
	 * @param txt
	 */
	public void writeText(String txt) {
		initPath();
		java.io.FileWriter fw = null;
		// FileWriter fw = null;
		try {
			fw = new java.io.FileWriter(filePath);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			fw.write(txt);
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		try {
			fw.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
