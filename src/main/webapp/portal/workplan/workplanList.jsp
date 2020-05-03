<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>


<body class="easyui-layout" data-options="fit:true" border="false">
	 <fieldset class="x-fieldset" id="keyFilter">
		 <legend class="x-fieldset-header"
			style="width: 95px; margin-bottom: 0px; border: none;">
			<span class="x-fieldset-title">标准筛选条件</span>
		</legend>
		 <div class="row keyfilter-border">
			<ul id="plan-year-keyfilter" data-toggle="keyfilter"
				data-title="年份" data-filter-filed="year"
				data-table-Id="workplan-table">
			</ul>
		</div>
		
		<div class="row keyfilter-border">
			<ul id="plan-month-keyfilter" data-toggle="keyfilter"
				data-title="月份" data-filter-filed="month"
				data-table-Id="workplan-table">
			</ul>
		</div>
		<div class="row keyfilter-border">
			<ul id="plan-period-keyfilter" data-toggle="keyfilter"
				data-title="计划周期" data-filter-filed="periodType"
				data-table-Id="workplan-table">
			</ul>
		</div>
		<div id="weekPeriod" class="row keyfilter-border" hidden>
			<ul id="plan-weekpPeriod-keyfilter" data-toggle="keyfilter"
				data-title="周期间" data-filter-filed="begin_time"
				data-table-Id="workplan-table">
			</ul>
		</div>
		<div id="type" class="row keyfilter-border" >
			<ul id="plan-type-keyfilter" data-toggle="keyfilter"
				data-title="计划类型" data-filter-filed="type"
				data-table-Id="workplan-table">
			</ul>
		</div>
	 </fieldset>
	
	<table id="workplan-table" fit="true" keyFilterDiv="keyFilter">
		<thead>
			<tr>
				<th field="orgName" width="100px">组织</th>	
				<th field="postnName" width="100px">职位</th>												
				<th field="emp" width="100px">创建人</th>
				<th field="type" width="100px" lov="WORK_PLAN_TYPE" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		method:'get',
																		data:getLovArray('WORK_PLAN_TYPE'),
																		editable:false,
																		required:true}}" sortable="true">计划类型</th>
				<th field="acctName" width="180px" editor="{type:'picklistbox',options:{title:'选择客户',completeFun:accntPicklistComplete,
																						tableUrl:'${AppContext.ctxPath}/portal/opty/picklist/accountPickList.jsp',
																						required:true}}"  >客户</th>
				<th defaultSearch="true" field="description" width="400px" editor="{type:'validatebox', options:{required:true}}">计划描述</th>
				<th field="attr03" width="130px" editor="{type:'validatebox', options:{required:false}}">资源支持</th>
				<th field="begin_time" width="100px" mark="DATE" editor="{type:'datebox', options:{required:true}}">计划开始日期</th>
				<th id="timebox" field="beginExactTime" width="100px" mark="TIME" editor="{type:'timespinner',  options:{required:false,value:'00:00',min:'00:00', max:'23:59'}}">开始时间点</th>
				<th field="end_time" width="100px" noSearch="true" editor="{type:'datebox', options:{required:true}}">计划结束日期</th>
				<th id="timebox" field="endExactTime" width="100px" mark="TIME" editor="{type:'timespinner', options:{required:false,value:'23:59',min:'00:00', max:'23:59'}}">结束时间点</th>
				<th field="status" width="100px" lov="WORKPLAN_SATRUS" editor="{type:'combobox',options:{valueField:'val',
																	textField:'name',
																	method:'get',
																	data:getLovArray('WORKPLAN_SATRUS'),
																	editable:false,
																	required:true}}" sortable="true">计划状态</th>
				<th field="periodType" width="100px" lov="WORKPLAN_CYCLE_TYPE" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		method:'get',
																		data:getLovArray('WORKPLAN_CYCLE_TYPE'),
																		editable:false,
																		required:true}}" sortable="true">计划周期</th>
																		
				<th field="workDesc" width="200px" editor="{type:'textbox'}">完成情况</th>
				<!-- 
				<th field="orgName" width="130px" editor="{type:'picklistbox',options:{title:'选择组织',
															completeFun:orgPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/orgPickList.jsp'}}">组织</th>
															
				<th field="postnName" width="130px"  editor="{type:'picklistbox',options:{title:'选择职位',
															completeFun:postnPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/positionPickList.jsp'}}">职位</th>
				 -->
				
				<th field="created" width="130px" mark="DATE">创建时间</th>
		</thead>
	</table>
   	
	<script type="text/javascript">	
		var year = "-ALL";
		var month = "-ALL";
        var periodType = "-ALL";
        var yearAndMonth = "noMatchSelect";
		$datagrid = $('#workplan-table');
		getLovOfList("[WORKPLAN_CYCLE_TYPE,WORKPLAN_SATRUS,WORK_PLAN_TYPE]");
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonCopy:true,
			buttonExport:true,
			buttonImport:true,
			buttonDelete:true,
			oauthFlag:true,
			striped:true,
			title:'',
			border:false,
			url:'${AppContext.ctxPath}/action/portal/workplan/queryWorkplanPage',
			buttonBatchEdit : true,
			onBatchUpdateAction : function(rows, successFun, errFun, that){
				
				$.ajax({
					url: "${AppContext.ctxPath}/action/portal/workplan/batchUpdate",
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
			onInsertOrUpdateAction:function(row,successFun,errFun,that){
				$.post('${AppContext.ctxPath}/action/portal/workplan/upsert',
			 	row,function(data){
					if(!data.success){
						errFun(data.result,that);
					}
					else{
						successFun(that,data);
					}
					
				});
			},
			onDeleteAction:function(row,successFun,errFun,that) {
		    	$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/workplan/deleteById', {
								id : row.id
						}, function(data) {
								if (!data.success) {
									errFun(data.result,that);
								} else {
									successFun(that,data);
								}
						});
					}
				});
			},onInitNewData:function(that){
				var orgName = (appCtx.orgName != "null") ? appCtx.orgName : "";
				var postnName = (appCtx.postnName != "null") ? appCtx.postnName : "";
				return {
					type:"BUSINESS_OPPORTUNITY_UP",
					status:"NO_START",
					periodType:'WEEK',
					begin_time:appCtx.getNowDateShortn(0),
					end_time:appCtx.getNowDateShortn(0),
					emp: appCtx.firstName,
					created: appCtx.sysdate(),
					orgId : appCtx.orgId,
					orgName : orgName,
					postnId : appCtx.postnId,
					postnName : postnName,
					beginExactTime:'00:00',
					endExactTime:'23:59'
				};
			}
			
		});
		
		 $('#plan-year-keyfilter').keyFilter({
				remoteData:true,
				filterByValue:true,
				remoteUrl:'${AppContext.ctxPath}/action/portal/workplan/list/YEAR',
				onClickKeyFilter:function(filedName,filedValue){
					checkWeekPeriod(filedName,filedValue);
				}
				
		 });
		 
		 $('#plan-month-keyfilter').keyFilter({
				remoteData:true,
				filterByValue:true,
				remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/MONTH',
				onClickKeyFilter:function(filedName,filedValue){
					checkWeekPeriod(filedName,filedValue);
				}
		 });
		 $('#plan-period-keyfilter').keyFilter({
				remoteData:true,
				filterByValue:true,
				remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/WORKPLAN_CYCLE_TYPE',
		        onClickKeyFilter:function(filedName,filedValue){
					checkWeekPeriod(filedName,filedValue);
		        }
				
		 });
		 //页面加完成后,周期间KeyFilter隐藏
		 $('#plan-weekpPeriod-keyfilter').keyFilter({
				//remoteData:true
				//remoteUrl:'${AppContext.ctxPath}/action/portal/workplan/listWeekPeriod/'+yearAndMonth
		 }); 
		 $('#plan-type-keyfilter').keyFilter({
				remoteData:true,
				filterByValue:true,
				remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/WORK_PLAN_TYPE',
		 });
		 
		 //同时选中年、月、"周计划",展现"周期间"的keyFilter
		 function checkWeekPeriod(filedName,filedValue){
			 if(filedName == "year"){
				 if(year == filedValue){
					 return;
				 }
				 else{
					 year = filedValue;
				 }
			 }
			 if(filedName == "sMonth"){
				 if(month == filedValue){
					 return;
				 }
				 else{
					 month = filedValue;
				 }
			 }
			 if(filedName == "periodType"){
				 if(periodType == filedValue){
					 return;
				 }
				 else{
					 periodType = filedValue;
				 }
			 }	 
			 var weekLovName = getLovShowName("WORKPLAN_CYCLE_TYPE", "WEEK");
			 if( year!="-ALL" && month!="-ALL" && periodType == weekLovName){
				 yearAndMonth = year+"&"+month;
				 $('#weekPeriod').show();
				 $('#plan-weekpPeriod-keyfilter').keyFilter("reloadRemoteData",'${AppContext.ctxPath}/action/portal/workplan/listWeekPeriod/'+yearAndMonth);
			 }
			 
			 else{
				 $('#weekPeriod').hide();
				 var $options = $datagrid.hdatagrid('options');
				 var filterList = $options.filterList;
				 if(filterList!= undefined){
					for(var i=0;i<filterList.length;i++){
						var filter = filterList[i];
						var poperty = filter.property;
						if(poperty == "begin_time"){
							filterList.splice(i,i); 
						}
					}
				 }
			 }
		 }
		 
		//初始化联系人客户Id
		function initContactPicklistParam(){
			var accntId = $datagrid.hdatagrid('getCurrentRow').accntId;
			if(accntId == null || accntId == ''){
				return {
					id  :  'noMatchId'
				}
			}else{
				return {
					id  :  accntId
				}
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
		function accntPicklistComplete(selectRow) {
			$datagrid.hdatagrid('getCurrentRow').attr01 = selectRow.id;
			return selectRow.acctName;
		}
	</script>
</body>
</html>