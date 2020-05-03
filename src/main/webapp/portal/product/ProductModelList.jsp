<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" /> 
<%@ include file="/portal/header.jsp" %>
<body>
	<table id="productModel-table" fit="true" border="false"
		singleSelect="true" rownumbers="true" toolbar="#productModel-table-toolbar">
	<thead>
		<tr>
			<th field="modelName" width="20%" editor="{type:'validatebox',options:{required:true}}">产品型号</th>
			<!-- <th field="company" width="30%" editor="{type:'combobox',
													options:{valueField:'text',
															textField:'text',
															method:'post',
															url:'${AppContext.ctxPath}/action/portal/orgnization/companyList',
															editable:false,
															loadFilter:function(data){return data;},
															onSelect:function(record){}
															}
													}">营销公司</th> -->
			<th field="comments" width="30%" editor="{type:'validatebox'}">备注</th>
		</tr>
	</thead>
</table>
	<script type="text/javascript">
	
	   $datagrid = $('#productModel-table');
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			buttonCopy:true,
			buttonExport:true,
			buttonImport:true,
			oauthFlag:true,
			url:'${AppContext.ctxPath}/action/portal/prodmodel/queryByExamplePage',
			buttonBatchEdit : true,
			onBatchUpdateAction : function(rows, successFun, errFun, that){
				var rows_2 = [];
				for(var i=0; i< rows.length; i++){
					var row = rows[i];
					var row_2 = {
							row_status   	: "UPDATE",
							id				: row.id,
							modelName 		: row.modelName,
							comments 		: row.comments
					}
					rows_2.push(row_2);
				}
				$.ajax({
					url: "${AppContext.ctxPath}/action/portal/prodmodel/batchUpdate",
					type:"post",
					data:JSON.stringify(rows_2),
					dataType:"json",
					contentType: "application/json",
					success: function(data){
						if(data.success){
							successFun(that, data);
						}else{
							errFun(that, data);
						}
					},
					error: function(xhr, code, msg){
						errFun(that, "msg");
					}
				});
			},				
			onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				$.post('${AppContext.ctxPath}/action/portal/prodmodel/upsert', {
					row_status   	: row.row_status,
					id				: row.id,
					modelName 		: row.modelName,
					comments 		: row.comments
				}, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			},
			onDeleteAction:function(row,successFun,errFun,that) {
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/prodmodel/deleteById', {
								id : row.id
						}, function(data) {
								if (!data.success) {
									errFun(data.result,that);
								} else {
									successFun(that, data);
								}
						});
					}
				});
			}
		});
	</script>
</body>
</html>