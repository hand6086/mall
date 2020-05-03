package com.hand.base.rongcloud.model;

import org.apache.commons.lang3.StringUtils;

import com.hand.base.basic.model.BasicModel;
import com.hand.core.util.AppConstants;

/**
 * rcs_manager
 * @author 
 */
public class RcsManager extends BasicModel{
	
    /**
	 * 
	 */
	private static final long serialVersionUID = -9089023035761575725L;

	private String name;

    /**
     * 管理员头像
     */
    private String portrait;

    private String managerToken;

    private String merchantId;
    private String   zhMail;  //智齿邮箱

    public String getZhMail() {
        return zhMail;
    }

    public void setZhMail(String zhMail) {
        this.zhMail = zhMail;
    }

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

	public String getManagerToken() {
        return managerToken;
    }

    public void setManagerToken(String managerToken) {
        this.managerToken = managerToken;
    }

    public String getMerchantId() {
        return merchantId;
    }

    public void setMerchantId(String merchantId) {
        this.merchantId = merchantId;
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
        RcsManager other = (RcsManager) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getName() == null ? other.getName() == null : this.getName().equals(other.getName()))
            && (this.getPortrait() == null ? other.getPortrait() == null : this.getPortrait().equals(other.getPortrait()))
            && (this.getManagerToken() == null ? other.getManagerToken() == null : this.getManagerToken().equals(other.getManagerToken()))
            && (this.getMerchantId() == null ? other.getMerchantId() == null : this.getMerchantId().equals(other.getMerchantId()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getId() == null) ? 0 : getId().hashCode());
        result = prime * result + ((getName() == null) ? 0 : getName().hashCode());
        result = prime * result + ((getPortrait() == null) ? 0 : getPortrait().hashCode());
        result = prime * result + ((getManagerToken() == null) ? 0 : getManagerToken().hashCode());
        result = prime * result + ((getMerchantId() == null) ? 0 : getMerchantId().hashCode());
        return result;
    }
}