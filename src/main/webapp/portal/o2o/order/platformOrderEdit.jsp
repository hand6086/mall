<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<head>
</head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" /> 
<%@ include file="/portal/header.jsp" %>
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/ue/themes/default/css/umeditor.css?version=<%=version%>">
<script type="text/javascript" src="${AppContext.ctxPath}/static/ue/third-party/template.min.js?version=<%=version%>"></script>
<script type="text/javascript" src="${AppContext.ctxPath}/static/ue/umeditor.config.js?version=<%=version%>" charset="utf-8" ></script>
<script type="text/javascript" src="${AppContext.ctxPath}/static/ue/umeditor.min.js?version=<%=version%>" charset="utf-8" ></script>
<style type="text/css">
#typeTable{
	
	width:1000px;
	margin: 20px auto;
}
.td-label{
	font-size:14px;
	font-weight:200;
	text-align:right;
	height:30px;
}
.td-input{
	width:180px;
	height:20px;
}
#form {
	width: 1000px;
	margin: 30px auto;
}
</style>
<body> 
<div class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north'" collapsible="false" border="false" style="width:100%;height:100%;padding:0px;" title="">
			<table id="typeTable" style="width: 100%; height: 80px;">
		       	<tr>
		       		<td width="120" class="td-label"><label>订单号：</label></td>
		       		<td width="100">
		       			<input id="orderNum" name="orderNum" disabled size="25" class="easyui-validatebox td-input" />
		       		</td>
		       		
		       		<td width="120" class="td-label"><label>外部订单编号：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="attrib54" name="temp_attrib54" disabled size="25" class="easyui-validatebox td-input" />
		       		</td>
		       	</tr>
		       	<tr>
		       		<td width="120" class="td-label"><label>订单状态：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="attrib48" name="temp_attrib48" disabled size="25" class="easyui-combobox td-input" />
		       		</td>
		       		
		       		<td width="120" class="td-label"><label>物流状态：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="attrib07" name="temp_attrib07" disabled size="25" class="easyui-combobox td-input" />
		       		</td>
		       	</tr>
		       	
		       	<tr>
		       		<td width="120" class="td-label"><label>订单推送备注：&nbsp;</label></td>
		       		<td colspan="3">
		       			<input id="orderProMsg" name="orderProMsg" disabled size="100" class="easyui-validatebox td-input" />
		       		</td>
		       	</tr>
		    </table>
		<div style="float: right; margin-top: 7px; margin-right: 30px; margin-bottom: 20px;">
			<a href="###" class="easyui-linkbutton" iconCls="icon-undo" onclick="cancel()">返回&nbsp;&nbsp;&nbsp;</a> 
		</div>
		<div id="platformOrder-tabs" class="easyui-tabs" style="width: 100%; height: 415px;" data-options="border:false">
				<div title="订单推送记录" href="${AppContext.ctxPath}/portal/o2o/order/orderPushRecordList.jsp?orderNum=${result.rows.orderNum}&objectId=${result.rows.id}"></div>
				<div title="订单评价" href="${AppContext.ctxPath}/portal/o2o/order/orderEvaluationList.jsp?orderId=${result.rows.id}"></div>
				<div title="订单促销活动" href="${AppContext.ctxPath}/portal/o2o/order/orderPromotionsList.jsp?orderId=${result.rows.id}"></div>
		</div>
	</div>
</div>   

<script type="text/javascript">
$(document).ready(function() { 
	$('#orderNum').val('${result.rows.orderNum}');
	$('#attrib54').val('${result.rows.attrib54}');
	$('#attrib48').combobox('setValue','${result.rows.attrib48}');
	$('#attrib07').combobox('setValue','${result.rows.attrib07}');
	$('#orderProMsg').val('${result.rows.orderProMsg}');
}); 

$('#attrib48').combobox({ 
    method:'get',
	data:getLovArray('TB_O2O_ORDER_STATUS'),
	valueField:'val',
	textField:'name',
    editable:false, //不可编辑状态
    panelHeight: 'auto',//自动高度适合
    cache: false
});

$('#attrib07').combobox({ 
    method:'get',
	data:getLovArray('TB_O2O_LOGISTICS_STATUS'),
	valueField:'val',
	textField:'name',
    editable:false, //不可编辑状态
    panelHeight: 'auto',//自动高度适合
    cache: false
});
function cancel(){
	window.parent.closeOrderNumDetailWin();
}
</script>
</body>
</html>