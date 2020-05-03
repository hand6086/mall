<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<body class="easyui-layout" data-options="fit:true" border="false">
   <table id="nma-table"
			singleSelect="true" rownumbers="true"  pagination="true" fit="true">
		<thead>
			<tr>
				<th field="areaName" width=100% >省份</th>
			</tr>
		</thead>
	</table>
	<script type="text/javascript">
	    $datagrid = $('#nma-table');
		$datagrid.hdatagrid({
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			newDefaultValue:true,
			url:'${AppContext.ctxPath}/action/portal/freight/queryNmaPage',
			onBeforeLoad:function(param){
				if(!freightId){
		    		param.id = "noMatchId";
		    	}else{
		    		param.id=freightId;
		    	}
			},
		});
		
	</script>
</style>
</body>
</html>