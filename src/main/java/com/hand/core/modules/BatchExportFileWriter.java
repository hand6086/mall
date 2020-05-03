package com.hand.core.modules;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.hand.core.modules.export.FileIndexGenarate;
import com.hand.core.util.AppConstants;

public class BatchExportFileWriter {
	private String				filePath;
	private String				urlPath;
	private String				urlZipPath;
	private String				ZipFilePath;
	private static final Logger	logger	= LogManager.getLogger(BatchExportFileWriter.class);
	
	public String getUrlPath() {
		return urlPath;
	}
	
	public String getUrlZipPath() {
		return urlZipPath;
	}
	
	public void setUrlZipPath(String urlZipPath) {
		this.urlZipPath = urlZipPath;
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
		String relatePath = "/export/" + dateFormatter.format(new Date()) + "/" + datetimeFormatter.format(new Date())
				+ "_" + FileIndexGenarate.getFileIndex(new Date()) + "_" + (int) (Math.random() * 100) + "/";
		File file = new File(AppConstants.temporaryIOFileDir + relatePath);
		if (!file.exists() && !file.isDirectory()) {
			System.out.println("file: '" + AppConstants.temporaryIOFileDir + relatePath + "' is not exists!");
			file.mkdirs();
		}
		setFilePath(AppConstants.temporaryIOFileDir + "/" + relatePath + "/");
		setUrlPath(AppConstants.temporaryIOUrlDir + "/" + relatePath);
		String tempzipfile = (int) (Math.random() * 100) + ".zip";
		ZipFilePath = AppConstants.temporaryIOFileDir + "/" + relatePath + "_" + tempzipfile;
		setUrlZipPath(AppConstants.temporaryIOUrlDir + "/" + relatePath + "_" + tempzipfile);
	}
	
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	
	private static ZipOutputStream outputStream;
	
	/**
	 * 
	 *<p>根据类型读取模板中相应文本文件并返回文件内容（字符串）</p>
	 * @author yrf
	 * @param Type
	 * @return
	 */
	public String gettemplateContent(String Type) {
		String outstring = "";
		/*if ("controller".equals(Type)) {
			outstring = readFileByLines(AppConstants.key_templatePath + "/crm/templateController.java");
		} else if ("model".equals(Type)) {
			outstring = readFileByLines(AppConstants.key_templatePath + "/crm/template.java");
		} else if ("service".equals(Type)) {
			outstring = readFileByLines(AppConstants.key_templatePath + "/crm/templateService.java");
		} else if ("serviceimpl".equals(Type)) {
			outstring = readFileByLines(AppConstants.key_templatePath + "/crm/templateServiceImpl.java");
		} else if ("mapper".equals(Type)) {
			outstring = readFileByLines(AppConstants.key_templatePath + "/crm/templateMapper.java");
		} else if ("mapperxml".equals(Type)) {
			outstring = readFileByLines(AppConstants.key_templatePath + "/crm/templateMapper.xml");
		} else if ("jsp".equals(Type)) {
			outstring = readFileByLines(AppConstants.key_templatePath + "/crm/templatejsp.jsp");
		} else if ("other".equals(Type)) {
			outstring = readFileByLines(AppConstants.key_templatePath + "/crm/other.txt");
		} else {
			outstring = readFileByLines(AppConstants.key_templatePath + Type);
		}*/
		return outstring;
	}
	
