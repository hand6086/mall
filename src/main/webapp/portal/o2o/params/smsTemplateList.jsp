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
		   <fieldset class="x-fieldset" id="smsTemplateKeyFilter">
				<legend class="x-fieldset-header" style="width: 95px; margin-bottom: 0px; border: none;">
					<span class="x-fieldset-title">线索筛选条件</span>
				</legend>
		
				<div class="row keyfilter-border">
					<ul id="smsTemplate-smsType-keyfilter" data-toggle="keyfilter"
						data-title="短信类型" data-filter-filed="tAttr01" data-table-Id="smsTemplate-table">
					</ul>
				</div>
			</fieldset>
		  <table id="smsTemplate-table" singleSelect="true" rownumbers="true" keyFilterDiv="smsTemplateKeyFilter" pagination="true" fit="true">
				<thead>
					<tr>
						<th field="tAttr01" width="140px" lov="TB_O2O_SMS_TYPE" editor="{type:'combobox',options:{valueField:'val',textField:'name',method:'get',
											data:getLovArray('TB_O2O_SMS_TYPE'),editable:false,required:true}}">短信类型</th>
						<th field="msgContext" width="400px" editor="{type:'textarea'}">短信内容</th>
						<th field="tAttr03" width="100px" editor="{type:'text'}">容联云模板ID</th>
						
						<th field="id" width="60px" noSearch="true" hidden="true">id</th>
					</tr>
				</thead>
			</table>
		</div>
	<script type="text/javascript">
		$datagrid = $('#smsTemplate-table');
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
			url : '${AppContext.ctxPath}/action/portal/params/smsTemplate/queryByExamplePage',
		    onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				$.post('${AppContext.ctxPath}/action/portal/params/smsTemplate/upsert', row, function(data) {
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
						$.post('${AppContext.ctxPath}/action/portal/params/smsTemplate/deleteById', {
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
			}
		});
		
		$('#smsTemplate-smsType-keyfilter').keyFilter({
			remoteData:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/TB_O2O_SMS_TYPE'
		});
	</script>
</body>
</html>