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
		   <fieldset class="x-fieldset" id="messagePushTemplateKeyFilter">
				<legend class="x-fieldset-header" style="width: 95px; margin-bottom: 0px; border: none;">
					<span class="x-fieldset-title">线索筛选条件</span>
				</legend>
		
				<div class="row keyfilter-border">
					<ul id="messagePushTemplate-type-keyfilter" data-toggle="keyfilter"
						data-title="消息类型" data-filter-filed="tAttr01" data-table-Id="messagePushTemplate-table">
					</ul>
				</div>
			</fieldset>
			<table id="messagePushTemplate-table" singleSelect="true" rownumbers="true" keyFilterDiv="messagePushTemplateKeyFilter" pagination="true" fit="true">
				<thead>
					<tr>
						<th field="tAttr01" width="160px" lov="TB_O2O_APP_MSG_TYPE" editor="{type:'combobox',options:{valueField:'val',textField:'name',method:'get',
											data:getLovArray('TB_O2O_APP_MSG_TYPE'),editable:false,required:true}}">消息类型</th>
						<th field="msgContext" width="600px" editor="{type:'textarea'}">消息内容</th>
						
						<th field="id" width="60px" noSearch="true" hidden="true">Id</th>
					</tr>
				</thead>
			</table>
		</div>
	<script type="text/javascript">
		$datagrid = $('#messagePushTemplate-table');
		$datagrid.hdatagrid({
			updateable : true,    
			toolbarShow:true, //显示工具栏
			buttonSearch:true, //搜索框功能
			buttonNew:true,
			buttonDelete:true,
			buttonMenu:true,
			oauthFlag:true,
			menuButtonCount : true,
			striped:true,
			title:'',
			border:false,
			url : '${AppContext.ctxPath}/action/portal/params/messagePushTemplate/queryByExamplePage',
		    onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				$.post('${AppContext.ctxPath}/action/portal/params/messagePushTemplate/upsert', row, function(data) {
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
						$.post('${AppContext.ctxPath}/action/portal/params/messagePushTemplate/deleteById', {
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
		
		$('#messagePushTemplate-type-keyfilter').keyFilter({
			remoteData:true,
			dataValue:'name',
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/TB_O2O_APP_MSG_TYPE'
		});
	</script>
</body>
</html>