<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<body class="easyui-layout" data-options="fit:true" border="false">
   <div data-options="region:'north'" border="false" style="height:50%;width:100%">
		<fieldset class="x-fieldset" id="keyFilter">
			<legend class="x-fieldset-header"
				style="width: 95px; margin-bottom: 0px; border: none;">
				<span class="x-fieldset-title">快速筛选</span>
			</legend>
			<div class="row keyfilter-border">
				<ul id="typeKeyfilter" data-toggle="keyfilter" data-title="账户类型"
					data-filter-filed="type" data-table-Id="dealerAccount-table"></ul>
			</div>
		</fieldset>


		<table id="dealerAccount-table"  fit="true" keyFilterDiv="keyFilter">
		<thead>
			<tr>
				<th field="id" width="100px" >编号</th>
				<th field="accntName" width="300px" editor="{type:'picklistbox',options:{title:'选择客户',completeFun:accntPicklistComplete,
																						tableUrl:'${AppContext.ctxPath}/portal/opty/picklist/accountPickList.jsp',
																						required:true}}">客户名称</th>
				<th field="type" width="150px" defaultSearch="false" lov="DEALER_ACCOUNT_TYPE" editor="{type:'combobox',options:{valueField:'val',
				textField:'name',data:getLovArray('DEALER_ACCOUNT_TYPE'),editable:false,required:true}}">账户类型</th>
				<th field="amount" width="150px" defaultSearch="false" currency="CNY" editor="{type:'numberbox',options:{
																				min:0,
																				precision:2}}">账户余额</th>
				<th field="initAmount" width="150px" defaultSearch="false" currency="CNY" editor="{type:'numberbox',options:{
																				min:0,
																				precision:2}}">初始金额</th>
				<th field="created" width="150px" style="text-align: right;" >创建时间</th>
			</tr>
		</thead>
	</table>
	</div>
	
	<div data-options="region:'center'" border="false"
		style="width: 100%;height:50%;">
		<table id="dealerTransactionDetail-table"  fit="true">
			<thead>
				<tr>
					<th field="id" width="100px">编号</th>
					<th field="created" width="100px">创建时间</th>
					<th field="sourceType" width="100px" defaultSearch="false"
						lov="TRANSACTION_SOURCE_TYPE"
						editor="{type:'combobox',options:{valueField:'val',
			textField:'name',data:getLovArray('TRANSACTION_SOURCE_TYPE'),editable:false,required:false}}">来源方式</th>
					<th field="sourceNum" width="100px">来源编号</th>
					<th field="dealTime" width="150px" defaultSearch="false" formatter="dateTimeFormate">交易时间</th>
					<th field="remainAmount" width="100px" currency="CNY" defaultSearch="false">期初余额</th>
					<th field="amount" width="100px" defaultSearch="false" currency="CNY" editor="{type:'numberbox',options:{
																				min:0,
																				precision:2,
																				required:true}}">交易金额</th>
					<th field="totalAmount" width="100px" defaultSearch="false" currency="CNY">期末余额</th>
					<th field="textDigest" width="200px" defaultSearch="false"
						editor="{type:'validatebox',options:{required:false}}">摘要</th>
					<th field="comments" width="100px" defaultSearch="false"
						editor="{type:'validatebox',options:{required:false}}">备注</th>

				</tr>
			</thead>
		</table>
	</div>
   	
	<script type="text/javascript">
		getLovOfList("[DEALER_ACCOUNT_TYPE,TRANSACTION_SOURCE_TYPE]");
		$datagrid = $('#dealerAccount-table');
		$datagridItem = $('#dealerTransactionDetail-table');

		$datagridItem.hdatagrid({
			title:'交易明细',
		    pageSize: 15,//每页显示的记录条数，默认为20 
		    pageList: [15,30,50],//可以设置每页记录条数的列表 
			//updateable : true,
			toolbarShow : true,
			buttonSearch : true,
			buttonNew : true,
			buttonDelete : true,
			buttonCopy : true,
			buttonExport : true,
			buttonImport : true,
			newDefaultValue : true,
			parentGridId : 'dealerAccount-table',
		    parentGridField : 'id',
		    linkGridField : 'headId',
		    refreshParentType : 'row',
			striped : true,
			border : false,
			url:'${AppContext.ctxPath}/action/portal/dealerTransactionDetail/queryByExamplePage',
			/* 	onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				$.post('${AppContext.ctxPath}/action/portal/dealerTransactionDetail/upsert', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that,data);
					}
				});
			}, */
			onInsertAction:function(row,successFun,errFun,that) {
				$.post('${AppContext.ctxPath}/action/portal/dealerTransactionDetail/insert', row, function(data) {
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
						$.post('${AppContext.ctxPath}/action/portal/dealerTransactionDetail/deleteById', {
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
			buttonExport : true,
			buttonImport : true,
			newDefaultValue : false,
			striped : true,
			border : false,
			subGridIds: ['dealerTransactionDetail-table'],
			url:'${AppContext.ctxPath}/action/portal/dealerAccount/queryByExamplePage',
			buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/dealerAccount/batchUpdate",
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
				
				$.post('${AppContext.ctxPath}/action/portal/dealerAccount/upsert', row, function(data) {
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
						$.post('${AppContext.ctxPath}/action/portal/dealerAccount/deleteById', {
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
					postnName : appCtx.postnName
				};
			}
		});

	   		
		$('#typeKeyfilter').keyFilter({
			remoteData : true,
			filterByValue : true,
			remoteUrl : '${AppContext.ctxPath}/action/portal/basic/list/DEALER_ACCOUNT_TYPE'
		});

		var editFormatter = function(value, row, index) {
			return value;
		}
		function accntPicklistComplete(selectRow){
			$datagrid.hdatagrid('updateCurrentRow', {
				accntId : selectRow.id
			});
			return selectRow.acctName;
		}
		/*以下为部分参考函数*/
		/*
		function orgPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').orgId = selectRow.id;
			return selectRow.text;
		}

		function postnPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').postnId = selectRow.id;
			return selectRow.text;
		}
		
		function contactPicklistComplete(selectRow){
			$datagrid.hdatagrid('updateCurrentRow', {
				contactId : selectRow.id
			});
			return selectRow.contactsName;
		}
		function DealerAccountSubmit(){
			var row = $datagrid.datagrid('getSelected');
			if(row.DealerAccountStatus == '新建'||row.DealerAccountStatus == '已拒绝'){
				$.post('${AppContext.ctxPath}/action/portal/DealerAccount/DealerAccountSubmit', 
				{
					id	: row.id,
					DealerAccountStatus : '已提交'
			    },
				function(data){
			    	if(!data.success){
						window.parent.operationtip(data.result, 'error');
					}else{
						$datagrid.datagrid('reload');
					}
				});
			}else{
				window.parent.operationtip('该线索状态为'+row.DealerAccountStatus+'，无法提交！', 'error');
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
