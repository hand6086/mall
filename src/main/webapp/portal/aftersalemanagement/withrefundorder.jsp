<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<%@ include file="/portal/header.jsp" %>

<style type="text/css">
.form-table{
	margin: 5px auto; 
	width: 100%;
}
.td-label {
	width:120px;
	font-size: 14px;
	text-align: right;
	height: 30px;
}
.td-content input{
	width:180px;
}
</style>

<body class="easyui-layout" data-options="fit:true" border="false">
 <div data-options="region:'north',split:true" fit="true" border="false">
   <div  border="false" style="height:520px;width:100%">
    <fieldset class="x-fieldset" id="withrefundorderKeyFilter">
		<legend class="x-fieldset-header" style="width: 95px; margin-bottom: 0px; border: none;">
			<span class="x-fieldset-title">快速查询</span>
		</legend>

		<div class="row keyfilter-border">
			<table class="form-table">
			    <tr>
	   				<td class="td-label"><label>下单时间从：</label></td>
					<td class="td-input">
						<input  class="easyui-datetimebox" name="attr1" type="text" id="attr1" size="25" />
					</td>

					<td class="td-label"><label>下单时间到：</label></td>
					<td class="td-input">
						<input  class="easyui-datetimebox" name="attr2" type="text" id="attr2" size="25" />
					</td>

					<td class="td-label"><label>物流状态：</label></td>
					<td class="td-input">
						<input  class="easyui-combobox" name="o2oLogisticsStatus" type="text" id="o2oLogisticsStatus" size="25" />
					</td>
				</tr>
			    <tr>
					<td class="td-label"><label>收货时间从：</label></td>
					<td class="td-input">
						<input  class="easyui-datetimebox" name="attr3" type="text" id="attr3" size="25" />
					</td>

					<td class="td-label"><label>收货时间到：</label></td>
					<td class="td-input">
						<input  class="easyui-datetimebox" name="attr4" type="text" id="attr4" size="25" />
					</td>

					<td class="td-label"><label>订单状态：</label></td>
					<td class="td-input">
						<input  class="easyui-combobox" name="o2oorderStatus" type="text" id="o2oorderStatus" size="25" />
					</td>
	   			</tr>
			    <tr>
	   				<td class="td-label"><label>订单编号：</label></td>
					<td class="td-input">
						<input  class="easyui-validatebox" name="orderNumber" type="text" id="orderNumber" size="25" />
					</td>
				</tr>
	   		</table>
		</div>
	</fieldset>
	<table id="WithRefundOrder-table" rownumbers="true"  pagination="true" keyFilterDiv="withrefundorderKeyFilter" fit="true" >
		<thead>
			<tr>
				<th field="check" checkbox="true"></th>
				<th field="orderNumber" width="130px" defaultSearch="true" formatter="orderFormatter">订单编号</th>
				<th field="o2oExloderNumber" width="150px" >外部订单编号</th>
				<th field="o2oPayInfoType" width="150px" lov="TB_O2O_PAYMENT_TYPE">在线支付方式</th>
				<th field="o2oorderStatus" width="150px" lov="TB_O2O_ORDER_STATUS">订单状态</th>
				<th field="o2oLogisticsStatus" width="150px" lov="TB_O2O_LOGISTICS_STATUS">商户物流状态</th>
				<th field="account" width="150px" >消费者名称</th>
				<th field="accountCode" width="150px" >消费者编码</th>
				<th field="mainPhoneNumber" width="150px" >消费者电话</th>
				<th field="o2oStoreName" width="150px" lov="TB_O2O_STORE_NAME">店铺名称</th>
				<th field="o2oReceiverName" width="150px" >收件人</th>
				<th field="o2oReceiverPhone" width="150px" >收货人电话</th>
				<th field="o2oReceiverProvince" width="150px" >省/直辖市</th>
				<th field="o2oReceiverCity" width="150px" >城市</th>
				<th field="o2oReceiverDistrict" width="150px" >区/县</th>
				<th field="o2oReceiverAddress" width="150px" >详细地址</th>
				<th field="o2oGPSLongitude" width="150px" >GPS经度</th>
				<th field="o2oGPSLatitude" width="150px" >GPS纬度</th>
				<th field="o2omerchandiseprice" width="150px" >商品总价</th>
				<th field="o2oDeducedPrice" width="150px" >特价优惠金额</th>
				<th field="o2oFreeGetPrice" width="150px" >买赠优惠金额</th>
				<th field="o2oFullCutAmount" width="150px" >满减优惠金额</th>
				<th field="o2oCouponValue" width="150px" >优惠券金额</th>
				<th field="o2oTip" width="150px" >小费</th>
				<th field="o2oorderTotalPrice" width="150px" >订单总金额</th>
				<th field="o2oPayType" width="150px" lov="TB_O2O_PAY_TYPE">支付方式</th>
				<th field="o2oCustomerMsg" width="150px" >买家留言</th>
				<th field="o2oDeliveryType" width="150px" lov="TB_O2O_ORDER_DILIVER_TYPE">配送方式</th>
				<th field="o2oDSRName" width="150px">商户名称</th>
				<th field="o2oDSRCode" width="150px" >商户编码</th>
				<th field="o2oStoreCellphone" width="150px" >商户电话</th>
				<th field="o2oDSRStoreType" width="150px" lov="TB_O2O_STORE_TYPE">商户类型</th>
				<th field="o2oDeliveryMan" width="150px" >配送员</th>
				<th field="o2oDeliveryManphone" width="150px" >配送员电话</th>
				<th field="o2oorderType" width="150px" lov="TB_O2O_ORDER_TYPE">o2o订单分类</th>
				<th field="o2oIsForcedPickup" width="150px" lov='S_IF'  editor="{type:'combobox',
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('S_IF'),
											editable:false,
											required:true}}">是否兜底订单</th>
				<th field="o2oIsGroPurorder" width="150px" lov='S_IF'  editor="{type:'combobox',
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('S_IF'),
											editable:false,
											required:true}}">是否团购订单</th>
				<th field="o2oCheckCode" width="150px" >校验码</th>
				<th field="o2oCheckStatus" width="150px" lov="TB_CHECK_STATUS">校验状态</th>
				<th field="orderCreated" width="150px" >下单时间</th>
				<th field="o2oPayBillTime" width="150px" >付款时间</th>
				<th field="o2oorderPickedT" width="150px" >接单时间</th>
				<th field="o2oStartDeliveryT" width="150px" >配送时间</th>
				<th field="o2oReceivedTime" width="150px" >收货时间</th>
				<th field="o2oorderSourceSystem" width="150px" lov="TB_O2O_ORDER_SOURCE_SYSTEM">来源系统</th>
				<th field="orderType" width="150px" lov="FS_ORDER_TYPE">类型</th>
				<th field="o2oiso2oorder" width="150px" lov='S_IF'  editor="{type:'combobox',
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('S_IF'),
											editable:false,
											required:true}}">是否o2o订单</th>
				<th field="o2o1stPushTime" width="150px" >第一轮推送时间</th>
				<th field="o2o2ndPushTime" width="150px" >第二轮推送时间</th>
				<th field="o2o3rdPushTime" width="150px" >第三轮推送时间</th>

			</tr>
		</thead>
	</table>
 </div>
	<div  border="false" style="width:100%;height:380px;">
		<table id="WithRefundOrder-table-goods" fit="true" >
			<thead>
				<tr>
				    <th field="merchandiseName" width="100px">商品名称</th>
				    <th field="merchandiseCode" width="100px">商品编码</th>
				    <th field="basePrice" width="100px">报价</th>
				    <th field="quantityRequested" width="100px">数量</th>
				    <th field="o2oOriMePrice" width="100px">报价总金额</th>
				    <th field="netPrice" width="100px">成交价</th>
				    <th field="o2oLineTotalPrice" width="100px">成交金额</th>
				    <th field="o2ooGPProd" width="100px"lov='S_IF'  editor="{type:'combobox',
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('S_IF'),
											editable:false,
											required:true}}">是否团购商品</th>
				    <th field="o2oIsFreeMerchandise" width="100px"lov='S_IF'  editor="{type:'combobox',
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('S_IF'),
											editable:false,
											required:true}}">是否赠品</th>
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
		var attr1 = null;
		var attr2 = null;
		var attr3 = null;
		var attr4 = null;
		var o2oLogisticsStatus = null;
		var o2oorderStatus = null;
		var orderNumber = null;

	   $getOrderNumDetailWinFram = $("#getOrderNumDetailWinFram");
	   $getOrderNumDetailWin = $("#getOrderNumDetailWin");
	   $datagrid = $('#WithRefundOrder-table');
	   $dataItemgrid=$('#WithRefundOrder-table-goods');
		$datagrid.hdatagrid({
            pagination:true,
			updateable:true,
			toolbarShow:true,	//显示工具栏
			buttonSearch:false,	//搜索框功能
			buttonMenu:true,
			oauthFlag:true,
			menuButtonCount : true,
			singleSelect:false,
			striped:true,
			border:false,
			pageSize: 10,//每页显示的记录条数，默认为20
		    pageList: [10,30,50],//可以设置每页记录条数的列表
		    subGridIds: ['WithRefundOrder-table-goods'],
			url:'${AppContext.ctxPath}/action/portal/withrefundorder/queryByExamplePage',

			onBeforeLoad:function(param){
				if(attr1 != null && attr1 != ''){
		    		param.attr1 = attr1;
				}
				if(attr2 != null && attr2 != ''){
		    		param.attr2 = attr2;
				}
				if(attr3 != null && attr3 != ''){
		    		param.attr3 = attr3;
				}
				if(attr4 != null && attr4 != ''){
		    		param.attr4 = attr4;
				}
				if(o2oLogisticsStatus != null && o2oLogisticsStatus != ''){
		    		param.o2oLogisticsStatus = o2oLogisticsStatus;
				}
				if(o2oorderStatus != null && o2oorderStatus != ''){
		    		param.o2oorderStatus = o2oorderStatus;
				}
				if(orderNumber != null && orderNumber != ''){
		    		param.orderNumber = orderNumber;
				}
			},

		    onAddMoreButton : function(that, addButtonFun) {
		    	addButtonFun(1,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="withrefundorderSearch()" iconCls="icon-search" plain="true">查询</a>',that);
				addButtonFun(2,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="withrefundorderClean()" iconCls="icon-reload" plain="true">重置</a>',that);
				addButtonFun(90,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="setCancel()" iconCls="icon-ok" plain="true">去退款</a>',that);
		    }
		});

		function orderFormatter(val,row){
		     if(val != null){
			     return "<a class='easyui-tooltip' href='javascript:void(0)' onclick='getOrderDetail(\""+row.orderNumber+"\")'>" + val + "</a>";
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
		$dataItemgrid.hdatagrid({

			toolbarShow:true,
			buttonSearch:true,
			pageSize: 10,//每页显示的记录条数，默认为20
		    pageList: [10,30,50],//可以设置每页记录条数的列表
		    parentGridId : 'WithRefundOrder-table',
		    parentGridField : 'id',
		    linkGridField : 'orderHeaderId',
			 url:'${AppContext.ctxPath}/action/portal/withrefundorder/queryoOderGoodsPage',


		});

		function selectedType(selectRow){
			$subdatagrid.hdatagrid('getCurrentRow').o2oSeriesId = selectRow.id;
		}

		function setCancel(){
			var userRefundUrl = $datagrid.datagrid('getSelected').userRefundUrl;
			var orderId = "";
			var count = 0;
			var rows = $datagrid.datagrid('getSelections');
			for(var i=0; i<rows.length; i++){
				if(rows[0].o2oPayInfoType == rows[i].o2oPayInfoType){
					count = count +1;
				}
			}
			if(count == rows.length){
				for(var i=0; i<rows.length; i++){
					orderId += rows[i].id + ",";
				}
				orderId = orderId.substr(0, orderId.length - 1);
				window.open(userRefundUrl+"?reason="+encodeURI('无')+"&id="+orderId);
			}else{
				$.messager.alert("操作提示", "在线支付方式必须一致!","error");
			}
		}

		$('#o2oLogisticsStatus').combobox({
			method:'get',
			data:getLovArray('TB_O2O_LOGISTICS_STATUS'),
			valueField:'val',
			textField:'name',
			panelHeight: 'auto',
		    cache: false
		});

		$('#o2oorderStatus').combobox({
			method:'get',
			data:getLovArray('TB_O2O_ORDER_STATUS'),
			valueField:'val',
			textField:'name',
			panelHeight: 'auto',
		    cache: false
		});

		function withrefundorderSearch(){
			attr1 = $('#attr1').datetimebox('getValue');
			attr2 = $('#attr2').datetimebox('getValue');
			attr3 = $('#attr3').datetimebox('getValue');
			attr4 = $('#attr4').datetimebox('getValue');
			o2oLogisticsStatus = $('#o2oLogisticsStatus').combobox('getValue');
			o2oorderStatus = $('#o2oorderStatus').combobox('getValue');
			orderNumber = $('#orderNumber').val();
		  	$datagrid.datagrid('reload');
	  	 }

	  	 function withrefundorderClean(){
		   $('#attr1').datetimebox('setValue','');
		   $('#attr2').datetimebox('setValue','');
		   $('#attr3').datetimebox('setValue','');
		   $('#attr4').datetimebox('setValue','');
		   $('#o2oLogisticsStatus').combobox('setValue','');
		   $('#o2oorderStatus').combobox('setValue','');
		   $('#orderNumber').val('');
		   attr1 = null;
		   attr2 = null;
		   attr3 = null;
		   attr4 = null;
		   o2oLogisticsStatus = null;
		   o2oorderStatus = null;
		   orderNumber = null;
		   $datagrid.datagrid('reload');
	  	 }

	</script>
</body>
</html>