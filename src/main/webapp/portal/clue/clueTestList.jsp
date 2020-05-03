<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true" border="false">
   <div data-options="region:'north',split:true" fit="true" border="false">
	
	<table id="clue-table"
			singleSelect="true" rownumbers="true"  pagination="true" fit="true" >
		<thead>
			<tr>
				<th field="code" width="100px" editor="{type:'textbox',options:{required:true}}">编号</th>
				<th field="name" width="300px" defaultSearch="true" editor="{type:'textbox',options:{required:true}}">名称</th>
				<th field="address" width="130px" editor="{type:'textbox',options:{required:true}}">地址</th>
				<th field="contactName" width="130px" editor="{type:'textbox',options:{required:true}}">联系人</th>
			</tr>
		</thead>
	</table>
	</div>
   	
   	
	<script type="text/javascript">
		window.addFlag = "Y";
		window.deleteFlag = "Y";
		window.editFlag = "Y";
		window.exportFlag = "Y";
		
	    $datagrid = $('#clue-table');
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			buttonCopy:true,
			newDefaultValue:true,
			striped:true,
			border:false,
			url:'${AppContext.ctxPath}/action/portal/clue/queryByExamplePage',
			
			/** 插入或更新 */
			onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				$.post('${AppContext.ctxPath}/action/portal/clue/upsert',row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			},
			/* 删除 */
			onDeleteAction:function(row,successFun,errFun,that) {
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/clue/deleteById', {
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
	</script>
</body>
</html>