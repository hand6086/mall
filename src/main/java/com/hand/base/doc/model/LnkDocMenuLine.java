package com.hand.base.doc.model;



import com.hand.base.basic.model.BasicModel;



public class LnkDocMenuLine extends BasicModel{



	/**
	 * 
	 */
	private static final long serialVersionUID = -206992670110384616L;
	private String encryptionMode;     	/*加密方式*/
	private String menuLineName;       	/*主菜单下菜单名*/
	private String menuId;             	/*与主菜单关联字段*/
	private String sampleAfter;        	/*示例（解密后）*/
	private String requestAddress;     	/*请求地址*/
	private String interfaceSpecification;	/*接口说明*/
	private String sampleBefore;       	/*示例（解密前）*/
	private String transmissionDirection;	/*传输方向*/
	private String requestHeader;      	/*请求Header*/
	private String dataType;           	/*数据类型*/
	private String requestMode;        	/*请求方式*/
	private String secretKeyEncryption;	/*加密秘钥*/
	


	public String getEncryptionMode() {
		return encryptionMode;
	}
	public void setEncryptionMode(String encryptionMode) {
		this.encryptionMode = encryptionMode;
	}

	public String getMenuLineName() {
		return menuLineName;
	}
	public void setMenuLineName(String menuLineName) {
		this.menuLineName = menuLineName;
	}

	public String getMenuId() {
		return menuId;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}

	public String getSampleAfter() {
		return sampleAfter;
	}
	public void setSampleAfter(String sampleAfter) {
		this.sampleAfter = sampleAfter;
	}

	public String getRequestAddress() {
		return requestAddress;
	}
	public void setRequestAddress(String requestAddress) {
		this.requestAddress = requestAddress;
	}

	public String getInterfaceSpecification() {
		return interfaceSpecification;
	}
	public void setInterfaceSpecification(String interfaceSpecification) {
		this.interfaceSpecification = interfaceSpecification;
	}

	public String getSampleBefore() {
		return sampleBefore;
	}
	public void setSampleBefore(String sampleBefore) {
		this.sampleBefore = sampleBefore;
	}

	public String getTransmissionDirection() {
		return transmissionDirection;
	}
	public void setTransmissionDirection(String transmissionDirection) {
		this.transmissionDirection = transmissionDirection;
	}

	public String getRequestHeader() {
		return requestHeader;
	}
	public void setRequestHeader(String requestHeader) {
		this.requestHeader = requestHeader;
	}

	public String getDataType() {
		return dataType;
	}
	public void setDataType(String dataType) {
		this.dataType = dataType;
	}

	public String getRequestMode() {
		return requestMode;
	}
	public void setRequestMode(String requestMode) {
		this.requestMode = requestMode;
	}

	public String getSecretKeyEncryption() {
		return secretKeyEncryption;
	}
	public void setSecretKeyEncryption(String secretKeyEncryption) {
		this.secretKeyEncryption = secretKeyEncryption;
	}

	





}

