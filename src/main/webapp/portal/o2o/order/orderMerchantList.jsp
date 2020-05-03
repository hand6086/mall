<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
<style type="text/css" >
.file {
    position: relative;
    display: inline-block;
    overflow: hidden;
    text-decoration: none;
    text-indent: 0;
    line-height: 20px;
}
.file input {
    position: absolute;
    font-size: 100px;
    right: 0;
    top: 0;
    opacity: 0;
}
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
			<fieldset class="x-fieldset" id="orderMKeyFilter">
				<legend class="x-fieldset-header"
					style="width: 95px; margin-bottom: 0px; border: none;">
					<span class="x-fieldset-title">快速查询</span>
				</legend>
				<div class="row keyfilter-border">
			   		<table class="form-table">
					    <tr>
			   				<td class="td-label"><label>订单编号：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="orderNum" type="text" id="orderNum" size="25" />
							</td>
							
							<td class="td-label"><label>商品名称：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="o2oDisplayName" type="text" id="o2oDisplayName" size="25" />
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
							
							<td class="td-label"><label>下单时间从 ：</label></td>
							<td class="td-input">
								<input  class="easyui-datetimebox" name="attr1" type="text" id="attr1" size="25" />
							</td>
							
							<td class="td-label"><label>下单时间至：</label></td>
							<td class="td-input">
								<input  class="easyui-datetimebox" name="attr2" type="text" id="attr2" size="25" />
							</td>
			   			</tr>
					    <tr>
							<td class="td-label"><label>城市：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="attrib37" type="text" id="attrib37" size="25" />
							</td>
							
							<td class="td-label"><label>收货人：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="contact" type="text" id="contact" size="25" />
							</td>
							
							<td class="td-label"><label>收货电话：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="contactPhone" type="text" id="contactPhone" size="25" />
							</td>
			   			</tr>
					    <tr>
							<td class="td-label"><label>详细地址：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="attrib01" type="text" id="attrib01" size="25" />
							</td>
			   			</tr>
			   		</table>
			   	</div>
			</fieldset>
			<table id="orderMerchant-table" style="width:100%;height:100%;" singleSelect="true" rownumbers="true" pagination="true" keyFilterDiv="orderMKeyFilter">
				<thead>
					<tr>
						<th field="orderNum" width="100px">订单编号</th>
						<th field="o2oDisplayName" width="200px">商品名称</th>
						<th field="o2oIntCode" width="180px">商品编码</th>
						<th field="baseUnitPri" width="100px">报价</th>
						<th field="qtyReq" width="100px">数量</th>
						<th field="attrib17" width="100px">报价总金额</th>
						<th field="netPri" width="100px">成交价</th>
						<th field="attrib19" width="100px">成交金额</th>
						<th field="attrib11" width="100px" lov="S_IF">是否赠品</th>
						<th field="contact" width="120px">收货人</th>
						<th field="contactPhone" width="120px">收货人电话</th>
						<th field="attrib36" width="120px">省/直辖市</th>
						<th field="attrib37" width="120px">城市</th>
						<th field="attrib38" width="120px">区/县</th>
						<th field="attrib01" width="140px">详细地址</th>
						<th field="attrib14" width="100px">商品总价</th>
						<th field="attrib16" width="100px">特价优惠金额</th>
						<th field="attrib21" width="100px">满减优惠金额</th>
						<th field="attrib22" width="100px">买赠优惠金额</th>
						<th field="attrib20" width="100px">优惠券金额</th>
						<th field="o2oTip" width="100px">小费</th>
						<th field="orderSum" width="100px">订单总金额</th>
						<th field="orderTime" width="140px">下单时间</th>
						<th field="attrib28" width="120px">配送时间</th>
						<th field="attrib48" width="100px" lov="TB_O2O_ORDER_STATUS">订单状态</th>
						<th field="attrib07" width="100px" lov="TB_O2O_LOGISTICS_STATUS">物流状态</th>
						<th field="merchantOfferSum" width="80px">商品优惠金额</th>
						<th field="orderOfferSum" width="80px">订单优惠金额分摊</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<script type="text/javascript">
	
		var orderNum = null;
		var o2oDisplayName = null;
		var attrib48 = null;
		var attrib07 = null;
		var attr1 = null;
		var attr2 = null;
		var attrib37 = null;
		var contact = null;
		var contactPhone = null;
		var attrib01 = null;
	
		$datagrid = $('#orderMerchant-table');
		
		$datagrid.hdatagrid({
					toolbarShow : true, //显示工具栏
					buttonSearch : false, //搜索框功能
					buttonMenu : true,
					buttonExport:true,
					oauthFlag : true,
					striped : true,
					nowrap:false,
					title : '',
					border : false,
					url : '${AppContext.ctxPath}/action/portal/order/orderMerchant/queryByExamplePage',
					
					onBeforeLoad:function(param){
						if(orderNum != null && orderNum != ''){
				    		param.orderNum = orderNum;
						}
						if(o2oDisplayName != null && o2oDisplayName != ''){
				    		param.o2oDisplayName = o2oDisplayName;
						}
						if(attrib48 != null && attrib48 != ''){
				    		param.attrib48 = attrib48;
						}
						if(attrib07 != null && attrib07 != ''){
				    		param.attrib07 = attrib07;
						}
						if(attr1 != null && attr1 != ''){
				    		param.attr1 = attr1;
						}
						if(attr2 != null && attr2 != ''){
				    		param.attr2 = attr2;
						}
						if(attrib37 != null && attrib37 != ''){
				    		param.attrib37 = attrib37;
						}
						if(contact != null && contact != ''){
				    		param.contact = contact;
						}
						if(contactPhone != null && contactPhone != ''){
				    		param.contactPhone = contactPhone;
						}
						if(attrib01 != null && attrib01 != ''){
				    		param.attrib01 = attrib01;
						}
					},
					/**
					 * 导出前触发的事件，返回false则不导出
					 */
					onBeforeExport: function(param){
						//某些查询条件已输入,则不验证查询条件的开始时间、结束时间等条件(0验证 1不验证)
						var isNecessary = 0;
						
				        orderNum = $('#orderNum').val();
				        o2oDisplayName = $('#o2oDisplayName').val();
				        attrib48 = $('#attrib48').combobox('getValue');
				        attrib07 = $('#attrib07').combobox('getValue');
				        attr1 = $('#attr1').datetimebox('getValue');
				        attr2 = $('#attr2').datetimebox('getValue');
				        attrib37 = $('#attrib37').val();
				        contact = $('#contact').val();
				        contactPhone = $('#contactPhone').val();
				        attrib01 = $('#attrib01').val();
						if(orderNum != null && orderNum != ''){
				    		param.orderNum = orderNum;
				    		isNecessary = 1;
						}
						if(o2oDisplayName != null && o2oDisplayName != ''){
				    		param.o2oDisplayName = o2oDisplayName;
				    		isNecessary = 1;
						}
						if(attrib48 != null && attrib48 != ''){
				    		param.attrib48 = attrib48;
						}
						if(attrib07 != null && attrib07 != ''){
				    		param.attrib07 = attrib07;
						}

						if(attrib37 != null && attrib37 != ''){
				    		param.attrib37 = attrib37;
						}
						if(contact != null && contact != ''){
				    		param.contact = contact;
				    		isNecessary = 1;
						}
						if(contactPhone != null && contactPhone != ''){
				    		param.contactPhone = contactPhone;
				    		isNecessary = 1;
						}
						if(attrib01 != null && attrib01 != ''){
				    		param.attrib01 = attrib01;
				    		isNecessary = 1;
						}
						
						if(attr1 != null && attr1 != ''){
				    		param.attr1 = attr1;
				    		if(attr2 == null || attr2 == ''){
				    			$.messager.alert("错误", "请输入结束时间！", "error");
								return false;
				    		}
						} else if( isNecessary == 0 ){
							$.messager.alert("错误", "请输入开始时间！", "error");
							return false;
						}
						if(attr2 != null && attr2 != ''){
				    		param.attr2 = attr2;
				    		if(attr1 == null || attr1 == ''){
				    			$.messager.alert("错误", "请输入开始时间！", "error");
								return false;
				    		}
						} else if( isNecessary == 0 ){
							$.messager.alert("错误", "请输入结束时间！", "error");
							return false;
						}
						
						if(attr1 != null && attr1 != '' && attr2 != null && attr2 != '' 
								&& attr1 >= attr2){
							$.messager.alert("错误", "开始时间不能大于结束时间！", "error");
							return false;
						}
						var startDate = new Date(attr1);
						var endDate = new Date(attr2);
						var day = ((endDate.getTime() - startDate.getTime())/(1000 * 60 * 60 * 24));
						if(day > 30){
							 $.messager.alert("错误", "只能导出30天内的数据", "error");
							 return false;
						}
						return true;
					},
					onAddMoreButton:function(that,addButtonFun){
		 				addButtonFun(1,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="orderSPSearch()" iconCls="icon-search" plain="true">查询</a>',that);
						addButtonFun(2,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="orderSPClean()" iconCls="icon-reload" plain="true">重置</a>',that);
		 			}, 
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
		
		function orderSPSearch(){
	       orderNum = $('#orderNum').val();
	       o2oDisplayName = $('#o2oDisplayName').val();
	       attrib48 = $('#attrib48').combobox('getValue');
	       attrib07 = $('#attrib07').combobox('getValue');
	       attr1 = $('#attr1').datetimebox('getValue');
	       attr2 = $('#attr2').datetimebox('getValue');
	       attrib37 = $('#attrib37').val();
	       contact = $('#contact').val();
	       contactPhone = $('#contactPhone').val();
	       attrib01 = $('#attrib01').val();
		   $datagrid.datagrid('reload');
	   }
	   
	   function orderSPClean(){
		   orderNum = $('#orderNum').val('');
		   o2oDisplayName = $('#o2oDisplayName').val('');
	       attrib48 = $('#attrib48').combobox('setValue','');
	       attrib07 = $('#attrib07').combobox('setValue','');
	       attr1 = $('#attr1').datetimebox('setValue','');
	       attr2 = $('#attr2').datetimebox('setValue','');
	       attrib37 = $('#attrib37').val('');
	       contact = $('#contact').val('');
	       contactPhone = $('#contactPhone').val('');
	       attrib01 = $('#attrib01').val('');
	       var orderNum = null;
		   var o2oDisplayName = null;
		   var attrib48 = null;
		   var attrib07 = null;
		   var attr1 = null;
		   var attr2 = null;
		   var attrib37 = null;
		   var contact = null;
		   var contactPhone = null;
		   var attrib01 = null;
		   $datagrid.datagrid('reload');
	   }
	</script>
</body>
</html>