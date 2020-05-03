<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
<style type="text/css">
</style>
<body class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:100%;padding:0px;">
		   <fieldset class="x-fieldset" id="cancelOrderKeyFilter">
			<legend class="x-fieldset-header" style="width: 95px; margin-bottom: 0px; border: none;">
				<span class="x-fieldset-title">线索筛选条件</span>
			</legend>
	
			<div class="row keyfilter-border">
				<ul id="cancelOrder-determineCancel-keyfilter" data-toggle="keyfilter"
					data-title="是否确认取消" data-filter-filed="determineCancel" data-table-Id="cancelOrder-table">
				</ul>
				<ul id="cancelOrder-alreadyCancel-keyfilter" data-toggle="keyfilter"
					data-title="是否已取消" data-filter-filed="alreadyCancel" data-table-Id="cancelOrder-table">
				</ul>
			</div>
		</fieldset>
		<table id="cancelOrder-table" style="width:100%;height:100%;" keyFilterDiv="cancelOrderKeyFilter" singleSelect="true" rownumbers="true" pagination="true">
			<thead>
				<tr>
					<th field="id" width="100px" hidden="true" noSearch="true">Id</th>
					<th field="orderNum" width="140px" editor="{type:'textbox',options:{required:true}}">订单编号</th>
					<th field="orderCity" width="160px">订单城市</th>
					<th field="determineCancel" width="100px" lov="S_IF">是否确认取消</th>
					<th field="determineTime" width="140px" mark="DATE">确认取消时间</th>
					<th field="alreadyCancel" width="100px" lov="S_IF">是否已取消</th>
					<th field="cancelTime" width="140px" mark="DATE">实际取消时间</th>
					<th field="cancelComments" width="220px">说明</th>
					<th field="created" width="140px">创建时间</th>
					<th field="operator" width="100px">操作人员</th>
					
					<th field="createdBy" width="100px" noSearch="true" hidden="true">createdBy</th>
				</tr>
			</thead>
		</table>
	</div>
	<script type="text/javascript">
		$datagrid = $('#cancelOrder-table');
		
		$datagrid.hdatagrid({
				updateable : false,    
				toolbarShow:true,	//显示工具栏
				buttonSearch:true,	//搜索框功能
				buttonNew:true,
				buttonDelete:true,
				buttonMenu : true,
				newDefaultValue:true,
				newDefaultUrl:'${AppContext.ctxPath}/action/portal/order/cancelOrder/preDefaultValue',
				oauthFlag : true,
				striped : true,
				title : '',
				border : false,
				url : '${AppContext.ctxPath}/action/portal/order/cancelOrder/queryByExamplePage',
				onInsertAction : function(row,successFun,errFun,that){
	 		    	$.post('${AppContext.ctxPath}/action/portal/order/cancelOrder/insert', row, function(data) {
	 					if (!data.success) {
	 						errFun(data.result,that);
	 					}else{
	 						successFun(that, data);
	 					}
	 				});
				},
				onDeleteAction : function(row,successFun,errFun,that) {
					$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
						if(data){
							$.post('${AppContext.ctxPath}/action/portal/order/cancelOrder/deleteById', {
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
				onInitNewData:function(that){
					return {
						determineCancel : 'N',
						alreadyCancel : 'N',
						created:appCtx.sysdate()
					};
				},
			    onAddMoreButton : function(that, addButtonFun) {
					addButtonFun(90,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="setCancel()" iconCls="icon-ok" plain="true">确认取消</a>',that);
			    }
			});
		
		$('#cancelOrder-determineCancel-keyfilter').keyFilter({
			remoteData:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/S_IF'
		});
		
		$('#cancelOrder-alreadyCancel-keyfilter').keyFilter({
			remoteData:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/S_IF'
		});
		
		function setCancel(){
			var row = $datagrid.datagrid('getSelected');
			$.post('${AppContext.ctxPath}/action/portal/order/cancelOrder/confirmCancel',{createdBy:row.createdBy,id:row.id} ,function(data){
				if(data.success){
					var index = $datagrid.hdatagrid('getRowIndex', row);
					row.cancelComments = data.newRow.cancelComments;//给被选中行的某个字段重新赋值 再刷新
					$datagrid.hdatagrid("refreshRow", index);
				}else{
					window.parent.operationtip(data.result, 'error');
				}
			});
		}
	</script>
</body>
</html>