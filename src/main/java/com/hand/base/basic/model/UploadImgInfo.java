package com.hand.base.basic.model;

public class UploadImgInfo {
	private String fileFolder;
	private String fileRelatePath;
	private String fileLessRelatePath;
	private String fileName;
	private String fileLessName;

	
	private String filePath;           //图片物理地址 
	private String fileLessPath;       //压缩图片物理地址 
	private String fileHttpPath;       //图片http地址 
	private String fileLessHtppPath;   //压缩图片http地址 
	private String bigfilePath;  
	private String bigfileHtppPath;
	private String fileSize;//文件大小
	
	private String imageId;    
	
	
	
	
	
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getFileLessPath() {
		return fileLessPath;
	}
	public void setFileLessPath(String fileLessPath) {
		this.fileLessPath = fileLessPath;
	}
	public String getFileHttpPath() {
		return fileHttpPath;
	}
	public void setFileHttpPath(String fileHttpPath) {
		this.fileHttpPath = fileHttpPath;
	}
	public String getFileLessHtppPath() {
		return fileLessHtppPath;
	}
	public void setFileLessHtppPath(String fileLessHtppPath) {
		this.fileLessHtppPath = fileLessHtppPath;
	}
	public String getBigfilePath() {
		return bigfilePath;
	}
	public void setBigfilePath(String bigfilePath) {
		this.bigfilePath = bigfilePath;
	}
	public String getBigfileHtppPath() {
		return bigfileHtppPath;
	}
	public void setBigfileHtppPath(String bigfileHtppPath) {
		this.bigfileHtppPath = bigfileHtppPath;
	}
	public String getFileSize() {
		return fileSize;
	}
	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}
	public String getImageId() {
		return imageId;
	}
	public void setImageId(String imageId) {
		this.imageId = imageId;
	}
	public String getFileFolder() {
		return fileFolder;
	}
	public void setFileFolder(String fileFolder) {
		this.fileFolder = fileFolder;
	}
	public String getFileRelatePath() {
		return fileRelatePath;
	}
	public void setFileRelatePath(String fileRelatePath) {
		this.fileRelatePath = fileRelatePath;
	}
	public String getFileLessRelatePath() {
		return fileLessRelatePath;
	}
	public void setFileLessRelatePath(String fileLessRelatePath) {
		this.fileLessRelatePath = fileLessRelatePath;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileLessName() {
		return fileLessName;
	}
	public void setFileLessName(String fileLessName) {
		this.fileLessName = fileLessName;
	}
	
}
