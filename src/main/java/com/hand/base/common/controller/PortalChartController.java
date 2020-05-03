package com.hand.base.common.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.user.model.User;
import com.hand.core.util.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hand.base.basic.model.CallParam;
import com.hand.base.common.model.CancelOrderReport;
import com.hand.base.common.model.CancelOrderReportParam;
import com.hand.base.common.model.DailySalesSingleReport;
import com.hand.base.common.model.DailySalesSingleReportParam;
import com.hand.base.common.model.DeliveryDaysReport;
import com.hand.base.common.model.DeliveryDaysReportParam;
import com.hand.base.common.model.MerchSettleBatchQueryReport;
import com.hand.base.common.model.MerchSettleBatchQueryReportParam;
import com.hand.base.common.model.MyChart;
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
import com.hand.base.common.service.MyChartService;
import com.hand.core.util.ExcelCommonUtils;
import com.hand.core.util.UserUtil;

@Controller
@RequestMapping("/action/portal/chart")
public class PortalChartController extends BasicController<MyChart> {

	private static final Logger logger = LogManager.getLogger(PortalChartController.class);

	@Resource
	private MyChartService myChartService;

	@RequestMapping(value = "/query", method = RequestMethod.POST)
	@ResponseBody
	public void query(MyChart record, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			// 对存储过程执行的参数进行处理,根据key从request中获取value

			// 执行过程

			result.put("success", true);
			result.put("result", "");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}

