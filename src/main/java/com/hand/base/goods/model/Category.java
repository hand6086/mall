package com.hand.base.goods.model;

import com.hand.base.basic.model.BasicModel;

public class Category extends BasicModel {

    private String cid;
    private String cname;
    public String getCid() {
        return cid;
    }
    public void setCid(String cid) {
        this.cid = cid;
    }
    public String getCname() {
        return cname;
    }
    public void setCname(String cname) {
        this.cname = cname;
    }
}
