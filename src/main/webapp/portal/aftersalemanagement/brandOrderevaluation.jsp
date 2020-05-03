<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true" border="false">
 <div data-options="region:'north',split:true" fit="true" border="false">
   <div  border="false" style="height:347px;width:100%">
	<table id="OrderEvaluation-table" fit="true" >
		<thead>
			<tr>
				<th field="orderRate" width="130px" lov="TB_O2O_APPRAISE_RATE">订单评级</th>							
				<th field="context" width="150px" >具体评价内容</th>
				<th field="isPositive" width="150px" >是否正面评价</th>
				<th field="orderCreated" width="150px" >评价时间</th>
				<th field="type" width="150px" lov="TB_O2O_EVALU_LBL_TYPE">类型</th>
				<th field="orderNumber" width="150px" >订单编号</th>
				<th field="customerName" width="150px" >消费者名称</th>
				<th field="customerCode" width="150px" >消费者编码</th>
				<th field="customerPhoneNumber" width="150px" >消费者电话</th>
				<th field="receiverName" width="150px" >收货人</th>
				<th field="receiverPhone" width="150px" >收货人电话</th>
				<th field="receiverProvince" width="150px" >省/直辖市</th>
				<th field="receiverCity" width="150px" >城市</th>
				<th field="receiverDistrict" width="150px" >区/县</th>
				<th field="receiverAddress" width="150px" >详细地址</th>
				<!-- <th field="dSRName" width="150px" >商户名称</th>
				<th field="dSRCode" width="150px" >商户编码</th>
				<th field="storeCellphone" width="150px" >商户电话</th> -->
				<th field="orderDate" width="150px" >下单时间</th>
				<th field="payBillTime" width="150px" >付款时间</th>
				<th field="orderPickedTime" width="150px" >接单时间</th>
				<th field="startDeliveryTime" width="150px" >配送时间</th>
				<th field="receivedTime" width="150px" >收货时间</th>
				
			</tr>
		</thead>
	</table>
 </div>
	<div  border="false" style="width:100%;height:347px;">
		<table id="WithRefundOrder-table-goods" fit="true" >
			<thead>
				<tr>
				    <th field="id" width="100px">id</th>
				    <th field="evaLabelName" width="100px">评价标签名称</th>
				</tr>
			</thead>
		</table>
		</div>
	</div>
   		
	<script type="text/javascript">
	   $datagrid = $('#OrderEvaluation-table');
	   $dataItemgrid=$('#WithRefundOrder-table-goods');
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			pageSize: 10,//每页显示的记录条数，默认为20 
		    pageList: [10,30,50],//可以设置每页记录条数的列表
		    subGridIds: ['WithRefundOrder-table-goods'],
			url:'${AppContext.ctxPath}/action/portal/orderevaluation/brandQueryByExamplePage',
			onBeforeLoad:function(param){
				param.type = 'Service Evaluate';
			}
		});
		$dataItemgrid.hdatagrid({
			
			pagination:true,
			toolbarShow:true,
			buttonSearch:true,
			pageSize: 10,//每页显示的记录条数，默认为20 
		    pageList: [10,30,50],//可以设置每页记录条数的列表
		    parentGridId : 'WithRefundOrder-table',
		    parentGridField : 'id',
		    linkGridField : 'evaluateId',
			 url:'${AppContext.ctxPath}/action/portal/orderevaluation/queryevaluationPage',
			 onBeforeLoad:function(param){
					param.type = 'Service Evaluate';
				}
		});
	
		
	
		
	</script>
</body>
</html>