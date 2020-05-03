<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
<style type="text/css">
</style>
<body>
	<div id="menu_layout" class="easyui-layout" fit="true" border="false">
		<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:100%;padding:0px;">
			<fieldset class="x-fieldset" id="orderKeyFilter">
				<legend class="x-fieldset-header"
					style="width: 95px; margin-bottom: 0px; border: none;">
					<span class="x-fieldset-title">快速筛选</span>
				</legend>
		
				<div class="row keyfilter-border">
					<ul id="order-status-keyfilter" data-toggle="keyfilter"
						data-title="订单状态" data-filter-filed="orderStatus"
						data-table-Id="order-table">
					</ul>
				</div>
			</fieldset>
			<table id="order-table" style="width:98%;height:380px;" singleSelect="true" rownumbers="true" pagination="true">
				<thead>
					<tr>
						<th field="orderNum" width="100px">订单编号</th>
						<th field="customerName" width="80px">消费者名称</th>
						<th field="recieverName" width="100px">收货人</th>
						<!-- <th field="province" width="100px">省/直辖市</th>
						<th field="city" width="100px">城市</th>
						<th field="district" width="140px">区/县</th>
						<th field="address" width="100px">详细地址</th> -->
						<th field="addressAll" width="280px">地址</th>
						<th field="recieverPhone" width="140px">收货人电话</th>
						<th field="storeName" width="120px">商户名称</th>
						<th field="orderStatus" width="120px" lov="BRAND_ORDER_STATUS" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('BRAND_ORDER_STATUS'),
																		editable:false}}">订单状态</th>
						<th field="orderTime" width="120px">下单时间</th>
						<th field="orderTotalPrice" width="120px">订单总金额</th>
						<th field="o2oPayType" width="100px" lov="TB_O2O_PAY_TYPE">支付方式</th>
						<th field="attrib26" width="140px">付款时间</th>
						<th field="logisticsStatus" width="100px" lov="TB_O2O_LOGISTICS_STATUS">物流状态</th>
						<th field="logisticsCompany" width="100px" lov="LOGISTICS_COMPANY">物流公司</th>
						<th field="logisticsOddNumber" width="120px">物流单号</th>
						<th field="shippingTime" width="120px">发运时间</th>
						<th field="tAttr20" width="120px">优惠券金额</th>
						<th field="offerSum" width="180px">优惠总金额</th>
						<th field="customerMsg" width="120px">买家留言</th>
						<th field="refuseRefundDate" width="120px">取消时间</th>
						<th field="cancelReason" width="120px">取消原因</th>
						<th field="fightGroupsId" width="100px">拼团Id</th>
						<th field="couponId" width="100px">优惠券Id</th>
						<th field="freight" width="100px">运费</th>
					</tr>
				</thead>
			</table>
			
			<table id="orderDetail-table" style="width:98%;height:380px;" singleSelect="true" rownumbers="true" pagination="true">
				<thead>
					<tr>
						<th field="merchName" width="160px">商品名称</th>
						<th field="productCode" width="160px">商品69码</th>
						<th field="price" width="100px">报价</th>
						<th field="qty" width="120px">数量</th>
						<th field="attrib17" width="120px">报价总金额</th>
						<th field="pmoPrice" width="120px">成交价</th>
						<th field="tAttr19" width="100px">成交金额</th>
						<th field="attrib11" width="120px" lov="S_IF">是否赠品</th>
						<th field="campId" width="120px">促销活动编码</th>
						<th field="activityName" width="120px">促销活动名称</th>
						<th field="merchantOfferSum" width="120px">优惠总金额</th>
						<th field="couponId" width="120px">优惠券ID</th>
						<th field="freight" width="120px">运费</th>
					</tr>
				</thead>
			</table>
			
		</div>
	</div>
	<script type="text/javascript">
		$datagrid = $('#order-table');
		$detaildatagrid = $('#orderDetail-table');
		var disabled = false;
		if(appCtx.systemRole=='super_administrator'){
			disabled = true;
		}
		$datagrid.hdatagrid({
			toolbarShow : true, //显示工具栏
			buttonSearch : true, //搜索框功能
			updateable: true,
			buttonExport : true,
			buttonMenu : true,
			oauthFlag : true,
			striped : true,
			title : '',
			border : false,
			pageSize: 10, 
		    pageList: [10,20,50], 
			subGridIds: ['orderDetail-table'], 
			url : '${AppContext.ctxPath}/action/portal/order/queryByExamplePage',
			
			onUpdateAction:function(row,successFun,errFun,that){
				row.brandUpdate = '1';
				$.post("${AppContext.ctxPath}/action/portal/order/update",row, 
				function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			},
		});
		
		$detaildatagrid.hdatagrid({
					toolbarShow : true, 
					buttonSearch : true, 
					buttonMenu : true,
					oauthFlag : true,
					striped : true,
					border : false,
					pageSize: 10, 
				    pageList: [10,20,50], 
					parentGridId : 'order-table',
					parentGridField : 'id',
					linkGridField : 'headId',
					url : '${AppContext.ctxPath}/action/portal/orderItem/queryByExamplePage',
				});
	   $('.fixed-keyfilter-ul').keyFilter();
	   $('#order-status-keyfilter').keyFilter({
			remoteData:true,
			filterByValue:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/BRAND_ORDER_STATUS'
	   });
		
	</script>
</body>
</html>