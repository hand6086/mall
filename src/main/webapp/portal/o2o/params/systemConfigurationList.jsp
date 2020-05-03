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
		<div data-options="region:'north',split:true" title="" border="false" fit="true">
   			<fieldset class="x-fieldset" id="systemConfigurationKeyFilter">
				<legend class="x-fieldset-header" style="width: 95px; margin-bottom: 0px; border: none;">
					<span class="x-fieldset-title">线索筛选条件</span>
				</legend>
		
				<div class="row keyfilter-border">
					<ul id="systemConfiguration-platform-keyfilter" data-toggle="keyfilter"
						data-title="短信平台切换" data-filter-filed="tAttr01" data-table-id="systemConfiguration-table">
					</ul>
				</div>
			</fieldset>
			<table id="systemConfiguration-table" singleSelect="true" rownumbers="true" keyFilterDiv="systemConfigurationKeyFilter" pagination="true" fit="true">
				<thead>
					<tr>
						<th field="name" width="200px" editor="{type:'text'}">名称</th>
						<th field="code" width="200px" editor="{type:'text'}">编码</th>
						<th field="value" width="160px" editor="{type:'text'}">值</th>
						<th field="tAttr01" width="120px" lov="TB_O2O_SMS_PLATFORM_CHANGE" editor="{type:'combobox',options:{valueField:'name',textField:'name',method:'get',
											data:getLovArray('TB_O2O_SMS_PLATFORM_CHANGE'),editable:false}}">短信平台切换</th>
						<th field="notes" width="360px" editor="{type:'text'}">说明</th>
						
					</tr>
				</thead>
			</table>
		</div>
	<script type="text/javascript">
		$datagrid = $('#systemConfiguration-table');
		$datagrid.hdatagrid({
			updateable : true,    
			toolbarShow:true,	//显示工具栏
			buttonSearch:true,	//搜索框功能
			buttonNew:true,
			buttonDelete:true,
			buttonMenu:true,
			oauthFlag:true,
			menuButtonCount : true,
			striped:true,
			title:'',
			border:false,
			url : '${AppContext.ctxPath}/action/portal/params/systemConfiguration/queryByExamplePage',
		    onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				$.post('${AppContext.ctxPath}/action/portal/params/systemConfiguration/upsert', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that,data);
					}
				});
			},
			onDeleteAction:function(row,successFun,errFun,that) {
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/params/systemConfiguration/deleteById', {
								id : row.id
						}, function(data) {
							if (!data.success) {
								errFun(data.result,that);
							}else{
								successFun(that);
							}
						});
					}
				});
			},
		});
		
		$('#systemConfiguration-platform-keyfilter').keyFilter({
			remoteData:true,
			dataValue : 'name',
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/TB_O2O_SMS_PLATFORM_CHANGE'
		});
	</script>
</body>
</html>