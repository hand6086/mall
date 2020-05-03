<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/css/common.css">
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/easyui/themes/icon.css"> 
<script src="${AppContext.ctxPath}/static/js/jquery.min.js"></script>
<script src="${AppContext.ctxPath}/static/easyui/js/jquery.easyui.min.js"></script>
<script src="${AppContext.ctxPath}/static/js/jquery.easyui.common.js"></script>
<script src="${AppContext.ctxPath}/static/easyui/js/locale/easyui-lang-zh_CN.js"></script>
<script src="${AppContext.ctxPath}/static/js/jquery.easyui.datagrid.js"></script> 
<script src="${AppContext.ctxPath}/static/js/mask.js"></script>
<body>
   	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:100%;padding:0px;">
			<div id="product-table-toolbar">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				搜索条件:
			    <input class="easyui-combobox" style="width:100px" url="/portal/json/deliveryOrder.json" valueField="id" textField="text"/> 
			    <input style="width: 200px;" type="text" class="easyui-textbox" />
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="$('#product-table').datagrid('doSearch')">查询</a> 
				<a href="javascript:void(0)" id="btn_inport" class="easyui-linkbutton" style="" iconCls="icon-table-add" plain="true" onclick="importParamsPicklist('product-table','${AppContext.ctxPath}/action/portal/product/uploadExcel','')">导入</a>
			</div>
			
			<table id="product-table" width="100%" height="100%" singleSelect="true" rownumbers="true" toolbar="#product-table-toolbar" pagination="true">
				<thead>
					<tr>
						<th field="checkStatus" width="80px">校验状态</th>
						<th field="errorMsg" width="80px" >信息</th>
						<th field="prodCode" width="80px" >sap物料</th>
						<th field="prodName" width="80px" >产品名</th>
						<th field="prodUnit" width="80px" >产品单位</th>
						<th field="prodSeries" width="80px" >产品系列</th>
						<th field="prodGroup" width="80px" >产品组</th>
						<th field="prodStatus" width="80px" >产品状态</th>
						<th field="prodMateSerires" width="80px" >产品区域代码关联系列</th>
						<th field="prodModel" width="80px" >产品型号</th>
						<th field="prodRatio" width="80px" >产品系数</th>
						<th field="integrateionId" width="80px" >集成id</th>

					</tr>
				</thead>
			</table>
		</div>
		
	</div>
   	
		
	<script type="text/javascript">
	        var pickSelectedRow = undefined;
	        var id = undefined;
			$datagrid = $('#product-table');
			var dataGridSelectIndex = undefined;
			$datagrid.datagrid({
					striped:true,
					title:'物料导入',
					pageSize: 20,//每页显示的记录条数，默认为20 
					pageList: [20,30,50],//可以设置每页记录条数的列表 
					width:$(window).width(),
					border:false,
					url:'${AppContext.ctxPath}/action/portal/product/listOfImport',
					onLoadSuccess:function(data){
						if(data.rows.length > 0){
							$datagrid.datagrid('selectRow', 0);
						}
				    }
			});
			
			
			
	</script>
</body>
</html>