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
   <fieldset class="x-fieldset" id="merchSkuDataKeyFilter">
		<legend class="x-fieldset-header" style="width: 95px; margin-bottom: 0px; border: none;">
			<span class="x-fieldset-title">快速查询</span>
		</legend>
		<div class="row keyfilter-border">
	   		<table class="form-table">
			    <tr>
					<td class="td-label"><label>商家名称 ：</label></td>
					<td class="td-content">
						<input type="text" id="merchName" name="merchName" />
					</td>
				</tr>
	   		</table>
	   	</div>
	</fieldset>
   <table id="merch-sku-date-table" singleSelect="true" rownumbers="true"  pagination="true" fit="true" keyFilterDiv="merchSkuDataKeyFilter">
		<thead>
			<tr>
				<th field="merchName" width="150px">商家名称</th>
				<th field="typeSku" width="100px">分类SKU</th>
				<th field="sku" width="100px">SKU</th>
			</tr>
		</thead>
	</table>
	</div>
	</div>
   
	<script type="text/javascript">
		var merchName = null;

	    $datagrid = $('#merch-sku-date-table');
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
			url:'${AppContext.ctxPath}/action/portal/platformBrandMerchSkuDataStatistics/queryByExamplePage',
			
			onBeforeLoad:function(param){
				if(merchName != null && merchName != ''){
		    		param.merchName = merchName;
				}
			},
			
 			 onAddMoreButton:function(that,addButtonFun){
 				addButtonFun(1,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="skuDataSearch()" iconCls="icon-search" plain="true">查询</a>',that);
 				addButtonFun(2,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="skuDataClean()" iconCls="icon-reload" plain="true">重置</a>',that);
	
 			 } 
			});

		
		function skuDataSearch(){
			merchName = $('#merchName').val();
		   	$datagrid.datagrid('reload');
		}
		function skuDataClean(){
			   $('#merchName').val('');
			   merchName = null;
			   $datagrid.datagrid('reload');
		  	 }
	
	</script>
</body>
</html>