package com.hand.base.common.model;

public class UserVisitCountReport {
	private String location; // 城市
	private String COUNT_DT_HH;///*当天 PV*/
	private String COUNT_DT_HH_uv;///*当天 UV*/
	private String COUNT_DZ_D;/*当周 PV*/
	private String COUNT_DZ_D_uv; /*当周 UV*/
	private String COUNT_DY_MM; /*当月注册人数*/
	private String COUNT_DY_MM_uv;/*当月注册uv*/
	private String COUNT_ZDY;/*自定义日期注册人数*/
	private String COUNT_ZDY_uv;/*自定义uv*/

	public String getCOUNT_DT_HH() {
		return COUNT_DT_HH;
	}
	public void setCOUNT_DT_HH(String cOUNT_DT_HH) {
		COUNT_DT_HH = cOUNT_DT_HH;
	}
	public String getCOUNT_DT_HH_uv() {
		return COUNT_DT_HH_uv;
	}
	public void setCOUNT_DT_HH_uv(String cOUNT_DT_HH_uv) {
		COUNT_DT_HH_uv = cOUNT_DT_HH_uv;
	}
	public String getCOUNT_DZ_D() {
		return COUNT_DZ_D;
	}
	public void setCOUNT_DZ_D(String cOUNT_DZ_D) {
		COUNT_DZ_D = cOUNT_DZ_D;
	}
	public String getCOUNT_DZ_D_uv() {
		return COUNT_DZ_D_uv;
	}
	public void setCOUNT_DZ_D_uv(String cOUNT_DZ_D_uv) {
		COUNT_DZ_D_uv = cOUNT_DZ_D_uv;
	}
	public String getCOUNT_DY_MM() {
		return COUNT_DY_MM;
	}
	public void setCOUNT_DY_MM(String cOUNT_DY_MM) {
		COUNT_DY_MM = cOUNT_DY_MM;
	}
	public String getCOUNT_DY_MM_uv() {
		return COUNT_DY_MM_uv;
	}
	public void setCOUNT_DY_MM_uv(String cOUNT_DY_MM_uv) {
		COUNT_DY_MM_uv = cOUNT_DY_MM_uv;
	}
	public String getCOUNT_ZDY() {
		return COUNT_ZDY;
	}
	public void setCOUNT_ZDY(String cOUNT_ZDY) {
		COUNT_ZDY = cOUNT_ZDY;
	}
	public String getCOUNT_ZDY_uv() {
		return COUNT_ZDY_uv;
	}
	public void setCOUNT_ZDY_uv(String cOUNT_ZDY_uv) {
		COUNT_ZDY_uv = cOUNT_ZDY_uv;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	
	

	
	

}
