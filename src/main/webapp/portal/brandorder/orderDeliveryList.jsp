<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
<style type="text/css">
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
.td-label {
	width:95px;
	font-size: 14px;
	text-align: right;
	height: 30px;
}
.td-content {
	padding-right:6px;
}
.td-content input{
	width:200px;
}
.form-table{
	margin: 5px auto; 
	width: 100%;
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
							<td class="td-label"><label>订单编号：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="orderNum" type="text" id="orderNum" size="25" />
							</td>
							
							<td class="td-label"><label>消费者名称：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="customerName" type="text" id="customerName" size="25" />
							</td>
							
							<td class="td-label"><label>收货人：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="recieverName" type="text" id="recieverName" size="25" />
							</td>
						</tr>
						<tr>		
							<td class="td-label"><label>收货地址：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="addressAll" type="text" id="addressAll" size="25" />
							</td>
						
							<td class="td-label"><label>收货人电话：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="recieverPhone" type="text" id="recieverPhone" size="25" />
							</td>
						
							<td class="td-label"><label>商户名称：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="storeName" type="text" id="storeName" size="25" />
							</td>
						</tr>
					    <tr>
			   				<td class="td-label"><label>订单状态：</label></td>
							<td class="td-input">
								<input  class="easyui-combobox" name="orderStatus" type="text" id="orderStatus" size="25" />
							</td>
							
							<td class="td-label"><label>物流状态：</label></td>
							<td class="td-input">
								<input  class="easyui-combobox" name="logisticsStatus" type="text" id="logisticsStatus" size="25" />
							</td>
							
							<td class="td-label"><label>物流公司：</label></td>
							<td class="td-input">
								<input  class="easyui-combobox" name="logisticsCompany1" type="text" id="logisticsCompany1" size="25" />
							</td>
						</tr>
					    <tr>		
							<td class="td-label"><label>下单时间从：</label></td>
							<td class="td-input">
								<input  class="easyui-datetimebox" name="attr3" type="text" id="attr3" size="25" />
							</td>
							
							<td class="td-label"><label>下单时间到：</label></td>
							<td class="td-input">
								<input  class="easyui-datetimebox" name="attr4" type="text" id="attr4" size="25" />
							</td>
							
							<td class="td-label"><label>付款时间从：</label></td>
							<td class="td-input">
								<input  class="easyui-datetimebox" name="attr2" type="text" id="attr2" size="25" />
							</td>
						</tr>
					    <tr>		
							<td class="td-label"><label>付款时间至：</label></td>
							<td class="td-input">
								<input  class="easyui-datetimebox" name="attr5" type="text" id="attr5" size="25" />
							</td>
							
							<td class="td-label"><label>发运时间从：</label></td>
							<td class="td-input">
								<input  class="easyui-datetimebox" name="attr6" type="text" id="attr6" size="25" />
							</td>
							
							<td class="td-label"><label>发运时间至：</label></td>
							<td class="td-input">
								<input  class="easyui-datetimebox" name="attr7" type="text" id="attr7" size="25" />
							</td>
						</tr>
			   		</table>
			   	</div>
			</fieldset>
			<table id="order-table" style="width:98%;height:580px;" singleSelect="true" rownumbers="true" pagination="true" keyFilterDiv="orderKeyFilter">
				<thead>
					<tr>
						<th field="orderNum" width="100px">订单编号</th>
						<th field="customerName" width="80px">消费者名称</th>
						<th field="recieverName" width="180px">收货人</th>
						<th field="province" width="100px">省/直辖市</th>
						<th field="city" width="100px">城市</th>
						<th field="district" width="140px">区/县</th>
						<th field="address" width="100px">详细地址</th>
						<th field="recieverPhone" width="140px">收货人电话</th>
						<th field="storeName" width="120px">商户名称</th>
						<th field="orderStatus" width="120px" lov="BRAND_ORDER_STATUS">订单状态</th>
						<th field="orderTime" width="120px">下单时间</th>
						<th field="orderTotalPrice" width="120px">订单总金额</th>
						<th field="o2oPayType" width="100px" lov="TB_O2O_PAY_TYPE">支付方式</th>
						<th field="attrib26" width="140px">付款时间</th>
						<th field="logisticsStatus" width="100px" lov="TB_O2O_LOGISTICS_STATUS">物流状态</th>
						<th field="logisticsCompany" width="100px" lov="LOGISTICS_COMPANY">物流公司</th>
						<th field="logisticsOddNumber" width="120px">物流单号</th>
						<th field="shippingTime" width="120px">发运时间</th>
						<th field="tAttr20" width="120px">优惠券金额</th>
						<th field="offerSum" width="180px">优惠总金额</th>
						<th field="customerMsg" width="120px">买家留言</th>
						<th field="refuseRefundDate" width="120px">取消时间</th>
						<th field="fightGroupsId" width="100px">拼团Id</th>
						<th field="couponId" width="100px">优惠券Id</th>
						<th field="freight" width="100px">运费</th>
					</tr>
				</thead>
			</table>
			
			<table id="orderTemp-table" style="width:98%;height:380px;" singleSelect=false rownumbers="true" pagination="true">
				<thead>
					<tr>
						<th field="check" checkbox="true"></th>
						<th field="orderNumber" width="100px" editor="{type:'textbox'}">订单编号</th>
						<th field="shippingAddress" width="180px" editor="{type:'textbox'}">收货地址</th>
						<th field="logisticsCompany" width="100px" editor="{type:'textbox'}">物流公司</th>
						<th field="logisticsOddNumber" width="100px" editor="{type:'textbox'}">物流单号</th>
						<th field="shippingTime" width="120px" editor="{type:'datetimebox',options:{showSeconds:true}}">发运时间</th>
						<th field="checkStatus" width="100px" lov="TB_CHECK_STATUS">校验状态</th>
						<th field="errorMessage" width="200px">校验结果</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<div id="dlg" class="easyui-dialog" title="请填写订单发运信息" data-options="closed:true,buttons:'#dlg-buttons'" style="width:350px;height:200px">
		<form id="orderDelForm" method="post">
			<table>
				<tr>
					<td class="td-label"><label>物流公司 </label></td>
					<td class="td-content">
						<input  class="easyui-combobox" name="logisticsCompany" type="text" id="logisticsCompany" required="true"/>
					</td>
				</tr>
				<tr>
					<td class="td-label"><label>物流单号</label></td>
					<td class="td-content">
						<input  class="easyui-textbox" name="logisticsOddNumber" type="text" id="logisticsOddNumber" 
																		data-options="required:true,validType:'logisticsNum'"/>
					</td>
				</tr>
				<tr>
					<td class="td-label"><label>发运时间</label></td>
					<td class="td-content">
						<input class="easyui-datetimebox" name="shippingTime" id="shippingTime">
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
		//订单编号验证
		 $(function(){ 
			$.extend($.fn.validatebox.defaults.rules, {
				logisticsNum: { //验证物流单号   
						validator: function(value, param){
							return /^[a-zA-Z0-9]*[0-9]+[a-zA-Z0-9]*$/.test(value);
						},
						message: '物流单号必须为数字或字母与数字的组合！'
					},
				});
		}); 
		var orderNum = null;
		var customerName = null;
		var recieverName = null;
		var addressAll = null;
		var recieverPhone = null;
		var storeName = null;
		var orderStatus = null;
		var logisticsStatus = null;
		var logisticsCompany1 = null;
		var attr2 = null;
		var attr3 = null;
		var attr4 = null;
		var attr5 = null;
		var attr6 = null;
		var attr7 = null;
	
		$dlg = $('#dlg');
		$orderDelForm = $('#orderDelForm');
		$logisticsCompanyCombobox = $('#logisticsCompany');
		$datagrid = $('#order-table');
		$tempdatagrid = $('#orderTemp-table');
		var disabled = false;
		var deliverId = "";
		if(appCtx.systemRole=='super_administrator'){
			disabled = true;
		}
		$datagrid.hdatagrid({
			toolbarShow : true, //显示工具栏
			buttonSearch : false, //搜索框功能
			updateable: false,
			buttonMenu : true,
			oauthFlag : true,
			striped : true,
			title : '',
			border : false,
			pageSize: 10, 
		    pageList: [10,20,50], 
			url : '${AppContext.ctxPath}/action/portal/order/queryByExamplePage',
			onBeforeLoad:function(param){
				param.attr1='delivery';
				if(orderNum != null && orderNum != ''){
		    		param.orderNum = orderNum;
				}
				if(customerName != null && customerName != ''){
		    		param.customerName = customerName;
				}
				if(recieverName != null && recieverName != ''){
		    		param.recieverName = recieverName;
				}
				if(addressAll != null && addressAll != ''){
		    		param.addressAll = addressAll;
				}
				if(recieverPhone != null && recieverPhone != ''){
		    		param.recieverPhone = recieverPhone;
				}
				if(storeName != null && storeName != ''){
		    		param.storeName = storeName;
				}
				if(orderStatus != null && orderStatus != ''){
		    		param.orderStatus = orderStatus;
				}
				if(logisticsStatus != null && logisticsStatus != ''){
		    		param.logisticsStatus = logisticsStatus;
				}
				if(logisticsCompany1 != null && logisticsCompany1 != ''){
		    		param.logisticsCompany = logisticsCompany1;
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
				if(attr5 != null && attr5 != ''){
		    		param.attr5 = attr5;
				}
				if(attr6 != null && attr6 != ''){
		    		param.attr6 = attr6;
				}
				if(attr7 != null && attr7 != ''){
		    		param.attr7 = attr7;
				}
			},
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(1,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="orderSearch()" iconCls="icon-search" plain="true">查询</a>',that);
				addButtonFun(2,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="orderClean()" iconCls="icon-reload" plain="true">重置</a>',that);
				addButtonFun(91,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="toexport()" iconCls="icon-page-excel" plain="true">导出发货模板</a>',that);
				addButtonFun(91,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="implement()" iconCls="icon-ok" plain="true">发运选中订单</a>',that);
			},
			onSelect:function(index, row){
				deliverId = row.id;
			},
		});
		
		$tempdatagrid.hdatagrid({
					toolbarShow : true, 
					buttonSearch : true, 
					updateable:true,
					buttonNew:true,
					buttonDelete:true,
					buttonImport : true, 
					buttonMenu : true,
					oauthFlag : true,
					border : false,
					pageSize: 10, 
				    pageList: [10,20,50], 
					url : '${AppContext.ctxPath}/action/portal/orderDelivery/queryByExamplePage',
					
					onInsertOrUpdateAction:function(row,successFun,errFun,that){
						$.post("${AppContext.ctxPath}/action/portal/orderDelivery/upsert",row, 
						function(data) {
							if (!data.success) {
								errFun(data.result,that);
							}else{
								successFun(that, data);
							}
						});
					},
					
					onDeleteAction : function(row,successFun,errFun,that){
						$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
							if(data){
								$.post('${AppContext.ctxPath}/action/portal/orderDelivery/deleteById', {
										id : row.id
								}, function(data) {
										if (!data.success) {
											errFun(data.result,that);
										} else {
											successFun(that, data);
										}
								});
							}
						});
					},
					
					onAddMoreButton:function(that,addButtonFun){
						addButtonFun(91,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="check()" iconCls="icon-page-white-excel" plain="true">校验</a>',that);
						addButtonFun(91,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="orderUpdata()" iconCls="icon-ok" plain="true">确认发货信息</a>',that);
					},
				});
	   
	 //初始化 客户状态 下拉列表
		$logisticsCompanyCombobox.combobox({
			data : getLovArray('LOGISTICS_COMPANY'),
			valueField : 'val',
			textField : 'name',
			editable : false, //不可编辑状态
			cache : false
		});
	   
	   function save(){
		   if(!deliverId){
			   window.parent.operationtip('请选择需要更新的数据!', 'error');
			   return;
		   }
		   if($('#shippingTime').datetimebox('getValue') == null || $('#shippingTime').datetimebox('getValue') == ''){
			    var curr_time=new Date();     
			    var strDate=curr_time.getFullYear()+"-";     
			    strDate +=curr_time.getMonth()+1+"-";     
			    strDate +=curr_time.getDate()+"-";     
			    strDate +=" "+curr_time.getHours()+":";     
			    strDate +=curr_time.getMinutes()+":";     
			    strDate +=curr_time.getSeconds();
			   $('#shippingTime').datetimebox('setValue',strDate);
		   }
		   var options = {
					url : '${AppContext.ctxPath}/action/portal/order/update',
					type : 'post',
					dataType :'json',
					data: {
						'id': deliverId,
						'brandUpdate' : '1',
						'orderStatus':'To Receive',
						'logisticsStatus':'Delivered',
						'attr1':'push',
						'attr2':'Brand Order Delivery'
		            },
					beforeSubmit: function() {
						var result = $orderDelForm.form('validate');
						return result;
					},  
					success : function(data) {
						if (data.success) {
							$dlg.dialog('close');
							window.parent.operationtip('发运信息更新成功！', 'info');
							$datagrid.datagrid('reload');
						} else {
							window.parent.operationtip(data.result, 'error');
						}
					}
				};
		   $orderDelForm.ajaxSubmit(options);
	   }
	   
	   function toexport(){
		   $.post('${AppContext.ctxPath}/action/portal/order/platformOrder/queryBfPage/exportData', {},
				function(data){
			    	if(data.success){
			    		window.open(data.url);
						if(datagrid.datagrid('options').exportReload){
							datagrid.datagrid('reload');
						}
					}else{
						$.messager.alert("导出失败",data.result);
					}
			});
	   }
	   
	   function implement(){
		   var row = $datagrid.datagrid('getSelected');
		   if(row.orderStatus=="To Deliver"){
		   $dlg.dialog('open');
		   }else{
			   window.parent.operationtip('订单状态必须为待发货状态！', 'error');
		   }
	   }
	   
	   function check(){
		   $.messager.confirm("操作提示", '是否确定校验信息？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/orderDelivery/check', {},
						function(data){
					    	if(data.success){
					    		$tempdatagrid.datagrid('reload');
							}else{
								window.parent.operationtip(data.result, 'error');
							}
						});
				}
			});
	   }
		
	   function orderUpdata(){
		   /* var rows= $tempdatagrid.datagrid('getSelections');
		   if(rows.length!=0){ */
		   $.messager.confirm("操作提示", '是否确定导入信息？', function(data) {
			    
			    /* alert(JSON.stringify(rows)); */
			    $.ajax({
					url:"${AppContext.ctxPath}/action/portal/orderDelivery/orderUpdata",
					type:"post",
					/* data:JSON.stringify(rows), */
					dataType:"json",
					contentType: "application/json",
					success:function(data){
						if(data.success){
							$datagrid.datagrid('reload');
							$tempdatagrid.datagrid('reload');
							window.parent.operationtip('发货信息已确认！', 'info');
						}else{
							window.parent.operationtip(data.result, 'error');
						}
					}
				});
			});
		  /*  }else{
			   window.parent.operationtip('请至少选择一条发货信息！', 'error');
		   } */
	   }
	   
	   $('#orderStatus').combobox({ 
		    method:'get',
			data:getLovArray('BRAND_ORDER_STATUS'),
			valueField:'val',
			textField:'name',
		    editable:false, //不可编辑状态
		    panelHeight: 'auto',//自动高度适合
		    cache: false
		});
	   
	   $('#logisticsStatus').combobox({ 
		    method:'get',
			data:getLovArray('TB_O2O_LOGISTICS_STATUS'),
			valueField:'val',
			textField:'name',
		    editable:false, //不可编辑状态
		    panelHeight: 'auto',//自动高度适合
		    cache: false
		});
		
	   $('#logisticsCompany1').combobox({ 
		    method:'get',
			data:getLovArray('LOGISTICS_COMPANY'),
			valueField:'val',
			textField:'name',
		    editable:false, //不可编辑状态
		    panelHeight: 'auto',//自动高度适合
		    cache: false
		});
		
		function orderSearch(){
		   orderNum = $('#orderNum').val();
		   customerName = $('#customerName').val();
		   recieverName = $('#recieverName').val();
		   addressAll = $('#addressAll').val();
		   recieverPhone = $('#recieverPhone').val();
		   storeName = $('#storeName').val();
		   orderStatus = $('#orderStatus').combobox('getValue');
		   logisticsStatus = $('#logisticsStatus').combobox('getValue');
		   logisticsCompany1 = $('#logisticsCompany1').combobox('getValue');
		   attr2 = $('#attr2').datetimebox('getValue');
		   attr3 = $('#attr3').datetimebox('getValue');
		   attr4 = $('#attr4').datetimebox('getValue');
		   attr5 = $('#attr5').datetimebox('getValue');
		   attr6 = $('#attr6').datetimebox('getValue');
		   attr7 = $('#attr7').datetimebox('getValue');
		   $datagrid.datagrid('reload');
	    }
	   
	    function orderClean(){
		   $('#orderNum').val('');
		   $('#customerName').val('');
		   $('#recieverName').val('');
		   $('#addressAll').val('');
		   $('#recieverPhone').val('');
		   $('#storeName').val('');
		   $('#orderStatus').combobox('setValue',''); 
		   $('#logisticsStatus').combobox('setValue',''); 
		   $('#logisticsCompany1').combobox('setValue',''); 
		   $('#attr2').datetimebox('setValue','');
		   $('#attr3').datetimebox('setValue','');
		   $('#attr4').datetimebox('setValue','');
		   $('#attr5').datetimebox('setValue','');
		   $('#attr6').datetimebox('setValue','');
		   $('#attr7').datetimebox('setValue','');
		   orderNum = null;
		   customerName = null;
		   recieverName = null;
		   addressAll = null;
		   recieverPhone = null;
		   storeName = null;
		   orderStatus = null;
		   logisticsStatus = null;
		   logisticsCompany1 = null;
		   attr2 = null;
		   attr3 = null;
		   attr4 = null;
		   attr5 = null;
		   attr6 = null;
		   attr7 = null;
		   $datagrid.datagrid('reload');
	    }
	</script>
</body>
</html>