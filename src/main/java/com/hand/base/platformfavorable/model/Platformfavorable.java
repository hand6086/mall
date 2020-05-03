package com.hand.base.platformfavorable.model;

import com.hand.base.basic.model.BasicModel;

public class Platformfavorable extends BasicModel {
	/**
	 * 
	 */
	private static final long serialVersionUID = 431045067889214811L;
	private String postcode;
	private String provinceName;
	private String activityName;
	private String activityCode;
	private String merchName;
	private String merchCode;
	private String minOrdAmount;
	private String pmoType;
	private String deducedCash;
	private String couponName;
	private String freeProductName;
	private String startTime;
	private String endTime;
	private String status;
	private String type;
	private String doubleFlag;
	private String noCouponUse;
	private String costProportionD;
	private String costMaxProportionD;
	private String costMinProportionD;
	private String costProportionW;
	private String costMaxProportionW;
	private String costMinProportionW;
	private String costProportionR;
	private String costMaxProportionR;
	private String costMinProportionR;
	private String cityId;
	private String cityName;
	private String notes;
	private String onCouponName;
	private String onCouponCode;
	private String faceValue;
	private String amtPerConsumer;
	private String drawType;
	private String restriction;
	private String couponId;
	private String merchId;
	private String approvalStatus;
	private String approvalFlg;
	private String schemaId;
	private String releaseAmt;

	public String getOnCouponName() {
		return onCouponName;
	}

	public void setOnCouponName(String onCuponName) {
		this.onCouponName = onCuponName;
	}

	public String getOnCouponCode() {
		return onCouponCode;
	}

	public void setOnCouponCode(String onCouponCode) {
		this.onCouponCode = onCouponCode;
	}

	public String getFaceValue() {
		return faceValue;
	}

	public void setFaceValue(String faceValue) {
		this.faceValue = faceValue;
	}

	public String getAmtPerConsumer() {
		return amtPerConsumer;
	}

	public void setAmtPerConsumer(String amtPerConsumer) {
		this.amtPerConsumer = amtPerConsumer;
	}

	public String getDrawType() {
		return drawType;
	}

	public void setDrawType(String drawType) {
		this.drawType = drawType;
	}

	public String getRestriction() {
		return restriction;
	}

	public void setRestriction(String restriction) {
		this.restriction = restriction;
	}

	public String getActivityName() {
		return activityName;
	}

	public void setActivityName(String activityName) {
		this.activityName = activityName;
	}

	public String getActivityCode() {
		return activityCode;
	}

	public void setActivityCode(String activityCode) {
		this.activityCode = activityCode;
	}

	public String getMinOrdAmount() {
		if (minOrdAmount != null) {
			int index = minOrdAmount.indexOf(".");
			if (index > 0 && minOrdAmount.length() >= index + 3) {
				return minOrdAmount.substring(0, index + 3);
			}
		}
		return minOrdAmount;
	}

	public void setMinOrdAmount(String minOrdAmount) {
		this.minOrdAmount = minOrdAmount;
	}

	public String getPmoType() {
		return pmoType;
	}

	public void setPmoType(String pmoType) {
		this.pmoType = pmoType;
	}

	public String getDeducedCash() {
		if (deducedCash != null) {
			int index = deducedCash.indexOf(".");
			if (index > 0 && deducedCash.length() >= index + 3) {
				return deducedCash.substring(0, index + 3);
			}
		}
		return deducedCash;
	}

	public void setDeducedCash(String deducedCash) {
		this.deducedCash = deducedCash;
	}

	public String getCouponName() {
		return couponName;
	}

	public void setCouponName(String couponName) {
		this.couponName = couponName;
	}

	public String getFreeProductName() {
		return freeProductName;
	}

