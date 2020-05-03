<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/portal/header.jsp"%>
<title>移动设备管理</title>
</head>
<body class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north',split:true" title="" border="false"
		fit="true">
		<table id="appMobileInfoList-table" singleSelect="true" rownumbers="true"
			pagination="true" fit="true">
			<thead>
				<tr>
					<th field="id" width="80px" sortable="true" hidden>id</th>
					<th field="created" width="130px" editor="{type:'validatebox'}">创建时间</th>
					<th field="userName" width="80px" editor="{type:'validatebox'}">用户名</th>
					<th field="name" width="80px" editor="{type:'validatebox'}" defaultSearch="true">姓名</th>
					<th field="appVersion" width="80px" editor="{type:'validatebox'}">APP版本号</th>
					<th field="mobileVersion" width="80px" editor="{type:'validatebox'}">设备版本</th>
					<th field="platFormType" width="80px" editor="{type:'validatebox'}">平台类型</th>
					<th field="token" width="180px" editor="{type:'validatebox'}">设备识别码</th>
					
					
				</tr>
			</thead>
		</table>
	</div>

	<script type="text/javascript">
		$datagrid = $('#appMobileInfoList-table');
		$datagrid.hdatagrid({
			updateable : true,
			toolbarShow : true, //显示工具栏
			buttonSearch : true, //搜索框功能
			buttonMenu : true,
			striped : true,
			title : '',
			border : false,
			url : '${AppContext.ctxPath}/action/portal/appMobileInfo/queryByExamplePage'
		});
	</script>
</body>

</body>
</html>