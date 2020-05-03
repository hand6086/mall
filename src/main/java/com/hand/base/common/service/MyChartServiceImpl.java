package com.hand.base.common.service;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.common.dao.mybatis.mapper.MyChartMapper;
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

@Service
public class MyChartServiceImpl implements MyChartService{
	
	private static final Logger logger = LogManager.getLogger(MyChartServiceImpl.class);
	
	@Autowired
	private MyChartMapper myChartMapper;
	
	/*
	 * 监控面板明细报表
	 * @param record
	 * @return
	 */
	@Override
	public List<PanelDetailReport> queryMonitoringPanelDetailReport(PanelDetailReportParam record) throws Exception {
		return myChartMapper.queryMonitoringPanelDetailReport(record);
	}

	@Override
	public List<SalesJournalReport> querySalesJournalReport(SalesJournalReportParam record) throws Exception {
		
		return myChartMapper.querySalesJournalReport(record);
	}

	@Override
	public List<DailySalesSingleReport> queryDailySalesReport(DailySalesSingleReportParam record) throws Exception {
		 return myChartMapper.queryDailySalesReport(record);
	}

	@Override
	public List<MerchSettleBatchQueryReport> queryMerchSettleBatchQueryReport(MerchSettleBatchQueryReportParam record) throws Exception {
		return myChartMapper.queryMerchSettleBatchQueryReport(record);
	}

	@Override
	public List<UsersPurchaseCountReport> queryUsersPurchaseCountReport(UsersPurchaseCountReportParam record)
			throws Exception {
		return myChartMapper.queryUsersPurchaseCountReport(record);
	}

	@Override
	public List<OrderDeliveryTimeReport> queryOrderDeliveryTimeReport(OrderDeliveryTimeReportParam record)throws Exception {
		return myChartMapper.queryOrderDeliveryTimeReport(record);
	}

	@Override
	public List<SalesExpressReport> querySalesExpressReport(SalesExpressReportParam record) throws Exception {
		return myChartMapper.querySalesExpressReport(record);
	}

	@Override
	public List<PanelCountReport> queryPanelCountReport(PanelCountReportParam record) throws Exception {
		return myChartMapper.queryPanelCountReport(record);
	}

	@Override
	public List<UserVisitCountReport> queryUserVisitCountReport(UserVisitCountReportParam record) throws Exception {
		return myChartMapper.queryUserVisitCountReport(record);
	}

	/*@Override
	public List<RePurchaseReport> queryRePurchaseReport(RePurchaseReportParam record) throws Exception {
		return myChartMapper.queryRePurchaseReport(record);
	}*/
	@Override
	public List<RePurchaseReport> queryRePurchaseReport(CallParam callParam) throws Exception {
		return myChartMapper.queryRePurchaseReport(callParam);
	}

	@Override
	public List<UserGrowthReport> queryUserGrowthReport(UserGrowthReportParam record) throws Exception {
		return myChartMapper.queryUserGrowthReport(record);
	}

	@Override
	public List<CancelOrderReport> queryCancelOrderReport(CancelOrderReportParam record) throws Exception {
		return myChartMapper.queryCancelOrderReport(record);
	}

	@Override
	public List<DeliveryDaysReport> queryDeliveryDaysReport(DeliveryDaysReportParam record) throws Exception {
		return myChartMapper.queryDeliveryDaysReport(record);
	}
	public List<CallParam> getRePurchaseReport(CallParam record) throws Exception {
		return myChartMapper.getRePurchaseReport(record);
	}

	//	复购统计为空
	@Override
	public List<RePurchaseReport> queryRePurchaseReportNull(MyChart myChart) throws Exception {
		return myChartMapper.queryRePurchaseReportNull(myChart);
	}


	// 品牌馆复购统计表
	@Override
	public List<RePurchaseReport> brandQueryRePurchaseReport(MyChart myChart) throws Exception {
		return myChartMapper.brandQueryRePurchaseReport(myChart);
	}

}
