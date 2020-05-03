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
<script src="${AppContext.ctxPath}/static/easyui/js/locale/easyui-lang-zh_CN.js"></script>
<script src="${AppContext.ctxPath}/static/js/jquery.easyui.datagrid.js"></script>
<script src="${AppContext.ctxPath}/static/js/jquery.easyui.hdatagrid.js"></script>
<body>
	<table id="basicLog-table" fit="true" border="false"
		singleSelect="true" rownumbers="true" toolbar="#basicLog-table-toolbar">
	<thead>
		<tr>
			<th field="exModel" width="5%">执行模块</th>
			<th field="exUrl" width="5%">执行URL</th>
			<th field="exDes" width="10%">执行描述</th>
			<th field="exParams" width="10%">执行参数</th>
			<th field="exLog" width="20%">执行日志</th>
			<th field="exIp" width="10%">执行IP地址</th>
			<th field="username" width="5%">执行人</th>
			<th field="created" width="10%">时间</th>
		</tr>
	</thead>
</table>
	<script type="text/javascript">
	   $datagrid = $('#basicLog-table');
	   $datagrid.hdatagrid({
			toolbarShow:true,
			buttonSearch:true,
			buttonExport:true,
			oauthFlag:true,
			striped:true,
			border:false,
		    pageSize: 100, 
		    pageList: [100,200,500],
			url:'${AppContext.ctxPath}/action/portal/basicLog/queryByExamplePage'
		});
	</script>
</body>
</html>