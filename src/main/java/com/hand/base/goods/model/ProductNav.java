package com.hand.base.goods.model;

import java.util.ArrayList;
import java.util.List;

public class ProductNav {

    private String id;

    private String name;

    private String parentId;

    private List<ProductNavChild> children = new ArrayList<>();

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public List<ProductNavChild> getChildren() {
        return children;
    }

    public void setChildren(List<ProductNavChild> children) {
        this.children = children;
    }
}
