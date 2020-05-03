<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/portal/header.jsp"%>
<title>移动前端日志</title>
</head>
<body class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north',split:true" title="" border="false"
		fit="true">
		<table id="appLocLog-table" singleSelect="true" rownumbers="true"
			pagination="true" fit="true">
			<thead>
				<tr>
					<th field="id" width="80px" sortable="true" hidden>id</th>
					<th field="created" width="130px" editor="{type:'validatebox'}">创建时间</th>
					<th field="userName" width="80px"  editor="{type:'validatebox'}">用户名</th>
					<th field="name" width="120px" defaultSearch="true" editor="{type:'validatebox'}">姓名</th>
					<th field="localLogInfo" width="900px" sortable="false" 
						editor="{type:'validatebox'}">日志</th>
				</tr>
			</thead>
		</table>
	</div>

	<script type="text/javascript">
		$datagrid = $('#appLocLog-table');
		$datagrid.hdatagrid({
			updateable : true,
			toolbarShow : true,//显示工具栏
			buttonSearch : true,//搜索框功能
			buttonMenu : true,
			striped : true, 
			title : '',
			 border : false, 
			url : '${AppContext.ctxPath}/action/portal/appLocLog/queryByExamplePage'
		});
	</script>
</body>
</html>