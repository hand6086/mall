package com.hand.core.util;

public class Constants {
	
	/** 标准公司帐套的编号，用于管理其他账套 */
	public static final String ADMIN_CORPID = "000";
	
	
	
	
	
	/**
	 * -------------------------------------------------------------------
	 * 以下代码为冗余代码，待删除 --2017-04-11
	 */
	
	// 分割线：打印日志用
	public static final String LOG_DIVISION_LINE = "\r\n---------------------------------\r\n";
	
	public static final String LOGIN = "LOGIN";
	
	public static final String COMPANY = "COMPANY";
	
	public static final String HAND_USERNAME = "hand_username";
	
	public static final String HAND_PASSWORD = "hand_password";
	
	public static final String ACCOUNT_BASE_TYPE = "account";
	
	public static final String ORDER_BASE_TYPE = "order";
	
	public static final String ACCOUNT_PROVINCE = "province";
	
	public static final String ACCOUNT_CITY = "city";
	
	public static final String ACCOUNT_COUNTY = "county";
	
	public static final String ORDER_MONTH = "month";
	
	public static final String ORDER_WEEK = "week";
	
	public static final String ORDER_DAY = "day";
	
	public static final String ORDER_DAY_IN_MONTH = "dayInMonth";
	
	public static final String ORDER_TIME_INTERVAL = "timeInterval";
	
	
	public static final String VISIT_BASE_TYPE = "visit";
	
	public static final String VISIT_MONTH_INTERVAL = "month";
	
	public static final String VISIT_DAY_INTERVAL = "day";
	
	//session中存放的验证码的键名称
	public static final String CHECK_NUMBER_KEY = "CHECK_NUMBER_KEY";
	
	/**
	 * 菜单类型：客户管理
	 */
	public static final String MENU_TYPE_ACCOUNT_MANAGE = "ACCOUNT_MANAGE";
	
	/**
	 * 菜单类型：产品管理
	 */
	public static final String MENU_TYPE_PRODUCT_MANAGE = "PRODUCT_MANAGE";
	
	/**
	 * 菜单类型：订单管理
	 */
	public static final String MENU_TYPE_ORDER_MANAGE = "ORDER_MANAGE";
	
	/**
	 * 菜单类型：商机管理
	 */
	public static final String MENU_TYPE_BUSINESS_MANAGE = "BUSINESS_MANAGE";
	
	/**
	 * 菜单类型：报价管理
	 */
	public static final String MENU_TYPE_OFFER_MANAGE = "OFFER_MANAGE";
	
	/**
	 * 菜单类型：活动管理
	 */
	public static final String MENU_TYPE_CAMPAIGN_MANAGE = "CAMPAIGN_MANAGE";
	
	/**
	 * 菜单类型：服务请求管理
	 */
	public static final String MENU_TYPE_SERVICE_MANAGE = "SERVICE_MANAGE";
	
	/**
	 * 菜单类型：报表管理
	 */
	public static final String MENU_TYPE_CHART_MANAGE = "CHART_MANAGE";
	
	/**
	 * 菜单类型：组织管理
	 */
	public static final String MENU_TYPE_ORGNIZATION_MANAGE = "ORGNIZATION_MANAGE";
	
	/**
	 * 菜单类型：用户管理
	 */
	public static final String MENU_TYPE_USER_MANAGE = "USER_MANAGE";
	
	/**
	 * 菜单类型：基础数据管理
	 */
	public static final String MENU_TYPE_BASE_MANAGE = "BASE_MANAGE";

	/**
	 * 菜单类型：系统管理
	 */
	public static final String MENU_TYPE_SYS_MANAGE = "SYS_MANAGE";
	
	
	/**
	 * 菜单类型：公告管理
	 */
	public static final String MENU_TYPE_ANNOUNCE_MANAGE = "ANNOUNCE_MANAGE";
	
	
	
	/**
	 * 值列表：是否有效
	 */
	public static final String IS_EFFECTIVE = "IS_EFFECTIVE";
	
	/**
	 * 值列表：售后退单状态类型
	 */
	public static final String SERVICE_ORDER_STATUS = "SERVICE_ORDER_STATUS";
	
