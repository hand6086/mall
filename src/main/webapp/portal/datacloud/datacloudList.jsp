<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<body>
	<div id="data_layout"  class="easyui-layout" border="false" fit="true">
		
		<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:30%;padding:0px;">
			<table id="datacloud-table" fit="true">
				<thead>
					<tr>
						<th field="id" width="5%" noSearch="true">ID</th>
						<th field="dcname" defaultSearch="true"   width="15%" editor="{type:'validatebox',options:{required:false}}"  >名称</th>
						<th field="website" defaultSearch="false"   width="15%" editor="{type:'validatebox',options:{required:false}}"  >官网</th>
						<th field="attr01" defaultSearch="false"   width="15%" editor="{type:'validatebox',options:{required:false}}"  >备注1</th>
						<th field="attr02" defaultSearch="false"   width="15%" editor="{type:'validatebox',options:{required:false}}"  >备注2</th>
						<th field="attr03" defaultSearch="false"   width="15%" editor="{type:'validatebox',options:{required:false}}"  >备注3</th>
						<th field="attr04" defaultSearch="false"   width="15%" editor="{type:'validatebox',options:{required:false}}"  >备注4</th>
					</tr>
				</thead>
			</table>	
		</div>
		
		<div data-options="region:'center'" border="false" style="width:100%;height:30%;padding:0px;">
			<table id="dataclouddt-table" title="市场销售数据抓取日期" fit="true">
				<thead>
					<tr>
						<th field="id" width="10%"  noSearch="true">ID</th>
						<th field="dt" defaultSearch="false"   width="15%" editor="{type:'validatebox',options:{required:false}}"  >日期</th>
						<th field="status" defaultSearch="false"   width="15%" editor="{type:'validatebox',options:{required:false}}"  >状态</th>
						<th field="attr01" defaultSearch="false"   width="10%" editor="{type:'validatebox',options:{required:false}}"  >备注1</th>
						<th field="attr02" defaultSearch="false"   width="10%" editor="{type:'validatebox',options:{required:false}}"  >备注2</th>
						<th field="attr03" defaultSearch="false"   width="10%" editor="{type:'validatebox',options:{required:false}}"  >备注3</th>
						<th field="attr04" defaultSearch="false"   width="10%" editor="{type:'validatebox',options:{required:false}}"  >备注4</th>
						<th field="loginfo" defaultSearch="false"   width="10%" editor="{type:'validatebox',options:{required:false}}"  >日志</th>
					</tr>
				</thead>
			</table>
		</div>
		
		<div data-options="region:'south',split:true" title="市场销售数据抓取日期"  border="false" style="width:100%;height:40%;padding:0px;">
			<table id="dataclouddt-item-table" fit="true">
				<thead>
					<tr>
						<th field="id" width="10%"  noSearch="true">ID</th>
						<th field="type01" defaultSearch="false"   width="5%" editor="{type:'validatebox',options:{required:false}}"  >一级类型</th>
						<th field="type02" defaultSearch="false"   width="5%" editor="{type:'validatebox',options:{required:false}}"  >二级类型</th>
						<th field="type03" defaultSearch="false"   width="5%" editor="{type:'validatebox',options:{required:false}}"  >三级类型</th>
						<th field="type04" defaultSearch="false"   width="5%" editor="{type:'validatebox',options:{required:false}}"  >四级类型</th>
						<th field="type05" defaultSearch="false"   width="5%" editor="{type:'validatebox',options:{required:false}}"  >五级类型</th>
						<th field="name" defaultSearch="false"   width="6%" editor="{type:'validatebox',options:{required:false}}"  >名称</th>
						<th field="desc1" defaultSearch="false"   width="6%" editor="{type:'validatebox',options:{required:false}}"  >说明</th>
						<th field="oldprice" defaultSearch="false"   width="6%" editor="{type:'validatebox',options:{required:false}}"  >原价</th>
						<th field="price" defaultSearch="false"   width="6%" editor="{type:'validatebox',options:{required:false}}"  >促销价</th>
						<th field="img" defaultSearch="false"   width="6%" editor="{type:'validatebox',options:{required:false}}"  >图片</th>
						<th field="attr01" defaultSearch="false"   width="6%" editor="{type:'validatebox',options:{required:false}}"  >备注1</th>
						<th field="attr02" defaultSearch="false"   width="6%" editor="{type:'validatebox',options:{required:false}}"  >备注2</th>
						<th field="attr03" defaultSearch="false"   width="6%" editor="{type:'validatebox',options:{required:false}}"  >备注3</th>
						<th field="attr04" defaultSearch="false"   width="6%" editor="{type:'validatebox',options:{required:false}}"  >备注4</th>
					</tr>
				</thead>
			</table>	
		</div>
		
	</div>
   	
	<script type="text/javascript">
		$('#data_layout').layout();
		$datagrid = $('#datacloud-table');
		$dataclouddtgrid = $('#dataclouddt-table');
		$dataclouddtItemgrid = $('#dataclouddt-item-table');
		
		//第一级
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			buttonCopy:true,
		    subGridIds: ['dataclouddt-table'],
		    pageSize: 5,//每页显示的记录条数，默认为10 
		    pageList: [5,10,15],//可以设置每页记录条数的列表 
			url:'${AppContext.ctxPath}/action/portal/datawebcloud/queryByExamplePage',
			buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/datawebcloud/batchUpdate",
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
					onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				$.post('${AppContext.ctxPath}/action/portal/datawebcloud/upsert', row, function(data) {
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
						$.post('${AppContext.ctxPath}/action/portal/datawebcloud/deleteById', {
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
		
		//第二级
		$dataclouddtgrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			buttonCopy:true,
		    parentGridId : 'datacloud-table',
		    parentGridField : 'id',
		    linkGridField : 'parentid',
		    subGridIds: ['dataclouddt-item-table'],
			url:'${AppContext.ctxPath}/action/portal/datawebclouddt/queryByExamplePage',
		    pageSize: 5,//每页显示的记录条数，默认为10 
		    pageList: [5,10,15],//可以设置每页记录条数的列表 
		    onAddMoreButton:function(that,addButtonFun){
		    	//addButtonFun(91,'<a href="javascript:void(0)" id="selectAccountBtn" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="selectMenuItemWindow()">新建</a>',that);
		    	//addButtonFun(92,'<a href="javascript:void(0)"  class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="delSelectedMenu()">删除</a>',that);
			},
			buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/datawebclouddt/batchUpdate",
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
					onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				$.post('${AppContext.ctxPath}/action/portal/datawebclouddt/upsert', row, function(data) {
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
						$.post('${AppContext.ctxPath}/action/portal/datawebclouddt/deleteById', {
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
		
		//第三级 
		$dataclouddtItemgrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			buttonCopy:true,
			pagination:true,
		    parentGridId : 'dataclouddt-table',
		    parentGridField : 'id',
		    linkGridField : 'parentid',
			url:'${AppContext.ctxPath}/action/portal/datawebclouddtItem/queryByExamplePage',
		    pageSize: 10,//每页显示的记录条数，默认为10 
		    pageList: [5,10,15],//可以设置每页记录条数的列表 
		    onAddMoreButton:function(that,addButtonFun){
				//addButtonFun(91,'<a href="javascript:void(0)" id="selectSubItemBtn" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="selectSubMenuItemWindow()">新建</a>',that);
				//addButtonFun(92,'<a href="javascript:void(0)"  class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="delSelectedSubMenu()">删除</a>',that);
			},
			onUpdateAction:function(row,successFun,errFun,that) {
		    	$.post('${AppContext.ctxPath}/action/portal/datawebclouddtItem/upsert', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
		    },
		});
		
		
		
		
	
	</script>
</body>
</html>