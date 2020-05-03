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
		 <table id="account-table" singleSelect="true" rownumbers="true" pagination="true" fit="true">
				<thead>
					<tr>
						<th field="type" width="100px" lov="TB_O2O_PAYMENT_TYPE" editor="{
																					type:'combobox',options:{
																					valueField:'val',
																					textField:'name',
																					method:'get',
																					data:getLovArray('TB_O2O_PAYMENT_TYPE'),
																					editable:false,
																					required:true
																					}}">平台账号类型</th>
						<th field="bank" width="100px" lov="TB_O2O_BANK" editor="{type:'combobox',options:{
																					valueField:'val',
																					textField:'name',
																					method:'get',
																					data:getLovArray('TB_O2O_BANK'),
																					editable:false,
																					required:true
																					}}">开户行</th>
						<th field="cardNum" width="100px" editor="{type:'numberbox',options:{
																					min:0,
																					precision:0,
																					required:true}}">平台账号</th>
						<th field="accntHolder" width="100px" editor="{type:'textbox',options:{required:true}}">收款人名称</th>
						<th field="sequence" width="100px" editor="{type:'numberbox',options:{
																					min:0,
																					precision:0,
																					required:true}}">序号</th>
					</tr>
				</thead>
		  </table>
		</div>
	<script type="text/javascript">
		$datagrid = $('#account-table');
		$datagrid.hdatagrid({
			updateable : true,    
			toolbarShow:true,	//显示工具栏
			buttonSearch:true,	//搜索框功能
			buttonNew:true,
			buttonDelete:true,
			buttonMenu:true,
			oauthFlag:false,
			menuButtonCount : true,
			striped:true,
			title:'',
			border:false,
			url : '${AppContext.ctxPath}/action/portal/account/queryAccountPickListPage',
			
			onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				$.post('${AppContext.ctxPath}/action/portal/account/accountUpsert', row, function(data) {
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
						$.post('${AppContext.ctxPath}/action/portal/account/deleteById', {
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
	</script>
</body>
</html>