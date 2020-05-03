<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body>
	<fieldset class="x-fieldset" id="keyFilter">
		<legend class="x-fieldset-header"
			style="width: 95px; margin-bottom: 0px; border: none;">
			<span class="x-fieldset-title">筛选条件</span>
		</legend>
		<div class="row keyfilter-border">
			<ul id="operate-keyfilter" data-toggle="keyfilter" data-title="操作类型"
				data-filter-filed="type" data-table-Id="approval-operate-table">
			</ul>
		</div>
	</fieldset>
	<table id="approval-operate-table" fit="true" keyFilterDiv="keyFilter">
		<thead>
			<tr>
				<th field="id">编码</th>
				<th field="type" width="100px" lov="APPROVAL_OPERATE_TYPE"
					editor="{type:'combobox',options:{valueField:'name',
																		textField:'name',
																		method:'get',
																		data:getLovArray('APPROVAL_OPERATE_TYPE'),
																		editable:false,
																		required:true}}">操作类型</th>
				<th field="module" width="10%" editor="{type:'textbox'}">模块</th>
				<th field="objectText" width="10%" defaultSearch="true" editor="{type:'textbox'}">操作对象描述</th>
				<th field="objectName" width="10%" editor="{type:'textbox'}">底层对象名</th>
				<th field="objectPath" width="10%" editor="{type:'textbox'}">底层对象路径</th>
				<th field="methodText" width="10%" editor="{type:'textbox'}">方法描述</th>
				<th field="methodName" width="15%" editor="{type:'textbox'}">方法名称</th>
				<th field="needNextNode" width="10%" editor="{type:'checkbox',options:{on:'Y',off:'N'}}">无下一节点</th>
				<th field="decideExpression" width="10%" editor="{type:'textarea'}">分支判断条件</th>
				<th field="param1" width="10%" editor="{type:'textbox'}">回调参数值1</th>
				<th field="param2" width="10%" editor="{type:'textbox'}">回调参数值2</th>
				<th field="param3" width="10%" editor="{type:'textbox'}">回调参数值3</th>
				<th field="param4" width="10%" editor="{type:'textbox'}">回调参数值4</th>
				<th field="param5" width="10%" editor="{type:'textbox'}">回调参数值5</th>
			</tr>
		</thead>
	</table>
	<script type="text/javascript">
	   $datagrid = $('#approval-operate-table');
	   getLovOfList("[APPROVAL_OPERATE_TYPE]");
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonCopy:true,
			buttonDelete:true,
		    pageSize: 25,//每页显示的记录条数，默认为20 
		    pageList: [25,50,100],//可以设置每页记录条数的列表 
			url:'${AppContext.ctxPath}/action/portal/approvalOperate/queryByExamplePage',
			buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/approvalOperate/batchUpdate",
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
				$.post('${AppContext.ctxPath}/action/portal/approvalOperate/upsert',row,function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			},
			onDeleteAction:function(row,successFun,errFun,that){
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/approvalOperate/deleteById', {
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
			},
		});	
		
		$('#operate-keyfilter').keyFilter({
			remoteData : true,
			remoteUrl : '${AppContext.ctxPath}/action/portal/basic/list/APPROVAL_OPERATE_TYPE'
		});
	</script>
</body>
</html>