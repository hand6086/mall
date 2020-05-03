<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<body class="easyui-layout" data-options="fit:true" border="false">
    <div data-options="region:'north',split:true" border="false" style="width:100%;" fit="true">
	<table id="charts-table" style="height:50%;width:100%" >
		<thead>
			<tr>
				<th field="id" width="100px" >编号</th>
				<th field="created" width="130px" >创建时间</th>
				<th field="chartsName"    width="100px" editor="{type:'validatebox',options:{required:false}}"  >报表名称</th>
				<th field="chartTable"    width="100px" editor="{type:'validatebox',options:{required:false}}"  >最终查询表</th>
				<th field="chartKey"    width="100px" editor="{type:'validatebox',options:{required:false}}"  >最终查询表key</th>
			</tr>
		</thead>
	</table>
	<table id="chartsresult-table" style="height:50%;width:100%" >
		<thead>
			<tr>
				<th field="id" width="100px" >编号</th>
				<th field="created" width="130px" >创建时间</th>
				<th field="resultKey" width="180px" editor="{type:'validatebox',options:{required:false}}"  >结果key</th>
				<th field="resultType"    width="100px" LOV="REPORT_DATA_TYPE" editor="{type:'combobox',	
																				options:{valueField:'val',
																				textField:'name',
																				method:'get',
																				data:getLovArray('REPORT_DATA_TYPE'),
																				editable:true,
																				required:true}}"  >结果类型</th>
				<th field="resultValue"   width="180px" editor="{type:'validatebox',options:{required:false}}"  >结果值</th>
				

			</tr>
		</thead>
	</table>
	
	</div>
   	
	<script type="text/javascript">
		$datagrid = $('#charts-table');
		$dataresultgrid = $('#chartsresult-table');
		$datagrid.hdatagrid({
			buttonNew:true,
			updateable:true,
			toolbarShow:true,
			buttonDelete:true,
			buttonSearch:true,
			subGridIds: ['chartsresult-table'],
			url:'${AppContext.ctxPath}/action/portal/charts/queryByExamplePage',
			onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				
				$.post('${AppContext.ctxPath}/action/portal/charts/upsert', row, function(data) {
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
						$.post('${AppContext.ctxPath}/action/portal/charts/deleteById', {
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

		$dataresultgrid.hdatagrid({
			buttonNew:true,
			updateable:true,
			toolbarShow:true,
			buttonDelete:true,
			buttonSearch:true,
			parentGridId : 'charts-table',
		    parentGridField : 'id',
		    linkGridField : 'headId',
			url:'${AppContext.ctxPath}/action/portal/chartsresult/queryByExamplePage',

			onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				row.headId=$datagrid.hdatagrid('getCurrentRow').id;
				$.post('${AppContext.ctxPath}/action/portal/chartsresult/upsert', row, function(data) {
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
						$.post('${AppContext.ctxPath}/action/portal/chartsresult/deleteById', {
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

		
		
		
		/*以下为部分参考函数*/
		/*
		
		function ChartsSubmit(){
			var row = $datagrid.datagrid('getSelected');
			if(row.ChartsStatus == '新建'||row.ChartsStatus == '已拒绝'){
				$.post('/action/portal/Charts/ChartsSubmit', 
				{
					id	: row.id,
					ChartsStatus : '已提交'
			    },
				function(data){
			    	if(!data.success){
						window.parent.operationtip(data.result, 'error');
					}else{
						$datagrid.datagrid('reload');
					}
				});
			}else{
				window.parent.operationtip('该线索状态为'+row.ChartsStatus+'，无法提交！', 'error');
			}
		}
		function productPicklistComplete(selectRow){ 
			$datagrid.hdatagrid('updateCurrentRow', {
				prodId : selectRow.id
			});
			return selectRow.prodName;
		}
		*/
	</script>
</body>
</html>