	/**
	 * 值列表：组织类型
	 */
	public static final String ORG_TYPE = "ORG_TYPE";
	
	/**
	 * 值列表：客户类型
	 */
	public static final String ACCT_TYPE = "ACCT_TYPE";
	
	/**
	 * 客户类型：大客户
	 */
	public static final String ACCT_SUP_DEALER = "SUP_DEALER";
	
	/**
	 * 值列表：经销商
	 */
	public static final String ACCT_DEALER = "DEALER";
	
	/**
	 * 值列表：下挂单位
	 */
	public static final String ACCT_SUB_DEALER = "SUB_DEALER";
	
	/**
	 * 值列表：用户类型
	 */
	public static final String EMP_TYPE = "EMP_TYPE";
	/**
	 * 值列表：用户类型
	 */
	public static final String INTERFACE_ONE_TYPE = "INTERFACE_ONE_TYPE";
	
	/**
	 * 值列表：部门类型	

	 */
	public static final String DEPT_TYPE = "DEPT_TYPE";
	
	/**
	 * 值列表：职位类型
	 */
	public static final String POSTN_TYPE = "POSTN_TYPE";
	
	/**
	 * 订单类型
	 */
	public static final String ORDER_TYPE = "ORDER_TYPE";
	
	/**
	 * 值列表：公司代码
	 */
	public static final String COMPANY_CODE = "COMPANY_CODE";
	
	/**
	 * 值列表：分销渠道
	 */
	public static final String DIS_CHANNEL = "DIS_CHANNEL";
	
	/**
	 * 值列表：产品组
	 */
	public static final String PROD_GROUP = "PROD_GROUP";
	/**
	 * 管式电池行信息（调换，检查，处理）
	 */
	public static final String TUBULAR_CELL_STATUS = "TUBULAR_CELL_STATUS";
	/**
	 * 产品系列
	 */
	public static final String PROD_SERIES = "PROD_SERIES";
	
	/**
	 * 值列表：销售组织
	 */
	public static final String MARKET_ORG = "MARKET_ORG";
	
	/**
	 * 值列表：调换更改说明
	 */
	public static final String ALTER_EXPLAIN = "ALTER_EXPLAIN";
	
	/**
	 * 值列表：调换更改情况
	 */
	public static final String ALTER_SITUATION = "ALTER_SITUATION";

	/**
	 * 销售小密电池编号
	 */
	public static final String SALE_ORDER_DENSE_NO = "10001";
	
	/**
	 * 销售光宣品电池编号
	 */
	public static final String SALE_ORDER_DECLARE_NO = "10002";
	
	/**
	 * 值列表：地址类型
	 */
	public static final String ADDR_TYPE = "ADDR_TYPE";
	
	/**
	 * 购物车状态：新建
	 */
	public static final String SHOP_CART_STATUS_NEW = "New";
	
	/**
	 * 购物车状态：提交
	 */
	public static final String SHOP_CART_STATUS_SUBMIT = "Submit";
	
	/**
	 * 订单状态：新建
	 */
	public static final String ORDER_STATUS_NEW = "New";
	
	/**
	 * 订单状态：提交
	 */
	public static final String ORDER_STATUS_SUBMIT = "Submitted";
	
	/**
	 * 订单状态：待财务审核
	 */
	public static final String ORDER_STATUS_FOR_FINANCIAL = "FOR_FINANCIAL";
	
	/**
	 * 订单状态：待渠道审核
	 */
	public static final String ORDER_STATUS_FOR_CHANNEL = "FOR_CHANNEL";
	
	/**
	 * 订单状态：同步成功
	 */
	public static final String ORDER_STATUS_SYN_SUCCESS = "S";
	
	/**
	 * 订单状态：同步失败
	 */
	public static final String ORDER_STATUS_SYN_FAIL = "E";
	
	/**
	 * 订单行类型：常规行
	 */
	public static final String ORDER_ITEM_TYPE_COMMON = "COMMON";
	
	/**
	 * 订单行类型：赠品行
	 */
	public static final String ORDER_ITEM_TYPE_PREZZIE = "PREZZIE";
	
	/**
	 * 值列表：是否默认
	 */
	public static final String IS_DEFAULT = "IS_DEFAULT";
	
