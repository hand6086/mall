package com.hand.base.common.model;

import com.hand.base.basic.model.BasicModel;
import com.hand.core.util.AppConstants;

public class Attachment extends BasicModel{
	
	private String headId;//父ID
	private String attachmentName;//系统生成的附件名称
	private String attachmentPath;
	private String attachmentSize;//文件大小(字节)
	private String attachmentType;//文件类型
	private String comments;//备注
	private String announcementId;
	private String attachmentOriginal;//附件名称
	private String attachmentRealPath;//附件绝对路径
	private String headCode;//业务对象编码
	private String headName;//业务对象名称
	private String moduleType;//所属业务模块
	private String documentType;//单据类型
	private String source;//来源
	private String addr;//地址
	private String lon;//
	private String lat;//
	private String smallurl;
	private String bigurl;
	private String attachmentFilePath;//对应数据库ATTACHMENT_PATH字段值，因attachmentPath在已在select是被拼接上了ip前缀
	

	public String getAttachmentFilePath() {
		return attachmentFilePath;
	}

	public void setAttachmentFilePath(String attachmentFilePath) {
		this.attachmentFilePath = attachmentFilePath;
	}

	public String getSmallurl() {
		return smallurl;
	}

	public void setSmallurl(String smallurl) {
		this.smallurl = smallurl;
	}

	public String getBigurl() {
		return bigurl;
	}

	public void setBigurl(String bigurl) {
		this.bigurl = bigurl;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getLon() {
		return lon;
	}

	public void setLon(String lon) {
		this.lon = lon;
	}

	public String getLat() {
		return lat;
	}

	public void setLat(String lat) {
		this.lat = lat;
	}

	public String getAttachmentName() {
		return attachmentName;
	}

	public void setAttachmentName(String attachmentName) {
		this.attachmentName = attachmentName;
	}

	public String getAttachmentPath() {
		return attachmentPath;
	}

	public void setAttachmentPath(String attachmentPath) {
		this.attachmentPath = attachmentPath;
	}

	public String getAttachmentSize() {
		return attachmentSize;
	}

	public void setAttachmentSize(String attachmentSize) {
		this.attachmentSize = attachmentSize;
	}

	public String getAttachmentType() {
		return attachmentType;
	}

	public void setAttachmentType(String attachmentType) {
		this.attachmentType = attachmentType;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getAnnouncementId() {
		return announcementId;
	}

	public void setAnnouncementId(String announcementId) {
		this.announcementId = announcementId;
	}

	public String getAttachmentOriginal() {
		return attachmentOriginal;
	}

	public void setAttachmentOriginal(String attachmentOriginal) {
		this.attachmentOriginal = attachmentOriginal;
	}

	public String getAttachmentRealPath() {
		return attachmentRealPath;
	}

	public void setAttachmentRealPath(String attachmentRealPath) {
		this.attachmentRealPath = attachmentRealPath;
	}
	
	public String getHeadId() {
		return headId;
	}

	public void setHeadId(String headId) {
		this.headId = headId;
	}

	public String getAttachmentRelativePath()
	{
		return AppConstants.portalShareFileDir + "/" + this.attachmentPath + "/" + this.attachmentName;
	}

	public String getHeadCode() {
		return headCode;
	}

	public void setHeadCode(String headCode) {
		this.headCode = headCode;
	}

	public String getHeadName() {
		return headName;
	}

	public void setHeadName(String headName) {
		this.headName = headName;
	}

	public String getModuleType() {
		return moduleType;
	}

	public void setModuleType(String moduleType) {
		this.moduleType = moduleType;
	}

	public String getDocumentType() {
		return documentType;
	}

	public void setDocumentType(String documentType) {
		this.documentType = documentType;
	}
	
}
