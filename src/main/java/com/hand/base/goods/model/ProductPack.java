package com.hand.base.goods.model;

import java.util.ArrayList;
import java.util.List;

public class ProductPack {

    private String firstPageUrl;

    private String previousPageUrl;

    private String nextPageUrl;

    private String lastPageUrl;

    public String getFirstPageUrl() {
        return firstPageUrl;
    }

    public void setFirstPageUrl(String firstPageUrl) {
        this.firstPageUrl = firstPageUrl;
    }

    public String getPreviousPageUrl() {
        return previousPageUrl;
    }

    public void setPreviousPageUrl(String previousPageUrl) {
        this.previousPageUrl = previousPageUrl;
    }

    public String getNextPageUrl() {
        return nextPageUrl;
    }

    public void setNextPageUrl(String nextPageUrl) {
        this.nextPageUrl = nextPageUrl;
    }

    public String getLastPageUrl() {
        return lastPageUrl;
    }

    public void setLastPageUrl(String lastPageUrl) {
        this.lastPageUrl = lastPageUrl;
    }

    private List<Product> records = new ArrayList<>();

    public List<Product> getRecords() {
        return records;
    }

    public void setRecords(List<Product> records) {
        this.records = records;
    }
}
