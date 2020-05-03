<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<body class="easyui-layout" data-options="fit:true" border="false">
   <div data-options="region:'north',split:true" border="false" style="width:100%;" fit="true">
  
	
	<table id="billAccount-table" fit="true">
		<thead>
			<tr>
				<th field="id" width="100px" >编号</th>
				<th field="periodTitle" width="200px" defaultSearch="true" editor="{type:'picklistbox',options:{title:'选择期间',completeFun:periodPicklistComplete,
																						tableUrl:'${AppContext.ctxPath}/portal/picklist/periodPickList.jsp',
																						required:true}}">对账期间</th>
				<th field="accntName" width="300px" editor="{type:'picklistbox',options:{title:'选择客户',completeFun:accntPicklistComplete,
																						tableUrl:'${AppContext.ctxPath}/portal/opty/picklist/accountPickList.jsp',
																						required:true}}">客户名称</th>
				<th field="startDate" width="120px" defaultSearch="false" formatter="dateFormate">期间开始时间</th>
				<th field="endDate" width="102px" defaultSearch="false" formatter="dateFormate">期间结束时间</th>
				<th field="confirmFlag" width="100px" defaultSearch="false" editor="{type:'checkbox',options:{on:'Y',off:'N'}}">是否确认</th>
				<th field="printFlag" width="100px" defaultSearch="false" editor="{type:'checkbox',options:{on:'Y',off:'N'}}">是否打印</th>
				<th field="address" width="150px" defaultSearch="false">打印地址</th>
				<th field="created" width="120px" >创建时间</th>
			</tr>
		</thead>
	</table>
	
	</div>
   	
	<script type="text/javascript">
		$datagrid = $('#billAccount-table');
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
			url:'${AppContext.ctxPath}/action/portal/billAccount/queryByExamplePage',
			buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/billAccount/batchUpdate",
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
				$.post('${AppContext.ctxPath}/action/portal/billAccount/upsert', row, function(data) {
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
						$.post('${AppContext.ctxPath}/action/portal/billAccount/deleteById', {
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
				//$datagrid.hdatagrid("changeParentItemAndParams",{BillAccountId:row.id});
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
				//addButtonFun(90,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="editBillAccountPrice()" iconCls="icon-edit" plain="true">修订</a>',that);
			}
		});

	   
		
		
		var editFormatter = function(value,row,index){
			return value;
		}
		
		function accntPicklistComplete(selectRow){
			$datagrid.hdatagrid('updateCurrentRow', {
				accntId : selectRow.id
			});
			return selectRow.acctName;
		}
		
		function periodPicklistComplete(selectRow){
			$datagrid.hdatagrid('updateCurrentRow', {
				periodId 	:selectRow.id,
				startDate	:selectRow.startDate,
				endDate		:selectRow.endDate
			});
			return selectRow.title;
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
		function BillAccountSubmit(){
			var row = $datagrid.datagrid('getSelected');
			if(row.BillAccountStatus == '新建'||row.BillAccountStatus == '已拒绝'){
				$.post('${AppContext.ctxPath}/action/portal/BillAccount/BillAccountSubmit', 
				{
					id	: row.id,
					BillAccountStatus : '已提交'
			    },
				function(data){
			    	if(!data.success){
						window.parent.operationtip(data.result, 'error');
					}else{
						$datagrid.datagrid('reload');
					}
				});
			}else{
				window.parent.operationtip('该线索状态为'+row.BillAccountStatus+'，无法提交！', 'error');
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
