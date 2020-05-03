<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true" border="false">
	
   <div data-options="region:'north',split:true" title="" border="false" fit="true">
	
	<table id="menu-table" 
			singleSelect="true" rownumbers="true"  pagination="true" fit="true">
		<thead>
			<tr>
				<th field="id" width="80px" sortable="true" hidden>菜单ID</th>
				<th field="moduleCode" width="120px" editor="{type:'validatebox'}">编码</th>
				<th field="moduleName" width="100px" editor="{type:'validatebox'}" sortable="true" >菜单名称</th>
				<th field="menuSource" lov="MENU_SOURCE" width="20%" editor="{type:'combobox',options:{valueField:'val',
						textField:'name',data:getLovArray('MENU_SOURCE'),editable:false,required:true}}">菜单应用</th>
				<th field="moduleType" width="50px" defaultSearch="true" editor="{type:'validatebox', options:{required:true}}">类型</th>
				
				<th data-options="field:'universalInd'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}" width="100px">通用版</th>
				      <th data-options="field:'fmcgInd'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}" width="100px">快消行业版</th>
				      <th data-options="field:'highTechInd'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}" width="100px">制造/高科技版</th>
				      <th data-options="field:'homeInd'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}" width="100px">家居行业版</th>
				      <th data-options="field:'finInd'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}" width="100px">金融行业版</th>
				      <th data-options="field:'retailInd'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}" width="100px">零售行业版</th>
				      <th data-options="field:'autoInd'" editor="{type:'checkbox', options:{on:'Y', off:'N'}}" width="100px">汽车行业版</th>
				      
				<th field="reportType" lov="MENU_REPORT_TYPE" width="140px" editor="{type:'combobox',options:{valueField:'val',
						textField:'name',data:getLovArray('MENU_REPORT_TYPE'),editable:false}}">报表类型</th>
                <th field="urlPath" width="300px" editor="{type:'validatebox', options:{required:true}}">URL地址</th>
				<th field="iconName" width="100px" editor="{type:'validatebox', options:{}}">图标</th>
				<th field="description" width="400px" editor="{type:'validatebox', options:{}}">描述</th>
				
				
				
			</tr>
		</thead>
	 </table>
	</div>
   	
	<script type="text/javascript">
		$datagrid = $('#menu-table');
		$datagrid.hdatagrid({
			updateable : true,    
			toolbarShow:true,	//显示工具栏
			buttonSearch:true,	//搜索框功能
			buttonNew:true,
			buttonCopy:true,
			buttonDelete:true,
			buttonMenu:true,
			striped:true,
			title:'',
			border:false,
			url:'${AppContext.ctxPath}/action/portal/appMenu/queryByExamplePage',
			onAddMoreButton:function(that,addButtonFun){
				
			},
			onDeleteAction : function(row,successFun,errFun,that){
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/appMenu/deleteById', {
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
			},
			buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/appMenu/batchUpdate",
							type:"post",
							data:JSON.stringify(rows),
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
					onInsertOrUpdateAction : function(row,successFun,errFun,that) {
				$.post('${AppContext.ctxPath}/action/portal/appMenu/upsert', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			}
		});
	</script>
</body>
</html>