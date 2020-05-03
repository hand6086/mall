package com.hand.base.rongcloud.model;

import org.apache.commons.lang3.StringUtils;

import com.hand.base.basic.model.BasicModel;
import com.hand.core.util.AppConstants;

import freemarker.template.utility.StringUtil;

/**
 * rcs_user
 * @author 
 */
public class RcsUser extends BasicModel{
    /**
	 * 
	 */
	private static final long serialVersionUID = -2088472620110229720L;

	private String phonNum;

    private String rongToken;

    private String name;

    private String portrait;

    public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPortrait() {
		if (StringUtils.isEmpty(portrait)){
			return AppConstants.portalStaticUrl+"/static/images/404.jpg";
		}else{
			return AppConstants.portalSharePicHttpDir+portrait;
		}
	}

	public void setPortrait(String portrait) {
		this.portrait = portrait;
	}

	public String getPhonNum() {
        return phonNum;
    }

    public void setPhonNum(String phonNum) {
        this.phonNum = phonNum;
    }

    public String getRongToken() {
        return rongToken;
    }

    public void setRongToken(String rongToken) {
        this.rongToken = rongToken;
    }

    @Override
    public boolean equals(Object that) {
        if (this == that) {
            return true;
        }
        if (that == null) {
            return false;
        }
        if (getClass() != that.getClass()) {
            return false;
        }
        RcsUser other = (RcsUser) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getPhonNum() == null ? other.getPhonNum() == null : this.getPhonNum().equals(other.getPhonNum()))
            && (this.getRongToken() == null ? other.getRongToken() == null : this.getRongToken().equals(other.getRongToken()))
            && (this.getName() == null ? other.getName() == null : this.getName().equals(other.getName()))
            && (this.getPortrait() == null ? other.getPortrait() == null : this.getPortrait().equals(other.getPortrait()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getId() == null) ? 0 : getId().hashCode());
        result = prime * result + ((getPhonNum() == null) ? 0 : getPhonNum().hashCode());
        result = prime * result + ((getRongToken() == null) ? 0 : getRongToken().hashCode());
        result = prime * result + ((getName() == null) ? 0 : getName().hashCode());
        result = prime * result + ((getPortrait() == null) ? 0 : getPortrait().hashCode());
        return result;
    }
}