<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<body class="easyui-layout" data-options="fit:true" border="false">
   <div data-options="region:'north'" border="false" style="height:50%;width:100%">
		<table id="news-table"  fit="true">
		<thead>
			<tr>
				<th field="id" width="100px" >编号</th>
				<th field="created" width="120px" >创建时间</th>
				<th field="mediaId" width="120px" defaultSearch="false" editor="{type:'validatebox',options:{required:false}}">素材ID</th>
				<th field="updateTime" width="200px" defaultSearch="false" editor="{type:'validatebox',options:{required:false}}">最后更新时间</th>
			</tr>
		</thead>
	</table>
	</div>
	<div data-options="region:'center'" border="false"
		style="width: 100%;height:50%;">
		<table id="newsItem-table"  fit="true">
			<thead>
				<tr>
					<th field="id" width="100px" >编号</th>
					<th field="created" width="100px" >创建时间</th>
					<th field="headId" width="100px" defaultSearch="false" editor="{type:'validatebox',options:{required:false}}">头ID</th>
					<th field="title" width="100px" defaultSearch="false" editor="{type:'validatebox',options:{required:false}}">标题</th>
					<th field="thumbMediaId" width="180px" defaultSearch="false" editor="{type:'validatebox',options:{required:false}}">封面图片素材id</th>
					<th field="thumbUrl" width="180px" defaultSearch="false" editor="{type:'validatebox',options:{required:false}}">封面图片地址</th>
					<th field="showCoverPic" width="100px" defaultSearch="false" editor="{type:'validatebox',options:{required:false}}">是否显示封面</th>
					<th field="author" width="100px" defaultSearch="false" editor="{type:'validatebox',options:{required:false}}">作者</th>
					<th field="digest" width="150px" defaultSearch="false" editor="{type:'validatebox',options:{required:false}}">摘要</th>
					<th field="content" width="150px" defaultSearch="false" editor="{type:'textarea'}">具体内容</th>
					<th field="url" width="100px" defaultSearch="false" editor="{type:'validatebox',options:{required:false}}">URL</th>
					<th field="contentSourceUrl" width="100px" defaultSearch="false" editor="{type:'validatebox',options:{required:false}}">原文地址</th>
					<th field="itemIndex" width="100px" defaultSearch="false" editor="{type:'validatebox',options:{required:false}}">图文序列</th>
				</tr>
			</thead>
		</table>
	</div>
   	<div>
		<form method="post" class="importForm" enctype="multipart/form-data" style = "width:54px;display:inline-block">';
			<a href="javascript:void(0)" class="file easyui-linkbutton-import-list-table moreToolbar_notHideFlag" iconCls="icon-table-add" plain="true">';
			<input type="file" style="width: 50px;position: absolute;right:0;top:0;opacity: 0;" 
			class="importButton" id="importFile" name="importFile" onchange="uploadFile()"/></a>';
		</form>
	</div>
	<script type="text/javascript">
		//getLovOfList("[DEALER_ACCOUNT_TYPE,TRANSACTION_SOURCE_TYPE]");
		$datagrid = $('#news-table');
		$datagridItem = $('#newsItem-table');

		$datagridItem.hdatagrid({
			title:'',
		    pageSize: 15,//每页显示的记录条数，默认为20 
		    pageList: [15,30,50],//可以设置每页记录条数的列表 
			updateable : true,
			toolbarShow : true,
			buttonSearch : true,
			buttonNew : true,
			buttonDelete : true,
			buttonCopy : true,
			//buttonExport : true,
			//buttonImport : true,
			newDefaultValue : true,
			parentGridId : 'news-table',
		    parentGridField : 'id',
		    linkGridField : 'headId',
		    refreshParentType : 'row',
			striped : true,
			border : false,
			url:'${AppContext.ctxPath}/action/portal/newsItem/queryByExamplePage',
			buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/newsItem/batchUpdate",
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
				$.post('${AppContext.ctxPath}/action/portal/newsItem/upsert', row, function(data) {
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
						$.post('${AppContext.ctxPath}/action/portal/newsItem/deleteById', {
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
			/**
			 * 初始化新建的数据
			 */
			onInitNewData:function(that){
				return {
					created : appCtx.sysdate(),
					orgId : appCtx.orgId,
					orgName : appCtx.orgName,
					postnId : appCtx.postnId,
					postnName : appCtx.postnName,
					headId : $datagrid.datagrid('getSelected').id
				};
			},
			onAddMoreButton:function(that,addButtonFun){
			}
		});
		$datagrid.hdatagrid({
			title:'',
		    pageSize: 15,//每页显示的记录条数，默认为20 
		    pageList: [15,30,50],//可以设置每页记录条数的列表 
			updateable : true,
			toolbarShow : true,
			buttonSearch : true,
			buttonNew : true,
			buttonDelete : true,
			buttonCopy : true,
			//buttonExport : true,
			//buttonImport : true,
			newDefaultValue : false,
			striped : true,
			border : false,
			subGridIds: ['newsItem-table'],
			url:'${AppContext.ctxPath}/action/portal/news/queryByExamplePage',
			buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/news/batchUpdate",
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
				delete row.newsItemList;
				$.post('${AppContext.ctxPath}/action/portal/news/upsert', row, function(data) {
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
						$.post('${AppContext.ctxPath}/action/portal/news/deleteById', {
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
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(1,'<a href="javascript:void(0)" id="btn-active" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newMateria()">新建</a>',that);				
				addButtonFun(90,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="ansyMateria()" iconCls="icon-reload" plain="true">素材同步</a>',that);
			},
			/**
			 * 初始化新建的数据
			 */
			onInitNewData:function(that){
				return {
					created : appCtx.sysdate(),
					orgId : appCtx.orgId,
					orgName : appCtx.orgName,
					postnId : appCtx.postnId,
					postnName : appCtx.postnName
				};
			}
		});

		function ansyMateria() {
			operationprogress('进度提示', '正在同步...');
			$.get('${AppContext.ctxPath}/action/portal/news/ansyMateria',
					function(data) {
						/* console.log(data); */
						if (!data.success) {
							$.messager.alert("操作提示", data.result, "error");
						} else {
							$.messager.progress('close');
							$datagrid.datagrid('reload');
							$.messager.alert("操作提示","已同步" + data.total + "条记录", "info");
						}
					});
		}
		
		function newMateria() {
			document.getElementById("importFile").click();
		}
		
		function uploadFile(){
			var fileName = $("#importFile").val();
	   		console.log(fileName);
	   		var fileext=fileName.substring(fileName.lastIndexOf("."),fileName.length)  
	   		fileext=fileext.toLowerCase();  
			console.log(fileext);
   		    if (fileext!='.json'){  
   		        alert("对不起，导入文件只能json！");  
   		        return;  
   		    }
			operationprogress('进度提示', '正在导入永久素材...');
   		    
   		 	var options = {
	   				url:'${AppContext.ctxPath}/action/portal/news/addEverMateriaNoNews',
	   				type:'post',
	   				dataType:'json',
	   				contentType:"application/octet-stream;charset=utf-8",
	   				success : function(data) {
	   					//$.messager.progress('close');
	   					if(data.success){
	   						$.messager.progress('close');
	   						$.messager.alert("操作提示","导入数据成功！", "info");
	   					}else{
	   						if(data.result == null){
	   							data.result = "导入数据失败！";
	   						}
	   						alert(data.result);
	   					}
	   				}
	   		};
	   		//$('.importForm').ajaxSubmit(options);
		}
	</script>
</body>
</html>