	/**
	 * 值列表：val 收货地址
	 */
	public static final String ADDR_TYPE_RECEIVE_ADDR_VAL = "RECEIVE_ADDR";

	/**
	 * 值列表：是否为某个客户的唯一主营业务
	 */
	public static final String IS_MAIN_BUSINESS = "IS_MAIN_BUSINESS";
	
	/**
	 * 值列表：订单状态
	 */
	public static final String ORDER_STATUS = "ORDER_STATUS";
	
	/**
	 * 值列表：库存操作明细的类型（例如：增加、减少等）
	 */
	public static final String REPLACE_TYPE = "REPLACE_TYPE";
	
	/**
	 * 值列表：同步状态
	 */
	public static final String SYN_STATUS = "SYN_STATUS";
	
	/**
	 * 值列表：性别
	 */
	public static final String GENDER = "GENDER";
	
	/**
	 * 值列表：用户角色
	 */
	public static final String ROLE = "ROLE";
	
	/**
	 * 值列表：用户状态
	 */
	public static final String USER_STATUS = "USER_STATUS";

	/**
	 * 外部用户
	 */
	public static final String EMP_OUTER_EMP = "OUTER_EMP";

	/**
	 * 内部用户
	 */
	public static final String EMP_INTER_EMP = "INTER_EMP";
	
	/**
	 * 税分类
	 */
	public static final String ACCNT_TAX_CATG = "ACCNT_TAX_CATG";
	
	/**
	 * 装运条件
	 */
	public static final String ACCNT_SHIP_COND = "ACCNT_SHIP_COND";
	
	/**
	 * 统驭科目
	 */
	public static final String ACCNT_CONTROL_SUB = "ACCNT_SHIP_COND";
	
	/**
	 * 账户分配组
	 */
	public static final String ACCNT_ASSIGN_GROUP = "ACCNT_ASSIGN_GROUP";
	
	/**
	 * 经销点
	 */
	public static final String ORG_POINT = "ORG_POINT";
	
	/**
	 * 值列表：是否
	 */
	public static final String S_IF = "S_IF";
	/**
	 * 值列表：产品 物料组
	 */
	public static final String PROD_MAT_SERIES = "PROD_MAT_SERIES";
	/**
	 * 值列表：产品类型
	 */
	public static final String BATTERY_TYPE = "BATTERY_TYPE";
	
	/**
	 * 值列表：产品状态	

	 */
	public static final String PROD_STATUS = "PROD_STATUS";
	/**
	 * 值列表：地址行政级别	

	 */
	public static final String IS_ADDR_TYPE = "IS_ADDR_TYPE";
	
	/**
	 * 值列表：基地类型
	 */
	public static final String PROD_LINE_TYPE = "PROD_LINE_TYPE";
	/**
	 * 值列表：申报单状态
	 */
	public static final String BUS_STATUS= "BUS_STATUS";
	/**
	 * 值列表：管式电池退单状态
	 */
	public static final String TUBULAR_STATUS= "TUBULAR_STATUS";
	
	/**
	 * 销售订单标记：已标记
	 */
	public static final String SALE_ORDER_IS_FLAG = "Y";
	
	/**
	 * 销售订单标记：未标记
	 */
	public static final String SALE_ORDER_NOT_FLAG = "N";
	
	/**
	 * 外部员工
	 */
	public static final String OUTER_EMP = "OUTER_EMP";
	
	/**
	 * 内部员工
	 */
	public static final String INTER_EMP = "INTER_EMP";
	
	/**
	 * 是否可退的时间的判断月份
	 */
	public static final int isAllowReturnJudgeMonths = 27;
	
	/**
	 * 故障类型
	 */
	public static final String FAULT_TYPE = "FAULT_TYPE";

	/**
	 * 值列表：仓库类型
	 */
	public static final String WARE_TYPE = "WARE_TYPE";
	
	/**
	 * 具体原因
	 */
	public static final String SPECIFIC_REASON = "SPECIFIC_REASON";
	
	/**
	 * 订单类型表的价格类型：销售价格 的独立源代码
	 */
	public static final String PRICE_TYPE_SALE_PRICE = "PR01";
}