	public String readFileByLines(String fileName) {
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
			// e.printStackTrace();
		}
		try {
			br = null;
			isr = null;
			fis.close();
			fis = null;
		} catch (IOException e) {
		}
		return FileContent;
	}
	
	public String readFileByLines3(String fileName) {
		String outstring = "";
		File file = new File(fileName);
		BufferedReader reader = null;
		try {
			// System.out.println("以行为单位读取文件内容，一次读一整行：");
			reader = new BufferedReader(new FileReader(file));
			String tempString = null;
			int line = 1;
			// 一次读入一行，直到读入null为文件结束
			while ((tempString = reader.readLine()) != null) {
				// 显示行号
				// System.out.println("line " + line + ": " + tempString);
				outstring += tempString + System.getProperty("line.separator");
				line++;
			}
			reader.close();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (reader != null) {
				try {
					reader.close();
				} catch (IOException e1) {
				}
			}
		}
		return outstring;
	}
	
	public void writeBatchText(Map<String, String> filetext) {
		initPath();
		Iterator it = filetext.entrySet().iterator();
		while (it.hasNext()) {
			Map.Entry entry = (Map.Entry) it.next();
			Object key = entry.getKey();
			Object value = entry.getValue();
			String fileName = key.toString();
			String txt = value.toString();
			// create folder
			/*
			 * String TempFileName = fileName; while
			 * (TempFileName.contains(".")) { int n =
			 * TempFileName.lastIndexOf("."); TempFileName =
			 * TempFileName.substring(0, n); String fildName1 =
			 * TempFileName.replace(".", "/"); String relPath = filePath +
			 * fildName1; File file = new File(relPath); if (file.exists()) {
			 * System.out.println("path: '" + file + "' is file,!"); fileName =
			 * fileName.replace(".", "__"); } }
			 */
			if (fileName.contains(".")) {
				int n = fileName.lastIndexOf(".");
				String TempFileName1 = fileName.substring(0, n);
				String relPath = filePath + TempFileName1.replace(".", "/");
				File file = new File(relPath);
				if (!file.exists() && !file.isDirectory()) {
					System.out.println("file: '" + relPath + "' is not exists!");
					try {
						file.mkdirs();
					} catch (Exception e) {
						e.printStackTrace();
					}
					System.out.println("we create dir" + relPath);
				} else {
					if (file.exists()) {
						System.out.println("--------we found : '" + relPath + "' is file!");
					} else {
						System.out.println("--------we found : '" + relPath + "' is dir!");
					}
				}
			}
			String relPath = filePath + fileName.replace(".", "/").replace("_xml", ".xml").replace("_txt", ".txt")
					.replace("_java", ".java").replace("_jsp", ".jsp").replace("_html", ".html").replace("_js", ".js")
					.replace("_css", ".css");
			;
			File file = new File(relPath);
			while (file.isDirectory()) {
				relPath = relPath + "_1";
				file = new File(relPath);
				System.out.println("file: '" + relPath + "' is a Directory!");
			}
			FileOutputStream fos = null;
			try {
				fos = new FileOutputStream(relPath);
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			OutputStreamWriter osw = null;
			try {
				osw = new OutputStreamWriter(fos, "UTF-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				osw.write(txt);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				osw.flush();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				osw = null;
				fos.close();
				fos = null;
			} catch (IOException e) {
			}
		}
		/*
		 * File zipFile = new File(ZipFilePath); if (!zipFile.exists()) { try {
		 * zipFile.createNewFile(); } catch (IOException e) {
		 * logger.error("创建文件" + ZipFilePath + "失败"); e.printStackTrace(); } }
		 * FileOutputStream fous; try { fous = new FileOutputStream(zipFile);
		 * outputStream = new ZipOutputStream(fous); outputStream.close(); }
		 * catch (FileNotFoundException e) { // logger.error(zipFileName + //
		 * "不存在!"); e.printStackTrace(); }catch (IOException e) {
		 * e.printStackTrace(); }
		 */
		// writeToZipFile(filePath);
		writeMultiFileToZip(filePath, ZipFilePath, false);
	}
	
	public static void writeToZipFile(String folderPath) {
		writeToZipFile(new File(folderPath));
	}
	
	public static void writeToZipFile(File[] files) {
		int length = files.length;
		for (int i = 0; i < length; i++) {
			writeToZipFile(files[i]);
		}
	}
	
	public static void writeToZipFile(File file) {
		if (file.exists()) {
			if (file.isFile()) {
				FileInputStream fis = null;
				BufferedInputStream bis = null;
				try {
					fis = new FileInputStream(file);
					bis = new BufferedInputStream(fis);
					logger.debug("压缩文件:" + file.getName());
					ZipEntry entry = new ZipEntry(file.getName());
					outputStream.putNextEntry(entry);
					// 向压缩文件中输出数据
					int length;
					byte[] buffer = new byte[4096];
					while ((length = bis.read(buffer)) != -1) {
						logger.debug("向压缩文件中写入数据大小：{}", length);
						outputStream.write(buffer, 0, length);
					}
				} catch (IOException e) {
					logger.error("把Excel文件写入压缩文件中出现异常：", e);
					e.printStackTrace();
				} finally {
					// 关闭创建的流对象
					try {
						bis.close();
						fis.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			} else {
				writeToZipFile(file.listFiles());
			}
		} else {
			logger.error(file.getName() + "文件不存在");
		}
	}
	
	/**
	 * 
	 *<p>FileWriter</p>
	 * @param txt
	 */
	public void writeText1(String txt) {
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
	
	/**
	 * 
	 *<p>FileOutputStream, UTF-8</p>
	 * @author yrf
	 * @param txt
	 */
	public void writeText(String txt) {
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
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			if(osw!=null){
				try {
					osw.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		osw = null;
	}
	
	/**
	 * 
	 * <p>
	 * 打包压缩整个目录的文件，并保存目录结构
	 * </p>
	 * 
	 * @author yrf
	 * @param filepath
	 *            需要打包的目录
	 * @param zippath
	 *            生成的压缩包路径
	 * @param dirFlag
	 *            是否包含一级目录，true为包含
	 */
	public static void writeMultiFileToZip(String filepath, String zippath, boolean dirFlag) {
		ZipOutputStream zipOut = null;
		try {
			File file = new File(filepath);// 要被压缩的文件夹
			File zipFile = new File(zippath);
			zipOut = new ZipOutputStream(new FileOutputStream(zipFile));
			if (file.isDirectory()) {
				File[] files = file.listFiles();
				for (File fileSec : files) {
					if (dirFlag) {
						traversalFileToZip(zipOut, fileSec, file.getName() + File.separator);
					} else {
						traversalFileToZip(zipOut, fileSec, "");
					}
				}
			} else if (file.isFile()) {
				traversalFileToZip(zipOut, file, "");
			}
			zipOut.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (zipOut != null) {
					zipOut.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * 
	 * <p>
	 * 递归遍历整个目录文件，把文件加入压缩包
	 * </p>
	 * 
	 * @author yrf
	 * @param zipOut
	 *            压缩文件输出流
	 * @param file
	 *            需要遍历的目录或者需要压缩的文件
	 * @param baseDir
	 *            文件在压缩包中的路径
	 * @throws Exception
	 */
	private static void traversalFileToZip(ZipOutputStream zipOut, File file, String baseDir) throws Exception {
		if (file.isDirectory()) {
			File[] files = file.listFiles();
			for (File fileSec : files) {
				traversalFileToZip(zipOut, fileSec, baseDir + file.getName() + File.separator);
			}
		} else {
			byte[] buf = new byte[1024];
			InputStream input = new FileInputStream(file);
			zipOut.putNextEntry(new ZipEntry(baseDir + file.getName()));
			int len;
			while ((len = input.read(buf)) != -1) {
				zipOut.write(buf, 0, len);
			}
			input.close();
		}
	}
}
