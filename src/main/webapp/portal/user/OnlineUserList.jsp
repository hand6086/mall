<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<style type="text/css">
.td-label {
	font-size: 12px;
	text-align: right;
	height: 30px;
}
</style>

<body class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'center'" border="false">
		<fieldset class="x-fieldset" id="keyFilter">
			<legend class="x-fieldset-header"
				style="width: 95px; margin-bottom: 0px; border: none;">
				<span class="x-fieldset-title">筛选条件</span>
			</legend>
			<div class="row keyfilter-border">
				<ul data-toggle="keyfilter"
					data-title="登录类型" data-filter-filed="loginType"
					data-table-Id="online-user-table">
					<li data-value="APP">APP</li>
					<li data-value="WEB">WEB</li>
				</ul>
			</div>
			<div class="row keyfilter-border">
				<ul data-toggle="keyfilter" data-title="用户类型" 
					id="empTypeKeyfilter" data-filter-filed="empType"
					data-table-Id="online-user-table">
				</ul>
			</div>
		</fieldset>
		<table id="online-user-table" keyFilterDiv="keyFilter" fit="true">
			<thead>
				<tr>
					<th field="firstName" width="150px">姓名</th>
					<th field="empType"  width="150px" lov="EMP_TYPE">用户类型</th>
					<th field="username" width="150px">用户名</th>
					<th field="loginTime" width="150px" mark="DATE">登录时间</th>
					<th field="loginType" width="150px">登录类型</th>
					<th field="ipAddress" width="150px">IP地址</th>
				</tr>
			</thead>
		</table>
	</div>
	<script type="text/javascript">
	$('.fixed-keyfilter-ul').keyFilter();
		$datagrid = $('#online-user-table');
		$datagrid.hdatagrid({
			toolbarShow:true,
			buttonSearch:true,
			buttonExport:true,
			oauthFlag:true,
			width:'100%',
			height:'100%',
			url : '${AppContext.ctxPath}/action/portal/online/queryByExamplePage',
			onAddMoreButton:function(that,addButtonFun){
				//addButtonFun(91,'<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="removeUser()">剔除用户</a>',that);
				//addButtonFun(92,'<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="dataRecovery()">修复数据</a>',that);
			}
		});

		$('#empTypeKeyfilter').keyFilter({
			remoteData:true,
			filterByValue:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/EMP_TYPE'
		});
		
		function removeUser(){
			$.messager.alert('提示','功能待完善。');
			return;
			var selectRow = $datagrid.datagrid('getSelected');
			$.messager.confirm("操作提示", '是否将该用户踢下线？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/online/deleteById', {
							id : selectRow.id
					}, function(data) {
						if (data.success) {
							$datagrid.datagrid('reload');
						} else {
							$.messager.alert('警告',data.result);
						}
					});
				}
			});
		}
		
		function dataRecovery(){
			$.messager.confirm("操作提示", '是否修复数据？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/online/dataRecovery', {
					}, function(data) {
						if (data.success) {
							$datagrid.datagrid('reload');
						} else {
							$.messager.alert('警告',data.result);
						}
					});
				}
			});
		}
	</script>
</body>
</html>