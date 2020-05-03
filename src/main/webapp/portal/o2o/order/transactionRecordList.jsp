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
 		   <fieldset class="x-fieldset" id="transactionRecordKeyFilter">
				<legend class="x-fieldset-header" style="width: 95px; margin-bottom: 0px; border: none;">
					<span class="x-fieldset-title">快速查询</span>
				</legend>
		
				<div class="row keyfilter-border">
					<table class="form-table">
					    <tr>
			   				<td class="td-label"><label>交易时间从：</label></td>
							<td class="td-input">
								<input  class="easyui-datetimebox" name="attr1" type="text" id="attr1" size="25" />
							</td>
							
							<td class="td-label"><label>交易时间到：</label></td>
							<td class="td-input">
								<input  class="easyui-datetimebox" name="attr2" type="text" id="attr2" size="25" />
							</td>
							<td class="td-label"><label>支付方式：</label></td>
							<td class="td-input">
								<input  class="easyui-combobox" name="type" type="text" id="type" size="25" />
							</td>
							
						</tr>
					    <tr>	
					    	<td class="td-label"><label>交易类型：</label></td>
							<td class="td-input">
								<input  class="easyui-combobox" name="tAttr01" type="text" id="tAttr01" size="25" />
							</td>
							
							
							
							<td class="td-label"><label>状态：</label></td>
							<td class="td-input">
								<input  class="easyui-combobox" name="attr5" type="text" id="attr5" size="25" />
							</td>
							
							<td class="td-label"><label>交易金额：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="attr3" type="text" id="attr3" size="25" />
							</td>
			   			
							
			   			</tr>
					    <tr>	
							<td class="td-label"><label>交易流水号：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="attr4" type="text" id="attr4" size="25" />
							</td>
							
							<td class="td-label"><label>订单编号：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="orderNum" type="text" id="orderNum" size="25" />
							</td>
							
							<td class="td-label"><label>联系人电话：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="o2oContactPhone" type="text" id="o2oContactPhone" size="25" />
							</td>
			   			</tr>
					    <!-- <tr>	
							<td class="td-label"><label>物流状态：</label></td>
							<td class="td-input">
								<input  class="easyui-combobox" name="attrib07" type="text" id="attrib07" size="25" />
							</td>
			   			</tr> -->
			   		</table>
					<!-- <ul id="transactionRecord-type-keyfilter" data-toggle="keyfilter"
						data-title="交易类型" data-filter-filed="tAttr01" data-table-Id="transactionRecord-table">
					</ul>
					<ul id="transactionRecord-status-keyfilter" data-toggle="keyfilter"
						data-title="状态" data-filter-filed="status" data-table-Id="transactionRecord-table">
					</ul>
					<ul id="transactionRecord-payType-keyfilter" data-toggle="keyfilter"
						data-title="支付方式" data-filter-filed="type" data-table-Id="transactionRecord-table">
					</ul> -->
				</div>
			</fieldset>
			<table id="transactionRecord-table" style="width:100%;height:100%;" keyFilterDiv="transactionRecordKeyFilter" singleSelect="true" rownumbers="true" pagination="true">
				<thead>
					<tr>
						<th field="created" width="140px">交易时间</th>
						<th field="tAttr01" width="80px" lov="TB_O2O_TRANSACTION_TYPE">交易类型</th>
						<th field="status" width="120px" lov="TB_O2O_PAYMENT_STATUS">状态</th>
						<th field="paymentAcct" width="200px">支付账号</th>
						<th field="receiveAcct" width="200px">收款账号</th>
						<th field="amount" width="140px">交易金额</th>
						<th field="orderNum" width="120px">订单编号</th>
						<th field="city" width="140px">城市</th>
						<th field="orderTime" width="140px">下单时间</th>
						<th field="attrib29" width="140px">收货时间</th>
						<th field="attrib48" width="120px" lov="TB_O2O_ORDER_STATUS">订单状态</th>
						<th field="attrib07" width="120px" lov="TB_O2O_LOGISTICS_STATUS">物流状态</th>
						<th field="name" width="140px">商户名称</th>
						<th field="ouNum" width="120px">商户编码</th>
						<th field="o2oContact" width="100px">联系人</th>
						<th field="o2oContactPhone" width="100px">联系人电话</th>
						<th field="o2oAlipay" width="120px">支付宝账号</th>
						<th field="o2oAccontName" width="120px">开户人</th>
						<th field="o2oBank" width="180px">发卡银行</th>
						<th field="o2oCreditCard" width="180px">银行卡号</th>
						<th field="paymentNumber" width="200px">支付流水号</th>
						<th field="type" width="120px" lov="TB_O2O_PAYMENT_TYPE">支付方式</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<script type="text/javascript">
		var attr1 = null;
		var attr2 = null;
		var attr3 = null;
		var attr4 = null;
		var tAttr01 = null;
		var attr5 = null;
		var type = null;
		var orderNum = null;
		var o2oContactPhone = null;
	
		$datagrid = $('#transactionRecord-table');
		
		$datagrid.hdatagrid({
					toolbarShow : true, //显示工具栏
					buttonSearch : false, //搜索框功能
					buttonExport : true,
					buttonMenu : true,
					oauthFlag : true,
					striped : true,
					title : '',
					border : false,
					url : '${AppContext.ctxPath}/action/portal/order/transactionRecord/queryByExamplePage',
					
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
						if(tAttr01 != null && tAttr01 != ''){
				    		param.tAttr01 = tAttr01;
						}
						if(attr5 != null && attr5 != ''){
				    		param.attr5 = attr5;
						}
						if(type != null && type != ''){
				    		param.type = type;
						}
						if(orderNum != null && orderNum != ''){
				    		param.orderNum = orderNum;
						}
						
						if(o2oContactPhone != null && o2oContactPhone != ''){
							param.o2oContactPhone = o2oContactPhone;
						}
					},
					
					onAddMoreButton:function(that,addButtonFun){
		 				addButtonFun(1,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="transactionSearch()" iconCls="icon-search" plain="true">查询</a>',that);
						addButtonFun(2,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="transactionClean()" iconCls="icon-reload" plain="true">重置</a>',that);
					},
				});
		
		$('#transactionRecord-type-keyfilter').keyFilter({
			remoteData:true,
			filterByValue:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/TB_O2O_TRANSACTION_TYPE'
		});
		
		$('#transactionRecord-status-keyfilter').keyFilter({
			remoteData:true,
			filterByValue:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/TB_O2O_PAYMENT_STATUS'
		});
		
		$('#transactionRecord-payType-keyfilter').keyFilter({
			remoteData:true,
			filterByValue:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/TB_O2O_PAYMENT_TYPE'
		});
		
		$('#tAttr01').combobox({ 
			method:'get',
			data:getLovArray('TB_O2O_TRANSACTION_TYPE'),
			valueField:'val',
			textField:'name',
			panelHeight: 'auto',
		    cache: false
		});
		
		$('#attr5').combobox({ 
			method:'get',
			data:getLovArray('TB_O2O_PAYMENT_STATUS'),
			valueField:'val',
			textField:'name',
			panelHeight: 'auto',
		    cache: false
		});
		
		$('#type').combobox({ 
			method:'get',
			data:getLovArray('TB_O2O_PAYMENT_TYPE'),
			valueField:'val',
			textField:'name',
			panelHeight: 'auto',
		    cache: false
		});
		
		
		function transactionSearch(){
			
			attr1 = $('#attr1').datetimebox('getValue');
			attr2 = $('#attr2').datetimebox('getValue');
			attr3 = $('#attr3').val();
			attr4 = $('#attr4').val();
			tAttr01 = $('#tAttr01').combobox('getValue');
			attr5 = $('#attr5').combobox('getValue');
			type = $('#type').combobox('getValue');
			orderNum = $('#orderNum').val();
			
			o2oContactPhone = $('#o2oContactPhone').val();
		  	$datagrid.datagrid('reload');
	  	 }
		
	  	 function transactionClean(){
		   $('#attr1').datetimebox('setValue','');
		   $('#attr2').datetimebox('setValue','');
		   $('#attr3').val('');
		   $('#attr4').val('');
		   $('#tAttr01').combobox('setValue','');
		   $('#attr5').combobox('setValue','');
		   $('#type').combobox('setValue','');
		   $('#orderNum').val('');
		   $('#o2oContactPhone').val('');
		   attr1 = null;
		   attr2 = null;
		   attr3 = null;
		   attr4 = null;
		   tAttr01 = null;
		   attr5 = null;
		   type = null;
		   orderNum = null;
		   o2oContactPhone = null;
		   $datagrid.datagrid('reload');
	  	 }
		
	</script>
</body>
</html>