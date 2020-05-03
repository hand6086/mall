package com.hand.base.params.model;

import com.hand.base.basic.model.BasicModel;

/**
 * O2O参数设置-平台订单推送规则
 */
public class PlatformOrderPushRule extends BasicModel {
	private String name;// 城市
	private String rounds;// 推送轮数
	private String firstRndDist;// 第1轮推送距离(米)
	private String firstRndTime;// 第1轮等待时间(分钟)
	private String secondRndDist;// 第2轮推送距离(米)
	private String secondRndTime;// 第2轮等待时间(分钟)
	private String thirdRndDist;// 第3轮推送距离(米)
	private String thirdRndTime;// 第3轮等待时间(分钟)
	private String tAttr10;// 兜底短信发送间隔
	private String tAttr09; // 兜底短信发送次数上限
	private String locId; //

	public PlatformOrderPushRule() {
		super();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRounds() {
		if (rounds != null && rounds.indexOf(".") > 0) {
			return rounds.substring(0, rounds.indexOf("."));
		}
		return rounds;
	}

	public void setRounds(String rounds) {
		this.rounds = rounds;
	}

	public String getFirstRndDist() {
		if (firstRndDist != null && firstRndDist.indexOf(".") > 0) {
			return firstRndDist.substring(0, firstRndDist.indexOf("."));
		}
		return firstRndDist;
	}

	public void setFirstRndDist(String firstRndDist) {
		this.firstRndDist = firstRndDist;
	}

	public String getFirstRndTime() {
		if (firstRndTime != null && firstRndTime.indexOf(".") > 0) {
			return firstRndTime.substring(0, firstRndTime.indexOf("."));
		}
		return firstRndTime;
	}

	public void setFirstRndTime(String firstRndTime) {
		this.firstRndTime = firstRndTime;
	}

	public String getSecondRndDist() {
		if (secondRndDist != null && secondRndDist.indexOf(".") > 0) {
			return secondRndDist.substring(0, secondRndDist.indexOf("."));
		}
		return secondRndDist;
	}

	public void setSecondRndDist(String secondRndDist) {
		this.secondRndDist = secondRndDist;
	}

	public String getSecondRndTime() {
		if (secondRndTime != null && secondRndTime.indexOf(".") > 0) {
			return secondRndTime.substring(0, secondRndTime.indexOf("."));
		}
		return secondRndTime;
	}

	public void setSecondRndTime(String secondRndTime) {
		this.secondRndTime = secondRndTime;
	}

	public String getThirdRndDist() {
		if (thirdRndDist != null && thirdRndDist.indexOf(".") > 0) {
			return thirdRndDist.substring(0, thirdRndDist.indexOf("."));
		}
		return thirdRndDist;
	}

	public void setThirdRndDist(String thirdRndDist) {
		this.thirdRndDist = thirdRndDist;
	}

	public String getThirdRndTime() {
		if (thirdRndTime != null && thirdRndTime.indexOf(".") > 0) {
			return thirdRndTime.substring(0, thirdRndTime.indexOf("."));
		}
		return thirdRndTime;
	}

	public void setThirdRndTime(String thirdRndTime) {
		this.thirdRndTime = thirdRndTime;
	}

	public String gettAttr10() {
		if (tAttr10 != null && tAttr10.indexOf(".") > 0) {
			return tAttr10.substring(0, tAttr10.indexOf("."));
		}
		return tAttr10;
	}

	public void settAttr10(String tAttr10) {
		this.tAttr10 = tAttr10;
	}

	public String gettAttr09() {
		if (tAttr09 != null && tAttr09.indexOf(".") > 0) {
			return tAttr09.substring(0, tAttr09.indexOf("."));
		}
		return tAttr09;
	}

	public void settAttr09(String tAttr09) {
		this.tAttr09 = tAttr09;
	}

	public String getLocId() {
		return locId;
	}

	public void setLocId(String locId) {
		this.locId = locId;
	}

}
