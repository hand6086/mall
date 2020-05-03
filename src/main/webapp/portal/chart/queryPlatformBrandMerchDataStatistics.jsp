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
   <fieldset class="x-fieldset" id="merchDataKeyFilter">
		<legend class="x-fieldset-header" style="width: 95px; margin-bottom: 0px; border: none;">
			<span class="x-fieldset-title">快速查询</span>
		</legend>
		<div class="row keyfilter-border">
	   		<table class="form-table">
			    <tr>
					<td class="td-label"><label>商品分类：</label></td>
					<td class="td-input">
						<input  class="easyui-combobox" name="goodsType" type="text" id="goodsType" size="25" />
					</td>
				</tr>
	   		</table>
	   	</div>
	</fieldset>
   <table id="merch-date-Statistics-table" singleSelect="true" rownumbers="true"  pagination="true" fit="true" keyFilterDiv="merchDataKeyFilter">
		<thead>
			<tr>
				<th field="goodsType" width="150px">商品分类</th>
				<th field="merchNumber" width="100px">商家数量</th>
			</tr>
		</thead>
	</table>
	</div>
	</div>
   
	<script type="text/javascript">
		var goodsType = null;

	    $datagrid = $('#merch-date-Statistics-table');
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
			url:'${AppContext.ctxPath}/action/portal/platformBrandMerchDataStatistics/queryByExamplePage',
			
			onBeforeLoad:function(param){
				if(goodsType != null && goodsType != ''){
		    		param.goodsType = goodsType;
				}
			},
			
 			 onAddMoreButton:function(that,addButtonFun){
 				addButtonFun(1,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="orderDeliverySearch()" iconCls="icon-search" plain="true">查询</a>',that);
 				addButtonFun(2,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="orderDeliveryClean()" iconCls="icon-reload" plain="true">重置</a>',that);
 					
 			 } 
			});
		
		$('#goodsType').combobox({ 
		    method:'get',
		    url:'/action/portal/classify/brandClassifyList',
			valueField:'name',
			textField:'name',
		    editable:false, //不可编辑状态
		    panelHeight: 'auto',//自动高度适合
		    cache: false
		});
		
		function orderDeliverySearch(){
			goodsType = $('#goodsType').combobox('getValue');
		   	$datagrid.datagrid('reload');
		}
		function orderDeliveryClean(){
				$('#goodsType').combobox('setValue','');
			   goodsType = null;
			   $datagrid.datagrid('reload');
		  	 }
	
	</script>
</body>
</html>