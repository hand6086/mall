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
		<div data-options="region:'north',split:true" title="" border="false" style="width: 100%; height: 100%; padding: 0px;">

			<table id="cancelPermission-table" style="width: 98%; height: 370px;" singleSelect="true" rownumbers="true" pagination="true">
				<thead>
					<tr>
						<th field="attrib48" width="100px" lov="TB_O2O_ORDER_STATUS">订单状态</th>
						<th field="orderNum" width="100px" formatter="orderFormatter">订单编号</th>
						<th field="attrib54" width="160px">外部订单编号</th>
						<th field="customerName" width="120px">消费者名称</th>
						<th field="customerOuNum" width="120px">消费者编码</th>
						<th field="mainPhNum" width="120px">消费者电话</th>
						<th field="attrib39" width="140px" lov="TB_O2O_STORE_NAME">店铺名称</th>
						<th field="contact" width="120px">收货人</th>
						<th field="contactPhone" width="120px">收货人电话</th>
						<th field="attrib36" width="120px">省/直辖市</th>
						<th field="attrib37" width="120px">城市</th>
						<th field="attrib38" width="120px">区/县</th>
						<th field="attrib01" width="140px">详细地址</th>
						<th field="gpsLongitude" width="100px">GPS经度</th>
						<th field="gpsLatitude" width="100px">GPS纬度</th>
						<th field="attrib14" width="100px">商品总价</th>
						<th field="attrib16" width="120px">特价优惠金额</th>
						<th field="attrib22" width="120px">买赠优惠金额</th>
						<th field="attrib21" width="120px">满减优惠金额</th>
						<th field="attrib20" width="120px">优惠券金额</th>
						<th field="offerSum" width="120px">优惠总金额</th>
						<th field="o2oTip" width="120px">小费</th>
						<th field="attrib17" width="100px">订单总金额</th>
						<th field="o2oPayType" width="100px" lov="TB_O2O_PAY_TYPE">支付方式</th>
						<th field="attrib47" width="140px">买家留言</th>
						<th field="attrib40" width="100px" lov="TB_O2O_ORDER_DILIVER_TYPE">配送方式</th>
						<th field="attrib07" width="100px" lov="TB_O2O_LOGISTICS_STATUS">物流状态</th>
						<th field="merchantName" width="160px">商户名称</th>
						<th field="merchantOuNum" width="100px">商户编码</th>
						<th field="o2oContactPhone" width="180px">商户电话</th>
						<th field="o2oStoreType" width="100px" lov="TB_O2O_STORE_TYPE">商户类型</th>
						<th field="distributor" width="100px">配送员</th>
						<th field="attrib42" width="100px">配送员电话</th>
						<th field="attrib44" width="100px" lov="TB_O2O_ORDER_TYPE">O2O订单分类</th>
						<th field="o2oForcedPickup" width="80px" lov="S_IF">是否兜底订单</th>
						<th field="attrib50" width="80px" lov="S_IF">是否团购订单</th>
						<th field="attrib55" width="80px" lov="S_IF">是否秒杀订单</th>
						<th field="attrib43" width="100px">校验码</th>
						<!-- 原先是TB_O2O_CHECK_STATUS,但数据库存放的值是New等 需要换成TB_CHECK_STATUS -->
						<th field="attrib49" width="100px" lov="TB_CHECK_STATUS">校验状态</th>
						<th field="created" width="140px">下单时间</th>
						<th field="attrib26" width="140px">付款时间</th>
						<th field="attrib27" width="140px">接单时间</th>
						<th field="attrib28" width="140px">配送时间</th>
						<th field="attrib29" width="140px">收货时间</th>
						<th field="attrib46" width="100px" lov="TB_O2O_SETTLEMENT_STATUS">结算状态</th>
						<th field="attrib53" width="130px" lov="TB_O2O_ORDER_SOURCE_SYSTEM">来源系统</th>
						<th field="typeName" width="120px" lov="FS_ORDER_TYPE">类型</th>
						<th field="attrib09" width="120px" lov="S_IF">是否O2O订单</th>
						<th field="attrib30" width="140px">第一轮推送时间</th>
						<th field="attrib31" width="140px">第二轮推送时间</th>
						<th field="attrib32" width="140px">第三轮推送时间</th>
						<th field="attrib57" width="140px">取消时间</th>
					</tr>
				</thead>
			</table>

			<table id="cancelPermission-productOrder-table" style="width: 98%; height: 390px;" singleSelect="true" rownumbers="true" pagination="true">
				<thead>
					<tr>
						<th field="orderId" width="140px" noSearch="true" hidden="true">订单Id</th>

						<th field="o2oDisplayName" width="160px">商品名称</th>
						<th field="o2oIntCode" width="160px">商品编码</th>
						<th field="baseUnitPri" width="100px">报价</th>
						<th field="qtyReq" width="120px">数量</th>
						<th field="attrib17" width="120px">报价总金额</th>
						<th field="netPri" width="120px">成交价</th>
						<th field="attrib19" width="100px">成交金额</th>
						<th field="o2oGpProd" width="120px" lov="S_IF">是否团购商品</th>
						<th field="attrib11" width="120px" lov="S_IF">是否赠品</th>
						<th field="merchantOfferSum" width="120px">商品优惠金额</th>
						<th field="orderOfferSum" width="120px">订单优惠金额分摊</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<div id="getOrderNumDetailWin" class="crmWin" style="width:100%;height:100%">
	    <iframe src=""  id="getOrderNumDetailWinFram" name="getOrderNumDetailWinFram" width="100%" height="100%" frameborder="0">
	    </iframe>
    </div>
	<script type="text/javascript">
		$getOrderNumDetailWinFram = $("#getOrderNumDetailWinFram");
		$getOrderNumDetailWin = $("#getOrderNumDetailWin");
		$datagrid = $('#cancelPermission-table');
		$productOrderdatagrid = $('#cancelPermission-productOrder-table');

		$datagrid.hdatagrid({
				toolbarShow : true, //显示工具栏
				buttonSearch : true, //搜索框功能
				buttonMenu : true,
				oauthFlag : true,
				striped : true,
				title : '',
				border : false,
				pageSize: 10, 
			    pageList: [10,20,50], 
				subGridIds : [ 'cancelPermission-productOrder-table' ],
				url : '${AppContext.ctxPath}/action/portal/order/cancelPermission/queryByExamplePage',
				onAddMoreButton : function(that, addButtonFun) {
					addButtonFun(90,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="cancelOrder()" iconCls="icon-ok" plain="true">取消订单</a>',that);
				}
			});
		function cancelOrder() {
			var row = $datagrid.datagrid('getSelected');
			row.id = '';
			$.messager.confirm("操作提示",'是否确定取消订单？',function(data) {
					if (data) {
						$.post('${AppContext.ctxPath}/action/portal/order/cancelPermission/insertCancelOrder',row,function(data) {
								if (data.success){
									window.parent.operationtip("操作成功",'success');
								} else {
									window.parent.operationtip(data.msg,'error');
									}
								});
							}
				});
		}
		
		function orderFormatter(val,row){
		     if(val != null){
			     return "<a class='easyui-tooltip' href='javascript:void(0)' onclick='getOrderDetail(\""+row.orderNum+"\")'>" + val + "</a>";
			 }
		}
		function getOrderDetail(orderNum){
			if(orderNum){
				$.post("${AppContext.ctxPath}/action/portal/order/platformOrder/queryOrderDetail" , {
					orderNum:orderNum
					}, function(data){
					if(data.success){
							$getOrderNumDetailWinFram.attr("src", "${AppContext.ctxPath}/portal/o2o/order/platformOrderEdit.jsp");
						$getOrderNumDetailWin.css("display", "block");
					}
				});
				
			}else{
				$.messager.alert("错误", "请传入正确参数", "error");
			} 
		}
		
		function closeOrderNumDetailWin(){
			$getOrderNumDetailWin.css("display", "none");
		}

		$productOrderdatagrid.hdatagrid({
					toolbarShow : true,
					buttonSearch : true,
					buttonMenu : true,
					oauthFlag : false,
					striped : true,
					title : '',
					nowrap:false,
					border : false,
					pageSize: 10, 
				    pageList: [10,20,50], 
					parentGridId : 'cancelPermission-table',
					parentGridField : 'id',
					linkGridField : 'orderId',
					url : '${AppContext.ctxPath}/action/portal/order/cancelPermission/queryProductOrderPage',
				});
	</script>
</body>
</html>