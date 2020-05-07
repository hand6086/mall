<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<style type="text/css" >
.file input {
    position: absolute;
    font-size: 100px;
    right: 0;
    top: 0;
    opacity: 0;
}
</style>
<body class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:100%;padding:0px;" fit="true">
		<table id="enterprise-table" fit="true">
			<thead>
				<tr>
					<th field="code" width="100px" editor="{type:'validatebox',options:{required:false}}">编号</th>
					<th field="name" width="200px" editor="{type:'validatebox',options:{required:false}}">名称</th>
					<th field="comments"  width="200px" editor="{type:'validatebox',options:{required:false}}">说明</th>

				</tr>
			</thead>
		</table>
	</div>

	<script type="text/javascript">
		$datagrid = $('#enterprise-table');
		$datagrid.hdatagrid({
			title:'',
		    pageSize: 20,//每页显示的记录条数，默认为20 
		    pageList: [20,50,100],//可以设置每页记录条数的列表 
			updateable : true,
			toolbarShow : true,
			buttonSearch : true,
			buttonNew : true,
			buttonDelete : true,
			newDefaultValue : true,
			striped : true,
			border : false,
			url:'${AppContext.ctxPath}/action/portal/enterprise/queryByExamplePage',
			onBeforeLoad:function(param){
			},
			onLoadSuccess: function (data) {
	        },
			onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				$.post("${AppContext.ctxPath}/action/portal/enterprise/upsert",row,
					function(data) {
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
						$.post('${AppContext.ctxPath}/action/portal/enterprise/deleteById', {
							id : row.id,
						}, function(data) {
							if (!data.success) {
								errFun(data.result,that);
							}else{
								successFun(that);
							}
						});
					}
				});
			}
		});
	</script>
</body>
</html>
