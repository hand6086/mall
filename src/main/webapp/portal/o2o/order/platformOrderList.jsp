<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
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
<body>
	<div id="menu_layout" class="easyui-layout" fit="true" border="false">
		<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:100%;padding:0px;">
			<fieldset class="x-fieldset" id="orderKeyFilter">
				<legend class="x-fieldset-header"
					style="width: 95px; margin-bottom: 0px; border: none;">
					<span class="x-fieldset-title">快速查询</span>
				</legend>
				<div class="row keyfilter-border">
					<table class="form-table">
					    <tr>
			   				<td class="td-label"><label>订单状态：</label></td>
							<td class="td-input">
								<input  class="easyui-combobox" name="attrib48" type="text" id="attrib48" size="25" />
							</td>
							
							<td class="td-label"><label>物流状态：</label></td>
							<td class="td-input">
								<input  class="easyui-combobox" name="attrib07" type="text" id="attrib07" size="25" />
							</td>
							
							<td class="td-label"><label>支付方式：</label></td>
							<td class="td-input">
								<input  class="easyui-combobox" name="o2oPayType" type="text" id="o2oPayType" size="25" />
							</td>
							
							<td class="td-label"><label>商户名称：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="merchantName" type="text" id="merchantName" size="25" />
							</td>
						</tr>
						<tr>	
							<td class="td-label"><label>下单时间从：</label></td>
							<td class="td-input">
								<input  class="easyui-datetimebox" name="tAttr13" type="text" id="tAttr13" size="25" />
							</td>
							
							<td class="td-label"><label>下单时间到：</label></td>
							<td class="td-input">
								<input  class="easyui-datetimebox" name="tAttr14" type="text" id="tAttr14" size="25" />
							</td>
							
							<td class="td-label"><label>订单编号：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="orderNum" type="text" id="orderNum" size="25" />
							</td>
							
							<td class="td-label"><label>收货人：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="contact" type="text" id="contact" size="25" />
							</td>
						</tr>
						<tr>	
							<td class="td-label"><label>收货时间从：</label></td>
							<td class="td-input">
								<input  class="easyui-datetimebox" name="attr1" type="text" id="attr1" size="25" />
							</td>
							
							<td class="td-label"><label>收货时间到：</label></td>
							<td class="td-input">
								<input  class="easyui-datetimebox" name="attr2" type="text" id="attr2" size="25" />
							</td>
							
							<td class="td-label"><label>付款时间从：</label></td>
							<td class="td-input">
								<input  class="easyui-datetimebox" name="attr3" type="text" id="attr3" size="25" />
							</td>
							
							<td class="td-label"><label>付款时间至：</label></td>
							<td class="td-input">
								<input  class="easyui-datetimebox" name="attr4" type="text" id="attr4" size="25" />
							</td>
						</tr>
						<tr>
							<td class="td-label"><label>收货人联系电话：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="contactPhone" type="text" id="contactPhone" size="25" />
							</td>
							
							<td class="td-label"><label>城市：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="attrib37" type="text" id="attrib37" size="25" />
							</td>
							
							<td class="td-label"><label>结算状态：</label></td>
							<td class="td-input">
								<input  class="easyui-combobox" name="attrib46" type="text" id="attrib46" size="25" />
							</td>
							
							<td class="td-label"><label>消费者名称：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="customerName" type="text" id="customerName" size="25" />
							</td>
			   			</tr>
						<tr>
							<td class="td-label"><label>消费者手机号码：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="mainPhNum" type="text" id="mainPhNum" size="25" />
							</td>
			   			</tr>
			   		</table>
			   	</div>
			</fieldset> 
			<table id="platformOrder-table" style="width:98%;height:515px;" singleSelect="true" rownumbers="true" 
					pagination="true" keyFilterDiv="orderKeyFilter">
				<thead>
					<tr>
						<th field="id" width="80px" noSearch="true" hidden="true">Id</th>
						
						<th field="o2oPayType" width="100px" lov="TB_O2O_PAY_TYPE">支付方式</th>
						<th field="attrib09" width="80px" lov="S_IF">是否O2O订单</th>
						<th field="merchantName" width="180px">商户名称</th>
						<th field="attrib48" width="100px" lov="TB_O2O_ORDER_STATUS">订单状态</th>
						<th field="attrib07" width="100px" lov="TB_O2O_LOGISTICS_STATUS">物流状态</th>
						<th field="attrib29" width="140px">收货时间</th>
						<th field="attrib22" width="100px">买赠优惠金额</th>
						<th field="created" width="140px">下单时间</th>
						<th field="cancelTime" width="140px">取消时间</th>
						<th field="cancelReason" width="140px">取消原因</th>
						<th field="orderNum" width="120px" formatter="orderFormatter">订单编号</th>
						<th field="attrib54" width="120px">外部订单编号</th>
						<th field="customerName" width="120px">消费者名称</th>
						<th field="customerOuNum" width="120px">消费者编码</th>
						<th field="mainPhNum" width="100px">消费者电话</th>
						<th field="attrib39" width="140px" lov="TB_O2O_STORE_NAME">店铺名称</th>
						<th field="contact" width="100px">收货人</th>
						<th field="contactPhone" width="100px">收货人电话</th>
						<th field="attrib36" width="120px">省/直辖市</th>
						<th field="attrib37" width="120px">城市</th>
						<th field="attrib38" width="120px">区/县</th>
						<th field="attrib01" width="180px" >详细地址</th>
						<th field="gpsLongitude" width="120px">GPS经度</th>
						<th field="gpsLatitude" width="120px">GPS纬度</th>
						<th field="attrib14" width="100px">商品总价</th>
						<th field="o2oTip" width="100px">小费</th>
						<th field="attrib21" width="100px">满减优惠金额</th>
						<th field="attrib16" width="100px">特价优惠金额</th>
						<th field="attrib20" width="100px">优惠券金额</th>
						<th field="offerSum" width="100px">优惠总金额</th>
						<th field="freight" width="100px">运费</th>
						<th field="attrib17" width="100px">订单总金额</th>
						<th field="attrib47" width="180px">买家留言</th>
						<th field="attrib40" width="100px" lov="TB_O2O_ORDER_DILIVER_TYPE">配送方式</th>
						<th field="merchantOuNum" width="100px">商户编码</th>
						<th field="o2oContactPhone" width="100px">商户电话</th>
						<th field="o2oStoreType" width="100px" lov="TB_O2O_STORE_TYPE">商户类型</th>
						<th field="distributor" width="180px">配送员</th>
						<th field="attrib42" width="100px">配送员电话</th>
						<th field="attrib44" width="100px" lov="TB_O2O_ORDER_TYPE">O2O订单分类</th>
						<th field="o2oForcedPickup" width="80px" lov="S_IF">是否兜底订单</th>
						<th field="attrib55" width="80px" lov="S_IF">是否秒杀订单</th>
						<th field="attrib50" width="80px" lov="S_IF">是否团购订单</th>
						<th field="attrib43" width="100px">校验码</th>
						<th field="attrib49" width="100px" lov="TB_O2O_CHECK_STATUS">校验状态</th>
						<th field="attrib26" width="140px">付款时间</th>
						<th field="attrib27" width="140px">接单时间</th>
						<th field="attrib28" width="140px">配送时间</th>
						<th field="attrib46" width="100px" lov="TB_O2O_SETTLEMENT_STATUS">结算状态</th>
						<th field="attrib53" width="130px" lov="TB_O2O_ORDER_SOURCE_SYSTEM">来源系统</th>
						<th field="typeName" width="120px" lov="FS_ORDER_TYPE">类型</th>
						<th field="attrib30" width="140px">第一轮推送时间</th>
						<th field="attrib31" width="140px">第二轮推送时间</th>
						<th field="attrib32" width="140px">第三轮推送时间</th>
						<th field="refuseRefundReason" width="150px">拒绝退款/取消理由</th>
						<th field="refuseRefundDate" width="140px">拒绝/确认取消时间</th>
						<th field="attrib59" width="120px">特价费用商户分摊</th>
						<th field="attrib23" width="120px">优惠券费用商户分摊</th>
						<th field="attrib25" width="120px">买赠费用商户分摊</th>
						<th field="attrib24" width="120px">满减费用商户分摊</th>
						<th field="merchantChargeSum" width="120px">商户分摊费用总额</th>
						<th field="chargeVerifivationSum" width="120px">需核销费用总额</th>
					</tr>
				</thead>
			</table>
			
			<table id="platformOrder-merchantDetail-table" style="width:98%;height:350px;" singleSelect="true" rownumbers="true" pagination="true">
				<thead>
					<tr>
						<th field="orderId" width="140px" noSearch="true" hidden="true">订单Id</th>
						<th field="id" width="80px" noSearch="true" hidden="true">Id</th>
						
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
						<th field="freight" width="100px">运费</th>
					</tr>
				</thead>
			</table>
			
			<table id="platformOrder-productDetail-table" style="width:98%;height:390px;" singleSelect="true" rownumbers="true" pagination="true">
				<thead>
					<tr>
						<th field="orderLineId" width="140px" noSearch="true" hidden="true">单品Id</th>
						
						<th field="o2oDisplayName" width="160px">单品名称</th>
						<th field="o2oIntCode" width="160px">单品编码</th>
						<th field="name" width="140px">单品产品名称</th>
						<th field="partNum" width="140px">单品产品编码</th>
						<th field="baseUnitPri" width="120px">报价</th>
						<th field="netPrice" width="100px">成交价</th>
						<th field="dealNumber" width="120px">成交数量</th>
						<th field="quotedPriceSum" width="120px">报价总金额</th>
						<th field="dealSum" width="120px">成交总金额</th>
						<th field="o2oMerchantDisplayName" width="120px">套装商品名称</th>
						<th field="o2oMerchantIntCode" width="120px">套装商品编码</th>
						<th field="orderOfferSum" width="120px">订单优惠金额分摊</th>
						<th field="merchantOfferSum" width="120px">商品优惠金额分摊</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<!-- 弹出窗 -->
    <div id="getOrderNumDetailWin" class="crmWin" style="width:100%;height:100%">
	    <iframe src=""  id="getOrderNumDetailWinFram" name="getOrderNumDetailWinFram" width="100%" height="100%" frameborder="0">
	    </iframe>
    </div>
	<script type="text/javascript">
		var attrib48 = null;
		var attrib07 = null;
		var o2oPayType = null;
		var merchantName = null;
		var tAttr13 = null;
		var tAttr14 = null;
		var orderNum = null;
		var contact = null;
		var contactPhone = null;
		var attrib37 = null;
		var attrib46 = null;
		var customerName = null;
		var mainPhNum = null;
		var attr1 = null;
		var attr2 = null;
		var attr3 = null;
		var attr4 = null;
		$getOrderNumDetailWinFram = $("#getOrderNumDetailWinFram");
		$getOrderNumDetailWin = $("#getOrderNumDetailWin");
		$datagrid = $('#platformOrder-table');
		$merchantDetaildatagrid = $('#platformOrder-merchantDetail-table');
		$productDetaildatagrid = $('#platformOrder-productDetail-table');
		
		$datagrid.hdatagrid({
					toolbarShow : true, //显示工具栏
					buttonSearch : false, //搜索框功能
					buttonMenu : true,
					oauthFlag : true,
					striped : true,
					buttonExport:true,
					border : false,
					nowrap:false,
					pageSize: 10, 
				    pageList: [10,20,50],
					subGridIds: ['platformOrder-merchantDetail-table'], 
					url : '${AppContext.ctxPath}/action/portal/order/platformOrder/queryByExamplePage',
					onBeforeLoad:function(param){
						if(attrib48 != null && attrib48 != ''){
				    		param.attrib48 = attrib48;
						}
						if(attrib07 != null && attrib07 != ''){
				    		param.attrib07 = attrib07;
						}
						if(o2oPayType != null && o2oPayType != ''){
				    		param.o2oPayType = o2oPayType;
						}
						if(merchantName != null && merchantName != ''){
				    		param.merchantName = merchantName;
						}
						if(tAttr13 != null && tAttr13 != ''){
				    		param.tAttr13 = tAttr13;
						}
						if(tAttr14 != null && tAttr14 != ''){
				    		param.tAttr14 = tAttr14;
						}
						if(orderNum != null && orderNum != ''){
				    		param.orderNum = orderNum;
						}
						if(contact != null && contact != ''){
				    		param.contact = contact;
						}
						if(contactPhone != null && contactPhone != ''){
				    		param.contactPhone = contactPhone;
						}
						if(attrib37 != null && attrib37 != ''){
				    		param.attrib37 = attrib37;
						}
						if(attrib46 != null && attrib46 != ''){
				    		param.attrib46 = attrib46;
						}
						if(customerName != null && customerName != ''){
				    		param.customerName = customerName;
						}
						if(mainPhNum != null && mainPhNum != ''){
				    		param.mainPhNum = mainPhNum;
						}
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
					},
					/**
					 * 导出前触发的事件，返回false则不导出
					 */
					onBeforeExport: function(param){
						//某些查询条件已输入,则不验证查询条件的开始时间、结束时间等条件(0验证 1不验证)
						var isNecessary = 0;
						attrib48 = $('#attrib48').combobox('getValue');
						attrib07 = $('#attrib07').combobox('getValue');
						o2oPayType = $('#o2oPayType').combobox('getValue');
						merchantName = $('#merchantName').val();
						tAttr13 = $('#tAttr13').datetimebox('getValue');
						tAttr14 = $('#tAttr14').datetimebox('getValue');
						attr1 = $('#attr1').datetimebox('getValue');
						attr2 = $('#attr2').datetimebox('getValue');
						attr3 = $('#attr3').datetimebox('getValue');
						attr4 = $('#attr4').datetimebox('getValue');
						orderNum = $('#orderNum').val();
						contact = $('#contact').val();
						contactPhone = $('#contactPhone').val();
						attrib37 = $('#attrib37').val();
						attrib46 = $('#attrib46').combobox('getValue');
						customerName = $('#customerName').val();
						mainPhNum = $('#mainPhNum').val();
						
						if(attrib48 != null && attrib48 != ''){
				    		param.attrib48 = attrib48;
				    		isNecessary = 1;
						}
						if(attrib07 != null && attrib07 != ''){
				    		param.attrib07 = attrib07;
				    		isNecessary = 1;
						}
						if(o2oPayType != null && o2oPayType != ''){
				    		param.o2oPayType = o2oPayType;
				    		isNecessary = 1;
						}
						if(attr1 != null && attr1 != ''){
				    		param.attr1 = attr1;
				    		isNecessary = 1;
						}
						if(attr2 != null && attr2 != ''){
				    		param.attr2 = attr2;
				    		isNecessary = 1;
						}
						if(attr3 != null && attr3 != ''){
				    		param.attr3 = attr3;
				    		isNecessary = 1;
						}
						if(attr4 != null && attr4 != ''){
				    		param.attr4 = attr4;
				    		isNecessary = 1;
						}
						if(merchantName != null && merchantName != ''){
				    		param.merchantName = merchantName;
				    		isNecessary = 1;
						}
						
						if(orderNum != null && orderNum != ''){
				    		param.orderNum = orderNum;
				    		isNecessary = 1;
						}
						if(contact != null && contact != ''){
				    		param.contact = contact;
				    		isNecessary = 1;
						}
						if(contactPhone != null && contactPhone != ''){
				    		param.contactPhone = contactPhone;
				    		isNecessary = 1;
						}
						if(attrib37 != null && attrib37 != ''){
				    		param.attrib37 = attrib37;
				    		isNecessary = 1;
						}
						if(attrib46 != null && attrib46 != ''){
				    		param.attrib46 = attrib46;
				    		isNecessary = 1;
						}
						if(customerName != null && customerName != ''){
				    		param.customerName = customerName;
				    		isNecessary = 1;
						}
						if(mainPhNum != null && mainPhNum != ''){
				    		param.mainPhNum = mainPhNum;
				    		isNecessary = 1;
						}
						
						if(tAttr13 != null && tAttr13 != ''){
				    		param.tAttr13 = tAttr13;
				    		isNecessary = 1;
						}

						if(tAttr14 != null && tAttr14 != ''){
				    		param.tAttr14 = tAttr14;
				    		isNecessary = 1;
						}

						if(isNecessary == 0){
							$.messager.alert("错误", "请输入至少一个查询条件！", "error");
							return false;
						}

						//验证时间
						var startDate = new Date(tAttr13);
						var endDate = new Date(tAttr14);
						var day = ((endDate.getTime() - startDate.getTime())/(1000 * 60 * 60 * 24));
						if(day > 30){
							 $.messager.alert("错误", "只能导出30天内的数据", "error");
							 return false;
						}
						return true;
					},
					onAddMoreButton:function(that,addButtonFun){
						addButtonFun(1,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="orderSearch()" iconCls="icon-search" plain="true">查询</a>',that);
						addButtonFun(2,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="orderClean()" iconCls="icon-reload" plain="true">重置</a>',that);
		 			}, 
				});
		
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
		
		$('#attrib48').combobox({ 
			method:'get',
			data:getLovArray('TB_O2O_ORDER_STATUS'),
			valueField:'val',
			textField:'name',
			panelHeight: 'auto',
		    cache: false
		});
		$('#attrib07').combobox({ 
			method:'get',
			data:getLovArray('TB_O2O_LOGISTICS_STATUS'),
			valueField:'val',
			textField:'name',
			panelHeight: 'auto',
		    cache: false
		});
		$('#o2oPayType').combobox({ 
			method:'get',
			data:getLovArray('TB_O2O_PAY_TYPE'),
			valueField:'val',
			textField:'name',
			panelHeight: 'auto',
		    cache: false
		});
		$('#attrib46').combobox({ 
			method:'get',
			data:getLovArray('TB_O2O_SETTLEMENT_STATUS'),
			valueField:'val',
			textField:'name',
			panelHeight: 'auto',
		    cache: false
		});
		
		function orderSearch(){
			attrib48 = $('#attrib48').combobox('getValue');
			attrib07 = $('#attrib07').combobox('getValue');
			o2oPayType = $('#o2oPayType').combobox('getValue');
			merchantName = $('#merchantName').val();
			tAttr13 = $('#tAttr13').datetimebox('getValue');
			tAttr14 = $('#tAttr14').datetimebox('getValue');
			attr1 = $('#attr1').datetimebox('getValue');
			attr2 = $('#attr2').datetimebox('getValue');
			attr3 = $('#attr3').datetimebox('getValue');
			attr4 = $('#attr4').datetimebox('getValue');
			orderNum = $('#orderNum').val();
			contact = $('#contact').val();
			contactPhone = $('#contactPhone').val();
			attrib37 = $('#attrib37').val();
			attrib46 = $('#attrib46').combobox('getValue');
			customerName = $('#customerName').val();
			mainPhNum = $('#mainPhNum').val();
			$datagrid.datagrid('reload');
	   }
	   
	   function orderClean(){
		  	$('#attrib48').combobox('setValue','');
		  	$('#attrib07').combobox('setValue','');
		  	$('#o2oPayType').combobox('setValue','');
			$('#merchantName').val('');
			$('#tAttr13').datetimebox('setValue','');
			$('#tAttr14').datetimebox('setValue','');
			$('#attr1').datetimebox('setValue','');
			$('#attr2').datetimebox('setValue','');
			$('#attr3').datetimebox('setValue','');
			$('#attr4').datetimebox('setValue','');
			$('#orderNum').val('');
			$('#contact').val('');
			$('#contactPhone').val('');
			$('#attrib37').val('');
			$('#attrib46').combobox('setValue','');
			$('#customerName').val('');
			$('#mainPhNum').val('');
			attrib48 = null;
			attrib07 = null;
			o2oPayType = null;
			merchantName = null;
			tAttr13 = null;
			tAttr14 = null;
			attr1 = null;
			attr2 = null;
			attr3 = null;
			attr4 = null;
			orderNum = null;
			contact = null;
			contactPhone = null;
			attrib37 = null;
			attrib46 = null;
			customerName = null;
			mainPhNum = null;
			$datagrid.datagrid('reload');
	   }
	   
		$merchantDetaildatagrid.hdatagrid({
					toolbarShow : true, 
					buttonSearch : true, 
					buttonMenu : true,
					oauthFlag : false,
					striped : true,
					nowrap:false,
					title : '商品详情',
					border : false,
					pageSize: 10, 
				    pageList: [10,20,50], 
					parentGridId : 'platformOrder-table',
					parentGridField : 'id',
					linkGridField : 'orderId',
					subGridIds: ['platformOrder-productDetail-table'], 
					url : '${AppContext.ctxPath}/action/portal/order/platformOrder/queryMerchantByPage',
				});
		
		$productDetaildatagrid.hdatagrid({
					toolbarShow : true, 
					buttonSearch : true, 
					buttonMenu : true,
					oauthFlag : false,
					striped : true,
					nowrap:false,
					title : '单品详情',
					border : false,
					pageSize: 10, 
				    pageList: [10,20,50], 
					parentGridId : 'platformOrder-merchantDetail-table',
					parentGridField : 'id',
					linkGridField : 'orderLineId',
					url : '${AppContext.ctxPath}/action/portal/order/platformOrder/queryProductByPage',
				});

	</script>
</body>
</html>