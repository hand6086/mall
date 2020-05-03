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

	<div data-options="region:'center'" border="false" style="width: 100%; padding: 0px;">
		<table id="online-user-table">
			<thead>
				<tr>
					<th field="id" width="150px">ID</th>
					<th field="userId" width="50px" hidden="true">用户ID</th>
					<th field="firstName" width="150px" defaultSearch="true">姓名</th>
					<th field="loginName" width="150px">用户名</th>
					<th field="loginTime" width="150px">登录时间</th>
					<th field="userSource" width="150px">登录类型</th>
					<th field="ipAddress" width="150px">IP地址</th>
					<th field="userAgent" width="150px">登录浏览器</th>
				</tr>
			</thead>
		</table>
	</div>
	<script type="text/javascript">
/* 	var row = {name: '我的日志', value: appCtx.userId};
	var data = [];
	data.push(row);
	$('#fixed-keyfilter-ul').keyFilter({
 		remoteData : false,
		filterByValue : true,
		filterList : data
	}); */
		$datagrid = $('#online-user-table');
		$datagrid.hdatagrid({
			toolbarShow:true,
			buttonSearch:true,
			buttonExport:true,
			oauthFlag:true,
			width:'100%',
			height:'100%',
			url : '${AppContext.ctxPath}/action/portal/loginlog/queryByExamplePage',
			onAddMoreButton:function(that,addButtonFun){
				//addButtonFun(91,'<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="removeUser()">剔除用户</a>',that);
				//addButtonFun(92,'<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="dataRecovery()">修复数据</a>',that);
			}
		});
		
		/* 
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
		 */
	</script>
</body>
</html>