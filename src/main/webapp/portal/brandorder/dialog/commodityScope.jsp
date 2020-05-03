<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
<style type="text/css">
</style>
<body class="easyui-layout" data-options="fit:true" border="false">
   <div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'center'" title="" style="width: 100%; height: 100%; padding: 0px;">
			
			<div id="freight-tabs" class="easyui-tabs" style="width: 100%;height: 100%;" data-options="border:false">
			 	 <table id="cs-table"
					singleSelect="true" rownumbers="true"  pagination="true" fit="true">
					<thead>
						<tr>
							<th field="o2oDisplayName" width=96% >商品名称</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var freightId = "${param.freightId}";
		$('#freight-tabs').tabs();
	    $csdatagrid = $('#cs-table');
		$csdatagrid.hdatagrid({
			toolbarShow:true,
			buttonSearch:true,
			newDefaultValue:true,
			url:'${AppContext.ctxPath}/action/portal/freight/queryCsPage',
			onBeforeLoad:function(param){
				if(!freightId){
		    		param.freightId = "noMatchId";
		    	}else{
		    		param.freightId=freightId;
		    	}
			},
		});
	</script>
</style>
</body>
</html>