		try {
			ObjectMapper objectMapper = new ObjectMapper();
			OutputStream os;
			response.setContentType("text/html;charset=UTF-8");
			os = response.getOutputStream();
			JsonGenerator jsonGenerator = objectMapper.getFactory().createGenerator(os);
			jsonGenerator.writeObject(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/queryMonitoringPanelDetailReport", method = RequestMethod.POST)
	public Map<String, Object> queryMonitoringPanelDetailReport(PanelDetailReportParam record, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			List<PanelDetailReport> list = myChartService.queryMonitoringPanelDetailReport(record);
			ExcelCommonUtils excel = new ExcelCommonUtils();
			String titles = "订单编号,订单状态,物流状态,下单时间,接单时间,配送时间,收货时间,商户编码,商户名称,商户电话,消费者编码,消费者名称,消费者电话,收货人,收货人电话,省,城市,区,详细地址";
			String fields = "ORDER_NUM,ATTRIB_48,ATTRIB_07,XD_PERIOD,ATTRIB_27,ATTRIB_28,ATTRIB_29,SH_CODE,SH_NAME,O2O_CONTACT_PHONE,XFZ_CODE,XFZ_NAME,XFZ_PHO,SH_MAN,SHR_PHO,ATTRIB_36,ATTRIB_37,ATTRIB_38,ATTRIB_01";
			excel.exportExcelNew("监控面板明细报表", titles, fields, list, response);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}

	@RequestMapping(value = "/querySalesJournalReport", method = RequestMethod.POST)
	public void querySalesJournalReport(SalesJournalReportParam record, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		try {

			List<SalesJournalReport> list = myChartService.querySalesJournalReport(record);
			ExcelCommonUtils excel = new ExcelCommonUtils();
			String titles = "城市,未接订单数量,待配送数量,待签收数量,已配送完成数量,有效订单数量,产品原价销售额(元),实收金额(元),箱数,千升数,有效团购订单数量,团购产品原价销售额(元),团购实收金额(元),团购箱数,团购千升数";
			String fields = "O2O_CITY,NOT_TAKE_ORDER_CNT,TO_BE_DISTRIBUT_CNT,TO_BE_SIGN_CNT,COMPLETE_CNT,ACTIVE_ORDER_CNT,PRO_ORI_AMOUNT_OF_SALES,AMOUNT_OF_PAID,CARTON_CNT,KILOLITER_CNT,ACTIVE_GROUP_ORDER_CNT,GROUP_ORI_AMOUNT_OF_SALES,AMOUNT_OF_GROUP_PAID,GROUP_CARTON_CNT,GROUP_KILOLITER_CNT";
			excel.exportExcelNew("销量日报", titles, fields, list, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/queryDailySalesReport", method = RequestMethod.POST)
	public void queryDailySalesReport(DailySalesSingleReportParam record, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		try {

			List<DailySalesSingleReport> list = myChartService.queryDailySalesReport(record);
			ExcelCommonUtils excel = new ExcelCommonUtils();
			String titles = "城市,商品,订单量,产品原价销售额（元）,实收金额（元）,箱数,千升数";
			String fields = "O2O_CITY,O2O_DISPLAY_NAME,ORDER_CNT,PRO_SUM,REAL_SUM,ORDER_CTNS_SUM,KL_NUM";
			excel.exportExcelNew("单品销量日报", titles, fields, list, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "/queryMerchSettleBatchQueryReport", method = RequestMethod.POST)
	public void queryMerchSettleBatchQueryReport(MerchSettleBatchQueryReportParam record, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		try {

			List<MerchSettleBatchQueryReport> list = myChartService.queryMerchSettleBatchQueryReport(record);
			ExcelCommonUtils excel = new ExcelCommonUtils();
			String titles = "开始时间,结束时间,城市,商户编码,商户名称,商户电话,支付宝账号,开户银行,开户人,银行卡号,结算总金额,结算时间,结算状态,未结算原因";
			String fields = "START_DATE,END_DATE,CITY,STORE_NUM,STORE_NAME,STORE_PHONE,STORE_ALIPAY,BANK,ACC_NAME,CARD,TOTAL_AMOUNT,SETTLE_TIME,SETTLE_STATUS,NO_SETTLE_REASON";
			excel.exportExcelNew("商品结算批次查询报表", titles, fields, list, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "/queryUsersPurchaseCountReport", method = RequestMethod.POST)
	public void queryUsersPurchaseCountReport(UsersPurchaseCountReportParam record, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		try {

			List<UsersPurchaseCountReport> list = myChartService.queryUsersPurchaseCountReport(record);
			ExcelCommonUtils excel = new ExcelCommonUtils();
			String titles = "城市,购买总人数,新注册人数,新用户购买人数,新用户未购买人数,新注册并购买人数占比,老用户购买人数,老用户购买占比";
			String fields = "O2O_CITY,NUM2,NUM1,NUM3,NUM4,ROTE1,NUM5,ROTE2";
			excel.exportExcelNew("O2O-用户购买统计报表", titles, fields, list, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	@RequestMapping(value = "/queryOrderDeliveryTimeReport", method = RequestMethod.POST)
	public void queryOrderDeliveryTimeReport(OrderDeliveryTimeReportParam record, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		try {

			List<OrderDeliveryTimeReport> list = myChartService.queryOrderDeliveryTimeReport(record);
			ExcelCommonUtils excel = new ExcelCommonUtils();
			String titles = "城市,有效订单总数,送达≤1小时,1小时＜送达＜3小时,3小时≤送达≤当日0点,次日达，送达≥3,2天以上送达";
			String fields = "O2O_CITY,NUM1,NUM2,NUM3,NUM4,NUM5,NUM6";
			excel.exportExcelNew("订单配送时效监控报表", titles, fields, list, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	@RequestMapping(value = "/querySalesExpressReport", method = RequestMethod.POST)
	public void querySalesExpressReport(SalesExpressReportParam record, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		try {

			List<SalesExpressReport> list = myChartService.querySalesExpressReport(record);
			ExcelCommonUtils excel = new ExcelCommonUtils();
			String titles = "城市,有效订单数量 ,未接订单数量，,已接订单数量,"
					+ "合作商抢单,合作商抢单-平均接单时长,兜底商抢单,兜底商抢单-平均接单时长,兜底订单数量,兜底订单-平均接单时长,待配送数量,待签收数量,"
					+ "已配送完成数量,原价订单,优惠券订单,秒杀订单,买赠订单";
			String fields = "O2O_CITY,ACTIVE_ORDER_CNT,NOT_TAKE_ORDER_CNT,TAKE_ORDER_CNT,COOP_TAKE_ORDER_CNT,COOP_TAKE_ORDER_AVG_TIME"
					+ ",POCKET_TAKE_ORDER_CNT,POCKET_TAKE_ORDER_AVG_TIME,POCKET_ORDER_CNT,POCKET_ORDER_AVG_TIME,TO_BE_DISTRIBUT_CNT,"
					+ "TO_BE_SIGN_CNT,COMPLETE_CNT,ORI_PRICE_ORDER_CNT,COUPON_ORDER_CNT,SECKILL_ORDER_CNT,BUY_GIFT_ORDER_CNT";
			excel.exportExcelNew("销量快报", titles, fields, list, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/queryPanelCountReport", method = RequestMethod.POST)
	public void queryPanelCountReport(PanelCountReportParam record, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		try {

			List<PanelCountReport> list = myChartService.queryPanelCountReport(record);
			ExcelCommonUtils excel = new ExcelCommonUtils();
			String titles = "城市,未接单数量-今日,未接单数量-截止昨日,未配送数量-今日,未配送数量-截止昨日,未录码数量-今日,未录码数量-截止昨日,待确认退款数量-今日,待确认退款数量-截止昨日";
			String fields = "ATTRIB_37,COUNT_OUM,WJDSL_JZZR,COUNT_OUM_WPS,WPSSL_JZZR,COUNT_OUM_WLM,WLMSL_JZZR,COUNT_OUM_DQRTK,DQRTKSL_JZZR";
			excel.exportExcelNew("监控面板统计报表", titles, fields, list, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	@RequestMapping(value = "/queryUserVisitCountReport", method = RequestMethod.POST)
	public void queryUserVisitCountReport(UserVisitCountReportParam record, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		try {

			List<UserVisitCountReport> list = myChartService.queryUserVisitCountReport(record);
			ExcelCommonUtils excel = new ExcelCommonUtils();
			String titles = "城市,当天 PV,当天 UV,当周 PV,当周 UV,当月pv,当月uv,自定义pv,自定义uv";
			String fields = "location,COUNT_DT_HH,COUNT_DT_HH_uv,COUNT_DZ_D,COUNT_DZ_D_uv,COUNT_DY_MM,COUNT_DY_MM_uv,COUNT_ZDY,COUNT_ZDY_uv";
			excel.exportExcelNew("用户访问统计报表", titles, fields, list, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/*@RequestMapping(value = "/queryRePurchaseReport", method = RequestMethod.POST)
	public void queryRePurchaseReport(RePurchaseReportParam record, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		try {

			List<RePurchaseReport> list = myChartService.queryRePurchaseReport(record);
			
			ExcelCommonUtils excel = new ExcelCommonUtils();
			String titles = "城市,累计注册人数,累计购买过的人数,累计使用率,累计购买过1次的人数,累计购买过2次的人数,累计购买过3次的人数,累计购买超过3次的人数,复购人数";
			String fields = "O2O_CITY,COUNT_ZDY,LJGMGD_RS,COUNT_LJSYL,LJGMGD_RS_ONE,LJGMGD_RS_TWO,LJGMGD_RS_THR,LJGMGD_RS_THREE,COUNT_LJFGL";
			excel.exportExcelNew("复购统计报表", titles, fields, list, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}*/
	
	@RequestMapping(value = "/queryRePurchaseReport", method = RequestMethod.POST)
	public void queryRePurchaseReport(RePurchaseReportParam record, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		User user = UserUtil.getUser(session);
		try {
			List<RePurchaseReport> list;
			//复购统计表的区分
			//快购
			if ("101".equals(user.getUsercorpid())) {
				//			判断用户选择为空，传过去的list为空 执行如下逻辑
				if (StringUtils.isBlank(record.getO2O_CITY())) {
					String date = record.getDATE_TO() + " 23:59:59";
					MyChart myChart = new MyChart();
					myChart.setAttr1(date);
					list = myChartService.queryRePurchaseReportNull(myChart);
				} else {
					CallParam callParam = new CallParam();
					callParam.setParam1(record.getO2O_CITY());
					callParam.setParam2(record.getDATE_TO());
					myChartService.getRePurchaseReport(callParam);
					list = myChartService.queryRePurchaseReport(callParam);
				}
			} else {
				//品牌馆
				MyChart myChart = new MyChart();
				myChart.setAttr2(record.getDATE_TO());
				myChart.setAttr3(record.getO2O_CITY());
				list = myChartService.brandQueryRePurchaseReport(myChart);

			}


			ExcelCommonUtils excel = new ExcelCommonUtils();
			String titles = "城市,累计注册人数,累计购买过的人数,累计使用率,累计购买过1次的人数,累计购买过2次的人数,累计购买过3次的人数,累计购买超过3次的人数,累计复购率";
			String fields = "O2O_CITY,COUNT_ZDY,LJGMGD_RS,COUNT_LJSYL,LJGMGD_RS_ONE,LJGMGD_RS_TWO,LJGMGD_RS_THR,LJGMGD_RS_THREE,COUNT_LJFGL";
			excel.exportExcelNew("复购统计报表", titles, fields, list, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "/queryUserGrowthReport", method = RequestMethod.POST)
	public void queryUserGrowthReport(UserGrowthReportParam record, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		try {

			List<UserGrowthReport> list = myChartService.queryUserGrowthReport(record);
			ExcelCommonUtils excel = new ExcelCommonUtils();
			String titles = "城市,当天注册人数,当周注册人数,当月注册人数,自定义日期注册人数";
			String fields = "O2O_CITY,COUNT_DT_HH,COUNT_DZ_D,COUNT_DY_MM,COUNT_ZDY";
			excel.exportExcelNew("用户增长统计报表", titles, fields, list, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "/queryCancelOrderReport", method = RequestMethod.POST)
	public void queryCancelOrderReport(CancelOrderReportParam record, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		try {

			List<CancelOrderReport> list = myChartService.queryCancelOrderReport(record);
			ExcelCommonUtils excel = new ExcelCommonUtils();
			String titles = "城市,货到付款,在线支付-支付前,在线支付-支付后";
			String fields = "O2O_CITY,COUNT_OUM,COUNT_OUM_ZFQ,COUNT_OUM_ZFH";
			excel.exportExcelNew("取消订单统计报表", titles, fields, list, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	@RequestMapping(value = "/queryDeliveryDaysReport", method = RequestMethod.POST)
	public void queryDeliveryDaysReport(DeliveryDaysReportParam record, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		try {

			List<DeliveryDaysReport> list = myChartService.queryDeliveryDaysReport(record);
			ExcelCommonUtils excel = new ExcelCommonUtils();
			String titles = "城市,考核时间点前总订单量,考核时间点前-当日送达量,考核时间点前-当日送达率,考核时间点前-次日送达量,考核时间点前-次日送达率,考核时间点前-其他时间送达量,"
					+ "考核时间点前-其他时间送达率,考核时间点前-未送达订单量,考核时间点后-总订单量,考核时间点后-当日送达量,考核时间点后-当日送达率,考核时间点后-次日送达量,考核时间点后-次日送达率"
					+ "考核时间点后-其他时间送达量,考核时间点后-其他时间送达率,考核时间点后-未送达订单量";
			String fields = "O2O_CITY,COUNT_OUM,COUNT_OUM_DR,KHQ_DRSD_LV,COUNT_OUM_CR,KHQ_CRSD_LV,COUNT_OUM_QT,KHQ_QTSD_LV,COUNT_OUM_WSD,"
					+ "COUNT_KHH_OUM,COUNT_OUM_KHHDR,KHH_DRSD_LV,COUNT_OUM_KHHCR,KHH_CRSD_LV,COUNT_OUM_KHHQT,KHH_QTSD_LV,COUNT_OUM_KHHWSD";
			excel.exportExcelNew("配送天数统计报表", titles, fields, list, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
