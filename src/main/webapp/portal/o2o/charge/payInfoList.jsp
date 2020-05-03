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
<body class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'north',split:true" title="" style="height:100%;width:100%">
		   <fieldset class="x-fieldset" id="payInfoKeyFilter">
				<legend class="x-fieldset-header" style="width: 95px; margin-bottom: 0px; border: none;">
					<span class="x-fieldset-title">线索筛选条件</span>
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
							
							<td class="td-label"><label>交易类型：</label></td>
							<td class="td-input">
								<input  class="easyui-combobox" name="attr01" type="text" id="attr01" size="25" />
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
							
							<td class="td-label"><label>状态：</label></td>
							<td class="td-input">
								<input  class="easyui-combobox" name="attr5" type="text" id="attr5" size="25" />
							</td>
			   			</tr>
					    <tr>	
							<td class="td-label"><label>付款时间从：</label></td>
							<td class="td-input">
								<input  class="easyui-datetimebox" name="attr6" type="text" id="attr6" size="25" />
							</td>
			   			
							<td class="td-label"><label>付款时间到：</label></td>
							<td class="td-input">
								<input  class="easyui-datetimebox" name="attr7" type="text" id=attr7 size="25" />
							</td>
							<td class="td-label"><label>订单状态：</label></td>
							<td class="td-input">
								<input  class="easyui-combobox" name="attrib48" type="text" id="attrib48" size="25" />
							</td>
			   			</tr>
					    <tr>	
							<td class="td-label"><label>物流状态：</label></td>
							<td class="td-input">
								<input  class="easyui-combobox" name="attrib07" type="text" id="attrib07" size="25" />
							</td>
							<td class="td-label"><label>支付方式：</label></td>
							<td class="td-input">
								<input  class="easyui-combobox" name="type" type="text" id="type" size="25" />
							</td>
							
							<td class="td-label"><label>订单编号：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="orderNum" type="text" id="orderNum" size="25" />
							</td>
			   			</tr>
			   		</table>
					<!-- <ul id="payInfo-transactionType-keyfilter" data-toggle="keyfilter"
						data-title="交易类型" data-filter-filed="attr01" data-table-Id="payInfo-table">
					</ul>
					<ul id="payInfo-status-keyfilter" data-toggle="keyfilter"
						data-title="状态" data-filter-filed="status" data-table-Id="payInfo-table">
					</ul>
					<ul id="payInfo-type-keyfilter" data-toggle="keyfilter"
						data-title="支付方式" data-filter-filed="type" data-table-Id="payInfo-table">
					</ul> -->
				</div>
			</fieldset>
			<table id="payInfo-table" rownumbers="true"  pagination="true" keyFilterDiv="payInfoKeyFilter" fit="true">
				<thead>
					<tr>
						<th field="paymentNumber" width="210px" sortable="true" editor="{type:'text'}">支付流水号</th>
						<th field="attr01" width="100px" lov="TB_O2O_TRANSACTION_TYPE" sortable="true" editor="{type:'combobox',options:{valueField:'val',textField:'name',method:'get',
											data:getLovArray('TB_O2O_TRANSACTION_TYPE'),editable:false,required:true}}">交易类型</th>
						<th field="orderNum" width="100px" editor="{type:'picklistbox',options:{title:'订单编号',completeFun:orderNumberPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/orderNumPickList.jsp'}}">订单编号</th>
						<th field="paymentAcct" width="200px" editor="{type:'text'}">支付账号</th>
						<th field="receiveAcct" width="200px" editor="{type:'text'}">收款账号</th>
						<th field="amount" width="90px" editor="{type:'text'}">交易金额</th>
						<th field="name" width="130px" editor="{type:'text'}">商户名称</th>
						<th field="city" width="80px" editor="{type:'text'}">城市</th>
						<th field="orderTime" width="130px" mark="DATE" editor="{type:'datetimebox',options:{showSeconds:true}}">下单时间</th>
						<th field="attrib29" width="130px" mark="DATE" editor="{type:'datetimebox'}">收货时间</th>
						<th field="attrib48" width="130px" lov="TB_O2O_ORDER_STATUS" editor="{type:'combobox',options:{valueField:'val',textField:'name',method:'get',
											data:getLovArray('TB_O2O_ORDER_STATUS'),editable:false,required:true}}">订单状态</th>
						<th field="attrib07" width="130px" lov="TB_O2O_LOGISTICS_STATUS" editor="{type:'combobox',options:{valueField:'val',textField:'name',method:'get',
											data:getLovArray('TB_O2O_LOGISTICS_STATUS'),editable:false,required:true}}">物流状态</th>
						<th field="ouNum" width="130px" editor="{type:'text'}">商户编码</th>
						<th field="o2oContact" width="130px" editor="{type:'text'}">联系人</th>
						<th field="o2oContactPhone" width="130px" editor="{type:'text'}">联系人电话</th>
						<th field="o2oCreditCard" width="130px" editor="{type:'text'}">银行卡号</th>
						<th field="o2oAlipay" width="130px" editor="{type:'text'}">支付宝账号</th>
						<th field="accontName" width="130px" editor="{type:'text'}">开户人</th>
						<th field="o2oBank" width="130px" editor="{type:'text'}">发卡银行</th>
						<th field="status" lov="TB_O2O_PAYMENT_STATUS" width="100px" editor="{type:'combobox',options:{valueField:'val',textField:'name',method:'get',
											data:getLovArray('TB_O2O_PAYMENT_STATUS'),editable:false,required:true}}">状态</th>
						<th field="type" width="100px" lov="TB_O2O_PAYMENT_TYPE" editor="{type:'combobox',options:{valueField:'val',textField:'name',method:'get',
											data:getLovArray('TB_O2O_PAYMENT_TYPE'),editable:false,required:true}}">支付方式</th>
						<th field="tradeTime" width="130px" mark="DATE" editor="{type:'datetimebox'}">交易时间</th>
					</tr>
				</thead>
			</table>
		</div>
	<script type="text/javascript">
		var attr1 = null;
		var attr2 = null;
		var attr3 = null;
		var attr4 = null;
		var attr01 = null;
		var attr5 = null;
		var type = null;
		var orderNum = null;
		var attrib48 = null;
		var attrib07 = null;
		var attr6 = null;
		var attr7 = null;
		
		$datagrid = $('#payInfo-table');
		$datagrid.hdatagrid({
					toolbarShow : true, //显示工具栏
					buttonSearch : false, //搜索框功能
					buttonExport : true,
					toolbarShow:true,
					url : '${AppContext.ctxPath}/action/portal/charge/payInfo/queryByExamplePage',
					
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
						if(attr6 != null && attr6 != ''){
				    		param.attr6 = attr6;
						}
						if(attr7 != null && attr7 != ''){
				    		param.attr7 = attr7;
						}
						if(attr01 != null && attr01 != ''){
				    		param.attr01 = attr01;
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
						if(attrib48 != null && attrib48 != ''){
				    		param.attrib48 = attrib48;
						}
						if(attrib07 != null && attrib07 != ''){
				    		param.attrib07 = attrib07;
						}
					},
					
					onAddMoreButton:function(that,addButtonFun){
		 				addButtonFun(1,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="payInfoSearch()" iconCls="icon-search" plain="true">查询</a>',that);
						addButtonFun(2,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="payInfoClean()" iconCls="icon-reload" plain="true">重置</a>',that);
					},
					
				});
		function orderNumberPicklistComplete(selectRow) {
			$datagrid.hdatagrid('getCurrentRow').orderNum = selectRow.orderNum;
			return selectRow.orderNum;
		};
		$('#payInfo-transactionType-keyfilter').keyFilter({
			remoteData:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/TB_O2O_TRANSACTION_TYPE'
		});
		$('#payInfo-status-keyfilter').keyFilter({
			remoteData:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/TB_O2O_PAYMENT_STATUS'
		});
		$('#payInfo-type-keyfilter').keyFilter({
			remoteData:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/TB_O2O_PAYMENT_TYPE'
		});
		
		$('#attr01').combobox({ 
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
		
		function payInfoSearch(){
			attr1 = $('#attr1').datetimebox('getValue');
			attr2 = $('#attr2').datetimebox('getValue');
			attr3 = $('#attr3').datetimebox('getValue');
			attr4 = $('#attr4').datetimebox('getValue');
			attr6 = $('#attr6').datetimebox('getValue');
			attr7 = $('#attr7').datetimebox('getValue');
			attr01 = $('#attr01').combobox('getValue');
			attr5 = $('#attr5').combobox('getValue');			
			type = $('#type').combobox('getValue');
			orderNum = $('#orderNum').val();
			attrib48 = $('#attrib48').combobox('getValue');
			attrib07 = $('#attrib07').combobox('getValue');
		  	$datagrid.datagrid('reload');
	  	 }
		
	  	 function payInfoClean(){
		   $('#attr1').datetimebox('setValue','');
		   $('#attr2').datetimebox('setValue','');
		   $('#attr3').datetimebox('setValue','');
		   $('#attr4').datetimebox('setValue','');
		   $('#attr6').datetimebox('setValue','');
		   $('#attr7').datetimebox('setValue','');
		   $('#attr01').combobox('setValue','');
		   $('#attr5').combobox('setValue','');
		   $('#type').combobox('setValue','');
		   $('#orderNum').val('');
		   $('#attrib48').combobox('setValue','');
		   $('#attrib07').combobox('setValue','');
		   attr1 = null;
		   attr2 = null;
		   attr3 = null;
		   attr4 = null;
		   attr6 = null;
		   attr7 = null;
		   attr01 = null;
		   attr5 = null;
		   type = null;
		   orderNum = null;
		   attrib48 = null;
		   attrib07 = null;
		   $datagrid.datagrid('reload');
	  	 }
	  	 
	</script>
</body>
</html>