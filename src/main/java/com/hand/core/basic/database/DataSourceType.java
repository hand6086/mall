package com.hand.core.basic.database;

/**
 * 数据源类型
 * @author qiqian.he
 *
 */
public enum DataSourceType {
	/** 主库 */
	MASTER("master"),
	/** 从库 */
	SLAVE("slave");
	
	private String name;
	
	private DataSourceType(String _name) {
		this.name = _name;
	}
	
	public String getName() {
        return name;
    }
}