	public void setFreeProductName(String freeProductName) {
		this.freeProductName = freeProductName;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getDoubleFlag() {
		return doubleFlag;
	}

	public void setDoubleFlag(String doubleFlag) {
		this.doubleFlag = doubleFlag;
	}

	public String getNoCouponUse() {
		return noCouponUse;
	}

	public void setNoCouponUse(String noCouponUse) {
		this.noCouponUse = noCouponUse;
	}

	public String getCostProportionD() {
		if (costProportionD != null) {
			int index = costProportionD.indexOf(".");
			if (index > 0 && costProportionD.length() >= index + 3) {
				return costProportionD.substring(0, index + 3);
			}
		}
		return costProportionD;
	}

	public void setCostProportionD(String costProportionD) {
		this.costProportionD = costProportionD;
	}

	public String getCostMaxProportionD() {
		if (costMaxProportionD != null) {
			int index = costMaxProportionD.indexOf(".");
			if (index > 0 && costMaxProportionD.length() >= index + 3) {
				return costMaxProportionD.substring(0, index + 3);
			}
		}
		return costMaxProportionD;
	}

	public void setCostMaxProportionD(String costMaxProportionD) {
		this.costMaxProportionD = costMaxProportionD;
	}

	public String getCostMinProportionD() {
		if (costMinProportionD != null) {
			int index = costMinProportionD.indexOf(".");
			if (index > 0 && costMinProportionD.length() >= index + 3) {
				return costMinProportionD.substring(0, index + 3);
			}
		}
		return costMinProportionD;
	}

	public void setCostMinProportionD(String costMinProportionD) {
		this.costMinProportionD = costMinProportionD;
	}

	public String getCostProportionW() {
		if (costProportionW != null) {
			int index = costProportionW.indexOf(".");
			if (index > 0 && costProportionW.length() >= index + 3) {
				return costProportionW.substring(0, index + 3);
			}
		}
		return costProportionW;
	}

	public void setCostProportionW(String costProportionW) {
		this.costProportionW = costProportionW;
	}

	public String getCostMaxProportionW() {
		if (costMaxProportionW != null) {
			int index = costMaxProportionW.indexOf(".");
			if (index > 0 && costMaxProportionW.length() >= index + 3) {
				return costMaxProportionW.substring(0, index + 3);
			}
		}
		return costMaxProportionW;
	}

	public void setCostMaxProportionW(String costMaxProportionW) {
		this.costMaxProportionW = costMaxProportionW;
	}

	public String getCostMinProportionW() {
		if (costMinProportionW != null) {
			int index = costMinProportionW.indexOf(".");
			if (index > 0 && costMinProportionW.length() >= index + 3) {
				return costMinProportionW.substring(0, index + 3);
			}
		}
		return costMinProportionW;
	}

	public void setCostMinProportionW(String costMinProportionW) {
		this.costMinProportionW = costMinProportionW;
	}

	public String getCostProportionR() {
		if (costProportionR != null) {
			int index = costProportionR.indexOf(".");
			if (index > 0 && costProportionR.length() >= index + 3) {
				return costProportionR.substring(0, index + 3);
			}
		}
		return costProportionR;
	}

	public void setCostProportionR(String costProportionR) {
		this.costProportionR = costProportionR;
	}

	public String getCostMaxProportionR() {
		if (costMaxProportionR != null) {
			int index = costMaxProportionR.indexOf(".");
			if (index > 0 && costMaxProportionR.length() >= index + 3) {
				return costMaxProportionR.substring(0, index + 3);
			}
		}
		return costMaxProportionR;
	}

	public void setCostMaxProportionR(String costMaxProportionR) {
		this.costMaxProportionR = costMaxProportionR;
	}

	public String getCostMinProportionR() {
		if (costMinProportionR != null) {
			int index = costMinProportionR.indexOf(".");
			if (index > 0 && costMinProportionR.length() >= index + 3) {
				return costMinProportionR.substring(0, index + 3);
			}
		}
		return costMinProportionR;
	}

	public void setCostMinProportionR(String costMinProportionR) {
		this.costMinProportionR = costMinProportionR;
	}

	public String getCityId() {
		return cityId;
	}

	public void setCityId(String cityId) {
		this.cityId = cityId;
	}

	public String getCityName() {
		return cityName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	public String getCouponId() {
		return couponId;
	}

	public void setCouponId(String couponId) {
		this.couponId = couponId;
	}

	public String getMerchName() {
		return merchName;
	}

	public void setMerchName(String merchName) {
		this.merchName = merchName;
	}

	public String getProvinceName() {
		return provinceName;
	}

	public void setProvinceName(String provinceName) {
		this.provinceName = provinceName;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getMerchCode() {
		return merchCode;
	}

	public void setMerchCode(String merchCode) {
		this.merchCode = merchCode;
	}

	public String getMerchId() {
		return merchId;
	}

	public void setMerchId(String merchId) {
		this.merchId = merchId;
	}

	public String getApprovalStatus() {
		return approvalStatus;
	}

	public void setApprovalStatus(String approvalStatus) {
		this.approvalStatus = approvalStatus;
	}

	public String getApprovalFlg() {
		return approvalFlg;
	}

	public void setApprovalFlg(String approvalFlg) {
		this.approvalFlg = approvalFlg;
	}

	public String getSchemaId() {
		return schemaId;
	}

	public void setSchemaId(String schemaId) {
		this.schemaId = schemaId;
	}

	public String getReleaseAmt() {
		return releaseAmt;
	}

	public void setReleaseAmt(String releaseAmt) {
		this.releaseAmt = releaseAmt;
	}

}
