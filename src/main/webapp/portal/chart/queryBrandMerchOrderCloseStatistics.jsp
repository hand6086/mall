<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>

<style type="text/css">
.form-table {
	margin: 5px auto;
	width: 100%;
}

.td-label {
	width: 180px;
	font-size: 14px;
	text-align: right;
	height: 30px;
}

.td-content input {
	width: 162px;
}
</style>

<body>
<div  class="easyui-layout" data-options="fit:true" border="false">
   <div data-options="region:'north',split:true" fit="true" border="false">
   <fieldset class="x-fieldset" id="brandMerchOrderCloseKeyFilter">
		<legend class="x-fieldset-header" style="width: 95px; margin-bottom: 0px; border: none;">
			<span class="x-fieldset-title">快速查询</span>
		</legend>
		<div class="row keyfilter-border">
	   		<table class="form-table">
			    <tr>
					<td class="td-label"><label>开始时间：</label></td>
					<td class="td-input">
						<input  class="easyui-datetimebox" name="startTime" type="text" id="startTime" size="25" />
					</td>
					
					<td class="td-label"><label>结束时间：</label></td>
					<td class="td-input">
						<input  class="easyui-datetimebox" name="endTime" type="text" id="endTime" size="25" />
					</td>
				</tr>
				<tr>
					<td class="td-label"><label>商家名称 ：</label></td>
					<td class="td-content">
						<input type="text" id="merchName" name="merchName" />
					</td>
					<td class="td-label"><label>订单关闭原因 ：</label></td>
					<td class="td-content">
						<input type="text" id="orderCloseCause" name="orderCloseCause" />
					</td>
					
				</tr>
	   		</table>
	   	</div>
	</fieldset>
   <table id="brand-merch-order-close-table" singleSelect="true" rownumbers="true"  pagination="true" fit="true" keyFilterDiv="brandMerchOrderCloseKeyFilter">
		<thead>
			<tr>
				<th field="merchName" width="150px">商家名称</th>
				<th field="orderStatus" width="150px">订单状态</th>
				<th field="orderCloseCause" width="150px">订单关闭原因</th>
				<th field="orderNumber" width="150px">订单数量</th>
			</tr>
		</thead>
	</table>
	</div>
	</div>
   
	<script type="text/javascript">

		var curr_time=Math.round(new Date()/1000);
		
		var startDate = timestampToTime(curr_time - 60*60);
		var endDate = timestampToTime(curr_time);
	
		var startTime = startDate;
		var endTime = endDate;
		
		var merchName = null;
		var orderCloseCause = null;

		$(function()  
	   		{     
	   		    $('#startTime').datetimebox('setValue',startDate);
	   		    $('#endTime').datetimebox('setValue',endDate);
	
	   			startTime = $('#startTime').datetimebox('getValue');
			   	endTime = $('#endTime').datetimebox('getValue');
	   		});
		
	    $datagrid = $('#brand-merch-order-close-table');
		$datagrid.hdatagrid({
			updateable:false,
			toolbarShow:true,
			buttonSearch:false,
			buttonNew:false,
			buttonDelete:false,
			buttonExport:true,
			buttonMenu:true,
			menuButtonCount : true,
			newDefaultValue:true,
			oauthFlag:false, //安全性
			striped:true,
			nowrap:false, //换行
			border:false,
			url:'${AppContext.ctxPath}/action/portal/brandMerchOrderCloseStatistics/queryByExamplePage',
			
			onBeforeLoad:function(param){
				if(startTime != null && startTime != ''){
		    		param.startTime = startTime;
				}
				if(endTime != null && endTime != ''){
		    		param.endTime = endTime;
				}
				if(merchName != null && merchName != ''){
		    		param.merchName = merchName;
				}
				if(orderCloseCause != null && orderCloseCause != ''){
		    		param.orderCloseCause = orderCloseCause;
				}
				
			},
			
 			 onAddMoreButton:function(that,addButtonFun){
 				addButtonFun(1,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="brandMerchOrderCloseSearch()" iconCls="icon-search" plain="true">查询</a>',that);
 				addButtonFun(2,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="brandMerchOrderCloseClean()" iconCls="icon-reload" plain="true">重置</a>',that);
 			 } 
		});
		
		function brandMerchOrderCloseSearch(){
			
		   	startTime = $('#startTime').datetimebox('getValue');
		   	endTime = $('#endTime').datetimebox('getValue');
		   	merchName = $('#merchName').val();
		   	orderCloseCause = $('#orderCloseCause').val();
		   	
		   	$datagrid.datagrid('reload');
		}
		
		function brandMerchOrderCloseClean(){
			   $('#merchName').val('');
			   $('#orderCloseCause').val('');
			   
			   merchName = null;
			   orderCloseCause = null;
			   
			   $datagrid.datagrid('reload');
		  	 }
		
		function timestampToTime(timestamp) {
	        var date = new Date(timestamp * 1000);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
	        Y = date.getFullYear() + '-';
	        M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
	        D = date.getDate() + ' ';
	        h = date.getHours() + ':';
	        m = date.getMinutes() + ':';
	        s = date.getSeconds();
	        return Y+M+D+h+m+s;
	    }
	
	</script>
</body>
</html>