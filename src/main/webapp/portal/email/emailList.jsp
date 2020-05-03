<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true" border="false">


	
   <div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:100%;padding:0px;">
   
   <fieldset class="x-fieldset" id="keyFilter">
		<legend class="x-fieldset-header"
			style="width: 95px; margin-bottom: 0px; border: none;">
			<span class="x-fieldset-title">邮件筛选条件</span>
		</legend>

		<div class="row keyfilter-border">
			<ul id="email-status-keyfilter" data-toggle="keyfilter"
				data-title="邮件状态" data-filter-filed="status"
				data-table-Id="email-table">
			</ul>
		</div>
		
	</fieldset>
	
	<table id="email-table" keyFilterDiv="keyFilter"
			singleSelect="true" rownumbers="true" pagination="true" style="width:100%;height:50%;">
		<thead>
			<tr>
				<th field="emailTitle" width="300px" editor="{type:'textbox'}" defaultSearch="true">邮件标题</th>
				<th field="emailMsg" width="500px" editor="{type:'textbox'}">邮件内容</th>
				<th field="sendTime" width="120px" mark="DATE" editor="{type:'datetimebox'}">定时发送时间</th>
				<th field="status" lov="EMAIL_HEADER_STATUS" width="80px" sortable="true" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('EMAIL_HEADER_STATUS'),
																		editable:false}}">发送状态</th>
				<th field="created" width="120px">创建时间</th>
			</tr>
		</thead>
	</table>
	
	<table id="email-item-table"
			singleSelect="true" rownumbers="true" pagination="true" style="width:100%;height:50%;">
		<thead>
			<tr>
				<th field="emailReceiveName" width="120px" editor="{type:'textbox'}">联系人</th>
				<th field="emailReceiveAddr" width="300px" editor="{type:'textbox'}" defaultSearch="true">Email地址</th>
				<!-- <th field="emailReceiveName" width="100px" editor="{type:'textbox'}">Email别名</th> -->
				<th field="sendedTime" width="120px">发送时间</th>
				<th field="status" width="80px" lov="EMAIL_ITEM_STATUS" sortable="true">发送状态</th>
				<th field="errorMsg" width="200px" sortable="true">失败原因</th>
				<th field="created" width="120px">创建时间</th>				
			</tr>
		</thead>
	</table>
	</div>
	<script type="text/javascript">
	   
		$datagrid = $('#email-table');
		$dataItemgrid = $('#email-item-table');
		getLovOfList("[EMAIL_HEADER_STATUS]");
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
			striped:true,
			border:false,
		    pageSize: 15,//每页显示的记录条数，默认为20 
		    pageList: [15,30,50],//可以设置每页记录条数的列表 
			url:'${AppContext.ctxPath}/action/portal/email/queryByExamplePage',
			buttonBatchEdit : true,
			onBatchUpdateAction : function(rows, successFun, errFun, that){
				var rows_2 = [];
				for(var i=0; i< rows.length; i++){
					var row = rows[i];
					var row_2 = {
							row_status   	: "UPDATE",
							id			:row.id,
							emailMsg	:row.emailMsg,
							emailTitle	:row.emailTitle,
							sendTime	:row.sendTime,
							status		:row.status
					}
					rows_2.push(row_2);
				}
				$.ajax({
					url: "${AppContext.ctxPath}/action/portal/email/batchUpdate",
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
				$.post('${AppContext.ctxPath}/action/portal/email/upsert', {
					row_status  :row.row_status,
					id			:row.id,
					emailMsg	:row.emailMsg,
					emailTitle	:row.emailTitle,
					sendTime	:row.sendTime,
					status		:row.status
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
						$.post('${AppContext.ctxPath}/action/portal/email/deleteById', {
								id : row.id
						}, function(data) {
							if (!data.success) {
								errFun(data.result,that);
							}else{
								successFun(that, data);
							}
						});
					}
				});
			},
			onChangeSelectedItem:function(row){
				$dataItemgrid.hdatagrid("changeParentItemAndParams",{emailId:row.id});
			}
		});


	   $('#email-status-keyfilter').keyFilter({
			remoteData:true,
			filterByValue:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/EMAIL_HEADER_STATUS'
	   });
		   
		$dataItemgrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			striped:true,
			border:false,
			title:'Email收件人列表',
		    pageSize: 15,//每页显示的记录条数，默认为20 
		    pageList: [15,30,50],//可以设置每页记录条数的列表 
			url:'${AppContext.ctxPath}/action/portal/emailItem/queryByExamplePage',
			buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/emailItem/batchUpdate",
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
				$.post('${AppContext.ctxPath}/action/portal/emailItem/upsert', {
					row_status   	 	: row.row_status,
					id					:row.id,
					contactId			:row.contactId,
					emailId				:$dataItemgrid.hdatagrid("getParentParams").emailId,
					emailReceiveAddr	:row.emailReceiveAddr,
					emailReceiveName	:row.emailReceiveName,
					sendedTime			:row.sendedTime,
					errorMsg			:row.errorMsg,
					status				:row.status
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
						$.post('${AppContext.ctxPath}/action/portal/emailItem/deleteById', {
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