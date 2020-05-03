<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/portal/header.jsp"%>
<title>移动登录日志</title>
</head>
<body class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north',split:true" title="" border="false"
		fit="true">
		<table id="appLoginList-table" singleSelect="true" rownumbers="true"
			pagination="true" fit="true">
			<thead>
				<tr>
					<th field="id" width="80px" sortable="true" hidden>id</th>
					<th field="created" width="120px" editor="{type:'validatebox'}">创建时间</th>
					<th field="loginTime" width="120px" editor="{type:'validatebox'}">登入时间</th>
					<th field="logoutTime" width="120px" editor="{type:'validatebox'}">登出时间</th>
					<th field="ipAddress" width="100px" editor="{type:'validatebox'}">IP地址</th>
					<th field="userName" width="50px" defaultSearch="true" editor="{type:'validatebox'}">用户名</th>
					<th field="name" width="50px" editor="{type:'validatebox'}">姓名</th>
					<th field="networkType" width="80px" editor="{type:'textbox'}">网络类型</th>
					<th field="token" width="100px" editor="{type:'textbox'}">设备号</th>
					<th field="platform" width="100px" editor="{type:'textbox'}">设备类型</th>
					<th field="platformType" width="100px" editor="{type:'textbox'}">设备版本</th>
					<th field="address" sortable="false" width="300px" editor="{type:'validatebox'}" formatter="addressFormatter">地址</th>					
				</tr>
			</thead>
		</table>
	</div>

	<script type="text/javascript">
		$datagrid = $('#appLoginList-table');
		$datagrid.hdatagrid({
			updateable : false,
			toolbarShow : true, //显示工具栏
			buttonSearch : true, //搜索框功能
			buttonMenu : true,
			striped : true,
			title : '',
			border : false,
			url : '${AppContext.ctxPath}/action/portal/appLogin/queryByExamplePage'
		});
		
		function addressFormatter(val,row){
			var province = "";
			var city = "";
			var address = "";
			if(row.province){
				province = row.province;
				}
			if(row.city){
				city = row.city;
				}
			if(row.address){
				address = row.address;
				}
			return province + " " + city + " " + address;
		}
	</script>
</body>
</html>