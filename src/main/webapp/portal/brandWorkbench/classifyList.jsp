<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<body class="easyui-layout" data-options="fit:true" border="false">
<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:100%;padding:0px;" fit="true">
   <table id="classify-table" width="100%" height="100%">
		<thead>
			<tr>
				<th field="name" width=20% editor="{type:'textbox',options:{required:true}}">名称</th>
				<th field="isDisplay" width=20% editor="{type:'checkbox', options:{on:'Y', off:'N',required:true}}">是否展示</th>
				<th field="displayOrder" width=20% editor="{type:'numberbox',options:{
																				min:0,
																				precision:0,
																				required:true}}">展示顺序</th>
			</tr>
		</thead>
	</table>
	
	</div>
   	
	<script type="text/javascript">
	    $datagrid = $('#classify-table');
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:false,
			newDefaultValue:true,
			border:false,
			pageSize: 10, 
		    pageList: [5,10,15],
		    url:'${AppContext.ctxPath}/action/portal/classify/queryByExamplePage',
		    onInsertOrUpdateAction:function(row,successFun,errFun,that){
				$.post("${AppContext.ctxPath}/action/portal/classify/upsert",row, 
				function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			},
			
			onDeleteAction : function(row,successFun,errFun,that){
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/classify/deleteById', {
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
			onInitNewData : function(that){
				return{
					isDisplay:'Y',
				};
			},

		});
	</script>
</body>
</html>