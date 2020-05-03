<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<body class="easyui-layout" data-options="fit:true" border="false">
   <div data-options="region:'north',split:true" border="false" style="width:100%;" fit="true">
	  <fieldset class="x-fieldset" id="keyFilter">
				<legend class="x-fieldset-header"
					style="width: 95px; margin-bottom: 0px; border: none;">
					<span class="x-fieldset-title">快速筛选</span>
				</legend>
				<div class="row keyfilter-border">
					<ul id="typeKeyfilter" data-toggle="keyfilter" data-title="类型"
						data-filter-filed="type" data-table-Id="period-table"></ul>
				</div>
			</fieldset>
	
	<table id="period-table" fit="true" keyFilterDiv="keyFilter">
		<thead>
			<tr>
				<th field="id" width="100px" >编号</th>
				<th field="title" width="200px" defaultSearch="true" editor="{type:'validatebox',options:{required:true}}">期间名称</th>
				<th field="type" width="120px" defaultSearch="false" lov="PERIOD_TYPE" editor="{type:'combobox',options:{valueField:'val',
				textField:'name',data:getLovArray('PERIOD_TYPE'),editable:false,required:true}}">类型</th>
				<th field="startDate" width="150px" defaultSearch="false" editor="{type:'datebox',options:{showSeconds:false}}" formatter="dateFormate">开始日期</th>
				<th field="endDate" width="150px" defaultSearch="false" editor="{type:'datebox',options:{showSeconds:false}}" formatter="dateFormate">结束日期</th>
				<th field="closed" width="60px" defaultSearch="false" editor="{type:'checkbox',options:{on:'Y',off:'N'}}">是否关闭</th>
				<th field="created" width="100px" >创建时间</th>
			</tr>
		</thead>
	</table>
	
	</div>
   	
	<script type="text/javascript">
		getLovOfList("[PERIOD_TYPE]");
		$datagrid = $('#period-table');
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
			buttonExport : true,
			buttonImport : true,
			newDefaultValue : true,
			striped : true,
			border : false,
			url:'${AppContext.ctxPath}/action/portal/period/queryByExamplePage',
			buttonBatchEdit : true,
			onBatchUpdateAction : function(rows, successFun, errFun, that){
				for(var i=0; i< rows.length; i++){
					var row = rows[i];
					if(row.endDate.length<19){
						row.endDate = row.endDate.substring(0,10)+" 23:59:59";
					}
					if(row.startDate.length<19){
						row.startDate = row.startDate.substring(0,10)+" 00:00:00";
					}
				}
				$.ajax({
					url: "${AppContext.ctxPath}/action/portal/period/batchUpdate",
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
				if(row.endDate.length<19){
					row.endDate = row.endDate.substring(0,10)+" 23:59:59";
				}
				if(row.startDate.length<19){
					row.startDate = row.startDate.substring(0,10)+" 00:00:00";
				}
				$.post('${AppContext.ctxPath}/action/portal/period/upsert', row, function(data) {
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
						$.post('${AppContext.ctxPath}/action/portal/period/deleteById', {
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
			onChangeSelectedItem:function(row){
				//$datagrid.hdatagrid("changeParentItemAndParams",{PeriodId:row.id});
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
			},
			onAddMoreButton:function(that,addButtonFun){
				//addButtonFun(90,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="editPeriodPrice()" iconCls="icon-edit" plain="true">修订</a>',that);
			}
		});

		$('#typeKeyfilter').keyFilter({
			remoteData : true,
			filterByValue : true,
			remoteUrl : '${AppContext.ctxPath}/action/portal/basic/list/PERIOD_TYPE'
		});
		
		
		var editFormatter = function(value,row,index){
			return value;
		}
	</script>
</body>
</html>
