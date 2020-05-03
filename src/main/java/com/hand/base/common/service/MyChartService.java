package com.hand.base.common.service;

import java.util.List;

import com.hand.base.basic.model.CallParam;
import com.hand.base.common.model.CancelOrderReport;
import com.hand.base.common.model.CancelOrderReportParam;
import com.hand.base.common.model.DailySalesSingleReport;
import com.hand.base.common.model.DailySalesSingleReportParam;
import com.hand.base.common.model.DeliveryDaysReport;
import com.hand.base.common.model.DeliveryDaysReportParam;
import com.hand.base.common.model.MerchSettleBatchQueryReport;
import com.hand.base.common.model.MerchSettleBatchQueryReportParam;
import com.hand.base.common.model.OrderDeliveryTimeReport;
import com.hand.base.common.model.OrderDeliveryTimeReportParam;
import com.hand.base.common.model.PanelCountReport;
import com.hand.base.common.model.PanelCountReportParam;
import com.hand.base.common.model.PanelDetailReport;
import com.hand.base.common.model.PanelDetailReportParam;
import com.hand.base.common.model.RePurchaseReport;
import com.hand.base.common.model.RePurchaseReportParam;
import com.hand.base.common.model.SalesExpressReport;
import com.hand.base.common.model.SalesExpressReportParam;
import com.hand.base.common.model.SalesJournalReport;
import com.hand.base.common.model.SalesJournalReportParam;
import com.hand.base.common.model.UserGrowthReport;
import com.hand.base.common.model.UserGrowthReportParam;
import com.hand.base.common.model.UserVisitCountReport;
import com.hand.base.common.model.UserVisitCountReportParam;
import com.hand.base.common.model.UsersPurchaseCountReport;
import com.hand.base.common.model.UsersPurchaseCountReportParam;
import com.hand.base.common.model.MyChart;

public interface MyChartService{
	
	/*
	 * 监控面板明细报表
	 * @param record
	 * @return
	 */
	public List<PanelDetailReport> queryMonitoringPanelDetailReport(PanelDetailReportParam record)throws Exception;
	/*
	 * 销量日报
	 * @param record
	 * @return
	 */
	public List<SalesJournalReport> querySalesJournalReport(SalesJournalReportParam record)throws Exception;
	/*
	 * 单品销量日报
	 * @param record
	 * @return
	 */
	public List<DailySalesSingleReport> queryDailySalesReport(DailySalesSingleReportParam record)throws Exception;
	/*
	 * 商品结算批次查询报表
	 * @param record
	 * @return
	 */
	
	public List<MerchSettleBatchQueryReport> queryMerchSettleBatchQueryReport(MerchSettleBatchQueryReportParam record)throws Exception;
	/*
	 * O2O-用户购买统计报表
	 * @param record
	 * @return
	 */
	public List<UsersPurchaseCountReport> queryUsersPurchaseCountReport(UsersPurchaseCountReportParam record)throws Exception;
	/*
	 * 订单配送时效报表
	 * @param record
	 * @return
	 */
	public List<OrderDeliveryTimeReport> queryOrderDeliveryTimeReport(OrderDeliveryTimeReportParam record) throws Exception;
	/*
	 * 销量快报
	 * @param record
	 * @return
	 */
	public List<SalesExpressReport> querySalesExpressReport(SalesExpressReportParam record)throws Exception;
	/*
	 * 监控面板统计报表
	 * @param record
	 * @return
	 */
	public List<PanelCountReport> queryPanelCountReport(PanelCountReportParam record)throws Exception;
	/*
	 * 用户访问统计报表
	 * @param record
	 * @return
	 */
	public List<UserVisitCountReport> queryUserVisitCountReport(UserVisitCountReportParam record)throws Exception;
	
	/*
	 * 存储过程QUERY_CHART_ORDER_COUNT_INFO
	 * @param record
	 * @throws Exception
	 */
	public List<CallParam> getRePurchaseReport(CallParam record) throws Exception;
	
	/*
	 * 用户访问统计报表
	 * @param record
	 * @return
	 
	public List<RePurchaseReport> queryRePurchaseReport(RePurchaseReportParam record)throws Exception;*/
	
	/*
	 * 复购统计报表
	 * @param record
	 * @return
	 */
	public List<RePurchaseReport> queryRePurchaseReport(CallParam callParam)throws Exception;
	
	/*
	 * 用户增长统计报表
	 * @param record
	 * @return
	 */
	public List<UserGrowthReport> queryUserGrowthReport(UserGrowthReportParam record)throws Exception;
	/*
	 * 取消订单统计报表
	 * @param record
	 * @return
	 */
	public List<CancelOrderReport> queryCancelOrderReport(CancelOrderReportParam record)throws Exception;
	/*
	 * 配送天数统计报表
	 * @param record
	 * @return
	 */
	public List<DeliveryDaysReport> queryDeliveryDaysReport(DeliveryDaysReportParam record)throws Exception;

	/*
	 * 用户选择为空   复购统计表
	 * @param record
	 * @return
	 */
	public List<RePurchaseReport>  queryRePurchaseReportNull(MyChart myChart) throws  Exception;

	/*
	 * 品牌馆复购统计表
	 * @param record
	 * @return
	 */
	public List<RePurchaseReport> brandQueryRePurchaseReport(MyChart myChart) throws  Exception;

}
