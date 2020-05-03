<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<script src="${AppContext.ctxPath}/static/js/jquery.easyui.validate.js?version=<%=version%>"></script>
<body class="easyui-layout" data-options="fit:true" border="false">
		<fieldset class="x-fieldset" id="keyFilter">
			 <legend class="x-fieldset-header"
				style="width: 95px; margin-bottom: 0px; border: none;">
				<span class="x-fieldset-title">标准筛选条件</span>
			 </legend>
			<div class="row keyfilter-border">
				<ul id="orgName-keyfilter" data-toggle="keyfilter"
					data-title="组别" data-filter-filed="orgName"
					data-table-Id="user-table">
				</ul>
			</div>
			<div class="row keyfilter-border">
				<ul id="positionname-keyfilter" data-toggle="keyfilter"
					data-title="岗位" data-filter-filed="positionname"
					data-table-Id="user-table">
				</ul>
			</div>
			<div class="row keyfilter-border">
				<ul id="update-version-keyfilter" data-toggle="keyfilter"
					data-title="更新版本" data-filter-filed="updateVersion"
					data-table-Id="user-table">
				</ul>
			</div>
			<div class="row keyfilter-border">
				<ul id="source-status-keyfilter" data-toggle="keyfilter"
					data-title="资源状态" data-filter-filed="sourceStatus"
					data-table-Id="user-table">
				</ul>
			</div>
	 	</fieldset>

		<table id="user-table" fit="true" keyFilterDiv="keyFilter">
			<thead frozen="true">
				<tr>
					<th field="username" width="50px">工号</th>
					<th field="firstName" width="60px" defaultSearch="true">姓名</th>
				</tr>
			</thead>
			<thead>
				<tr>
				<!-- 
					<th field="firstName" width="60px" defaultSearch="true" style="display:none;">姓名</th>
					 -->
					<th field="joindate" width="100px" mark="DATE">入职日期</th>
					<th field="orgName" width="100px">组别</th>
					<th field="positionname" width="100px" >岗位</th>
					<th field="status" width="100px" lov="USER_STATUS" editor="{type:'combobox',	
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('USER_STATUS'),
											editable:false,
											required:true}}">状态</th>
					<th field="leader" width="80px" editor="{ 
						type:'picklistbox',
						options:{
							title:'选择汇报领导',
							completeFun:leaderPicklistComplete,
							tableUrl:'${AppContext.ctxPath}/portal/user/picklist/interEmployeePickList.jsp',
							initParam:leaderPicklistInit
							}
						}">汇报领导</th>
					<th field="basename" width="60px">Base地</th>
					<th field="updateVersion" width="100px" lov="CRM_BU_VERDATE"
						editor="{type:'combobox',	
											options:{valueField:'name',
											textField:'name',
											method:'get',
											data:getDefineLovArray('CRM_BU_VERDATE'),
											editable:false,
											required:true}}">更新版本</th>
					<th field="currentProject" width="300px" lov="CRM_BU_PROJ"
						editor="{type:'combobox',	
										options:{valueField:'val',
										textField:'name',
										method:'get',
										data:getLovArray('CRM_BU_PROJ'),
										editable:false}}">目前项目</th>
					<th field="proRole" width="100px" lov="CRM_BU_PROJROLE"
						editor="{type:'combobox',	
										options:{valueField:'val',
										textField:'name',
										method:'get',
										data:getLovArray('CRM_BU_PROJROLE'),
										editable:false}}">项目角色</th>
					<th field="enterProjDate" width="120px" mark="DATE" editor="{type:'datebox'}">入场时间</th>
					<th field="releaseDate" width="120px" mark="DATE" editor="{type:'datebox'}">计划释放时间</th>
					<th field="sourceStatus" width="80px" lov="CRM_BU_RSSTATUS"
						editor="{type:'combobox',	
										options:{valueField:'val',
										textField:'name',
										method:'get',
										data:getLovArray('CRM_BU_RSSTATUS'),
										editable:false}}">资源状态</th>
					<th field="planComments" width="300px" editor="{type:'textarea'}">后续项目安排及备注</th>
					<th field="timesheet" width="300px" editor="{type:'textarea'}">近期timesheet</th>
					
				</tr>
			</thead>
		</table>
	 
	<script type="text/javascript">
		$datagrid = $('#user-table');
		getLovOfList("[CORP_ID,CRM_BU_PROJ,CRM_BU_PROJROLE,CRM_BU_RSSTATUS]");
		$datagrid.hdatagrid({
			/*frozenColumns:[[
			        		{field:'username',title:'工号',width:50},
			        		{field:'firstName',title:'姓名',width:60},
			        	]],*/
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			//buttonNew:true,
			buttonDelete:false,
			//buttonCopy:true,
			buttonExport:true,
			newDefaultValue:true,
			oauthFlag:true,
			pageSize: 20,
			pageList: [20,100,500],
			sortName:'joindate',
			sortOrder:'asc',
			url : '${AppContext.ctxPath}/action/portal/user/list/INTER_EMP',
			onBeforeLoad:function(param){
				param.filtersRaw = '[{"id":"status","property":"status","value":"NORMAL"}]';
			},
			buttonBatchEdit : true,
			onBatchUpdateAction : function(rows, successFun, errFun, that){
				var rows_2 = [];
				for(var i=0; i< rows.length; i++){
					var row = rows[i];
					var row_2 = {
							row_status   	: "UPDATE",
							id 				: row.id,
							username 		: row.username,
							firstName 		: row.firstName,
							companyCode 	: row.companyCode,
							role 			: row.role,
							appRole 		: row.appRole,
							corpid 			: row.corpid,
							contact 		: row.contact,
							contactPhone 	: row.contactPhone,
							email 			: row.email,
							basename 		: row.basename,
							formuladate 	: row.formuladate,
							hometown 		: row.hometown,
							joblevel 		: row.joblevel,
							joindate 		: row.joindate,
							joingroupdate 	: row.joingroupdate,
							nextproj 		: row.nextproj,
							positionname 	: row.positionname,
							trialdate 		: row.trialdate,
							unitname 		: row.unitname,
							workdate 		: row.workdate,
							status 			: row.status,
							empType			:'INTER_EMP',
							uKeyId 			: row.uKeyId,
							zqsfmy1 		: row.zqsfmy1,
							postnId 		: row.postnId,
							dutyId			: row.dutyId,
							appResp       	: row.appResp,
							scancardFlag	: row.scancardFlag,
							leaderId		: row.leaderId,
							currentProject	: row.currentProject,
							proRole			: row.proRole,
							enterProjDate	: row.enterProjDate,
							releaseDate		: row.releaseDate,
							sourceStatus	: row.sourceStatus,
							planComments	: row.planComments,
							timesheet		: row.timesheet,
							updateVersion	: row.updateVersion
					}
					rows_2.push(row_2);
				}
				$.ajax({
					url: "${AppContext.ctxPath}/action/portal/user/batchUpdate",
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
				$.post('${AppContext.ctxPath}/action/portal/user/upsert', {
					row_status   	: row.row_status,
					id 				: row.id,
					username 		: row.username,
					firstName 		: row.firstName,
					companyCode 	: row.companyCode,
					role 			: row.role,
					appRole 		: row.appRole,
					corpid 			: row.corpid,
					contact 		: row.contact,
					contactPhone 	: row.contactPhone,
					email 			: row.email,
					basename 		: row.basename,
					formuladate 	: row.formuladate,
					hometown 		: row.hometown,
					joblevel 		: row.joblevel,
					joindate 		: row.joindate,
					joingroupdate 	: row.joingroupdate,
					nextproj 		: row.nextproj,
					positionname 	: row.positionname,
					trialdate 		: row.trialdate,
					unitname 		: row.unitname,
					workdate 		: row.workdate,
					status 			: row.status,
					empType			:'INTER_EMP',
					uKeyId 			: row.uKeyId,
					zqsfmy1 		: row.zqsfmy1,
					postnId 		: row.postnId,
					dutyId			: row.dutyId,
					appResp       	: row.appResp,
					scancardFlag	: row.scancardFlag,
					leaderId		: row.leaderId,
					currentProject	: row.currentProject,
					proRole			: row.proRole,
					enterProjDate	: row.enterProjDate,
					releaseDate		: row.releaseDate,
					sourceStatus	: row.sourceStatus,
					planComments	: row.planComments,
					timesheet		: row.timesheet,
					updateVersion	: row.updateVersion
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
						$.post('${AppContext.ctxPath}/action/portal/user/deleteById', {
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
			/**
			 * 初始化新建的数据
			 */
			onInitNewData:function(that){
				return {
					empType:"内部用户",
					corpid:appCtx.corpId
				};
			}
		});
		$('#orgName-keyfilter').keyFilter({
			remoteData:true,
			filterByValue:false,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/CRM_BU'
	 	});
		$('#positionname-keyfilter').keyFilter({
			remoteData:true,
			filterByValue:false,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/CRM_BU_POST'
	 	});
		$('#update-version-keyfilter').keyFilter({
			remoteData:true,
			filterByValue:false,
			remoteUrl:'${AppContext.ctxPath}/action/portal/user/list/CRM_BU_VERDATE'
	 	});
		$('#source-status-keyfilter').keyFilter({
			remoteData:true,
			filterByValue:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/CRM_BU_RSSTATUS'
	 	});
		
		function leaderPicklistComplete(selectRow){
			var row = $datagrid.hdatagrid('getCurrentRow');
			row.leaderId = selectRow.id;
			return selectRow.firstName;
		}
		
		function leaderPicklistInit(){
			return {filtersRaw:'[{"id":"status","property":"status","value":"NORMAL"}]'};
		}
		
		/**
		 * 根据类型返回值列表数组[{},{},...]
		 * @param type
		 */
		function getDefineLovArray(type){
			if(window.lovList == null ){
				window.lovList = [];
			}
			var lovArray = [];
			for(var i=0;i<window.lovList.length;i++){
				var item = window.lovList[i];
				if(item.type == type){
					lovArray.push(item);
				}
			}
			if(lovArray.length >0){
				return lovArray;
			}
			$.ajax({
				async:false,
				method:'POST',
				dataType:'json',
				url:'${AppContext.ctxPath}/action/portal/user/listOfVal/'+type,
				timeout:2000,
				success:function(data){
					if(data.success){
						addLovOfList(data.rows);
					}
				}
			});
			for(var i=0;i<window.lovList.length;i++){
				var item = window.lovList[i];
				if(item.type == type){
					lovArray.push(item);
				}
			}
			return lovArray;
		}
	</script>
</body>
</html>