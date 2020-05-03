<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true" border="false">


	
   <div data-options="region:'north',split:true" border="false" style="width:100%;padding:0px;" fit="true">
   
   <fieldset class="x-fieldset" id="keyfilter">
		<legend class="x-fieldset-header"
			style="width: 95px; margin-bottom: 0px; border: none;">
			<span class="x-fieldset-title">活动筛选条件</span>
		</legend>

		<div class="row keyfilter-border">
			<ul id="activity-type-keyfilter" data-toggle="keyfilter"
				data-title="活动类型" data-filter-filed="type"
				data-table-Id="activity-table">
			</ul>
		</div>
		<div class="row keyfilter-border">
			<ul id="activity-status-keyfilter" data-toggle="keyfilter"
				data-title="活动状态" data-filter-filed="status"
				data-table-Id="activity-table">
			</ul>
		</div>
	</fieldset>
	
	<table id="activity-table"
			singleSelect="true" rownumbers="true" toolbar="#activity-table-toolbar" fit="true" pagination="true" style="width:100%;" keyFilterDiv="keyfilter">
		<thead>
			<tr>
				<th field="type" width="80px" lov="TUDO_CD" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		method:'get',
																		data:getLovArray('TUDO_CD'),
																		editable:false,
																		required:true}}"sortable="true">活动类型</th>
				<th field="important" width="50px" lov="ACTIVITY_IMPORTANT" sortable="true" 
																editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		method:'get',
																		data:getLovArray('ACTIVITY_IMPORTANT'),
																		editable:false,
																		required:true}}">重要性</th>
				<th field="status" width="80px" lov="EVT_STAT_CD" sortable="true" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		method:'get',
																		data:getLovArray('EVT_STAT_CD'),
																		editable:false,
																		required:true}}">活动状态</th>
				<th field="description" width="230px" defaultSearch="true" editor="{type:'validatebox', options:{required:true}}">活动内容</th>
				<th field="planStartDt" width="100px" mark="DATE" editor="{type:'datetimebox',options:{showSeconds:false}}">计划开始时间</th>
				<th field="planEndDt" width="100px" mark="DATE" editor="{type:'datetimebox',options:{showSeconds:false}}">计划结束时间</th>
				<th field="actlStartDt" width="100px" mark="DATE" editor="{type:'datetimebox',options:{showSeconds:false}}">实际开始时间</th>
				<th field="actlEndDt" width="100px" mark="DATE" editor="{type:'datetimebox',options:{showSeconds:false}}">实际结束时间</th>
				<th field="optyName" width="120px" editor="{type:'picklistbox',options:{title:'选择商机',completeFun:optyPicklistComplete,tableUrl:'${AppContext.ctxPath}/portal/picklist/optyPickList.jsp'}}">商机名称</th>
				<th field="accntName" width="120px" editor="{type:'picklistbox',options:{title:'选择客户',completeFun:accntPicklistComplete,tableUrl:'${AppContext.ctxPath}/portal/picklist/accountPickList.jsp'}}">客户名称</th>
                <th field="contactsName" width="80px"  editor="{type:'picklistbox',options:{title:'选择联系人',initParam:initContactPicklistParam,completeFun:contactPicklistComplete,tableUrl:'${AppContext.ctxPath}/portal/picklist/contactPickList.jsp'}}">联系人</th>
				<th field="orgName" width="130px" editor="{type:'picklistbox',options:{title:'选择组织',
															completeFun:orgPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/orgPickList.jsp'}}">组织</th>
				<th field="postnName" width="130px" editor="{type:'picklistbox',options:{title:'选择职位',
															completeFun:postnPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/positionPickList.jsp'}}">职位</th>
															
				<th field="created" width="130px" mark="DATE">创建时间</th>
			</tr>
		</thead>
	</table>
	</div>
   	
	<script type="text/javascript">
	   
	   $datagrid = $('#activity-table');
	   getLovOfList("[TUDO_CD,ACTIVITY_IMPORTANT,EVT_STAT_CD]");
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			buttonCopy:true,
			buttonExport:true,
			buttonImport:true,
			newDefaultValue:true,
			oauthFlag:true,
			striped:true,
			border:false,
			url:'${AppContext.ctxPath}/action/portal/activity/queryByExamplePage',
			buttonBatchEdit : true,
			onBatchUpdateAction : function(rows, successFun, errFun, that){
				var rows_2 = [];
				for(var i=0; i< rows.length; i++){
					var row = rows[i];
					var row_2 = {
							row_status   	: "UPDATE",
							id			:row.id,
							description	:row.description,
							important	:row.important,
							type		:row.type,
							status		:row.status,
							comments	:row.comments,
							actlEndDt	:row.actlEndDt,
							actlStartDt	:row.actlStartDt,
							planEndDt	:row.planEndDt,
							planStartDt	:row.planStartDt,
							optyId		:row.optyId,
							accntId		:row.accntId,
							postnId		:row.postnId,
							orgId		:row.orgId,
							empId		:'noMatchId',
							contactId	:row.contactId
					}
					rows_2.push(row_2);
				}
				$.ajax({
					url: "${AppContext.ctxPath}/action/portal/activity/batchUpdate",
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
				$.post('${AppContext.ctxPath}/action/portal/activity/upsert', {
					row_status  :row.row_status,
					id			:row.id,
					description	:row.description,
					important	:row.important,
					type		:row.type,
					status		:row.status,
					comments	:row.comments,
					actlEndDt	:row.actlEndDt,
					actlStartDt	:row.actlStartDt,
					planEndDt	:row.planEndDt,
					planStartDt	:row.planStartDt,
					optyId		:row.optyId,
					accntId		:row.accntId,
					postnId		:row.postnId,
					orgId		:row.orgId,
					empId		:'noMatchId',
					contactId	:row.contactId
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
						$.post('${AppContext.ctxPath}/action/portal/activity/deleteById', {
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

	   $('#activity-type-keyfilter').keyFilter({
			remoteData:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/TUDO_CD'
	   });
	   $('#activity-status-keyfilter').keyFilter({
			remoteData:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/EVT_STAT_CD'
	   });
       
		function accntPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').accntId = selectRow.id;
			return selectRow.acctName;
		}
		
		function contactPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').contactId = selectRow.id;
			return selectRow.contactsName;
		}
		function optyPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').optyId = selectRow.id;
			return selectRow.optyName;
		}
		
		//初始化联系人客户Id
		function initContactPicklistParam(){
			var accntIdValue = $datagrid.hdatagrid('getCurrentRow').accntId;
			if(accntIdValue == null || accntIdValue == ''){
				return {attr1:'noMatchId'};
			}else{
				return {attr1:accntIdValue};
			}
		}
		
		function orgPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').orgId = selectRow.id;
			return selectRow.text;
		}

		function postnPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').postnId = selectRow.id;
			return selectRow.text;
		}
		
	</script>
</body>
</html>