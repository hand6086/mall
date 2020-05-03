<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
<style type="text/css">
</style>
<body>
	<div id="menu_layout" class="easyui-layout" fit="true" border="false">
		<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:100%;padding:0px;">
 		   <fieldset class="x-fieldset" id="shoppingCartKeyFilter">
				<legend class="x-fieldset-header" style="width: 95px; margin-bottom: 0px; border: none;">
					<span class="x-fieldset-title">线索筛选条件</span>
				</legend>
		
				<div class="row keyfilter-border">
					<ul id="shoppingCart-status-keyfilter" data-toggle="keyfilter"
						data-title="状态" data-filter-filed="status" data-table-Id="shoppingCart-table">
					</ul>
				</div>
			</fieldset>
			<table id="shoppingCart-table" style="width:100%;height:100%;" keyFilterDiv="shoppingCartKeyFilter" singleSelect="true" rownumbers="true" pagination="true">
				<thead>
					<tr>
						<th field="name" width="120px" editor="{type:'picklistbox',options:{title:'选择城市',
															completeFun:cityPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/Tbo2oDistrictPickList.jsp'}}">城市</th>
						<th field="customerName" width="100px" editor="{type:'picklistbox',options:{title:'城市',completeFun:customerNamePicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/customerNamePickList.jsp'}}">消费者名称</th>
						<th field="ouNum" width="140px">消费者编码</th>
						<th field="mainPhNum" width="140px">消费者电话</th>
						<th field="o2oDisplayName" width="140px" editor="{type:'picklistbox',options:{title:'城市',completeFun:merchantNamePicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/merchantNamePickList.jsp'}}">商品名称</th>
						<th field="o2oIntCode" width="180px">商品编码</th>
						<th field="qty" width="100px" editor="{type:'numberbox'}">数量</th>
						<th field="created" width="120px" editor="{type:'datetimebox'}">日期</th>
						<th field="status" width="120px" lov="TB_O2O_SHOPPING_CART_STATUS" editor="{type:'combobox',options:{valueField:'name',textField:'name',
																						method:'get',data:getLovArray('TB_O2O_SHOPPING_CART_STATUS'),editable:false,required:true}}">状态</th>
						<th field="tAttr01" width="120px" hidden="true" noSearch="true">tAttr01</th>
						<th field="customerId" width="120px" hidden="true" noSearch="true">customerId</th>
						<th field="merchId" width="120px" hidden="true" noSearch="true">merchId</th>
						<th field="channelType" width="120px" lov="CHANNEL_TYPE" editor="{type:'combobox',options:{
																						valueField:'name',textField:'name',
																						method:'get',data:getLovArray('CHANNEL_TYPE'),
																						editable:false}}">频道标识</th>
						<th field="scenesType" width="120px" lov="SCENES_TYPE" editor="{type:'combobox',options:{
																						valueField:'name',textField:'name',
																						method:'get',data:getLovArray('SCENES_TYPE'),
																						editable:false}}">场景标识</th>
						<th field="promotionType" width="120px" lov="TB_O2O_CAMPAIGN_TYPE" editor="{type:'combobox',options:{
																						valueField:'val',
																						textField:'name',
																						method:'post',
																						url:'${AppContext.ctxPath}/action/portal/order/shoppingCart/campaignType',
																						editable:false}}">促销标识</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<script type="text/javascript">
		$datagrid = $('#shoppingCart-table');
		
		$datagrid.hdatagrid({
				updateable:true,			
				buttonNew:false,
				toolbarShow : true, //显示工具栏
				buttonSearch : true, //搜索框功能
				buttonMenu : true,
            	buttonExport:true,	//导出功能 可导出
				nowrap:false,
				striped : true,
				title : '',
				newDefaultValue:true,
				newDefaultUrl:'${AppContext.ctxPath}/action/portal/order/shoppingCart/preDefaultValue',
				border : false,
				url : '${AppContext.ctxPath}/action/portal/order/shoppingCart/queryByExamplePage',
				onInsertOrUpdateAction : function(row,successFun,errFun,that){
	 		    	$.post('${AppContext.ctxPath}/action/portal/order/shoppingCart/upsert', row, function(data) {
	 					if (!data.success) {
	 						errFun(data.result,that);
	 					}else{
	 						successFun(that, data);
	 					}
	 				});
				},
			});
		
		$('#shoppingCart-status-keyfilter').keyFilter({
			remoteData:true,
			dataValue:'val',
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/TB_O2O_SHOPPING_CART_STATUS'
		});
		
		function cityPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').cityId = selectRow.id;
			return selectRow.name;
		}
		function customerNamePicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').customerName = selectRow.customerName;
			$datagrid.hdatagrid('getCurrentRow').ouNum = selectRow.ouNum;
			$datagrid.hdatagrid('getCurrentRow').customerId = selectRow.customerId;
			return selectRow.customerName;
		}
		function merchantNamePicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').o2oDisplayName = selectRow.o2oDisplayName;
			$datagrid.hdatagrid('getCurrentRow').o2oIntCode = selectRow.o2oIntCode;
			$datagrid.hdatagrid('getCurrentRow').merchId = selectRow.merchId;
			return selectRow.o2oDisplayName;
		}
	</script>
</body>
</html>