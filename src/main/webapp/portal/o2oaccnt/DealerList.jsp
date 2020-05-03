<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<style type="text/css">


</style>
<body >
<div class="easyui-layout" data-options="fit:true" border="false">
   <div data-options="region:'north',split:true" title="" border="false" fit="true">
	 <fieldset class="x-fieldset" id="keyFilter">
				<legend class="x-fieldset-header"
					style="width: 95px; margin-bottom: 0px; border: none;">
					<span class="x-fieldset-title">快速筛选</span>
				</legend>

				<div class="row keyfilter-border">
					<ul id="frsTypeKeyfilter" data-toggle="keyfilter" data-title="一级分类"
						data-filter-filed="frsType" data-table-Id="account-table">
				</ul>
				</div> 
		</fieldset>
	<table id="account-table" keyFilterDiv="keyFilter"
			singleSelect="true" rownumbers="true"  pagination="true" fit="true">
		<thead>
			<tr>
				<th field="erpCode" width="100px" sortable="true">ERP编码</th>
				<th field="siebleCode" width="100px" sortable="true"  editor="{type:'textbox', options:{required:true}}">SIEBEL编码</th>
				<th field="acctName" width="230px" editor="{type:'textbox', options:{required:true}}">客户名称</th>
                <th field="orgCity" width="230px" >城市大区</th>
				<th field="orgName" width="150px" >销售单位</th>
				<th field="frsType" width="250px" lov="ACCOUNT_TYPE" editor="{type:'combobox',options:{
																		valueField:'val',
																		textField:'name',
																		data:getLovArray('ACCOUNT_TYPE'),
																		editable:false}}">一级分类</th>	
			</tr>
		</thead>
	</table>
	</div>
</div>
	<script type="text/javascript">		
		$datagrid = $('#account-table');		
		$datagrid.hdatagrid({
			updateable : false,    
			toolbarShow:true,	//显示工具栏
			buttonSearch:true,	//搜索框功能
			buttonExport:true,
			buttonDelete:false,
			buttonCopy:false,
			buttonMenu:true,
			striped:true,
			title:'',
			border:false,//边框
			url:'${AppContext.ctxPath}/action/portal/dealerAccount/queryByExamplePage',

/* 			onInsertAction : function(row,successFun,errFun,that) {
				delete row.children;
				$.post('${AppContext.ctxPath}/action/portal/accnt/insert', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			},
			onUpdateAction : function(row,successFun,errFun,that) {
				delete row.children;
				$.post('${AppContext.ctxPath}/action/portal/accnt/update', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			}, 
			onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				$.post('${AppContext.ctxPath}/action/portal/dealerAccount/upsert', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that,data);
					}
				});
			},
			onDeleteAction:function(row,successFun,errFun,that){
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/accnt/deleteById', {
								id : row.id
						}, function(data) {
								if (!data.success) {
									errFun(data.result,that);
								} else {
									successFun(that);
								}
						});
					}
				});
			}*/
		});
		//快速筛选一级分类
		 $('#frsTypeKeyfilter').keyFilter({		   
			remoteData:true,
			filterByValue:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/ACCOUNT_TYPE'
	  	 }); 
	</script>
</body>
</html>