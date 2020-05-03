<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<script src="${AppContext.ctxPath}/static/js/content_zoom.js"></script>
<style type="text/css">
.form-table{
	margin: 5px auto; 
	width: 100%;
}
.table-block {
	margin: 5px auto;
	width:100%;
}
fieldset{
	margin: 0px 0px 0px 0px;
	width:100%;
}
legend{
	font-size: 16px;
	margin: 20px auto auto 20px;
}
.td-label {
	width:120px;
	font-size: 14px;
	text-align: right;
	height: 30px;
}
.td-content {
	padding-right:6px;
}
.td-content input,textarea{
	width:180px;
	border:none;
}
input:disabled,textarea:disabled
{
background:#ffffff;
color: #29303F;
}
</style>
<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'north',split:true,collapsible:false"
			 border="false" style="width:100%;height:100%;">
			<div id="header" class="easyui-panel" style="height:45%">
				<legend>订单信息</legend>
				<form id="orderForm">
					<table class="form-table">
						<tr>
							<td>
								<table class="table-block" >							
									<tr>
										<td class="td-label"><label>商家名称： </label></td>
										<td class="td-content">
											<input id="storeName" name="storeName" disabled/>
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>消费者： </label></td>
										<td class="td-content">
											<input id="customerName" name="customerName" disabled/>
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>订单总金额： </label></td>
										<td class="td-content">
											<input id="orderTotalPrice" name="orderTotalPrice" disabled/>
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>订单状态： </label></td>
										<td class="td-content">
											<input id="orderStatusName" name="orderStatusName" disabled/>
										</td>
									</tr>
									<tr class="cancelStatus" hidden>
										<td class="td-label"><label>取消时间： </label></td>
										<td class="td-content">
											<input id="refuseRefundDate" name="refuseRefundDate" disabled/>
										</td>
									</tr>
									<tr rowspan="2">
										<td colspan="6" style="padding: 10px 20px 0 60px;">
											<a href="javascript:void(0)" style="background-color: #e0ecff; width: 80px;" class="easyui-linkbutton cancel" plain="true">返回</a>
										</td>
									</tr>
								</table>
							</td>
							<td>
								<table class="table-block" >							
									<tr>
										<td class="td-label"><label>订单编号： </label></td>
										<td class="td-content">
											<input id="orderNum" name="orderNum" disabled/>
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>消费者联系电话： </label></td>
										<td class="td-content">
											<input id="mainPhNum" name="mainPhNum" disabled/>
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>优惠总金额： </label></td>
										<td class="td-content">
											<input id="offerSum" name="offerSum" disabled/>
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>下单时间： </label></td>
										<td class="td-content">
											<input id="orderTime" name="orderTime" disabled/>
										</td>
									</tr>
									<tr class="cancelStatus" hidden>
										<td class="td-label"><label>取消原因： </label></td>
										<td class="td-content">
											<input id="cancelReason" name="cancelReason" disabled/>
										</td>
									</tr>
								</table>
							</td>
							<td>
								<table class="table-block" >							
									<tr rowspan="2">
										<td class="td-label"><label>买家留言： </label></td>
										<td class="td-content">
											<textarea id="customerMsg" name="customerMsg" 
												style="height: 50px;margin-bottom: 8px;" disabled></textarea>
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>运费： </label></td>
										<td class="td-content">
											<input id="freight" name="freight" disabled/>
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>付款时间： </label></td>
										<td class="td-content">
											<input id="attrib26" name="attrib26" disabled/>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div id="goods-tabs" class="easyui-tabs" style="width: 100%;height: 55%;" data-options="border:false">
				<div title="商品信息">
					<table id="orderDetail-table" singleSelect="true" rownumbers="true"  pagination="true" fit="true">
						<thead>
							<tr>
								<th field="merchPic" width="100px" formatter="imageFormatter">商品图片</th>
								<th field="merchName" width="100px">商品名称</th>
								<th field="price" width="80px">报价</th>
								<th field="qty" width="80px">数量</th>
								<th field="attrib17" width="80px">报价总金额</th>
								<th field="pmoPrice" width="80px">成交价</th>
								<th field="tAttr19" width="80px">成交金额</th>
								<th field="attrib11" width="80px" lov="S_IF">是否赠品</th>
								<th field="activityName" width="80px">促销活动名称</th>
								<th field="merchantOfferSum" width="80px">优惠总金额</th>
								<th field="freight" width="80px">运费</th>
							</tr>
						</thead>
					</table>
					<div id="bigImg" style="display: none;">
						<img id="popUpImg"/>
					</div>
				</div>
				<div title="收货及物流信息">
					<form id="recieverFrom">
						<table class="table-block" >							
							<tr rowspan="2" class="toDelivery" hidden>
								<td colspan="6" style="padding: 20px 20px 20px 55px;">
									<a href="javascript:void(0)" style="background-color: #e0ecff; width: 80px;" class="easyui-linkbutton" 
									onclick="javascript:$('#dlg').dialog('open')" plain="true">订单发运</a>
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>收货人： </label></td>
								<td class="td-content">
									<input id="storeName" name="recieverName" disabled/>
								</td>
								
								<td class="td-label"><label>收货人电话： </label></td>
								<td class="td-content">
									<input id="storeName" name="recieverPhone" disabled/>
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>收货地址： </label></td>
								<td class="td-content" colspan="6">
									<input style="width: 572px;" id="addressAll" name="addressAll" disabled/>
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>物流公司： </label></td>
								<td class="td-content">
									<input id="logisticsCompany" name="logisticsCompany" disabled/>
								</td>
								<td class="td-label"><label>物流单号： </label></td>
								<td class="td-content">
									<input id="logisticsOddNumber" name="logisticsOddNumber" disabled/>
								</td>
								<td class="td-label"><label>发运时间： </label></td>
								<td class="td-content">
									<input id="shippingTime" name="shippingTime" disabled/>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div id="dlg" class="easyui-dialog" title="请填写订单发运信息" data-options="closed:true,buttons:'#dlg-buttons'" style="width:350px;height:200px">
		<form id="orderDelForm" method="post">
			<table>
				<tr>
					<td class="td-label"><label>物流公司 </label></td>
					<td class="td-content">
						<input  class="easyui-combobox" name="logisticsCompany1" type="text" id="logisticsCompany1" required="true"/>
					</td>
				</tr>
				<tr>
					<td class="td-label"><label>物流单号</label></td>
					<td class="td-content">
						<input  class="easyui-numberbox" name="logisticsOddNumber1" type="text" id="logisticsOddNumber1" data-options="min:0,
																					precision:0,required:true"/>
					</td>
				</tr>
				<tr>
					<td class="td-label"><label>发运时间</label></td>
					<td class="td-content">
						<input class="easyui-datetimebox" name="shippingTime1" id="shippingTime1">
					</td>
				</tr>
			</table>
		</form>
    </div>
    <div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="save()">确定</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#dlg').dialog('close')">取消</a>
	</div>

	<script type="text/javascript">
	var orderId = "${param.orderId}";
	$dlg = $('#dlg');
	function infoInit(orderId, refreshDatagrid){
		if(!orderId){
			$.messager.alert("错误","参数错误, 无法获取商品id", "error");
			return;
		}else if(orderId == "current"){
			orderId = initId;
		}
		initId = orderId;
		var order = {};
		$.post("${AppContext.ctxPath}/action/portal/order/queryById",{id:initId},
			function(data){
				if(data){
					if(data.success){
						order = data.result;
						if(order.orderStatus == 'Cancelling' || order.orderStatus == 'Cancelled'
												   || order.orderStatus == 'Tran_Closed'){
							$(".cancelStatus").attr("hidden",false);
						}else{
							$(".cancelStatus").attr("hidden",true);
						}
						if(order.orderStatus == 'To Deliver'){
							$(".toDelivery").attr("hidden",false);
						}else{
							$(".toDelivery").attr("hidden",true);
						}
						$("#orderForm").form("load", order);
						order.logisticsCompany = getLovShowName('LOGISTICS_COMPANY', order.logisticsCompany);
						$("#recieverFrom").form("load", order);
					}
				}
			});
		if(refreshDatagrid){
		}
	}
	
	
	$(".cancel").click(function(){
		window.parent.closeDetailWin();
	}); 
	
	$("#logisticsCompany1").combobox({
		data : getLovArray('LOGISTICS_COMPANY'),
		valueField : 'val',
		textField : 'name',
		editable : false, //不可编辑状态
		cache : false
	});
	
	function save(){
		   if(!orderId){
			   window.parent.operationtip('请选择需要更新的数据!', 'error');
			   return;
		   }
		   if($('#shippingTime1').datetimebox('getValue') == null || $('#shippingTime1').datetimebox('getValue') == ''){
			    var curr_time=new Date();     
			    var strDate=curr_time.getFullYear()+"-";     
			    strDate +=curr_time.getMonth()+1+"-";     
			    strDate +=curr_time.getDate()+"-";     
			    strDate +=" "+curr_time.getHours()+":";     
			    strDate +=curr_time.getMinutes()+":";     
			    strDate +=curr_time.getSeconds();
			   $('#shippingTime1').datetimebox('setValue',strDate);
		   }
		   var logisticsCompany = $("#logisticsCompany1").combobox('getValue');
		   var logisticsOddNumber = $("#logisticsOddNumber1").numberbox('getValue');
		   var shippingTime = $("#shippingTime1").datetimebox('getValue');
		   var options = {
					url : '${AppContext.ctxPath}/action/portal/order/update',
					type : 'post',
					dataType :'json',
					data: {
						'id': orderId,
						'brandUpdate' : '1',
						'orderStatus':'To Receive',
						'logisticsStatus':'Delivered',
						'logisticsCompany':logisticsCompany,
						'logisticsOddNumber':logisticsOddNumber,
						'shippingTime':shippingTime,
		            },
					beforeSubmit: function() {
						var result = $("#orderDelForm").form('validate');
						return result;
					},  
					success : function(data) {
						if (data.success) {
							$dlg.dialog('close');
							$("#orderDelForm").form('clear');
							window.parent.operationtip('发运信息更新成功！', 'info');
							logisticsCompany = getLovShowName('LOGISTICS_COMPANY', logisticsCompany);
							$("#logisticsCompany").val(logisticsCompany);
							$("#logisticsOddNumber").val(logisticsOddNumber);
							$("#shippingTime").val(shippingTime);
							$("#orderStatusName").val('待签收');
							$(".toDelivery").attr("hidden",true);
						} else {
							window.parent.operationtip(data.result, 'error');
						}
					}
				};
		   $("#orderDelForm").ajaxSubmit(options);
	   }
	
	$detaildatagrid = $('#orderDetail-table');
	$detaildatagrid.hdatagrid({
		toolbarShow : true, 
		buttonSearch : true, 
		buttonMenu : true,
		oauthFlag : true,
		striped : true,
		border : false,
		pageSize: 10, 
	    pageList: [10,20,50], 
		url : '${AppContext.ctxPath}/action/portal/orderItem/queryByExamplePage',
		onBeforeLoad:function(param){
			if(!orderId){
	    		param.headId = "noMatchId";
	    		param. brandQuery="1";
	    	}else{
	    		param.headId = orderId;
	    		param. brandQuery="1";
	    	}
		},
		
		onLoadSuccess: function (data) {
	        //调用图片展示组件
	        $('div.small_pic a').fancyZoom({scaleImg: true, closeOnClick: true});
	    },
	});
	
	function imageFormatter(val,row){   
		var imgUrl_A = "<div class=\"small_pic\"><a href=\"#bigImg\"> <img height=\"50\" src=\"";
		var imgUrl_B = "\" /></a></div>";
		if(val)
		{
			return imgUrl_A +row.merchPic +imgUrl_B;
		} 
		return imgUrl_A + "${AppContext.ctxPath}/static/images/404.jpg" + imgUrl_B;
	}
    </script>

</body>
</html>